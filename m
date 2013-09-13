From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 6/9] sdhci: sdhci-esdhc-imx: change pinctrl state according to uhs mode
Date: Fri, 13 Sep 2013 19:11:35 +0800
Message-ID: <1379070698-7344-7-git-send-email-b29396@freescale.com>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.12] ([216.32.180.12]:18771 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754244Ab3IMLV1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2013 07:21:27 -0400
In-Reply-To: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, ulf.hansson@linaro.org, neko@bakuhatsu.net, b29396@freescale.com

Without proper pinctrl state, the card may not be able to work
on high speed stablely. e.g. SDR104.

This patch add pinctrl state switch code according to different
uhs mode include 100mhz sate, 200mhz sate and normal state
(50Mhz and below).

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
ChangeLog since v1:
* addressed Shawn's comments
---
 drivers/mmc/host/sdhci-esdhc-imx.c          |   96 ++++++++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h |    4 +
 2 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f906c20..ed00d6d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -53,6 +53,10 @@
 
 #define ESDHC_TUNING_BLOCK_PATTERN_LEN	64
 
+/* pinctrl state */
+#define ESDHC_PINCTRL_STATE_100MHZ	"state_100mhz"
+#define ESDHC_PINCTRL_STATE_200MHZ	"state_200mhz"
+
 /*
  * Our interpretation of the SDHCI_HOST_CONTROL register
  */
@@ -94,6 +98,9 @@ struct pltfm_imx_data {
 	u32 scratchpad;
 	enum imx_esdhc_type devtype;
 	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_100mhz;
+	struct pinctrl_state *pins_200mhz;
 	struct esdhc_platform_data boarddata;
 	struct clk *clk_ipg;
 	struct clk *clk_ahb;
@@ -693,6 +700,62 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	return ret;
 }
 
+static int esdhc_change_pinstate(struct sdhci_host *host,
+						unsigned int uhs)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct pinctrl_state *pinctrl;
+
+	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
+
+	if (IS_ERR(imx_data->pinctrl) ||
+		IS_ERR(imx_data->pins_default) ||
+		IS_ERR(imx_data->pins_100mhz) ||
+		IS_ERR(imx_data->pins_200mhz))
+		return -EINVAL;
+
+	switch (uhs) {
+	case MMC_TIMING_UHS_SDR50:
+		pinctrl = imx_data->pins_100mhz;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		pinctrl = imx_data->pins_200mhz;
+		break;
+	default:
+		/* back to default state for other legacy timing */
+		pinctrl = imx_data->pins_default;
+	}
+
+	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
+}
+
+static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+
+	switch (uhs) {
+	case MMC_TIMING_UHS_SDR12:
+		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR12;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR25;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR50;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR104;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		imx_data->uhs_mode = SDHCI_CTRL_UHS_DDR50;
+		break;
+	}
+
+	return esdhc_change_pinstate(host, uhs);
+}
+
 static const struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -704,6 +767,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_ro = esdhc_pltfm_get_ro,
 	.platform_bus_width = esdhc_pltfm_bus_width,
+	.set_uhs_signaling = esdhc_set_uhs_signaling,
 	.platform_execute_tuning = esdhc_executing_tuning,
 };
 
@@ -746,6 +810,11 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
 
+	if (of_find_property(np, "no-1-8-v", NULL))
+		boarddata->support_vsel = false;
+	else
+		boarddata->support_vsel = true;
+
 	return 0;
 }
 #else
@@ -808,12 +877,20 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_prepare_enable(imx_data->clk_ipg);
 	clk_prepare_enable(imx_data->clk_ahb);
 
-	imx_data->pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl)) {
 		err = PTR_ERR(imx_data->pinctrl);
 		goto disable_clk;
 	}
 
+	imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
+						PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(imx_data->pins_default)) {
+		err = PTR_ERR(imx_data->pins_default);
+		dev_err(mmc_dev(host->mmc), "could not get default state\n");
+		goto disable_clk;
+	}
+
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
@@ -890,6 +967,23 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		break;
 	}
 
+	/* sdr50 and sdr104 needs work on 1.8v signal voltage */
+	if ((boarddata->support_vsel) && is_imx6q_usdhc(imx_data)) {
+		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
+						ESDHC_PINCTRL_STATE_100MHZ);
+		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
+						ESDHC_PINCTRL_STATE_200MHZ);
+		if (IS_ERR(imx_data->pins_100mhz) ||
+				IS_ERR(imx_data->pins_200mhz)) {
+			dev_warn(mmc_dev(host->mmc),
+				"could not get ultra high speed state, work on normal mode\n");
+			/* fall back to not support uhs by specify no 1.8v quirk */
+			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+		}
+	} else {
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+	}
+
 	err = sdhci_add_host(host);
 	if (err)
 		goto disable_clk;
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index d44912d..a0f5a8f 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -10,6 +10,8 @@
 #ifndef __ASM_ARCH_IMX_ESDHC_H
 #define __ASM_ARCH_IMX_ESDHC_H
 
+#include <linux/types.h>
+
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
 	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
@@ -32,6 +34,7 @@ enum cd_types {
  * @cd_gpio:	gpio for card_detect interrupt
  * @wp_type:	type of write_protect method (see wp_types enum above)
  * @cd_type:	type of card_detect method (see cd_types enum above)
+ * @support_vsel:  indicate it supports 1.8v switching
  */
 
 struct esdhc_platform_data {
@@ -41,5 +44,6 @@ struct esdhc_platform_data {
 	enum cd_types cd_type;
 	int max_bus_width;
 	unsigned int f_max;
+	bool support_vsel;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.7.1


