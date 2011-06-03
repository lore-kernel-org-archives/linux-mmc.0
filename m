From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v3 1/4] mmc: support sdhci-pxav3.c
Date: Fri,  3 Jun 2011 17:49:32 +0800
Message-ID: <1307094572-8378-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:50344 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab1FCJti (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2011 05:49:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vg
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>

	Instead of sharing sdhci-pxa.c, use sdhci-pxav3.c for mmp2.
	The original method is not easy to track, which is share sdhci-pxa.c among pxa serious, like pxa910, mmp2, etc,
	and put the platfrom difference under arch/arm.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   37 ++++-
 drivers/mmc/host/Kconfig               |   11 +-
 drivers/mmc/host/Makefile              |    2 +-
 drivers/mmc/host/sdhci-pxa.c           |  303 -------------------------------
 drivers/mmc/host/sdhci-pxav3.c         |  305 ++++++++++++++++++++++++++++++++
 5 files changed, 343 insertions(+), 315 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-pxa.c
 create mode 100644 drivers/mmc/host/sdhci-pxav3.c

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index 1ab332e..b4acf5c 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -15,21 +15,48 @@
 
 /* pxa specific flag */
 /* Require clock free running */
-#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
-
+#define PXA_FLAG_ENABLE_CLOCK_GATING (1<<0)
+/* card alwayes wired to host, like on-chip emmc */
+#define PXA_FLAG_CARD_PERMANENT	(1<<1)
 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
+/* card not use wp, such as micro sd card */
+#define PXA_FLAG_CARD_NO_WP	(1<<3)
 
 /*
  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
- * @max_speed: the maximum speed supported
- * @quirks: quirks of specific device
  * @flags: flags for platform requirement
+ * @clk_delay_cycles:
+ *	mmp2: each step is roughly 100ps, 5bits width
+ *	pxa910: each step is 1ns, 4bits width
+ * @clk_delay_sel: select clk_delay, used on pxa910
+ *	0: choose feedback clk
+ *	1: choose feedback clk + delay value
+ *	2: choose internal clk
+ * @clk_delay_enable: enable clk_delay or not, used on pxa910
+ * @ext_cd_gpio: gpio pin used for external CD line
+ * @ext_cd_gpio_invert: invert values for external CD gpio line
+ * @max_speed: the maximum speed supported
+ * @host_caps: Standard MMC host capabilities bit field.
+ * @quirks: quirks of platfrom
+ * @pm_caps: pm_caps of platfrom
  */
 struct sdhci_pxa_platdata {
+	unsigned int	flags;
+	unsigned int	clk_delay_cycles;
+	unsigned int	clk_delay_sel;
+	bool		clk_delay_enable;
+	unsigned int	ext_cd_gpio;
+	bool		ext_cd_gpio_invert;
 	unsigned int	max_speed;
+	unsigned int	host_caps;
 	unsigned int	quirks;
-	unsigned int	flags;
+	unsigned int	pm_caps;
+};
+
+struct sdhci_pxa {
+	u8	clk_enable;
+	u8	power_mode;
 };
 
 #endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 74e77c9..4ee869a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -181,14 +181,13 @@ config MMC_SDHCI_S3C
 
 	  If unsure, say N.
 
-config MMC_SDHCI_PXA
-	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
-	depends on ARCH_PXA || ARCH_MMP
+config MMC_SDHCI_PXAV3
+	tristate "Marvell PXAV3 SD Host Controller support"
 	select MMC_SDHCI
-	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_SDHCI_PLTFM
 	help
-	  This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
-	  If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
+	  This selects the Marvell(R) PXAV3 SD Host Controller.
+	  If you have a PXAV3 platform (such as mmp2) with SD Host Controller
 	  and a card slot, say Y or M here.
 
 	  If unsure, say N.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index bf479ab..9131a27 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
-obj-$(CONFIG_MMC_SDHCI_PXA)	+= sdhci-pxa.o
+obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
deleted file mode 100644
index 089c9a6..0000000
--- a/drivers/mmc/host/sdhci-pxa.c
+++ /dev/null
@@ -1,303 +0,0 @@
-/* linux/drivers/mmc/host/sdhci-pxa.c
- *
- * Copyright (C) 2010 Marvell International Ltd.
- *		Zhangfei Gao <zhangfei.gao@marvell.com>
- *		Kevin Wang <dwang4@marvell.com>
- *		Mingwei Wang <mwwang@marvell.com>
- *		Philip Rakity <prakity@marvell.com>
- *		Mark Brown <markb@marvell.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/* Supports:
- * SDHCI support for MMP2/PXA910/PXA168
- *
- * Refer to sdhci-s3c.c.
- */
-
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/err.h>
-#include <plat/sdhci.h>
-#include "sdhci.h"
-
-#define DRIVER_NAME	"sdhci-pxa"
-
-#define SD_FIFO_PARAM		0x104
-#define DIS_PAD_SD_CLK_GATE	0x400
-
-struct sdhci_pxa {
-	struct sdhci_host		*host;
-	struct sdhci_pxa_platdata	*pdata;
-	struct clk			*clk;
-	struct resource			*res;
-
-	u8 clk_enable;
-};
-
-/*****************************************************************************\
- *                                                                           *
- * SDHCI core callbacks                                                      *
- *                                                                           *
-\*****************************************************************************/
-static void set_clock(struct sdhci_host *host, unsigned int clock)
-{
-	struct sdhci_pxa *pxa = sdhci_priv(host);
-	u32 tmp = 0;
-
-	if (clock == 0) {
-		if (pxa->clk_enable) {
-			clk_disable(pxa->clk);
-			pxa->clk_enable = 0;
-		}
-	} else {
-		if (0 == pxa->clk_enable) {
-			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
-				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
-				tmp |= DIS_PAD_SD_CLK_GATE;
-				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
-			}
-			clk_enable(pxa->clk);
-			pxa->clk_enable = 1;
-		}
-	}
-}
-
-static int set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
-{
-	u16 ctrl_2;
-
-	/*
-	 * Set V18_EN -- UHS modes do not work without this.
-	 * does not change signaling voltage
-	 */
-	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
-	/* Select Bus Speed Mode for host */
-	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
-	switch (uhs) {
-	case MMC_TIMING_UHS_SDR12:
-		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-		break;
-	case MMC_TIMING_UHS_SDR25:
-		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
-		break;
-	case MMC_TIMING_UHS_SDR50:
-		ctrl_2 |= SDHCI_CTRL_UHS_SDR50 | SDHCI_CTRL_VDD_180;
-		break;
-	case MMC_TIMING_UHS_SDR104:
-		ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
-		break;
-	case MMC_TIMING_UHS_DDR50:
-		ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
-		break;
-	}
-
-	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
-	pr_debug("%s:%s uhs = %d, ctrl_2 = %04X\n",
-		__func__, mmc_hostname(host->mmc), uhs, ctrl_2);
-
-	return 0;
-}
-
-static struct sdhci_ops sdhci_pxa_ops = {
-	.set_uhs_signaling = set_uhs_signaling,
-	.set_clock = set_clock,
-};
-
-/*****************************************************************************\
- *                                                                           *
- * Device probing/removal                                                    *
- *                                                                           *
-\*****************************************************************************/
-
-static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
-{
-	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
-	struct device *dev = &pdev->dev;
-	struct sdhci_host *host = NULL;
-	struct resource *iomem = NULL;
-	struct sdhci_pxa *pxa = NULL;
-	int ret, irq;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq specified\n");
-		return irq;
-	}
-
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iomem) {
-		dev_err(dev, "no memory specified\n");
-		return -ENOENT;
-	}
-
-	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pxa));
-	if (IS_ERR(host)) {
-		dev_err(dev, "failed to alloc host\n");
-		return PTR_ERR(host);
-	}
-
-	pxa = sdhci_priv(host);
-	pxa->host = host;
-	pxa->pdata = pdata;
-	pxa->clk_enable = 0;
-
-	pxa->clk = clk_get(dev, "PXA-SDHCLK");
-	if (IS_ERR(pxa->clk)) {
-		dev_err(dev, "failed to get io clock\n");
-		ret = PTR_ERR(pxa->clk);
-		goto out;
-	}
-
-	pxa->res = request_mem_region(iomem->start, resource_size(iomem),
-				      mmc_hostname(host->mmc));
-	if (!pxa->res) {
-		dev_err(&pdev->dev, "cannot request region\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
-	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
-	if (!host->ioaddr) {
-		dev_err(&pdev->dev, "failed to remap registers\n");
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	host->hw_name = "MMC";
-	host->ops = &sdhci_pxa_ops;
-	host->irq = irq;
-	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
-		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
-		| SDHCI_QUIRK_32BIT_DMA_ADDR
-		| SDHCI_QUIRK_32BIT_DMA_SIZE
-		| SDHCI_QUIRK_32BIT_ADMA_SIZE
-		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
-
-	if (pdata->quirks)
-		host->quirks |= pdata->quirks;
-
-	/* enable 1/8V DDR capable */
-	host->mmc->caps |= MMC_CAP_1_8V_DDR;
-
-	/* If slot design supports 8 bit data, indicate this to MMC. */
-	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
-		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
-
-	ret = sdhci_add_host(host);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add host\n");
-		goto out;
-	}
-
-	if (pxa->pdata->max_speed)
-		host->mmc->f_max = pxa->pdata->max_speed;
-
-	platform_set_drvdata(pdev, host);
-
-	return 0;
-out:
-	if (host) {
-		clk_put(pxa->clk);
-		if (host->ioaddr)
-			iounmap(host->ioaddr);
-		if (pxa->res)
-			release_mem_region(pxa->res->start,
-					   resource_size(pxa->res));
-		sdhci_free_host(host);
-	}
-
-	return ret;
-}
-
-static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
-{
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pxa *pxa = sdhci_priv(host);
-	int dead = 0;
-	u32 scratch;
-
-	if (host) {
-		scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
-		if (scratch == (u32)-1)
-			dead = 1;
-
-		sdhci_remove_host(host, dead);
-
-		if (host->ioaddr)
-			iounmap(host->ioaddr);
-		if (pxa->res)
-			release_mem_region(pxa->res->start,
-					   resource_size(pxa->res));
-		if (pxa->clk_enable) {
-			clk_disable(pxa->clk);
-			pxa->clk_enable = 0;
-		}
-		clk_put(pxa->clk);
-
-		sdhci_free_host(host);
-		platform_set_drvdata(pdev, NULL);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int sdhci_pxa_suspend(struct platform_device *dev, pm_message_t state)
-{
-	struct sdhci_host *host = platform_get_drvdata(dev);
-
-	return sdhci_suspend_host(host, state);
-}
-
-static int sdhci_pxa_resume(struct platform_device *dev)
-{
-	struct sdhci_host *host = platform_get_drvdata(dev);
-
-	return sdhci_resume_host(host);
-}
-#else
-#define sdhci_pxa_suspend	NULL
-#define sdhci_pxa_resume	NULL
-#endif
-
-static struct platform_driver sdhci_pxa_driver = {
-	.probe		= sdhci_pxa_probe,
-	.remove		= __devexit_p(sdhci_pxa_remove),
-	.suspend	= sdhci_pxa_suspend,
-	.resume		= sdhci_pxa_resume,
-	.driver		= {
-		.name	= DRIVER_NAME,
-		.owner	= THIS_MODULE,
-	},
-};
-
-/*****************************************************************************\
- *                                                                           *
- * Driver init/exit                                                          *
- *                                                                           *
-\*****************************************************************************/
-
-static int __init sdhci_pxa_init(void)
-{
-	return platform_driver_register(&sdhci_pxa_driver);
-}
-
-static void __exit sdhci_pxa_exit(void)
-{
-	platform_driver_unregister(&sdhci_pxa_driver);
-}
-
-module_init(sdhci_pxa_init);
-module_exit(sdhci_pxa_exit);
-
-MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
-MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
new file mode 100644
index 0000000..c5b99e0
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -0,0 +1,305 @@
+/*
+ * Copyright (C) 2010 Marvell International Ltd.
+ *		Zhangfei Gao <zhangfei.gao@marvell.com>
+ *		Kevin Wang <dwang4@marvell.com>
+ *		Mingwei Wang <mwwang@marvell.com>
+ *		Philip Rakity <prakity@marvell.com>
+ *		Mark Brown <markb@marvell.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <plat/sdhci.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+#define SD_CLOCK_BURST_SIZE_SETUP		0x10A
+#define SDCLK_SEL	0x100
+#define SDCLK_DELAY_SHIFT	9
+#define SDCLK_DELAY_MASK	0x1f
+
+#define SD_CFG_FIFO_PARAM       0x100
+#define SDCFG_GEN_PAD_CLK_ON	(1<<6)
+#define SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
+#define SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
+
+#define SD_SPI_MODE          0x108
+#define SD_CE_ATA_1          0x10C
+
+#define SD_CE_ATA_2          0x10E
+#define SDCE_MISC_INT		(1<<2)
+#define SDCE_MISC_INT_EN	(1<<1)
+
+static void pxav3_set_private_registers(struct sdhci_host *host, u8 mask)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+
+	if (mask == SDHCI_RESET_ALL) {
+		/*
+		 * tune timing of read data/command when crc error happen
+		 * no performance impact
+		 */
+		if (pdata && 0 != pdata->clk_delay_cycles) {
+			u16 tmp;
+
+			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
+			tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
+				<< SDCLK_DELAY_SHIFT;
+			tmp |= SDCLK_SEL;
+			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
+		}
+	}
+}
+
+#define MAX_WAIT_COUNT 5
+static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+	u16 tmp;
+	int count;
+
+	if (pxa->power_mode == MMC_POWER_UP
+			&& power_mode == MMC_POWER_ON) {
+
+		dev_dbg(mmc_dev(host->mmc),
+				"%s: slot->power_mode = %d,"
+				"ios->power_mode = %d\n",
+				__func__,
+				pxa->power_mode,
+				power_mode);
+
+		/* set we want notice of when 74 clocks are sent */
+		tmp = readw(host->ioaddr + SD_CE_ATA_2);
+		tmp |= SDCE_MISC_INT_EN;
+		writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+		/* start sending the 74 clocks */
+		tmp = readw(host->ioaddr + SD_CFG_FIFO_PARAM);
+		tmp |= SDCFG_GEN_PAD_CLK_ON;
+		writew(tmp, host->ioaddr + SD_CFG_FIFO_PARAM);
+
+		/* slowest speed is about 100KHz or 10usec per clock */
+		udelay(740);
+		count = 0;
+
+		while (count++ < MAX_WAIT_COUNT) {
+			if ((readw(host->ioaddr + SD_CE_ATA_2)
+						& SDCE_MISC_INT) == 0)
+				break;
+			udelay(10);
+		}
+
+		if (count == MAX_WAIT_COUNT)
+			dev_warn(mmc_dev(host->mmc), "74 clock interrupt not cleared\n");
+
+		/* clear the interrupt bit if posted */
+		tmp = readw(host->ioaddr + SD_CE_ATA_2);
+		tmp |= SDCE_MISC_INT;
+		writew(tmp, host->ioaddr + SD_CE_ATA_2);
+	}
+	pxa->power_mode = power_mode;
+}
+
+static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
+{
+	u16 ctrl_2;
+
+	/*
+	 * Set V18_EN -- UHS modes do not work without this.
+	 * does not change signaling voltage
+	 */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	switch (uhs) {
+	case MMC_TIMING_UHS_SDR12:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50 | SDHCI_CTRL_VDD_180;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
+		break;
+	}
+
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+	dev_dbg(mmc_dev(host->mmc),
+		"%s uhs = %d, ctrl_2 = %04X\n",
+		__func__, uhs, ctrl_2);
+
+	return 0;
+}
+
+static unsigned int pxav3_get_ro(struct sdhci_host *host)
+{
+	/* Micro SD does not support write-protect feature */
+	return 0;
+}
+
+static struct sdhci_ops pxav3_sdhci_ops = {
+	.get_ro = pxav3_get_ro,
+	.platform_reset_exit = pxav3_set_private_registers,
+	.set_uhs_signaling = pxav3_set_uhs_signaling,
+	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
+};
+
+static struct sdhci_ops pxav3_sdhci_wp_ops = {
+	.platform_reset_exit = pxav3_set_private_registers,
+	.set_uhs_signaling = pxav3_set_uhs_signaling,
+	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
+};
+
+static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host = NULL;
+	struct sdhci_pxa *pxa = NULL;
+	int ret;
+	struct clk *clk;
+
+	pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
+	if (!pxa)
+		return -ENOMEM;
+
+	host = sdhci_pltfm_init(pdev, NULL);
+	if (IS_ERR(host)) {
+		kfree(pxa);
+		return PTR_ERR(host);
+	}
+	pltfm_host = sdhci_priv(host);
+	pltfm_host->priv = pxa;
+
+	clk = clk_get(dev, "PXA-SDHCLK");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get io clock\n");
+		ret = PTR_ERR(clk);
+		goto err_clk_get;
+	}
+	pltfm_host->clk = clk;
+	clk_enable(clk);
+
+	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
+
+	/* enable 1/8V DDR capable */
+	host->mmc->caps |= MMC_CAP_1_8V_DDR;
+
+	if (pdata) {
+		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+			/* on-chip device */
+			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+			host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+		}
+
+		/* If slot design supports 8 bit data, indicate this to MMC. */
+		if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
+			host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
+		if (pdata->quirks)
+			host->quirks |= pdata->quirks;
+		if (pdata->host_caps)
+			host->mmc->caps |= pdata->host_caps;
+		if (pdata->pm_caps)
+			host->mmc->pm_caps |= pdata->pm_caps;
+	}
+
+	if (pdata && pdata->flags & PXA_FLAG_CARD_NO_WP)
+		host->ops = &pxav3_sdhci_ops;
+	else
+		host->ops = &pxav3_sdhci_wp_ops;
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add host\n");
+		goto err_add_host;
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+
+err_add_host:
+	clk_disable(clk);
+	clk_put(clk);
+err_clk_get:
+	sdhci_pltfm_free(pdev);
+	kfree(pxa);
+	return ret;
+}
+
+static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+
+	sdhci_remove_host(host, 1);
+
+	clk_disable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+	sdhci_pltfm_free(pdev);
+	kfree(pxa);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver sdhci_pxav3_driver = {
+	.driver		= {
+		.name	= "sdhci-pxav3",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_pxav3_probe,
+	.remove		= __devexit_p(sdhci_pxav3_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
+#endif
+};
+static int __init sdhci_pxav3_init(void)
+{
+	return platform_driver_register(&sdhci_pxav3_driver);
+}
+
+static void __exit sdhci_pxav3_exit(void)
+{
+	platform_driver_unregister(&sdhci_pxav3_driver);
+}
+
+module_init(sdhci_pxav3_init);
+module_exit(sdhci_pxav3_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for pxav3");
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_LICENSE("GPL v2");
+
-- 
1.7.0.4

