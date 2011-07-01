From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/2] mmc: sdhci-esdhc: simplify cd_gpio, wp_gpio
Date: Fri,  1 Jul 2011 16:13:38 -0700
Message-ID: <1309562019-32707-1-git-send-email-troy.kisky@boundarydevices.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:55953 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757869Ab1GAXNq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 19:13:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de
Cc: Hong-Xing.Zhu@freescale.com, cjb@laptop.org, linux-mmc@vger.kernel.org, Troy Kisky <troy.kisky@boundarydevices.com>

Currently, platform data is referenced by non init functions.
Copy these fields into locally defined struct pltfm_imx_data.

The code also currently frees imx_data on troubles with
cd_gpio, but returns 0 anyway. Now the code ignores cd_gpio
and wp_gpio if the values cause an error.

Also, allow mx51/mx53 to use platform data.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   79 ++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a19967d..ad53041 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,7 +31,6 @@
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
 
-#define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
 /*
  * The CMDTYPE of the CMD register (offset 0xE) should be set to
  * "11" when the STOP CMD12 is issued on imx53 to abort one
@@ -48,6 +47,8 @@
 struct pltfm_imx_data {
 	int flags;
 	u32 scratchpad;
+	unsigned int wp_gpio;
+	unsigned int cd_gpio;
 };
 
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
@@ -67,12 +68,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 	u32 val = readl(host->ioaddr + reg);
 
 	if (unlikely((reg == SDHCI_PRESENT_STATE)
-			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP))) {
-		struct esdhc_platform_data *boarddata =
-				host->mmc->parent->platform_data;
-
-		if (boarddata && gpio_is_valid(boarddata->cd_gpio)
-				&& gpio_get_value(boarddata->cd_gpio))
+			&& (imx_data->cd_gpio != -EINVAL))) {
+		if (gpio_get_value(imx_data->cd_gpio))
 			/* no card, if a valid gpio says so... */
 			val &= SDHCI_CARD_PRESENT;
 		else
@@ -89,10 +86,9 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
 	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
-			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)))
+			&& (imx_data->cd_gpio != -EINVAL)))
 		/*
 		 * these interrupts won't work with a custom card_detect gpio
-		 * (only applied to mx25/35)
 		 */
 		val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
 
@@ -193,10 +189,11 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 {
-	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
-	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
-		return gpio_get_value(boarddata->wp_gpio);
+	if (imx_data->wp_gpio != -EINVAL)
+		return gpio_get_value(imx_data->wp_gpio);
 	else
 		return -ENOSYS;
 }
@@ -242,6 +239,8 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 		clk_put(pltfm_host->clk);
 		return -ENOMEM;
 	}
+	imx_data->cd_gpio = -EINVAL;
+	imx_data->wp_gpio = -EINVAL;
 	pltfm_host->priv = imx_data;
 
 	if (!cpu_is_mx25())
@@ -258,62 +257,56 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
 
 	if (boarddata) {
-		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
+		if (gpio_is_valid(boarddata->cd_gpio))
+			imx_data->cd_gpio = boarddata->cd_gpio;
+		if (gpio_is_valid(boarddata->wp_gpio))
+			imx_data->wp_gpio = boarddata->wp_gpio;
+	}
+	if (imx_data->wp_gpio != -EINVAL) {
+		err = gpio_request_one(imx_data->wp_gpio, GPIOF_IN, "ESDHC_WP");
 		if (err) {
 			dev_warn(mmc_dev(host->mmc),
 				"no write-protect pin available!\n");
-			boarddata->wp_gpio = err;
+			imx_data->wp_gpio = -EINVAL;
+			/* success, just don't use wp_gpio */
 		}
-
-		err = gpio_request_one(boarddata->cd_gpio, GPIOF_IN, "ESDHC_CD");
+	}
+	if (imx_data->cd_gpio != -EINVAL) {
+		err = gpio_request_one(imx_data->cd_gpio, GPIOF_IN, "ESDHC_CD");
 		if (err) {
 			dev_warn(mmc_dev(host->mmc),
 				"no card-detect pin available!\n");
-			goto no_card_detect_pin;
+			imx_data->cd_gpio = -EINVAL;
+			/* success, just don't use cd_gpio */
+			return 0;
 		}
-
-		/* i.MX5x has issues to be researched */
-		if (!cpu_is_mx25() && !cpu_is_mx35())
-			goto not_supported;
-
-		err = request_irq(gpio_to_irq(boarddata->cd_gpio), cd_irq,
+		err = request_irq(gpio_to_irq(imx_data->cd_gpio), cd_irq,
 				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 				 mmc_hostname(host->mmc), host);
 		if (err) {
 			dev_warn(mmc_dev(host->mmc), "request irq error\n");
-			goto no_card_detect_irq;
+			gpio_free(imx_data->cd_gpio);
+			imx_data->cd_gpio = -EINVAL;
+			/* success, just don't use cd_gpio */
+			return 0;
 		}
-
-		imx_data->flags |= ESDHC_FLAG_GPIO_FOR_CD_WP;
 		/* Now we have a working card_detect again */
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
-
-	return 0;
-
- no_card_detect_irq:
-	gpio_free(boarddata->cd_gpio);
- no_card_detect_pin:
-	boarddata->cd_gpio = err;
- not_supported:
-	kfree(imx_data);
 	return 0;
 }
 
 static void esdhc_pltfm_exit(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
-	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
-		gpio_free(boarddata->wp_gpio);
-
-	if (boarddata && gpio_is_valid(boarddata->cd_gpio)) {
-		gpio_free(boarddata->cd_gpio);
+	if (imx_data->wp_gpio != -EINVAL)
+		gpio_free(imx_data->wp_gpio);
 
-		if (!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION))
-			free_irq(gpio_to_irq(boarddata->cd_gpio), host);
+	if (imx_data->cd_gpio != -EINVAL) {
+		free_irq(gpio_to_irq(imx_data->cd_gpio), host);
+		gpio_free(imx_data->cd_gpio);
 	}
 
 	clk_disable(pltfm_host->clk);
-- 
1.7.0.4

