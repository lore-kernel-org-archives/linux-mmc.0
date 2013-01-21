From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 5/6] mmc: sdhci-esdhc-imx: support 8bit mode
Date: Mon, 21 Jan 2013 19:02:28 +0800
Message-ID: <1358766149-9534-6-git-send-email-shawn.guo@linaro.org>
References: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:55277
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403Ab3AUKel (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 05:34:41 -0500
In-Reply-To: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

From: Sascha Hauer <s.hauer@pengutronix.de>

The i.MX esdhc has a nonstandard bit layout for the SDHCI_HOST_CONTROL
register. To support 8bit bus width on i.MX populate the platform_bus_width
callback. This is tested on an i.MX25, but should according to the datasheets
work on the other i.MX using this hardware aswell. The i.MX6, while having
a SDHCI_SPEC_300 controller, still uses the same nonstandard register layout.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          |   56 ++++++++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h |    1 +
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 24daaf4..f7ee5e6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -41,6 +41,13 @@
 #define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
 
 /*
+ * Our interpretation of the SDHCI_HOST_CONTROL register
+ */
+#define ESDHC_CTRL_4BITBUS		(0x1 << 1)
+#define ESDHC_CTRL_8BITBUS		(0x2 << 1)
+#define ESDHC_CTRL_BUSWIDTH_MASK	(0x3 << 1)
+
+/*
  * There is an INT DMA ERR mis-match between eSDHC and STD SDHC SPEC:
  * Bit25 is used in STD SPEC, and is reserved in fsl eSDHC design,
  * but bit28 is used as the INT DMA ERR in fsl eSDHC design.
@@ -294,6 +301,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 	u32 new_val;
+	u32 mask;
 
 	switch (reg) {
 	case SDHCI_POWER_CONTROL:
@@ -304,7 +312,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		return;
 	case SDHCI_HOST_CONTROL:
 		/* FSL messed up here, so we need to manually compose it. */
-		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
+		new_val = val & SDHCI_CTRL_LED;
 		/* ensure the endianness */
 		new_val |= ESDHC_HOST_CONTROL_LE;
 		/* bits 8&9 are reserved on mx25 */
@@ -313,7 +321,13 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
 		}
 
-		esdhc_clrset_le(host, 0xffff, new_val, reg);
+		/*
+		 * Do not touch buswidth bits here. This is done in
+		 * esdhc_pltfm_bus_width.
+		 */
+		mask = 0xffff & ~ESDHC_CTRL_BUSWIDTH_MASK;
+
+		esdhc_clrset_le(host, mask, new_val, reg);
 		return;
 	}
 	esdhc_clrset_le(host, 0xff, val, reg);
@@ -370,6 +384,28 @@ static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 	return -ENOSYS;
 }
 
+static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
+{
+	u32 ctrl;
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		ctrl = ESDHC_CTRL_8BITBUS;
+		break;
+	case MMC_BUS_WIDTH_4:
+		ctrl = ESDHC_CTRL_4BITBUS;
+		break;
+	default:
+		ctrl = 0;
+		break;
+	}
+
+	esdhc_clrset_le(host, ESDHC_CTRL_BUSWIDTH_MASK, ctrl,
+			SDHCI_HOST_CONTROL);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -380,6 +416,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_ro = esdhc_pltfm_get_ro,
+	.platform_bus_width = esdhc_pltfm_bus_width,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
@@ -417,6 +454,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (gpio_is_valid(boarddata->wp_gpio))
 		boarddata->wp_type = ESDHC_WP_GPIO;
 
+	of_property_read_u32(np, "bus-width", &boarddata->max_bus_width);
+
 	return 0;
 }
 #else
@@ -548,6 +587,19 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		break;
 	}
 
+	switch (boarddata->max_bus_width) {
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
 	err = sdhci_add_host(host);
 	if (err)
 		goto disable_clk;
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index aaf9748..b4a0521 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -39,5 +39,6 @@ struct esdhc_platform_data {
 	unsigned int cd_gpio;
 	enum wp_types wp_type;
 	enum cd_types cd_type;
+	int max_bus_width;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.7.9.5


