From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and sdhci-esdhc-imx
Date: Thu,  5 May 2011 21:22:56 +0800
Message-ID: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33002 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab1EENT0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 09:19:26 -0400
Received: by pzk9 with SMTP id 9so959064pzk.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 May 2011 06:19:25 -0700 (PDT)
In-Reply-To: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

This patch is to consolidate SDHCI driver for Freescale eSDHC
controller found on both MPCxxx and i.MX platforms.  It merges
sdhci-of-esdhc.c into sdhci-esdhc.c, so that the same pair of
.probe/.remove hook works with eSDHC for two platforms.

As the results, sdhci-of-esdhc.c and sdhci-esdhc.h are removed, and
header esdhc.h containing the definition of esdhc_platform_data is
put into the public folder.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/Kconfig          |   38 ++++---
 drivers/mmc/host/Makefile         |    3 +-
 drivers/mmc/host/sdhci-esdhc.c    |  244 +++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci-esdhc.h    |   81 ------------
 drivers/mmc/host/sdhci-of-esdhc.c |  142 ---------------------
 include/linux/mmc/esdhc.h         |   27 ++++
 6 files changed, 273 insertions(+), 262 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-esdhc.h
 delete mode 100644 drivers/mmc/host/sdhci-of-esdhc.c
 create mode 100644 include/linux/mmc/esdhc.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fdd20ad..e32cb76 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -81,17 +81,6 @@ config MMC_RICOH_MMC
 
 	  If unsure, say Y.
 
-config MMC_SDHCI_OF_ESDHC
-	bool "SDHCI OF support for the Freescale eSDHC controller"
-	depends on MMC_SDHCI
-	depends on PPC_OF
-	select MMC_SDHCI_PLTFM
-	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
-	help
-	  This selects the Freescale eSDHC controller support.
-
-	  If unsure, say N.
-
 config MMC_SDHCI_OF_HLWD
 	bool "SDHCI OF support for the Nintendo Wii SDHCI controllers"
 	depends on MMC_SDHCI
@@ -122,15 +111,34 @@ config MMC_SDHCI_CNS3XXX
 
 	  If unsure, say N.
 
+config MMC_SDHCI_ESDHC
+	bool
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
+	help
+	  This selects SDHCI driver for Freescale eSDHC controller.
+
+config MMC_SDHCI_ESDHC_MPC
+	bool "SDHCI support for the Freescale eSDHC MPC controller"
+	depends on MMC_SDHCI
+	depends on PPC_OF && PPC_CLOCK
+	select MMC_SDHCI_ESDHC
+	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
+	help
+	  This selects the Freescale eSDHC controller support on the
+	  MPC platforms.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_ESDHC_IMX
-	tristate "SDHCI platform support for the Freescale eSDHC i.MX controller"
+	tristate "SDHCI support for the Freescale eSDHC i.MX controller"
 	depends on ARCH_MX25 || ARCH_MX35 || ARCH_MX5
 	depends on MMC_SDHCI
-	select MMC_SDHCI_PLTFM
+	select MMC_SDHCI_ESDHC
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-	  This selects the Freescale eSDHC controller support on the platform
-	  bus, found on platforms like mx35/51.
+	  This selects the Freescale eSDHC controller support on platforms
+          like mx25/mx35/mx5x.
 
 	  If unsure, say N.
 
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 186f0ed..a3f1df8 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -45,10 +45,9 @@ obj-$(CONFIG_MMC_USHC)		+= ushc.o
 
 obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
-obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc.o
+obj-$(CONFIG_MMC_SDHCI_ESDHC)		+= sdhci-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
-obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
diff --git a/drivers/mmc/host/sdhci-esdhc.c b/drivers/mmc/host/sdhci-esdhc.c
index 8da57d4..f3b4ff5 100644
--- a/drivers/mmc/host/sdhci-esdhc.c
+++ b/drivers/mmc/host/sdhci-esdhc.c
@@ -1,7 +1,11 @@
 /*
- * Freescale eSDHC i.MX controller driver for the platform bus.
+ * Freescale eSDHC i.MX controller driver for MPCxxx and i.MX.
  *
- * derived from the OF-version.
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *   Author: Xiaobo Xie <X.Xie@freescale.com>
+ *
+ * Copyright (c) 2009 MontaVista Software, Inc.
+ *   Author: Anton Vorontsov <avorontsov@ru.mvista.com>
  *
  * Copyright (c) 2010 Pengutronix e.K.
  *   Author: Wolfram Sang <w.sang@pengutronix.de>
@@ -21,11 +25,40 @@
 #include <linux/mmc/sdhci-pltfm.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
+#include <linux/mmc/esdhc.h>
+#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
 #include <mach/hardware.h>
-#include <mach/esdhc.h>
+#endif
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
-#include "sdhci-esdhc.h"
+
+/*
+ * Ops and quirks for the Freescale eSDHC controller.
+ */
+
+#define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
+				SDHCI_QUIRK_NO_BUSY_IRQ | \
+				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
+				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
+				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
+				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
+
+#define ESDHC_SYSTEM_CONTROL	0x2c
+#define ESDHC_CLOCK_MASK	0x0000fff0
+#define ESDHC_PREDIV_SHIFT	8
+#define ESDHC_DIVIDER_SHIFT	4
+#define ESDHC_CLOCK_PEREN	0x00000004
+#define ESDHC_CLOCK_HCKEN	0x00000002
+#define ESDHC_CLOCK_IPGEN	0x00000001
+
+/* OF-specific */
+#define ESDHC_DMA_SYSCTL	0x40c
+#define ESDHC_DMA_SNOOP		0x00000040
+
+#define ESDHC_HOST_CONTROL_RES	0x05
+
+/* pltfm-specific */
+#define ESDHC_HOST_CONTROL_LE	0x20
 
 /* VENDOR SPEC register */
 #define SDHCI_VENDOR_SPEC		0xC0
@@ -50,6 +83,117 @@ struct pltfm_imx_data {
 	u32 scratchpad;
 };
 
+static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	int pre_div = 2;
+	int div = 1;
+	u32 temp;
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+		| ESDHC_CLOCK_MASK);
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
+	if (clock == 0)
+		goto out;
+
+	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
+		pre_div *= 2;
+
+	while (host->max_clk / pre_div / div > clock && div < 16)
+		div++;
+
+	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
+		clock, host->max_clk / pre_div / div);
+
+	pre_div >>= 1;
+	div--;
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+		| (div << ESDHC_DIVIDER_SHIFT)
+		| (pre_div << ESDHC_PREDIV_SHIFT));
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+	mdelay(100);
+out:
+	host->clock = clock;
+}
+
+#ifdef CONFIG_MMC_SDHCI_ESDHC_MPC
+static u16 esdhc_readw(struct sdhci_host *host, int reg)
+{
+	u16 ret;
+
+	if (unlikely(reg == SDHCI_HOST_VERSION))
+		ret = in_be16(host->ioaddr + reg);
+	else
+		ret = sdhci_be32bs_readw(host, reg);
+	return ret;
+}
+
+static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	if (reg == SDHCI_BLOCK_SIZE) {
+		/*
+		 * Two last DMA bits are reserved, and first one is used for
+		 * non-standard blksz of 4096 bytes that we don't support
+		 * yet. So clear the DMA boundary bits.
+		 */
+		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
+	}
+	sdhci_be32bs_writew(host, val, reg);
+}
+
+static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
+	if (reg == SDHCI_HOST_CONTROL)
+		val &= ~ESDHC_HOST_CONTROL_RES;
+	sdhci_be32bs_writeb(host, val, reg);
+}
+
+static int esdhc_of_enable_dma(struct sdhci_host *host)
+{
+	setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
+	return 0;
+}
+
+static unsigned int esdhc_of_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return pltfm_host->clock;
+}
+
+static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return pltfm_host->clock / 256 / 16;
+}
+
+static struct sdhci_ops sdhci_esdhc_mpc_ops = {
+	.read_l = sdhci_be32bs_readl,
+	.read_w = esdhc_readw,
+	.read_b = sdhci_be32bs_readb,
+	.write_l = sdhci_be32bs_writel,
+	.write_w = esdhc_writew,
+	.write_b = esdhc_writeb,
+	.set_clock = esdhc_set_clock,
+	.enable_dma = esdhc_of_enable_dma,
+	.get_max_clock = esdhc_of_get_max_clock,
+	.get_min_clock = esdhc_of_get_min_clock,
+};
+
+static struct sdhci_pltfm_data sdhci_esdhc_mpc_pdata = {
+	/* card detection could be handled via GPIO */
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
+		| SDHCI_QUIRK_NO_CARD_NO_RESET,
+	.ops = &sdhci_esdhc_mpc_ops,
+};
+#endif /* CONFIG_MMC_SDHCI_ESDHC_MPC */
+
+#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
 {
 	void __iomem *base = host->ioaddr + (reg & ~0x3);
@@ -191,7 +335,7 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
-static struct sdhci_ops sdhci_esdhc_ops = {
+static struct sdhci_ops sdhci_esdhc_imx_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
 	.write_l = esdhc_writel_le,
@@ -206,8 +350,35 @@ static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
 			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
 	/* ADMA has issues. Might be fixable */
-	.ops = &sdhci_esdhc_ops,
+	.ops = &sdhci_esdhc_imx_ops,
+};
+#endif /* CONFIG_MMC_SDHCI_ESDHC_IMX */
+
+#ifdef CONFIG_OF
+#include <linux/of_device.h>
+static const struct of_device_id sdhci_esdhc_dt_ids[] = {
+#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
+	{ .compatible = "fsl,imx-esdhc", .data = &sdhci_esdhc_imx_pdata },
+#endif
+#ifdef CONFIG_MMC_SDHCI_ESDHC_MPC
+	{ .compatible = "fsl,mpc8379-esdhc", .data = &sdhci_esdhc_mpc_pdata },
+	{ .compatible = "fsl,mpc8536-esdhc", .data = &sdhci_esdhc_mpc_pdata },
+	{ .compatible = "fsl,esdhc", .data = &sdhci_esdhc_mpc_pdata },
+#endif
+	{ }
 };
+MODULE_DEVICE_TABLE(platform, sdhci_esdhc_dt_ids);
+#else
+#define sdhci_esdhc_dt_ids NULL
+#endif
+
+static const struct platform_device_id sdhci_esdhc_pltfm_ids[] = {
+#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
+	{ "sdhci-esdhc-imx", (kernel_ulong_t)&sdhci_esdhc_imx_pdata },
+#endif
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sdhci_esdhc_pltfm_ids);
 
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 {
@@ -227,8 +398,20 @@ static irqreturn_t cd_irq(int irq, void *data)
 	return IRQ_HANDLED;
 };
 
-static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
+#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
+#define cpu_is_mx25()	(0)
+#define cpu_is_mx35()	(0)
+#define cpu_is_mx51()	(0)
+#define cpu_is_imx()	(0)
+#else
+#define cpu_is_imx()	(1)
+#endif
+
+static int __devinit sdhci_esdhc_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	const struct of_device_id *dtid = pdev->dev.of_match;
+	struct sdhci_pltfm_data *pdata;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct esdhc_platform_data *boarddata;
@@ -236,12 +419,24 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	int err;
 	struct pltfm_imx_data *imx_data;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
+	if (platid && platid->driver_data)
+		pdata = (void *)platid->driver_data;
+	else if (dtid && dtid->data)
+		pdata = dtid->data;
+	else
+		pdata = pdev->dev.platform_data;
+
+	host = sdhci_pltfm_init(pdev, pdata);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	sdhci_get_of_property(pdev);
+
 	pltfm_host = sdhci_priv(host);
 
+	if (!cpu_is_imx())
+		goto add_host;
+
 	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
 	if (!imx_data)
 		return -ENOMEM;
@@ -263,7 +458,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
 		/* write_protect can't be routed to controller, use gpio */
-		sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
+		pdata->ops->get_ro = esdhc_pltfm_get_ro;
 	}
 
 	if (!(cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()))
@@ -302,6 +497,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
 
+ add_host:
 	err = sdhci_add_host(host);
 	if (err)
 		goto err_add_host;
@@ -322,7 +518,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
+static int __devexit sdhci_esdhc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -351,31 +547,35 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver sdhci_esdhc_imx_driver = {
+static struct platform_driver sdhci_esdhc_driver = {
 	.driver		= {
-		.name	= "sdhci-esdhc-imx",
+		.name	= "sdhci-esdhc",
 		.owner	= THIS_MODULE,
+		.of_match_table = sdhci_esdhc_dt_ids,
 	},
-	.probe		= sdhci_esdhc_imx_probe,
-	.remove		= __devexit_p(sdhci_esdhc_imx_remove),
+	.probe		= sdhci_esdhc_probe,
+	.remove		= __devexit_p(sdhci_esdhc_remove),
+	.id_table	= sdhci_esdhc_pltfm_ids,
 #ifdef CONFIG_PM
 	.suspend	= sdhci_pltfm_suspend,
 	.resume		= sdhci_pltfm_resume,
 #endif
 };
  
-static int __init sdhci_esdhc_imx_init(void)
+static int __init sdhci_esdhc_init(void)
 {
-	return platform_driver_register(&sdhci_esdhc_imx_driver);
+	return platform_driver_register(&sdhci_esdhc_driver);
 }
-module_init(sdhci_esdhc_imx_init);
+module_init(sdhci_esdhc_init);
 
-static void __exit sdhci_esdhc_imx_exit(void)
+static void __exit sdhci_esdhc_exit(void)
 {
-	platform_driver_unregister(&sdhci_esdhc_imx_driver);
+	platform_driver_unregister(&sdhci_esdhc_driver);
 }
-module_exit(sdhci_esdhc_imx_exit);
+module_exit(sdhci_esdhc_exit);
 
-MODULE_DESCRIPTION("SDHCI driver for Freescale i.MX eSDHC");
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_DESCRIPTION("SDHCI driver for Freescale eSDHC");
+MODULE_AUTHOR("Xiaobo Xie <X.Xie@freescale.com>, "
+	      "Anton Vorontsov <avorontsov@ru.mvista.com>, "
+	      "Wolfram Sang <w.sang@pengutronix.de>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
deleted file mode 100644
index c3b08f1..0000000
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * Freescale eSDHC controller driver generics for OF and pltfm.
- *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
- * Copyright (c) 2009 MontaVista Software, Inc.
- * Copyright (c) 2010 Pengutronix e.K.
- *   Author: Wolfram Sang <w.sang@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
- */
-
-#ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
-#define _DRIVERS_MMC_SDHCI_ESDHC_H
-
-/*
- * Ops and quirks for the Freescale eSDHC controller.
- */
-
-#define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
-				SDHCI_QUIRK_NO_BUSY_IRQ | \
-				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
-				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
-				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
-				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
-
-#define ESDHC_SYSTEM_CONTROL	0x2c
-#define ESDHC_CLOCK_MASK	0x0000fff0
-#define ESDHC_PREDIV_SHIFT	8
-#define ESDHC_DIVIDER_SHIFT	4
-#define ESDHC_CLOCK_PEREN	0x00000004
-#define ESDHC_CLOCK_HCKEN	0x00000002
-#define ESDHC_CLOCK_IPGEN	0x00000001
-
-/* pltfm-specific */
-#define ESDHC_HOST_CONTROL_LE	0x20
-
-/* OF-specific */
-#define ESDHC_DMA_SYSCTL	0x40c
-#define ESDHC_DMA_SNOOP		0x00000040
-
-#define ESDHC_HOST_CONTROL_RES	0x05
-
-static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
-{
-	int pre_div = 2;
-	int div = 1;
-	u32 temp;
-
-	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
-	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
-		| ESDHC_CLOCK_MASK);
-	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-
-	if (clock == 0)
-		goto out;
-
-	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
-		pre_div *= 2;
-
-	while (host->max_clk / pre_div / div > clock && div < 16)
-		div++;
-
-	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
-		clock, host->max_clk / pre_div / div);
-
-	pre_div >>= 1;
-	div--;
-
-	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
-	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
-		| (div << ESDHC_DIVIDER_SHIFT)
-		| (pre_div << ESDHC_PREDIV_SHIFT));
-	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-	mdelay(100);
-out:
-	host->clock = clock;
-}
-
-#endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
deleted file mode 100644
index 2db6a45..0000000
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * Freescale eSDHC controller driver.
- *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
- * Copyright (c) 2009 MontaVista Software, Inc.
- *
- * Authors: Xiaobo Xie <X.Xie@freescale.com>
- *	    Anton Vorontsov <avorontsov@ru.mvista.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- */
-
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/mmc/host.h>
-#include "sdhci-pltfm.h"
-#include "sdhci.h"
-#include "sdhci-esdhc.h"
-
-static u16 esdhc_readw(struct sdhci_host *host, int reg)
-{
-	u16 ret;
-
-	if (unlikely(reg == SDHCI_HOST_VERSION))
-		ret = in_be16(host->ioaddr + reg);
-	else
-		ret = sdhci_be32bs_readw(host, reg);
-	return ret;
-}
-
-static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
-{
-	if (reg == SDHCI_BLOCK_SIZE) {
-		/*
-		 * Two last DMA bits are reserved, and first one is used for
-		 * non-standard blksz of 4096 bytes that we don't support
-		 * yet. So clear the DMA boundary bits.
-		 */
-		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
-	}
-	sdhci_be32bs_writew(host, val, reg);
-}
-
-static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
-{
-	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
-	if (reg == SDHCI_HOST_CONTROL)
-		val &= ~ESDHC_HOST_CONTROL_RES;
-	sdhci_be32bs_writeb(host, val, reg);
-}
-
-static int esdhc_of_enable_dma(struct sdhci_host *host)
-{
-	setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
-	return 0;
-}
-
-static unsigned int esdhc_of_get_max_clock(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	return pltfm_host->clock;
-}
-
-static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	return pltfm_host->clock / 256 / 16;
-}
-
-static struct sdhci_ops sdhci_esdhc_ops = {
-	.read_l = sdhci_be32bs_readl,
-	.read_w = esdhc_readw,
-	.read_b = sdhci_be32bs_readb,
-	.write_l = sdhci_be32bs_writel,
-	.write_w = esdhc_writew,
-	.write_b = esdhc_writeb,
-	.set_clock = esdhc_set_clock,
-	.enable_dma = esdhc_of_enable_dma,
-	.get_max_clock = esdhc_of_get_max_clock,
-	.get_min_clock = esdhc_of_get_min_clock,
-};
-
-static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
-	/* card detection could be handled via GPIO */
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
-		| SDHCI_QUIRK_NO_CARD_NO_RESET,
-	.ops = &sdhci_esdhc_ops,
-};
-
-static int __devinit sdhci_esdhc_probe(struct platform_device *pdev)
-{
-	return sdhci_pltfm_register(pdev, &sdhci_esdhc_pdata);
-}
-
-static int __devexit sdhci_esdhc_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
-static const struct of_device_id sdhci_esdhc_of_match[] = {
-	{ .compatible = "fsl,mpc8379-esdhc" },
-	{ .compatible = "fsl,mpc8536-esdhc" },
-	{ .compatible = "fsl,esdhc" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, sdhci_esdhc_of_match);
-
-static struct platform_driver sdhci_esdhc_driver = {
-	.driver = {
-		.name = "sdhci-esdhc",
-		.owner = THIS_MODULE,
-		.of_match_table = sdhci_esdhc_of_match,
-	},
-	.probe = sdhci_esdhc_probe,
-	.remove = __devexit_p(sdhci_esdhc_remove),
-#ifdef CONFIG_PM
-	.suspend = sdhci_pltfm_suspend,
-	.resume = sdhci_pltfm_resume,
-#endif
-};
-
-static int __init sdhci_esdhc_init(void)
-{
-	return platform_driver_register(&sdhci_esdhc_driver);
-}
-module_init(sdhci_esdhc_init);
-
-static void __exit sdhci_esdhc_exit(void)
-{
-	platform_driver_unregister(&sdhci_esdhc_driver);
-}
-module_exit(sdhci_esdhc_exit);
-
-MODULE_DESCRIPTION("SDHCI OF driver for Freescale MPC eSDHC");
-MODULE_AUTHOR("Xiaobo Xie <X.Xie@freescale.com>, "
-	      "Anton Vorontsov <avorontsov@ru.mvista.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mmc/esdhc.h b/include/linux/mmc/esdhc.h
new file mode 100644
index 0000000..e0f6598
--- /dev/null
+++ b/include/linux/mmc/esdhc.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2010 Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#ifndef __LINUX_MMC_ESDHC_H
+#define __LINUX_MMC_ESDHC_H
+
+/**
+ * struct esdhc_platform_data - optional platform data for esdhc
+ *
+ * strongly recommended for i.MX25/35, not needed for other variants
+ *
+ * @wp_gpio:	gpio for write_protect (-EINVAL if unused)
+ * @cd_gpio:	gpio for card_detect interrupt (-EINVAL if unused)
+ */
+
+struct esdhc_platform_data {
+	unsigned int wp_gpio;
+	unsigned int cd_gpio;
+};
+
+#endif /* __LINUX_MMC_ESDHC_H */
-- 
1.7.4.1

