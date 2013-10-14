From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/5] mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
Date: Mon, 14 Oct 2013 16:23:42 +0800
Message-ID: <1381739024-24924-4-git-send-email-shawn.guo@linaro.org>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:2482 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451Ab3JNIXP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2013 04:23:15 -0400
In-Reply-To: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Add flag ESDHC_FLAG_USDHC to tell that the ESDHC is actually an USDHC
block, and replace the is_imx6q_usdhc() occurrences with inline function
esdhc_is_usdhc() which checks the flag.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   37 ++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a5d7d15..63a6024 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -94,6 +94,11 @@
  * presents on i.MX25 and i.MX35.
  */
 #define ESDHC_FLAG_ENGCM07207		BIT(2)
+/*
+ * The flag tells that the ESDHC controller is an USDHC block that is
+ * integrated on the i.MX6 series.
+ */
+#define ESDHC_FLAG_USDHC		BIT(3)
 
 enum imx_esdhc_type {
 	IMX25_ESDHC,
@@ -180,6 +185,11 @@ static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
 	return data->devtype == IMX6Q_USDHC;
 }
 
+static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
+{
+	return !!(data->flags & ESDHC_FLAG_USDHC);
+}
+
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
 {
 	void __iomem *base = host->ioaddr + (reg & ~0x3);
@@ -218,11 +228,11 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 		}
 	}
 
-	if (unlikely(reg == SDHCI_CAPABILITIES_1) && is_imx6q_usdhc(imx_data))
+	if (unlikely(reg == SDHCI_CAPABILITIES_1) && esdhc_is_usdhc(imx_data))
 		val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
 				| SDHCI_SUPPORT_SDR50;
 
-	if (unlikely(reg == SDHCI_MAX_CURRENT) && is_imx6q_usdhc(imx_data)) {
+	if (unlikely(reg == SDHCI_MAX_CURRENT) && esdhc_is_usdhc(imx_data)) {
 		val = 0;
 		val |= 0xFF << SDHCI_MAX_CURRENT_330_SHIFT;
 		val |= 0xFF << SDHCI_MAX_CURRENT_300_SHIFT;
@@ -312,7 +322,7 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 
 	if (unlikely(reg == SDHCI_HOST_VERSION)) {
 		reg ^= 2;
-		if (is_imx6q_usdhc(imx_data)) {
+		if (esdhc_is_usdhc(imx_data)) {
 			/*
 			 * The usdhc register returns a wrong host version.
 			 * Correct it here.
@@ -326,7 +336,7 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 		if (val & ESDHC_VENDOR_SPEC_VSELECT)
 			ret |= SDHCI_CTRL_VDD_180;
 
-		if (is_imx6q_usdhc(imx_data)) {
+		if (esdhc_is_usdhc(imx_data)) {
 			val = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			if (val & ESDHC_MIX_CTRL_EXE_TUNE)
 				ret |= SDHCI_CTRL_EXEC_TUNING;
@@ -384,7 +394,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
 		}
 
-		if (is_imx6q_usdhc(imx_data)) {
+		if (esdhc_is_usdhc(imx_data)) {
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			/* Swap AC23 bit */
 			if (val & SDHCI_TRNS_AUTO_CMD23) {
@@ -409,7 +419,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		    (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
 			imx_data->multiblock_status = MULTIBLK_IN_PROCESS;
 
-		if (is_imx6q_usdhc(imx_data))
+		if (esdhc_is_usdhc(imx_data))
 			writel(val << 16,
 			       host->ioaddr + SDHCI_TRANSFER_MODE);
 		else
@@ -475,7 +485,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		 * The reset on usdhc fails to clear MIX_CTRL register.
 		 * Do it manually here.
 		 */
-		if (is_imx6q_usdhc(imx_data))
+		if (esdhc_is_usdhc(imx_data))
 			writel(0, host->ioaddr + ESDHC_MIX_CTRL);
 	}
 }
@@ -512,7 +522,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	u32 temp, val;
 
 	if (clock == 0) {
-		if (is_imx6q_usdhc(imx_data)) {
+		if (esdhc_is_usdhc(imx_data)) {
 			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 					host->ioaddr + ESDHC_VENDOR_SPEC);
@@ -520,7 +530,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		goto out;
 	}
 
-	if (is_imx6q_usdhc(imx_data))
+	if (esdhc_is_usdhc(imx_data))
 		pre_div = 1;
 
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
@@ -547,7 +557,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	if (is_imx6q_usdhc(imx_data)) {
+	if (esdhc_is_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 		host->ioaddr + ESDHC_VENDOR_SPEC);
@@ -873,6 +883,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
 		imx_data->flags |= ESDHC_FLAG_ENGCM07207;
 
+	if (is_imx6q_usdhc(imx_data))
+		imx_data->flags |= ESDHC_FLAG_USDHC;
+
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
 		err = PTR_ERR(imx_data->clk_ipg);
@@ -925,7 +938,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * The imx6q ROM code will change the default watermark level setting
 	 * to something insane.  Change it back here.
 	 */
-	if (is_imx6q_usdhc(imx_data))
+	if (esdhc_is_usdhc(imx_data))
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
 
 	boarddata = &imx_data->boarddata;
@@ -988,7 +1001,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	}
 
 	/* sdr50 and sdr104 needs work on 1.8v signal voltage */
-	if ((boarddata->support_vsel) && is_imx6q_usdhc(imx_data)) {
+	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data)) {
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
-- 
1.7.9.5


