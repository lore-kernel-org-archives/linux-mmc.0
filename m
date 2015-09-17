From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 4/8] mmc: sdhci-of-esdhc: add eMMC Adapter Card HS200 mode support
Date: Thu, 17 Sep 2015 13:50:50 +0800
Message-ID: <1442469054-23644-4-git-send-email-yangbo.lu@freescale.com>
References: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0139.outbound.protection.outlook.com ([207.46.100.139]:45216
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752989AbbIQF5b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Sep 2015 01:57:31 -0400
In-Reply-To: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Freescale QorIQ QDS boards use different SDHC Adapter card types as below.
To support SDHC Adapter card type 1(eMMC card Rev4.5) HS200 mode, select
to use peripheral clock and add callbacks for signal voltage switching and
tuning block setting for eSDHC.
SDHC_ADAPTER_TYPE:
ADAPTER_TYPE_1      0x1   /* eMMC Card Rev4.5 */
ADAPTER_TYPE_2      0x2   /* SD/MMC Legacy Card */
ADAPTER_TYPE_3      0x3   /* eMMC Card Rev4.4 */
ADAPTER_TYPE_4      0x4   /* Reserved */
ADAPTER_TYPE_5      0x5   /* MMC Card */
ADAPTER_TYPE_6      0x6   /* SD Card Rev2.0 Rev3.0 */
NO_ADAPTER          0x7   /* No Card is Present*/

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h    |  22 ++++++++
 drivers/mmc/host/sdhci-of-esdhc.c | 116 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 163ac99..de9be18 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -24,14 +24,34 @@
 				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
 				SDHCI_QUIRK_NO_HISPD_BIT)
 
+#define ESDHCI_PRESENT_STATE	0x24
+#define ESDHC_CLK_STABLE	0x00000008
+
+#define ESDHC_PROCTL		0x28
+#define ESDHC_VOLT_SEL		0x00000400
+
 #define ESDHC_SYSTEM_CONTROL	0x2c
 #define ESDHC_CLOCK_MASK	0x0000fff0
 #define ESDHC_PREDIV_SHIFT	8
 #define ESDHC_DIVIDER_SHIFT	4
+#define ESDHC_CLOCK_CRDEN	0x00000008
 #define ESDHC_CLOCK_PEREN	0x00000004
 #define ESDHC_CLOCK_HCKEN	0x00000002
 #define ESDHC_CLOCK_IPGEN	0x00000001
 
+#define ESDHC_CAPABILITIES_1	0x114
+#define ESDHC_MODE_MASK		0x00000007
+#define ESDHC_MODE_DDR50_SEL	0xfffffffc
+#define ESDHC_MODE_SDR104	0x00000002
+#define ESDHC_MODE_DDR50	0x00000004
+
+#define ESDHC_TBCTL		0x120
+#define ESDHC_TB_EN		0x00000004
+
+#define ESDHC_CLOCK_CONTROL	0x144
+#define ESDHC_CLKLPBK_EXTPIN	0x80000000
+#define ESDHC_CMDCLK_SHIFTED	0x00008000
+
 /* pltfm-specific */
 #define ESDHC_HOST_CONTROL_LE	0x20
 
@@ -45,6 +65,8 @@
 /* OF-specific */
 #define ESDHC_DMA_SYSCTL	0x40c
 #define ESDHC_DMA_SNOOP		0x00000040
+#define ESDHC_FLUSH_ASYNC_FIFO	0x00040000
+#define ESDHC_USE_PERICLK	0x00080000
 
 #define ESDHC_HOST_CONTROL_RES	0x01
 
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 653f335..bffc8c4 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -24,11 +24,35 @@
 
 #define VENDOR_V_22	0x12
 #define VENDOR_V_23	0x13
+
+/* SDHC Adapter Card Type */
+#define ESDHC_ADAPTER_TYPE_1      0x1	/* eMMC Card Rev4.5 */
+#define ESDHC_ADAPTER_TYPE_2      0x2	/* SD/MMC Legacy Card */
+#define ESDHC_ADAPTER_TYPE_3      0x3	/* eMMC Card Rev4.4 */
+#define ESDHC_ADAPTER_TYPE_4      0x4	/* Reserved */
+#define ESDHC_ADAPTER_TYPE_5      0x5	/* MMC Card */
+#define ESDHC_ADAPTER_TYPE_6      0x6	/* SD Card Rev2.0 Rev3.0 */
+#define ESDHC_NO_ADAPTER          0x7	/* No Card is Present*/
+
+static u32 adapter_type;
+
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
 
-	ret = in_be32(host->ioaddr + reg);
+	if (reg == SDHCI_CAPABILITIES_1) {
+		ret = in_be32(host->ioaddr + ESDHC_CAPABILITIES_1);
+		switch (adapter_type) {
+		case ESDHC_ADAPTER_TYPE_1:
+			if (ret & ESDHC_MODE_SDR104)
+				host->mmc->caps2 |= MMC_CAP2_HS200;
+			ret &= ~ESDHC_MODE_MASK;
+			break;
+		default:
+			ret &= ~ESDHC_MODE_MASK;
+		}
+	} else
+		ret = in_be32(host->ioaddr + reg);
 	/*
 	 * The bit of ADMA flag in eSDHC is not compatible with standard
 	 * SDHC register, so set fake flag SDHCI_CAN_DO_ADMA2 when ADMA is
@@ -137,8 +161,11 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 	}
 
 	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
-	if (reg == SDHCI_HOST_CONTROL)
+	if (reg == SDHCI_HOST_CONTROL) {
 		val &= ~ESDHC_HOST_CONTROL_RES;
+		val &= ~SDHCI_CTRL_HISPD;
+		val |= (in_be32(host->ioaddr + reg) & SDHCI_CTRL_HISPD);
+	}
 	sdhci_be32bs_writeb(host, val, reg);
 }
 
@@ -197,6 +224,33 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 	return pltfm_host->clock / 256 / 16;
 }
 
+void esdhc_clock_control(struct sdhci_host *host, bool enable)
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
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int pre_div = 1;
@@ -282,6 +336,42 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 			ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
 }
 
+void esdhc_set_tuning_block(struct sdhci_host *host)
+{
+	u32 value;
+
+	esdhc_clock_control(host, false);
+	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+	value |= ESDHC_FLUSH_ASYNC_FIFO;
+	sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
+
+	value = sdhci_readl(host, ESDHC_TBCTL);
+	value |= ESDHC_TB_EN;
+	sdhci_writel(host, value, ESDHC_TBCTL);
+	esdhc_clock_control(host, true);
+}
+
+void esdhc_signal_voltage_switch(struct sdhci_host *host,
+				 unsigned char signal_voltage)
+{
+	u32 value;
+
+	value = sdhci_readl(host, ESDHC_PROCTL);
+
+	switch (signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		value &= (~ESDHC_VOLT_SEL);
+		sdhci_writel(host, value, ESDHC_PROCTL);
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		value |= ESDHC_VOLT_SEL;
+		sdhci_writel(host, value, ESDHC_PROCTL);
+		break;
+	default:
+		return;
+	}
+}
+
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
 	sdhci_reset(host, mask);
@@ -306,6 +396,8 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_tuning_block = esdhc_set_tuning_block,
+	.signal_voltage_switch = esdhc_signal_voltage_switch,
 };
 
 #ifdef CONFIG_PM
@@ -358,6 +450,10 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct device_node *np;
+	struct sdhci_pltfm_host *pltfm_host;
+	const __be32 *value;
+	u32 val;
+	int size;
 	int ret;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
@@ -382,6 +478,22 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
 	}
 
+	value = of_get_property(np, "adapter-type", &size);
+	if (value && size == sizeof(*value) && *value)
+		adapter_type = be32_to_cpup(value);
+
+	/* If getting a peripheral-frequency, use it instead */
+	value = of_get_property(np, "peripheral-frequency", &size);
+	if (value && size == sizeof(*value) && *value) {
+		pltfm_host = sdhci_priv(host);
+		pltfm_host->clock = be32_to_cpup(value);
+		esdhc_clock_control(host, false);
+		val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+		val |= ESDHC_USE_PERICLK;
+		sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
+		esdhc_clock_control(host, true);
+	}
+
 	/* call to generic mmc_of_parse to support additional capabilities */
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-- 
2.1.0.27.g96db324

