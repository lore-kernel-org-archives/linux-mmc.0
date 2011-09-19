From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci-esdhc-imx: add basic imx6q usdhc support
Date: Mon, 19 Sep 2011 17:32:21 +0800
Message-ID: <1316424742-18502-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44570 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab1ISJbK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2011 05:31:10 -0400
Received: by yxl31 with SMTP id 31so2475yxl.19
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2011 02:31:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

This patch adds the basic support for imx6q usdhc, which is a
derivative of esdhc controller.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/Kconfig           |    6 +++---
 drivers/mmc/host/sdhci-esdhc-imx.c |   36 ++++++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c226d54..87d5067 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -130,13 +130,13 @@ config MMC_SDHCI_CNS3XXX
 	  If unsure, say N.
 
 config MMC_SDHCI_ESDHC_IMX
-	tristate "SDHCI platform support for the Freescale eSDHC i.MX controller"
+	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
 	depends on ARCH_MXC
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-	  This selects the Freescale eSDHC controller support on the platform
-	  bus, found on i.MX25, i.MX35 and i.MX5x.
+	  This selects the Freescale eSDHC/uSDHC controller support
+	  found on i.MX25, i.MX35 i.MX5x and i.MX6x.
 
 	  If you have a controller with this interface, say Y or M here.
 
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 4557aa1..ae57769 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -32,6 +32,7 @@
 /* VENDOR SPEC register */
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
+#define SDHCI_MIX_CTRL			0x48
 
 /*
  * There is an INT DMA ERR mis-match between eSDHC and STD SDHC SPEC:
@@ -59,6 +60,7 @@ enum imx_esdhc_type {
 	IMX35_ESDHC,
 	IMX51_ESDHC,
 	IMX53_ESDHC,
+	IMX6Q_USDHC,
 };
 
 struct pltfm_imx_data {
@@ -82,6 +84,9 @@ static struct platform_device_id imx_esdhc_devtype[] = {
 		.name = "sdhci-esdhc-imx53",
 		.driver_data = IMX53_ESDHC,
 	}, {
+		.name = "sdhci-usdhc-imx6q",
+		.driver_data = IMX6Q_USDHC,
+	}, {
 		/* sentinel */
 	}
 };
@@ -92,6 +97,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx35-esdhc", .data = &imx_esdhc_devtype[IMX35_ESDHC], },
 	{ .compatible = "fsl,imx51-esdhc", .data = &imx_esdhc_devtype[IMX51_ESDHC], },
 	{ .compatible = "fsl,imx53-esdhc", .data = &imx_esdhc_devtype[IMX53_ESDHC], },
+	{ .compatible = "fsl,imx6q-usdhc", .data = &imx_esdhc_devtype[IMX6Q_USDHC], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
@@ -116,6 +122,11 @@ static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
 	return data->devtype == IMX53_ESDHC;
 }
 
+static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
+{
+	return data->devtype == IMX6Q_USDHC;
+}
+
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
 {
 	void __iomem *base = host->ioaddr + (reg & ~0x3);
@@ -220,8 +231,16 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 
 static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 {
-	if (unlikely(reg == SDHCI_HOST_VERSION))
-		reg ^= 2;
+	if (unlikely(reg == SDHCI_HOST_VERSION)) {
+		u16 val = readw(host->ioaddr + (reg ^ 2));
+		/*
+		 * uSDHC supports SDHCI v3.0, but it's encoded as value
+		 * 0x3 in host controller version register, which violates
+		 * SDHCI_SPEC_300 definition.  Work it around here.
+		 */
+		if ((val & SDHCI_SPEC_VER_MASK) == 3)
+			return --val;
+	}
 
 	return readw(host->ioaddr + reg);
 }
@@ -252,8 +271,17 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION)
 			&& (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
 			val |= SDHCI_CMD_ABORTCMD;
-		writel(val << 16 | imx_data->scratchpad,
-			host->ioaddr + SDHCI_TRANSFER_MODE);
+
+		if (is_imx6q_usdhc(imx_data)) {
+			u32 m = readl(host->ioaddr + SDHCI_MIX_CTRL);
+			m = imx_data->scratchpad | (m & 0xffff0000);
+			writel(m, host->ioaddr + SDHCI_MIX_CTRL);
+			writel(val << 16,
+			       host->ioaddr + SDHCI_TRANSFER_MODE);
+		} else {
+			writel(val << 16 | imx_data->scratchpad,
+			       host->ioaddr + SDHCI_TRANSFER_MODE);
+		}
 		return;
 	case SDHCI_BLOCK_SIZE:
 		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
-- 
1.7.4.1

