From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [RFC PATCH 1/2] sdhci-of: reorganize driver to support additional hardware
Date: Mon, 14 Dec 2009 20:33:25 +0100
Message-ID: <1260819206-30074-2-git-send-email-albert_herranz@yahoo.es>
References: <1260819206-30074-1-git-send-email-albert_herranz@yahoo.es>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp141.mail.ukl.yahoo.com ([77.238.184.72]:46163 "HELO
	smtp141.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752721AbZLNTkY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 14:40:24 -0500
In-Reply-To: <1260819206-30074-1-git-send-email-albert_herranz@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, Albert Herranz <albert_herranz@yahoo.es>

This patch breaks down sdhci-of into a core portion and a eSDHC portion,
clearing the path to easily support additional hardware using the same
OF driver.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/mmc/host/Kconfig          |   26 +++-
 drivers/mmc/host/Makefile         |    5 +-
 drivers/mmc/host/sdhci-of-core.c  |  227 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c |  142 ++++++++++++++++
 drivers/mmc/host/sdhci-of.c       |  336 -------------------------------------
 drivers/mmc/host/sdhci-of.h       |   42 +++++
 6 files changed, 438 insertions(+), 340 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-of-core.c
 create mode 100644 drivers/mmc/host/sdhci-of-esdhc.c
 delete mode 100644 drivers/mmc/host/sdhci-of.c
 create mode 100644 drivers/mmc/host/sdhci-of.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 432ae83..92076b3 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -44,6 +44,19 @@ config MMC_SDHCI_IO_ACCESSORS
 	  This is silent Kconfig symbol that is selected by the drivers that
 	  need to overwrite SDHCI IO memory accessors.
 
+config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
+	bool
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This option is selected by drivers running on big endian hosts
+	  and performing I/O to a SDHCI controller through a bus that
+	  implements a hardware byte swapper using a 32-bit datum.
+	  This endian mapping mode is called "data invariance" and
+	  has the effect of scrambling the addresses and formats of data
+	  accessed in sizes other than the datum size.
+
+	  This is the case for the Freescale eSDHC.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
@@ -75,11 +88,18 @@ config MMC_RICOH_MMC
 config MMC_SDHCI_OF
 	tristate "SDHCI support on OpenFirmware platforms"
 	depends on MMC_SDHCI && PPC_OF
-	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the OF support for Secure Digital Host Controller
-	  Interfaces. So far, only the Freescale eSDHC controller is known
-	  to exist on OF platforms.
+	  Interfaces.
+
+	  If unsure, say N.
+
+config MMC_SDHCI_OF_ESDHC
+	bool "SDHCI OF support for the Freescale eSDHC controller"
+	depends on MMC_SDHCI_OF
+	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
+	help
+	  This selects the Freescale eSDHC controller support.
 
 	  If unsure, say N.
 
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index abcb040..2563c81 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_RICOH_MMC)	+= ricoh_mmc.o
-obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)	+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
@@ -35,6 +34,10 @@ obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_CB710)	+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 
+obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
+sdhci-of-y				:= sdhci-of-core.o
+sdhci-of-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
+
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
 endif
diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
new file mode 100644
index 0000000..5d64424
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -0,0 +1,227 @@
+/*
+ * OpenFirmware bindings for Secure Digital Host Controller Interface.
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2009 MontaVista Software, Inc.
+ *
+ * Authors: Xiaobo Xie <X.Xie@freescale.com>
+ *	    Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/mmc/host.h>
+#include <asm/machdep.h>
+#include "sdhci-of.h"
+
+#ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
+
+/*
+ * These accessors are designed for big endian hosts doing I/O to
+ * little endian controllers incorporating a 32-bit hardware byte swapper.
+ */
+
+u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
+{
+	return in_be32(host->ioaddr + reg);
+}
+
+u16 sdhci_be32bs_readw(struct sdhci_host *host, int reg)
+{
+	return in_be16(host->ioaddr + (reg ^ 0x2));
+}
+
+u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg)
+{
+	return in_8(host->ioaddr + (reg ^ 0x3));
+}
+
+void sdhci_be32bs_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	out_be32(host->ioaddr + reg, val);
+}
+
+void sdhci_be32bs_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_of_host *of_host = sdhci_priv(host);
+	int base = reg & ~0x3;
+	int shift = (reg & 0x2) * 8;
+
+	switch (reg) {
+	case SDHCI_TRANSFER_MODE:
+		/*
+		 * Postpone this write, we must do it together with a
+		 * command write that is down below.
+		 */
+		of_host->xfer_mode_shadow = val;
+		return;
+	case SDHCI_COMMAND:
+		sdhci_be32bs_writel(host, val << 16 | of_host->xfer_mode_shadow,
+				    SDHCI_TRANSFER_MODE);
+		return;
+	}
+	clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
+}
+
+void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	int base = reg & ~0x3;
+	int shift = (reg & 0x3) * 8;
+
+	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
+}
+#endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
+
+#ifdef CONFIG_PM
+
+static int sdhci_of_suspend(struct of_device *ofdev, pm_message_t state)
+{
+	struct sdhci_host *host = dev_get_drvdata(&ofdev->dev);
+
+	return mmc_suspend_host(host->mmc, state);
+}
+
+static int sdhci_of_resume(struct of_device *ofdev)
+{
+	struct sdhci_host *host = dev_get_drvdata(&ofdev->dev);
+
+	return mmc_resume_host(host->mmc);
+}
+
+#else
+
+#define sdhci_of_suspend NULL
+#define sdhci_of_resume NULL
+
+#endif
+
+static bool __devinit sdhci_of_wp_inverted(struct device_node *np)
+{
+	if (of_get_property(np, "sdhci,wp-inverted", NULL))
+		return true;
+
+	/* Old device trees don't have the wp-inverted property. */
+	return machine_is(mpc837x_rdb) || machine_is(mpc837x_mds);
+}
+
+static int __devinit sdhci_of_probe(struct of_device *ofdev,
+				 const struct of_device_id *match)
+{
+	struct device_node *np = ofdev->node;
+	struct sdhci_of_data *sdhci_of_data = match->data;
+	struct sdhci_host *host;
+	struct sdhci_of_host *of_host;
+	const u32 *clk;
+	int size;
+	int ret;
+
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	host = sdhci_alloc_host(&ofdev->dev, sizeof(*of_host));
+	if (IS_ERR(host))
+		return -ENOMEM;
+
+	of_host = sdhci_priv(host);
+	dev_set_drvdata(&ofdev->dev, host);
+
+	host->ioaddr = of_iomap(np, 0);
+	if (!host->ioaddr) {
+		ret = -ENOMEM;
+		goto err_addr_map;
+	}
+
+	host->irq = irq_of_parse_and_map(np, 0);
+	if (!host->irq) {
+		ret = -EINVAL;
+		goto err_no_irq;
+	}
+
+	host->hw_name = dev_name(&ofdev->dev);
+	if (sdhci_of_data) {
+		host->quirks = sdhci_of_data->quirks;
+		host->ops = &sdhci_of_data->ops;
+	}
+
+	if (of_get_property(np, "sdhci,1-bit-only", NULL))
+		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
+
+	if (sdhci_of_wp_inverted(np))
+		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+
+	clk = of_get_property(np, "clock-frequency", &size);
+	if (clk && size == sizeof(*clk) && *clk)
+		of_host->clock = *clk;
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_add_host;
+
+	return 0;
+
+err_add_host:
+	irq_dispose_mapping(host->irq);
+err_no_irq:
+	iounmap(host->ioaddr);
+err_addr_map:
+	sdhci_free_host(host);
+	return ret;
+}
+
+static int __devexit sdhci_of_remove(struct of_device *ofdev)
+{
+	struct sdhci_host *host = dev_get_drvdata(&ofdev->dev);
+
+	sdhci_remove_host(host, 0);
+	sdhci_free_host(host);
+	irq_dispose_mapping(host->irq);
+	iounmap(host->ioaddr);
+	return 0;
+}
+
+static const struct of_device_id sdhci_of_match[] = {
+#ifdef CONFIG_MMC_SDHCI_OF_ESDHC
+	{ .compatible = "fsl,mpc8379-esdhc", .data = &sdhci_esdhc, },
+	{ .compatible = "fsl,mpc8536-esdhc", .data = &sdhci_esdhc, },
+	{ .compatible = "fsl,esdhc", .data = &sdhci_esdhc, },
+#endif
+	{ .compatible = "generic-sdhci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sdhci_of_match);
+
+static struct of_platform_driver sdhci_of_driver = {
+	.driver.name = "sdhci-of",
+	.match_table = sdhci_of_match,
+	.probe = sdhci_of_probe,
+	.remove = __devexit_p(sdhci_of_remove),
+	.suspend = sdhci_of_suspend,
+	.resume	= sdhci_of_resume,
+};
+
+static int __init sdhci_of_init(void)
+{
+	return of_register_platform_driver(&sdhci_of_driver);
+}
+module_init(sdhci_of_init);
+
+static void __exit sdhci_of_exit(void)
+{
+	of_unregister_platform_driver(&sdhci_of_driver);
+}
+module_exit(sdhci_of_exit);
+
+MODULE_DESCRIPTION("Secure Digital Host Controller Interface OF driver");
+MODULE_AUTHOR("Xiaobo Xie <X.Xie@freescale.com>, "
+	      "Anton Vorontsov <avorontsov@ru.mvista.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
new file mode 100644
index 0000000..0fd184e
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -0,0 +1,142 @@
+/*
+ * Freescale eSDHC controller driver.
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2009 MontaVista Software, Inc.
+ *
+ * Authors: Xiaobo Xie <X.Xie@freescale.com>
+ *	    Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/mmc/host.h>
+#include "sdhci-of.h"
+
+/*
+ * Ops and quirks for the Freescale eSDHC controller.
+ */
+
+#define ESDHC_DMA_SYSCTL	0x40c
+#define ESDHC_DMA_SNOOP		0x00000040
+
+#define ESDHC_SYSTEM_CONTROL	0x2c
+#define ESDHC_CLOCK_MASK	0x0000fff0
+#define ESDHC_PREDIV_SHIFT	8
+#define ESDHC_DIVIDER_SHIFT	4
+#define ESDHC_CLOCK_PEREN	0x00000004
+#define ESDHC_CLOCK_HCKEN	0x00000002
+#define ESDHC_CLOCK_IPGEN	0x00000001
+
+#define ESDHC_HOST_CONTROL_RES	0x05
+
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
+static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	int pre_div = 2;
+	int div = 1;
+
+	clrbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
+		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
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
+	setbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
+		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN |
+		  div << ESDHC_DIVIDER_SHIFT | pre_div << ESDHC_PREDIV_SHIFT);
+	mdelay(100);
+out:
+	host->clock = clock;
+}
+
+static int esdhc_enable_dma(struct sdhci_host *host)
+{
+	setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
+	return 0;
+}
+
+static unsigned int esdhc_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_of_host *of_host = sdhci_priv(host);
+
+	return of_host->clock;
+}
+
+static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_of_host *of_host = sdhci_priv(host);
+
+	return of_host->clock / 256 / 16;
+}
+
+struct sdhci_of_data sdhci_esdhc = {
+	.quirks = SDHCI_QUIRK_FORCE_BLK_SZ_2048 |
+		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_NO_BUSY_IRQ |
+		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
+		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
+		  SDHCI_QUIRK_NO_CARD_NO_RESET,
+	.ops = {
+		.readl = sdhci_be32bs_readl,
+		.readw = esdhc_readw,
+		.readb = sdhci_be32bs_readb,
+		.writel = sdhci_be32bs_writel,
+		.writew = esdhc_writew,
+		.writeb = esdhc_writeb,
+		.set_clock = esdhc_set_clock,
+		.enable_dma = esdhc_enable_dma,
+		.get_max_clock = esdhc_get_max_clock,
+		.get_min_clock = esdhc_get_min_clock,
+	},
+};
diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
deleted file mode 100644
index 01ab916..0000000
--- a/drivers/mmc/host/sdhci-of.c
+++ /dev/null
@@ -1,336 +0,0 @@
-/*
- * OpenFirmware bindings for Secure Digital Host Controller Interface.
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
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/mmc/host.h>
-#include <asm/machdep.h>
-#include "sdhci.h"
-
-struct sdhci_of_data {
-	unsigned int quirks;
-	struct sdhci_ops ops;
-};
-
-struct sdhci_of_host {
-	unsigned int clock;
-	u16 xfer_mode_shadow;
-};
-
-/*
- * Ops and quirks for the Freescale eSDHC controller.
- */
-
-#define ESDHC_DMA_SYSCTL	0x40c
-#define ESDHC_DMA_SNOOP		0x00000040
-
-#define ESDHC_SYSTEM_CONTROL	0x2c
-#define ESDHC_CLOCK_MASK	0x0000fff0
-#define ESDHC_PREDIV_SHIFT	8
-#define ESDHC_DIVIDER_SHIFT	4
-#define ESDHC_CLOCK_PEREN	0x00000004
-#define ESDHC_CLOCK_HCKEN	0x00000002
-#define ESDHC_CLOCK_IPGEN	0x00000001
-
-#define ESDHC_HOST_CONTROL_RES	0x05
-
-static u32 esdhc_readl(struct sdhci_host *host, int reg)
-{
-	return in_be32(host->ioaddr + reg);
-}
-
-static u16 esdhc_readw(struct sdhci_host *host, int reg)
-{
-	u16 ret;
-
-	if (unlikely(reg == SDHCI_HOST_VERSION))
-		ret = in_be16(host->ioaddr + reg);
-	else
-		ret = in_be16(host->ioaddr + (reg ^ 0x2));
-	return ret;
-}
-
-static u8 esdhc_readb(struct sdhci_host *host, int reg)
-{
-	return in_8(host->ioaddr + (reg ^ 0x3));
-}
-
-static void esdhc_writel(struct sdhci_host *host, u32 val, int reg)
-{
-	out_be32(host->ioaddr + reg, val);
-}
-
-static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
-{
-	struct sdhci_of_host *of_host = sdhci_priv(host);
-	int base = reg & ~0x3;
-	int shift = (reg & 0x2) * 8;
-
-	switch (reg) {
-	case SDHCI_TRANSFER_MODE:
-		/*
-		 * Postpone this write, we must do it together with a
-		 * command write that is down below.
-		 */
-		of_host->xfer_mode_shadow = val;
-		return;
-	case SDHCI_COMMAND:
-		esdhc_writel(host, val << 16 | of_host->xfer_mode_shadow,
-			     SDHCI_TRANSFER_MODE);
-		return;
-	case SDHCI_BLOCK_SIZE:
-		/*
-		 * Two last DMA bits are reserved, and first one is used for
-		 * non-standard blksz of 4096 bytes that we don't support
-		 * yet. So clear the DMA boundary bits.
-		 */
-		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
-		/* fall through */
-	}
-	clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
-}
-
-static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
-{
-	int base = reg & ~0x3;
-	int shift = (reg & 0x3) * 8;
-
-	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
-	if (reg == SDHCI_HOST_CONTROL)
-		val &= ~ESDHC_HOST_CONTROL_RES;
-
-	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
-}
-
-static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
-{
-	int pre_div = 2;
-	int div = 1;
-
-	clrbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
-		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
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
-	setbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
-		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN |
-		  div << ESDHC_DIVIDER_SHIFT | pre_div << ESDHC_PREDIV_SHIFT);
-	mdelay(100);
-out:
-	host->clock = clock;
-}
-
-static int esdhc_enable_dma(struct sdhci_host *host)
-{
-	setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
-	return 0;
-}
-
-static unsigned int esdhc_get_max_clock(struct sdhci_host *host)
-{
-	struct sdhci_of_host *of_host = sdhci_priv(host);
-
-	return of_host->clock;
-}
-
-static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
-{
-	struct sdhci_of_host *of_host = sdhci_priv(host);
-
-	return of_host->clock / 256 / 16;
-}
-
-static struct sdhci_of_data sdhci_esdhc = {
-	.quirks = SDHCI_QUIRK_FORCE_BLK_SZ_2048 |
-		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_NO_BUSY_IRQ |
-		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
-		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
-		  SDHCI_QUIRK_NO_CARD_NO_RESET,
-	.ops = {
-		.readl = esdhc_readl,
-		.readw = esdhc_readw,
-		.readb = esdhc_readb,
-		.writel = esdhc_writel,
-		.writew = esdhc_writew,
-		.writeb = esdhc_writeb,
-		.set_clock = esdhc_set_clock,
-		.enable_dma = esdhc_enable_dma,
-		.get_max_clock = esdhc_get_max_clock,
-		.get_min_clock = esdhc_get_min_clock,
-	},
-};
-
-#ifdef CONFIG_PM
-
-static int sdhci_of_suspend(struct of_device *ofdev, pm_message_t state)
-{
-	struct sdhci_host *host = dev_get_drvdata(&ofdev->dev);
-
-	return mmc_suspend_host(host->mmc, state);
-}
-
-static int sdhci_of_resume(struct of_device *ofdev)
-{
-	struct sdhci_host *host = dev_get_drvdata(&ofdev->dev);
-
-	return mmc_resume_host(host->mmc);
-}
-
-#else
-
-#define sdhci_of_suspend NULL
-#define sdhci_of_resume NULL
-
-#endif
-
-static bool __devinit sdhci_of_wp_inverted(struct device_node *np)
-{
-	if (of_get_property(np, "sdhci,wp-inverted", NULL))
-		return true;
-
-	/* Old device trees don't have the wp-inverted property. */
-	return machine_is(mpc837x_rdb) || machine_is(mpc837x_mds);
-}
-
-static int __devinit sdhci_of_probe(struct of_device *ofdev,
-				 const struct of_device_id *match)
-{
-	struct device_node *np = ofdev->node;
-	struct sdhci_of_data *sdhci_of_data = match->data;
-	struct sdhci_host *host;
-	struct sdhci_of_host *of_host;
-	const u32 *clk;
-	int size;
-	int ret;
-
-	if (!of_device_is_available(np))
-		return -ENODEV;
-
-	host = sdhci_alloc_host(&ofdev->dev, sizeof(*of_host));
-	if (IS_ERR(host))
-		return -ENOMEM;
-
-	of_host = sdhci_priv(host);
-	dev_set_drvdata(&ofdev->dev, host);
-
-	host->ioaddr = of_iomap(np, 0);
-	if (!host->ioaddr) {
-		ret = -ENOMEM;
-		goto err_addr_map;
-	}
-
-	host->irq = irq_of_parse_and_map(np, 0);
-	if (!host->irq) {
-		ret = -EINVAL;
-		goto err_no_irq;
-	}
-
-	host->hw_name = dev_name(&ofdev->dev);
-	if (sdhci_of_data) {
-		host->quirks = sdhci_of_data->quirks;
-		host->ops = &sdhci_of_data->ops;
-	}
-
-	if (of_get_property(np, "sdhci,1-bit-only", NULL))
-		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
-
-	if (sdhci_of_wp_inverted(np))
-		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
-
-	clk = of_get_property(np, "clock-frequency", &size);
-	if (clk && size == sizeof(*clk) && *clk)
-		of_host->clock = *clk;
-
-	ret = sdhci_add_host(host);
-	if (ret)
-		goto err_add_host;
-
-	return 0;
-
-err_add_host:
-	irq_dispose_mapping(host->irq);
-err_no_irq:
-	iounmap(host->ioaddr);
-err_addr_map:
-	sdhci_free_host(host);
-	return ret;
-}
-
-static int __devexit sdhci_of_remove(struct of_device *ofdev)
-{
-	struct sdhci_host *host = dev_get_drvdata(&ofdev->dev);
-
-	sdhci_remove_host(host, 0);
-	sdhci_free_host(host);
-	irq_dispose_mapping(host->irq);
-	iounmap(host->ioaddr);
-	return 0;
-}
-
-static const struct of_device_id sdhci_of_match[] = {
-	{ .compatible = "fsl,mpc8379-esdhc", .data = &sdhci_esdhc, },
-	{ .compatible = "fsl,mpc8536-esdhc", .data = &sdhci_esdhc, },
-	{ .compatible = "fsl,esdhc", .data = &sdhci_esdhc, },
-	{ .compatible = "generic-sdhci", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, sdhci_of_match);
-
-static struct of_platform_driver sdhci_of_driver = {
-	.driver.name = "sdhci-of",
-	.match_table = sdhci_of_match,
-	.probe = sdhci_of_probe,
-	.remove = __devexit_p(sdhci_of_remove),
-	.suspend = sdhci_of_suspend,
-	.resume	= sdhci_of_resume,
-};
-
-static int __init sdhci_of_init(void)
-{
-	return of_register_platform_driver(&sdhci_of_driver);
-}
-module_init(sdhci_of_init);
-
-static void __exit sdhci_of_exit(void)
-{
-	of_unregister_platform_driver(&sdhci_of_driver);
-}
-module_exit(sdhci_of_exit);
-
-MODULE_DESCRIPTION("Secure Digital Host Controller Interface OF driver");
-MODULE_AUTHOR("Xiaobo Xie <X.Xie@freescale.com>, "
-	      "Anton Vorontsov <avorontsov@ru.mvista.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/sdhci-of.h b/drivers/mmc/host/sdhci-of.h
new file mode 100644
index 0000000..59a6d03
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of.h
@@ -0,0 +1,42 @@
+/*
+ * OpenFirmware bindings for Secure Digital Host Controller Interface.
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2009 MontaVista Software, Inc.
+ *
+ * Authors: Xiaobo Xie <X.Xie@freescale.com>
+ *	    Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#ifndef __SDHCI_OF_H
+#define __SDHCI_OF_H
+
+#include <linux/types.h>
+#include "sdhci.h"
+
+struct sdhci_of_data {
+	unsigned int quirks;
+	struct sdhci_ops ops;
+};
+
+struct sdhci_of_host {
+	unsigned int clock;
+	u16 xfer_mode_shadow;
+};
+
+extern u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg);
+extern u16 sdhci_be32bs_readw(struct sdhci_host *host, int reg);
+extern u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg);
+extern void sdhci_be32bs_writel(struct sdhci_host *host, u32 val, int reg);
+extern void sdhci_be32bs_writew(struct sdhci_host *host, u16 val, int reg);
+extern void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg);
+
+extern struct sdhci_of_data sdhci_esdhc;
+
+#endif /* __SDHCI_OF_H */
+
-- 
1.6.3.3

