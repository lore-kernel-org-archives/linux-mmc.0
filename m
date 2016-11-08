From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 4/9] mmc: mmci: add support for setting pad type via pinctrl
Date: Tue,  8 Nov 2016 14:43:40 +0100
Message-ID: <1478612625-23256-5-git-send-email-andrea.merello@gmail.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34962 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbcKHNoZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2016 08:44:25 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so11946868wme.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2016 05:44:24 -0800 (PST)
In-Reply-To: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>

The STM32 variant  hasn't the control bit to switch pads in opendrain mode.
In this case we can achive the same result by askint to the pinmux driver
to configure pins for us.

This patch make the mmci driver able to do this whenever needed.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/mmc/host/mmci.c | 52 +++++++++++++++++++++++++++++++++++++++----------
 drivers/mmc/host/mmci.h |  7 +++++--
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0c629e3..170c78a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -107,6 +107,7 @@ struct variant_data {
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
 	bool			has_start_err;
+	bool			has_pad_config;
 };
 
 static __maybe_unused struct variant_data variant_arm = {
@@ -117,6 +118,7 @@ static __maybe_unused struct variant_data variant_arm = {
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_arm_extended_fifo = {
@@ -126,6 +128,7 @@ static __maybe_unused struct variant_data variant_arm_extended_fifo = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -136,6 +139,7 @@ static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_u300 = {
@@ -152,6 +156,7 @@ static __maybe_unused struct variant_data variant_u300 = {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_nomadik = {
@@ -169,6 +174,7 @@ static __maybe_unused struct variant_data variant_nomadik = {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_ux500 = {
@@ -189,6 +195,7 @@ static __maybe_unused struct variant_data variant_ux500 = {
 	.busy_detect		= true,
 	.pwrreg_nopower		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_ux500v2 = {
@@ -211,6 +218,7 @@ static __maybe_unused struct variant_data variant_ux500v2 = {
 	.busy_detect		= true,
 	.pwrreg_nopower		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_qcom = {
@@ -230,6 +238,7 @@ static __maybe_unused struct variant_data variant_qcom = {
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static int mmci_card_busy(struct mmc_host *mmc)
@@ -1317,6 +1326,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	u32 pwr = 0;
 	unsigned long flags;
 	int ret;
+	struct pinctrl_state *pins;
+	bool is_opendrain;
 
 	if (host->plat->ios_handler &&
 		host->plat->ios_handler(mmc_dev(mmc), ios))
@@ -1375,16 +1386,31 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				~MCI_ST_DATA2DIREN);
 	}
 
-	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
-		if (host->hw_designer != AMBA_VENDOR_ST)
-			pwr |= MCI_ROD;
-		else {
-			/*
-			 * The ST Micro variant use the ROD bit for something
-			 * else and only has OD (Open Drain).
-			 */
-			pwr |= MCI_OD;
+	if (host->variant->has_pad_config) {
+		if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
+			if (host->hw_designer != AMBA_VENDOR_ST) {
+				pwr |= MCI_ROD;
+			} else {
+				/*
+				 * The ST Micro variant use the ROD bit for
+				 * something else and only has OD (Open Drain).
+				 */
+				pwr |= MCI_OD;
+			}
 		}
+	} else {
+		/*
+		 * If the variant cannot configure the pads by its own, then we
+		 * expect the pinctrl to be able to do that for us
+		 */
+		is_opendrain = (ios->bus_mode == MMC_BUSMODE_OPENDRAIN);
+		pins = pinctrl_lookup_state(host->pinctrl, is_opendrain ?
+					MMCI_PINCTRL_STATE_OPENDRAIN :
+					MMCI_PINCTRL_STATE_PUSHPULL);
+		if (IS_ERR(pins))
+			dev_warn(mmc_dev(mmc), "Cannot select pin drive type via pinctrl\n");
+		else
+			pinctrl_select_state(host->pinctrl, pins);
 	}
 
 	/*
@@ -1492,7 +1518,6 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
 		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
 	if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
-
 	return 0;
 }
 
@@ -1530,6 +1555,13 @@ static struct mmci_host *mmci_probe(struct device *dev,
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
+	if (!variant->has_pad_config) {
+		host->pinctrl = devm_pinctrl_get(dev);
+		if (IS_ERR(host->pinctrl)) {
+			dev_err(dev, "failed to get pinctrl");
+			goto host_free;
+		}
+	}
 	host->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index a1f5e4f..d06c048 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -185,6 +185,10 @@
 
 #define NR_SG		128
 
+/* pinctrl configs */
+#define MMCI_PINCTRL_STATE_PUSHPULL "default"
+#define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
+
 struct clk;
 struct variant_data;
 struct dma_chan;
@@ -219,7 +223,7 @@ struct mmci_host {
 	bool			vqmmc_enabled;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
-
+	struct pinctrl		*pinctrl;
 	u8			hw_designer;
 	u8			hw_revision:4;
 
@@ -244,4 +248,3 @@ struct mmci_host {
 #define dma_inprogress(host)	(0)
 #endif
 };
-
-- 
2.7.4

