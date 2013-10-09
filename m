From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 02/10] mmc: sdhci-esdhc-imx: add std tuning support for mx6sl
Date: Wed, 9 Oct 2013 19:20:08 +0800
Message-ID: <1381317616-1229-3-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:36249
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab3JILer (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 07:34:47 -0400
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, b29396@freescale.com, john.tobias.ph@gmail.com

The mx6sl supports standard sdhci tuning, then esdhc_executing_tuning
is only needed for mx6q/dl. We introduce is_imx6_usdhc() and
is_imx6sl_usdhc() to handle the difference.

The standard tuning is enabled by setting ESDHC_TUNE_CTRL_STD_TUNING_EN bit
in new register ESDHC_TUNE_CTRL and operates with new tuning bits
defined in SDHCI_ACMD12_ERR register.

Note: mx6sl can also work on the old manually tuning mode as mx6q/dl if
not enable standard tuning mode.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |  108 +++++++++++++++++++++++++++---------
 1 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b9899e9..2cce244 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -51,6 +51,11 @@
 #define  ESDHC_TUNE_CTRL_MIN		0
 #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
 
+#define ESDHC_TUNING_CTRL		0xCC
+#define ESDHC_STD_TUNING_EN		(1 << 24)
+/* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
+#define ESDHC_TUNING_START_TAP		0x1
+
 #define ESDHC_TUNING_BLOCK_PATTERN_LEN	64
 
 /* pinctrl state */
@@ -91,6 +96,7 @@ enum imx_esdhc_type {
 	IMX51_ESDHC,
 	IMX53_ESDHC,
 	IMX6Q_USDHC,
+	IMX6SL_USDHC,
 };
 
 struct pltfm_imx_data {
@@ -130,6 +136,9 @@ static struct platform_device_id imx_esdhc_devtype[] = {
 		.name = "sdhci-usdhc-imx6q",
 		.driver_data = IMX6Q_USDHC,
 	}, {
+		.name = "sdhci-usdhc-imx6sl",
+		.driver_data = IMX6SL_USDHC,
+	}, {
 		/* sentinel */
 	}
 };
@@ -141,6 +150,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx51-esdhc", .data = &imx_esdhc_devtype[IMX51_ESDHC], },
 	{ .compatible = "fsl,imx53-esdhc", .data = &imx_esdhc_devtype[IMX53_ESDHC], },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &imx_esdhc_devtype[IMX6Q_USDHC], },
+	{ .compatible = "fsl,imx6sl-usdhc", .data = &imx_esdhc_devtype[IMX6SL_USDHC], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
@@ -170,6 +180,17 @@ static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
 	return data->devtype == IMX6Q_USDHC;
 }
 
+static inline int is_imx6sl_usdhc(struct pltfm_imx_data *data)
+{
+	return data->devtype == IMX6SL_USDHC;
+}
+
+static inline int is_imx6_usdhc(struct pltfm_imx_data *data)
+{
+	return (data->devtype == IMX6Q_USDHC) ||
+		(data->devtype == IMX6SL_USDHC);
+}
+
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
 {
 	void __iomem *base = host->ioaddr + (reg & ~0x3);
@@ -208,11 +229,16 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 		}
 	}
 
-	if (unlikely(reg == SDHCI_CAPABILITIES_1) && is_imx6q_usdhc(imx_data))
-		val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
-				| SDHCI_SUPPORT_SDR50;
+	if (unlikely(reg == SDHCI_CAPABILITIES_1)) {
+		if (is_imx6q_usdhc(imx_data))
+			/* imx6q/dl does not have cap_1 register, fake one */
+			val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
+					| SDHCI_SUPPORT_SDR50;
+		else if (is_imx6sl_usdhc(imx_data))
+			val = readl(host->ioaddr + SDHCI_CAPABILITIES) & 0xFFFF;
+	}
 
-	if (unlikely(reg == SDHCI_MAX_CURRENT) && is_imx6q_usdhc(imx_data)) {
+	if (unlikely(reg == SDHCI_MAX_CURRENT) && is_imx6_usdhc(imx_data)) {
 		val = 0;
 		val |= 0xFF << SDHCI_MAX_CURRENT_330_SHIFT;
 		val |= 0xFF << SDHCI_MAX_CURRENT_300_SHIFT;
@@ -316,13 +342,16 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 		if (val & ESDHC_VENDOR_SPEC_VSELECT)
 			ret |= SDHCI_CTRL_VDD_180;
 
-		if (is_imx6q_usdhc(imx_data)) {
+		if (is_imx6q_usdhc(imx_data))
 			val = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			if (val & ESDHC_MIX_CTRL_EXE_TUNE)
-				ret |= SDHCI_CTRL_EXEC_TUNING;
-			if (val & ESDHC_MIX_CTRL_SMPCLK_SEL)
-				ret |= SDHCI_CTRL_TUNED_CLK;
-		}
+		else if (is_imx6sl_usdhc(imx_data))
+			/* the std tuning bits is in ACMD12_ERR for imx6sl */
+			val = readl(host->ioaddr + SDHCI_ACMD12_ERR);
+
+		if (val & ESDHC_MIX_CTRL_EXE_TUNE)
+			ret |= SDHCI_CTRL_EXEC_TUNING;
+		if (val & ESDHC_MIX_CTRL_SMPCLK_SEL)
+			ret |= SDHCI_CTRL_TUNED_CLK;
 
 		ret |= (imx_data->uhs_mode & SDHCI_CTRL_UHS_MASK);
 		ret &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
@@ -356,12 +385,37 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			new_val &= ~ESDHC_VENDOR_SPEC_VSELECT;
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
 		imx_data->uhs_mode = val & SDHCI_CTRL_UHS_MASK;
-		new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
-		if (val & SDHCI_CTRL_TUNED_CLK)
-			new_val |= ESDHC_MIX_CTRL_SMPCLK_SEL;
-		else
-			new_val &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-		writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
+		if (is_imx6q_usdhc(imx_data)) {
+			new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			if (val & SDHCI_CTRL_TUNED_CLK)
+				new_val |= ESDHC_MIX_CTRL_SMPCLK_SEL;
+			else
+				new_val &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
+		} else if (is_imx6sl_usdhc(imx_data)) {
+			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
+			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			new_val = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+			if (val & SDHCI_CTRL_EXEC_TUNING) {
+				new_val |= ESDHC_STD_TUNING_EN |
+						ESDHC_TUNING_START_TAP;
+				v |= ESDHC_MIX_CTRL_EXE_TUNE;
+				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
+			} else {
+				new_val &= ~ESDHC_STD_TUNING_EN;
+				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
+				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
+			}
+
+			if (val & SDHCI_CTRL_TUNED_CLK)
+				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
+			else
+				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+
+			writel(new_val, host->ioaddr + ESDHC_TUNING_CTRL);
+			writel(v, host->ioaddr + SDHCI_ACMD12_ERR);
+			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+		}
 		return;
 	case SDHCI_TRANSFER_MODE:
 		if ((imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
@@ -374,7 +428,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
 		}
 
-		if (is_imx6q_usdhc(imx_data)) {
+		if (is_imx6_usdhc(imx_data)) {
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			/* Swap AC23 bit */
 			if (val & SDHCI_TRNS_AUTO_CMD23) {
@@ -399,7 +453,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		    (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
 			imx_data->multiblock_status = MULTIBLK_IN_PROCESS;
 
-		if (is_imx6q_usdhc(imx_data))
+		if (is_imx6_usdhc(imx_data))
 			writel(val << 16,
 			       host->ioaddr + SDHCI_TRANSFER_MODE);
 		else
@@ -465,7 +519,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		 * The reset on usdhc fails to clear MIX_CTRL register.
 		 * Do it manually here.
 		 */
-		if (is_imx6q_usdhc(imx_data))
+		if (is_imx6_usdhc(imx_data))
 			writel(0, host->ioaddr + ESDHC_MIX_CTRL);
 	}
 }
@@ -502,7 +556,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	u32 temp, val;
 
 	if (clock == 0) {
-		if (is_imx6q_usdhc(imx_data)) {
+		if (is_imx6_usdhc(imx_data)) {
 			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 					host->ioaddr + ESDHC_VENDOR_SPEC);
@@ -510,7 +564,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		goto out;
 	}
 
-	if (is_imx6q_usdhc(imx_data))
+	if (is_imx6_usdhc(imx_data))
 		pre_div = 1;
 
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
@@ -537,7 +591,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	if (is_imx6q_usdhc(imx_data)) {
+	if (is_imx6_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 		host->ioaddr + ESDHC_VENDOR_SPEC);
@@ -760,7 +814,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	return esdhc_change_pinstate(host, uhs);
 }
 
-static const struct sdhci_ops sdhci_esdhc_ops = {
+static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
 	.write_l = esdhc_writel_le,
@@ -772,7 +826,6 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.get_ro = esdhc_pltfm_get_ro,
 	.platform_bus_width = esdhc_pltfm_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
-	.platform_execute_tuning = esdhc_executing_tuning,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
@@ -909,9 +962,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * The imx6q ROM code will change the default watermark level setting
 	 * to something insane.  Change it back here.
 	 */
-	if (is_imx6q_usdhc(imx_data))
+	if (is_imx6_usdhc(imx_data))
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
 
+	if (is_imx6q_usdhc(imx_data))
+		sdhci_esdhc_ops.platform_execute_tuning =
+					esdhc_executing_tuning;
 	boarddata = &imx_data->boarddata;
 	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {
 		if (!host->mmc->parent->platform_data) {
@@ -972,7 +1028,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	}
 
 	/* sdr50 and sdr104 needs work on 1.8v signal voltage */
-	if ((boarddata->support_vsel) && is_imx6q_usdhc(imx_data)) {
+	if ((boarddata->support_vsel) && is_imx6_usdhc(imx_data)) {
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
-- 
1.7.2.rc3


