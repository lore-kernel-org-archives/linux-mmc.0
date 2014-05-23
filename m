From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/5] mmc: sdhci-esdhc-imx: use mmc_of_parse
Date: Fri, 23 May 2014 14:33:03 +0200
Message-ID: <1400848384-3226-5-git-send-email-s.hauer@pengutronix.de>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43524 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaEWMdZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 08:33:25 -0400
In-Reply-To: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>

mmc_of_parse allows us to use the generic devicetree bindings instead
of parsing the properties manually.
To do so we have to refactor the driver. The driver currently parses
the dt properties into platform_data which is then translated into
struct mmc_host caps. This changes the driver so that it
- parses dt data into mmc_host caps directly via mmc_of_parse
- parses platform_data into mmc_host caps directly
- parses the flags for which no mmc_host caps exist into driver private
  data
This makes platform_data used for its original purpose and irrelevant
for the devicetree case.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 175 +++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 85 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 620cbcd..8c0af44 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -151,8 +151,9 @@ struct pltfm_imx_data {
 	struct pinctrl_state *pins_100mhz;
 	struct pinctrl_state *pins_200mhz;
 	const struct esdhc_soc_data *socdata;
-	struct esdhc_platform_data boarddata;
 	unsigned long f_max;
+	unsigned int delay_line;
+	bool support_vsel;
 	struct clk *clk_ipg;
 	struct clk *clk_ahb;
 	struct clk *clk_per;
@@ -161,6 +162,7 @@ struct pltfm_imx_data {
 		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
 		WAIT_FOR_INT,        /* sent CMD12, waiting for response INT */
 	} multiblock_status;
+	enum wp_types wp_type;
 	u32 uhs_mode;
 	u32 is_ddr;
 };
@@ -651,9 +653,8 @@ static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
-	switch (boarddata->wp_type) {
+	switch (imx_data->wp_type) {
 	case ESDHC_WP_GPIO:
 		return mmc_gpio_get_ro(host->mmc);
 	case ESDHC_WP_CONTROLLER:
@@ -839,7 +840,6 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	switch (uhs) {
 	case MMC_TIMING_UHS_SDR12:
@@ -861,9 +861,9 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 				ESDHC_MIX_CTRL_DDREN,
 				host->ioaddr + ESDHC_MIX_CTRL);
 		imx_data->is_ddr = 1;
-		if (boarddata->delay_line) {
+		if (imx_data->delay_line) {
 			u32 v;
-			v = boarddata->delay_line <<
+			v = imx_data->delay_line <<
 				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
 				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
 			if (is_imx53_esdhc(imx_data))
@@ -900,49 +900,50 @@ static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 #ifdef CONFIG_OF
 static int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
-			 struct pltfm_imx_data *imx_data)
+			 struct sdhci_host *host, struct pltfm_imx_data *imx_data)
 {
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 	struct device_node *np = pdev->dev.of_node;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
 
-	if (of_get_property(np, "non-removable", NULL))
-		boarddata->cd_type = ESDHC_CD_PERMANENT;
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		return ret;
 
-	if (of_get_property(np, "fsl,cd-controller", NULL))
-		boarddata->cd_type = ESDHC_CD_CONTROLLER;
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
 	if (of_get_property(np, "fsl,wp-controller", NULL))
-		boarddata->wp_type = ESDHC_WP_CONTROLLER;
+		imx_data->wp_type = ESDHC_WP_CONTROLLER;
 
-	boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
-	if (gpio_is_valid(boarddata->cd_gpio))
-		boarddata->cd_type = ESDHC_CD_GPIO;
+	if (mmc_gpio_get_ro(host->mmc) >= 0)
+		imx_data->wp_type = ESDHC_WP_GPIO;
 
-	boarddata->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
-	if (gpio_is_valid(boarddata->wp_gpio))
-		boarddata->wp_type = ESDHC_WP_GPIO;
+	/* This flag only means: Do not set the MMC_CAP_4_BIT_DATA flag */
+	host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
-	of_property_read_u32(np, "bus-width", &boarddata->max_bus_width);
-
-	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
+	/*
+	 * mmc_of_parse sets host->mmc->f_max, but it gets overwritten
+	 * by the sdhci driver later, so we have to save the value
+	 */
+	imx_data->f_max = host->mmc->f_max;
 
 	if (of_find_property(np, "no-1-8-v", NULL))
-		boarddata->support_vsel = false;
+		imx_data->support_vsel = false;
 	else
-		boarddata->support_vsel = true;
+		imx_data->support_vsel = true;
 
-	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
-		boarddata->delay_line = 0;
+	if (of_property_read_u32(np, "fsl,delay-line", &imx_data->delay_line))
+		imx_data->delay_line = 0;
 
 	return 0;
 }
 #else
 static inline int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
-			 struct pltfm_imx_data *imx_data)
+			 struct sdhci_host *host, struct pltfm_imx_data *imx_data)
 {
 	return -ENODEV;
 }
@@ -950,16 +951,67 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 static int
 sdhci_esdhc_imx_probe_boarddata(struct platform_device *pdev,
-			 struct pltfm_imx_data *imx_data)
+			 struct sdhci_host *host, struct pltfm_imx_data *imx_data)
 {
 	struct esdhc_platform_data *pdata = pdev->dev.platform_data;
+	int err;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "no boarddata\n");
 		return -EINVAL;
 	}
 
-	imx_data->boarddata = *pdata;
+	/* card_detect */
+	switch (pdata->cd_type) {
+	case ESDHC_CD_GPIO:
+		err = mmc_gpio_request_cd(host->mmc, pdata->cd_gpio, 0);
+		if (err) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to request card-detect gpio!\n");
+			return err;
+		}
+		break;
+
+	case ESDHC_CD_CONTROLLER:
+		break;
+
+	case ESDHC_CD_PERMANENT:
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		break;
+
+	case ESDHC_CD_NONE:
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		break;
+	}
+
+	/* write_protect */
+	imx_data->wp_type = pdata->wp_type;
+	if (pdata->wp_type == ESDHC_WP_GPIO) {
+		err = mmc_gpio_request_ro(host->mmc, pdata->wp_gpio);
+		if (err) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to request write-protect gpio!\n");
+			return err;
+		}
+		host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+	}
+
+	switch (pdata->max_bus_width) {
+	case 8:
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
+		break;
+	case 4:
+		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
+		break;
+	case 1:
+	default:
+		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
+		break;
+	}
+
+	imx_data->delay_line = pdata->delay_line;
+	imx_data->support_vsel = pdata->support_vsel;
 
 	return 0;
 }
@@ -970,9 +1022,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			of_match_device(imx_esdhc_dt_ids, &pdev->dev);
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
-	struct esdhc_platform_data *boarddata;
 	int err;
 	struct pltfm_imx_data *imx_data;
+	unsigned long f_max;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata, 0);
 	if (IS_ERR(host))
@@ -1052,67 +1104,20 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP,
 			host->ioaddr + ESDHC_TUNING_CTRL);
 
-	boarddata = &imx_data->boarddata;
-	if (sdhci_esdhc_imx_probe_dt(pdev, imx_data) < 0) {
-		err = sdhci_esdhc_imx_probe_boarddata(pdev, imx_data);
+	if (sdhci_esdhc_imx_probe_dt(pdev, host, imx_data) < 0) {
+		err = sdhci_esdhc_imx_probe_boarddata(pdev, host, imx_data);
 		if (err)
 			goto disable_clk;
 	}
 
-	imx_data->f_max = clk_get_rate(imx_data->clk_per);
-	if (boarddata->f_max && boarddata->f_max < imx_data->f_max)
-		imx_data->f_max = boarddata->f_max;
-
-	/* write_protect */
-	if (boarddata->wp_type == ESDHC_WP_GPIO) {
-		err = mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
-		if (err) {
-			dev_err(mmc_dev(host->mmc),
-				"failed to request write-protect gpio!\n");
-			goto disable_clk;
-		}
-		host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
-	}
-
-	/* card_detect */
-	switch (boarddata->cd_type) {
-	case ESDHC_CD_GPIO:
-		err = mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio, 0);
-		if (err) {
-			dev_err(mmc_dev(host->mmc),
-				"failed to request card-detect gpio!\n");
-			goto disable_clk;
-		}
-		break;
-
-	case ESDHC_CD_CONTROLLER:
-		break;
-
-	case ESDHC_CD_PERMANENT:
-		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
-		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-		break;
-
-	case ESDHC_CD_NONE:
-		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-		break;
-	}
-
-	switch (boarddata->max_bus_width) {
-	case 8:
-		host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
-		break;
-	case 4:
-		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
-		break;
-	case 1:
-	default:
-		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
-		break;
-	}
+	f_max = clk_get_rate(imx_data->clk_per);
+	if (imx_data->f_max)
+		imx_data->f_max = min(f_max, imx_data->f_max);
+	else
+		imx_data->f_max = f_max;
 
 	/* sdr50 and sdr104 needs work on 1.8v signal voltage */
-	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data)) {
+	if ((imx_data->support_vsel) && esdhc_is_usdhc(imx_data)) {
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
-- 
2.0.0.rc0

