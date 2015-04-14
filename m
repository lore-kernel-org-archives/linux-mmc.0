From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 4/4] mmc: esdhc: add eMMC DDR mode support
Date: Tue, 14 Apr 2015 18:05:43 +0800
Message-ID: <1429005943-21235-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0135.outbound.protection.outlook.com ([207.46.100.135]:38200
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753532AbbDNKY0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Apr 2015 06:24:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Add eMMC DDR mode support for Freescale SDHC adapter card.
The u-boot should provide device tree properties 'adapter-type'
and 'periperal-frequency' for this feature, if not, the card
would not use DDR mode.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h    |  24 +++++++
 drivers/mmc/host/sdhci-of-esdhc.c | 132 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 3497cfa..a6f887e 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -27,10 +27,32 @@
 #define ESDHC_CLOCK_MASK	0x0000fff0
 #define ESDHC_PREDIV_SHIFT	8
 #define ESDHC_DIVIDER_SHIFT	4
+#define ESDHC_CLOCK_CRDEN	0x00000008
 #define ESDHC_CLOCK_PEREN	0x00000004
 #define ESDHC_CLOCK_HCKEN	0x00000002
 #define ESDHC_CLOCK_IPGEN	0x00000001
 
+#define ESDHCI_PRESENT_STATE	0x24
+#define ESDHC_CLK_STABLE	0x00000008
+
+#define ESDHC_CAPABILITIES_1	0x114
+#define ESDHC_MODE_MASK		0x00000007
+#define ESDHC_MODE_DDR50_SEL	0xfffffffc
+#define ESDHC_MODE_DDR50	0x00000004
+
+#define ESDHC_CLOCK_CONTROL	0x144
+#define ESDHC_CLKLPBK_EXTPIN	0x80000000
+#define ESDHC_CMDCLK_SHIFTED	0x00008000
+
+/* SDHC Adapter Card Type */
+#define ESDHC_ADAPTER_TYPE_EMMC45       0x1	/* eMMC Card Rev4.5 */
+#define ESDHC_ADAPTER_TYPE_SDMMC_LEGACY 0x2	/* SD/MMC Legacy Card */
+#define ESDHC_ADAPTER_TYPE_EMMC44       0x3	/* eMMC Card Rev4.4 */
+#define ESDHC_ADAPTER_TYPE_RSV          0x4	/* Reserved */
+#define ESDHC_ADAPTER_TYPE_MMC          0x5	/* MMC Card */
+#define ESDHC_ADAPTER_TYPE_SD           0x6	/* SD Card Rev2.0 Rev3.0 */
+#define ESDHC_NO_ADAPTER                0x7	/* No Card is Present*/
+
 /* pltfm-specific */
 #define ESDHC_HOST_CONTROL_LE	0x20
 
@@ -44,6 +66,8 @@
 /* OF-specific */
 #define ESDHC_DMA_SYSCTL	0x40c
 #define ESDHC_DMA_SNOOP		0x00000040
+#define ESDHC_FLUSH_ASYNC_FIFO          0x00040000
+#define ESDHC_USE_PERIPHERAL_CLK        0x00080000
 
 #define ESDHC_HOST_CONTROL_RES	0x05
 
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 858d65d..284094c 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -24,11 +24,30 @@
 
 #define VENDOR_V_22	0x12
 #define VENDOR_V_23	0x13
+
+static u32 adapter_type;
+static bool peripheral_clk_available;
+
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
 
-	ret = sdhci_32bs_readl(host, reg);
+	if (reg == SDHCI_CAPABILITIES_1) {
+		ret = sdhci_32bs_readl(host, ESDHC_CAPABILITIES_1);
+		switch (adapter_type) {
+		case ESDHC_ADAPTER_TYPE_EMMC44:
+			if (ret & ESDHC_MODE_DDR50) {
+				ret &= ESDHC_MODE_DDR50_SEL;
+				/* enable 1/8V DDR capable */
+				host->mmc->caps |= MMC_CAP_1_8V_DDR;
+			} else
+				ret &= ~ESDHC_MODE_MASK;
+			break;
+		default:
+			ret &= ~ESDHC_MODE_MASK;
+		}
+	} else
+		ret = sdhci_32bs_readl(host, reg);
 	/*
 	 * The bit of ADMA flag in eSDHC is not compatible with standard
 	 * SDHC register, so set fake flag SDHCI_CAN_DO_ADMA2 when ADMA is
@@ -159,8 +178,11 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 	}
 
 	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
-	if (reg == SDHCI_HOST_CONTROL)
+	if (reg == SDHCI_HOST_CONTROL) {
 		val &= ~ESDHC_HOST_CONTROL_RES;
+		val &= ~SDHCI_CTRL_HISPD;
+		val |= (sdhci_32bs_readl(host, reg) & SDHCI_CTRL_HISPD);
+	}
 	sdhci_clrsetbits(host, 0xff, val, reg);
 }
 
@@ -307,6 +329,84 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+static void esdhc_clock_control(struct sdhci_host *host, bool enable)
+{
+	u32 value;
+	u32 time_out;
+
+	value = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+
+	if (enable)
+		value |= ESDHC_CLOCK_CRDEN;
+	else
+		value &= ~ESDHC_CLOCK_CRDEN;
+
+	sdhci_writel(host, value, ESDHC_SYSTEM_CONTROL);
+
+	time_out = 20;
+	value = ESDHC_CLK_STABLE;
+	while (!(sdhci_readl(host, ESDHCI_PRESENT_STATE) & value)) {
+		if (time_out == 0) {
+			pr_err("%s: Internal clock never stabilised.\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+		time_out--;
+		mdelay(1);
+	}
+}
+
+static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
+{
+	u16 ctrl_2;
+	u32 time_out;
+	u32 value;
+
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	if ((uhs == MMC_TIMING_MMC_HS200) ||
+		(uhs == MMC_TIMING_UHS_SDR104))
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+	else if (uhs == MMC_TIMING_UHS_SDR12)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+	else if (uhs == MMC_TIMING_UHS_SDR25)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+	else if (uhs == MMC_TIMING_UHS_SDR50)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+	else if (uhs == MMC_TIMING_UHS_DDR50)
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+
+	if (uhs == MMC_TIMING_UHS_DDR50) {
+		esdhc_clock_control(host, false);
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+		value = sdhci_readl(host, ESDHC_CLOCK_CONTROL);
+		value |= (ESDHC_CLKLPBK_EXTPIN | ESDHC_CMDCLK_SHIFTED);
+		sdhci_writel(host, value, ESDHC_CLOCK_CONTROL);
+		esdhc_clock_control(host, true);
+
+		esdhc_clock_control(host, false);
+		value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+		value |= ESDHC_FLUSH_ASYNC_FIFO;
+		sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
+		/* Wait max 20 ms */
+		time_out = 20;
+		value = ESDHC_FLUSH_ASYNC_FIFO;
+		while (sdhci_readl(host, ESDHC_DMA_SYSCTL) & value) {
+			if (time_out == 0) {
+				pr_err("%s: FAF bit is auto cleaned failed.\n",
+					mmc_hostname(host->mmc));
+
+				break;
+			}
+			time_out--;
+			mdelay(1);
+		}
+		esdhc_clock_control(host, true);
+	} else
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
+
 static const struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -322,7 +422,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.adma_workaround = esdhci_of_adma_workaround,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = esdhc_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_uhs_signaling = esdhc_set_uhs_signaling,
 };
 
 #ifdef CONFIG_PM
@@ -376,6 +476,8 @@ static void esdhc_get_property(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	const __be32 *value;
+	int size;
 
 	sdhci_get_of_property(pdev);
 
@@ -383,6 +485,18 @@ static void esdhc_get_property(struct platform_device *pdev)
 	mmc_of_parse(host->mmc);
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
+	value = of_get_property(np, "adapter-type", &size);
+	if (value && size == sizeof(*value) && *value)
+		adapter_type = be32_to_cpup(value);
+
+	/* If getting a peripheral-frequency, use it instead */
+	value = of_get_property(np, "peripheral-frequency", &size);
+	if (value && size == sizeof(*value) && *value) {
+		pltfm_host->clock = be32_to_cpup(value);
+		peripheral_clk_available = true;
+	} else
+		peripheral_clk_available = false;
+
 	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
 		/*
 		 * Freescale messed up with P2020 as it has a non-standard
@@ -402,13 +516,23 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	int ret;
-
+	u32 value;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	esdhc_get_property(pdev);
+
+	/* Select peripheral clock as the eSDHC clock */
+	if (peripheral_clk_available) {
+		esdhc_clock_control(host, false);
+		value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+		value |= ESDHC_USE_PERIPHERAL_CLK;
+		sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
+		esdhc_clock_control(host, true);
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err;
-- 
2.1.0.27.g96db324

