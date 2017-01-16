From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v3 4/9] mmc: mmci: add support for setting pad type via pinctrl
Date: Mon, 16 Jan 2017 08:37:13 +0100
Message-ID: <1484552238-23171-5-git-send-email-andrea.merello@gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34694 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdAPHhm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 02:37:42 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so28594415wmi.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2017 23:37:41 -0800 (PST)
In-Reply-To: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

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
index fbb5728..c581b81 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -115,6 +115,7 @@ struct variant_data {
 	bool			qcom_dml;
 	bool			reversed_irq_handling;
 	bool			has_start_err;
+	bool			has_pad_config;
 };
 
 static __maybe_unused struct variant_data variant_arm = {
@@ -125,6 +126,7 @@ static __maybe_unused struct variant_data variant_arm = {
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_arm_extended_fifo = {
@@ -134,6 +136,7 @@ static __maybe_unused struct variant_data variant_arm_extended_fifo = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -144,6 +147,7 @@ static __maybe_unused struct variant_data variant_arm_extended_fifo_hwfc = {
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_u300 = {
@@ -160,6 +164,7 @@ static __maybe_unused struct variant_data variant_u300 = {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_nomadik = {
@@ -177,6 +182,7 @@ static __maybe_unused struct variant_data variant_nomadik = {
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_ux500 = {
@@ -200,6 +206,7 @@ static __maybe_unused struct variant_data variant_ux500 = {
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_ux500v2 = {
@@ -225,6 +232,7 @@ static __maybe_unused struct variant_data variant_ux500v2 = {
 	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 static __maybe_unused struct variant_data variant_qcom = {
@@ -244,6 +252,7 @@ static __maybe_unused struct variant_data variant_qcom = {
 	.qcom_fifo		= true,
 	.qcom_dml		= true,
 	.has_start_err		= true,
+	.has_pad_config		= true,
 };
 
 /* Busy detection for the ST Micro variant */
@@ -1362,6 +1371,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	u32 pwr = 0;
 	unsigned long flags;
 	int ret;
+	struct pinctrl_state *pins;
+	bool is_opendrain;
 
 	if (host->plat->ios_handler &&
 		host->plat->ios_handler(mmc_dev(mmc), ios))
@@ -1420,16 +1431,31 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -1537,7 +1563,6 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
 		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
 	if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
-
 	return 0;
 }
 
@@ -1575,6 +1600,13 @@ static struct mmci_host *mmci_probe(struct device *dev,
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
index 56322c6..b5be66a 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -192,6 +192,10 @@
 
 #define NR_SG		128
 
+/* pinctrl configs */
+#define MMCI_PINCTRL_STATE_PUSHPULL "default"
+#define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
+
 struct clk;
 struct variant_data;
 struct dma_chan;
@@ -226,7 +230,7 @@ struct mmci_host {
 	bool			vqmmc_enabled;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
-
+	struct pinctrl		*pinctrl;
 	u8			hw_designer;
 	u8			hw_revision:4;
 
@@ -251,4 +255,3 @@ struct mmci_host {
 #define dma_inprogress(host)	(0)
 #endif
 };
-
-- 
2.7.4

