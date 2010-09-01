From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on platform sdhci
	api
Date: Wed, 1 Sep 2010 17:48:53 +0800
Message-ID: <1283334533-12793-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Richard Zhu <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Based on SDHCI platform API, PIO and simple internal DMA
are enabled.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/mmc/host/Kconfig     |   12 +
 drivers/mmc/host/Makefile    |    1 +
 drivers/mmc/host/sdhci-fsl.c |  481 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 494 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-fsl.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 283190b..2b67e11 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -167,6 +167,18 @@ config MMC_SDHCI_S3C_DMA
 
 	  YMMV.
 
+config MMC_SDHCI_FSL
+	tristate "Freescale i.MX platform eSDHCI support"
+	depends on ARCH_MX5 && MMC_SDHCI
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Freescale i.MX Enhanced Secure Card Host
+	  Controller Interface.
+	  If you have a i.MX platform with a Multimedia Card slot,
+	  say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
 	depends on ARCH_OMAP
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 840bcb5..649656c 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
+obj-$(CONFIG_MMC_SDHCI_FSL)	+= sdhci-fsl.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
diff --git a/drivers/mmc/host/sdhci-fsl.c b/drivers/mmc/host/sdhci-fsl.c
new file mode 100644
index 0000000..fa57ec4
--- /dev/null
+++ b/drivers/mmc/host/sdhci-fsl.c
@@ -0,0 +1,481 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * sdhci-fsl.c Support for SDHCI platform devices
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * SDHCI fsl devices
+ *
+ * Inspired by sdhci-pci.c, by Pierre Ossman
+ */
+
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/regulator/consumer.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/mmc/host.h>
+
+#include <mach/mmc.h>
+
+#include "sdhci.h"
+
+#define DRIVER_NAME "imx-sdhci"
+
+enum {
+	/* Vendor specified registors */
+	FSL_SDHCI_WML 		= 0x44,
+	FSL_SDHCI_WML_16_WORDS 	= 0x08100810,
+	FSL_SDHCI_WML_32_WORDS 	= 0x08200820,
+	FSL_SDHCI_WML_64_WORDS 	= 0x08400840,
+	FSL_SDHCI_WML_128_WORDS 	= 0x08800880,
+
+	/* Non-standard clock control registor */
+	FSL_SDHCI_CLOCK_MASK 	= 0xFFFF,
+	FSL_SDHCI_CLOCK_SD_EN 	= 0x00000008,
+	FSL_SDHCI_CLOCK_HLK_EN 	= 0x00000002,
+
+	/* Non-standard host control registor */
+	FSL_SDHCI_CTRL_8BITBUS 	= 0x00000004,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * SDHCI core callbacks                                                      *
+ *                                                                           *
+\*****************************************************************************/
+
+struct sdhci_fsl_host {
+	struct sdhci_host 		*host;
+	struct platform_device 		*pdev; /*! Platform dev */
+	struct imxmmc_platform_data 	*pdata; /*! private data */
+	struct clk 			*clk_input; /*! Clock */
+	struct regulator 		*regulator_mmc;	/*! Regulator */
+};
+
+static u32 sdhci_fsl_readl(struct sdhci_host *host, int reg)
+{
+	return readl(host->ioaddr + reg);
+}
+
+static u16 sdhci_fsl_readw(struct sdhci_host *host, int reg)
+{
+	u32 val;
+	u16 rc;
+
+	if (reg % 4 == 3) {
+		printk(KERN_ERR "Invalid reg address!\n");
+		return 0;
+	}
+
+	val = readl(host->ioaddr + (reg / 4) * 4);
+	rc = (val >> (reg % 4) * 8) & 0xFFFF;
+
+	return rc;
+}
+
+static u8 sdhci_fsl_readb(struct sdhci_host *host, int reg)
+{
+	u32 val;
+	u8 rc;
+
+	val = readl(host->ioaddr + (reg / 4) * 4);
+	rc = (val >> (reg % 4) * 8) & 0xFF;
+
+	return rc;
+}
+
+static void sdhci_fsl_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	writel(val, host->ioaddr + reg);
+}
+
+static void sdhci_fsl_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	u32 io_val;
+
+	if (reg % 4 == 3) {
+		printk(KERN_ERR "Invalid reg address!\n");
+		return;
+	}
+
+	io_val = readl(host->ioaddr + (reg / 4) * 4);
+	io_val &= ~(0xFFFF << ((reg % 4) * 8));
+	io_val |= val << ((reg % 4) * 8);
+
+	writel(io_val, host->ioaddr + (reg / 4) * 4);
+}
+
+static void sdhci_fsl_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	u32 io_val;
+
+	io_val = readl(host->ioaddr + (reg / 4) * 4);
+	io_val &= ~(0xFF << ((reg % 4) * 8));
+	io_val |= val << ((reg % 4) * 8);
+
+	writel(io_val, host->ioaddr + (reg / 4) * 4);
+}
+
+static unsigned int sdhci_fsl_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_fsl_host *fsl_host = sdhci_priv(host);
+
+	return fsl_host->pdata->max_clk;
+}
+
+static unsigned int sdhci_fsl_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_fsl_host *fsl_host = sdhci_priv(host);
+
+	return fsl_host->pdata->min_clk;
+}
+
+static unsigned int sdhci_fsl_get_timeout_clock(struct sdhci_host *host)
+{
+	return sdhci_fsl_get_max_clock(host) / 1000000;
+}
+
+static unsigned int sdhci_fsl_get_ro(struct sdhci_host *host)
+{
+	struct sdhci_fsl_host *fsl_host = sdhci_priv(host);
+
+	return fsl_host->pdata->wp_status(host->mmc->parent);
+}
+
+static void sdhci_fsl_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	/*This variable holds the value of clock divider, prescaler */
+	int div = 0, prescaler = 1;
+	int clk_rate = 0;
+	u32 clk;
+	unsigned long timeout;
+	struct sdhci_fsl_host *fsl_host = sdhci_priv(host);
+
+	if (clock == 0) {
+		host->clock = 0;
+		clk = readl(host->ioaddr + SDHCI_CLOCK_CONTROL);
+		writel(clk & (~FSL_SDHCI_CLOCK_HLK_EN),
+				host->ioaddr + SDHCI_CLOCK_CONTROL);
+		return;
+	}
+
+	clk_rate = clk_get_rate(fsl_host->clk_input);
+	clk = readl(host->ioaddr + SDHCI_CLOCK_CONTROL) & ~FSL_SDHCI_CLOCK_MASK;
+	/* precaler can't be set to zero in CLK_CTL reg */
+	clk |= (prescaler << 8);
+	writel(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
+
+	if (clock == sdhci_fsl_get_min_clock(host))
+		prescaler = 0x10;
+
+	while (prescaler <= 0x80) {
+		for (div = 0; div <= 0xF; div++) {
+			int x;
+			if (prescaler != 0)
+				x = (clk_rate / (div + 1)) / (prescaler * 2);
+			else
+				x = clk_rate / (div + 1);
+
+			dev_dbg(&fsl_host->pdev->dev, "x=%d, clock=%d %d\n",
+					x, clock, div);
+			if (x <= clock)
+				break;
+		}
+		if (div < 0x10)
+			break;
+
+		prescaler <<= 1;
+	}
+	dev_dbg(&fsl_host->pdev->dev, "prescaler = 0x%x, divider = 0x%x\n",
+			prescaler, div);
+	clk |= (prescaler << 8) | (div << 4);
+
+	/* Configure the clock control register */
+	clk |= readl(host->ioaddr + SDHCI_CLOCK_CONTROL)
+		& (~FSL_SDHCI_CLOCK_MASK);
+	clk |= FSL_SDHCI_CLOCK_HLK_EN;
+	writel(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 10 ms */
+	timeout = 5000;
+	while (timeout > 0) {
+		timeout--;
+		udelay(20);
+	}
+	writel(clk | FSL_SDHCI_CLOCK_SD_EN, host->ioaddr + SDHCI_CLOCK_CONTROL);
+
+	host->clock = (clk_rate / (div + 1)) / (prescaler * 2);
+}
+
+static void sdhci_fsl_set_power(struct sdhci_host *host, unsigned int power)
+{
+	struct sdhci_fsl_host *fsl_host = sdhci_priv(host);
+	int voltage = 0;
+
+	/* There is no sdhci standard PWR CTL REG in fsl esdhci */
+	if (host->pwr == power)
+		return;
+
+	if (fsl_host->regulator_mmc) {
+		if (power == (unsigned short)-1) {
+			regulator_disable(fsl_host->regulator_mmc);
+			dev_dbg(&fsl_host->pdev->dev, "mmc power off\n");
+		} else {
+			if (power == 7)
+				voltage = 1800000;
+			else if (power >= 8)
+				voltage = 2000000 + (power - 8) * 100000;
+			regulator_set_voltage(fsl_host->regulator_mmc,
+					      voltage, voltage);
+
+			if (regulator_enable(fsl_host->regulator_mmc) == 0) {
+				dev_dbg(&fsl_host->pdev->dev, "mmc power on\n");
+				msleep(1);
+			}
+		}
+	}
+
+	host->pwr = power;
+}
+
+static void sdhci_fsl_set_bus(struct sdhci_host *host, unsigned int bus_width)
+{
+	u32 ctrl;
+
+	ctrl = readl(host->ioaddr + SDHCI_HOST_CONTROL);
+
+	if (bus_width == MMC_BUS_WIDTH_4) {
+		ctrl &= ~FSL_SDHCI_CTRL_8BITBUS;
+		ctrl |= SDHCI_CTRL_4BITBUS;
+	} else if (bus_width == MMC_BUS_WIDTH_8) {
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		ctrl |= FSL_SDHCI_CTRL_8BITBUS;
+	} else if (bus_width == MMC_BUS_WIDTH_1) {
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		ctrl &= ~FSL_SDHCI_CTRL_8BITBUS;
+	}
+
+	writel(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
+}
+
+static u16 sdhci_fsl_make_blksz(u16 blk_sz)
+{
+	return  blk_sz &= 0x1FFF;
+}
+
+static int esdhci_fsl_enable_dma(struct sdhci_host *host)
+{
+	u32 ctrl;
+
+	ctrl = readl(host->ioaddr + SDHCI_HOST_CONTROL);
+	ctrl &= ~(SDHCI_CTRL_DMA_MASK << 5);
+	if ((host->flags & SDHCI_REQ_USE_DMA) &&
+		(host->flags & SDHCI_USE_ADMA))
+		ctrl |= (SDHCI_CTRL_ADMA32 << 8);
+	else if (host->flags & SDHCI_REQ_USE_DMA)
+		ctrl |= (SDHCI_CTRL_SDMA << 8);
+
+	writel(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
+
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		writel(FSL_SDHCI_WML_64_WORDS,
+				host->ioaddr + FSL_SDHCI_WML);
+	else
+		writel(FSL_SDHCI_WML_128_WORDS,
+				host->ioaddr + FSL_SDHCI_WML);
+	return 0;
+}
+
+static const struct sdhci_ops sdhci_fsl_ops = {
+	.read_l 		= sdhci_fsl_readl,
+	.read_w 		= sdhci_fsl_readw,
+	.read_b 		= sdhci_fsl_readb,
+	.write_l 		= sdhci_fsl_writel,
+	.write_w 		= sdhci_fsl_writew,
+	.write_b 		= sdhci_fsl_writeb,
+	.set_clock 		= sdhci_fsl_set_clock,
+	.set_power 		= sdhci_fsl_set_power,
+	.set_bus 		= sdhci_fsl_set_bus,
+	.enable_dma 		= esdhci_fsl_enable_dma,
+	.get_max_clock 		= sdhci_fsl_get_max_clock,
+	.get_min_clock 		= sdhci_fsl_get_min_clock,
+	.get_timeout_clock 	= sdhci_fsl_get_timeout_clock,
+	.get_ro 		= sdhci_fsl_get_ro,
+	.make_blksz 		= sdhci_fsl_make_blksz,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Device probing/removal                                                    *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __devinit sdhci_fsl_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	struct resource *iomem;
+	struct sdhci_fsl_host *fsl_host;
+	int ret;
+	struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
+
+	BUG_ON(pdev == NULL);
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_fsl_host));
+
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
+		goto err;
+	}
+
+	fsl_host = sdhci_priv(host);
+
+	fsl_host->host = host;
+	fsl_host->pdev = pdev;
+	fsl_host->pdata = pdata;
+
+	/* Get clk supply for eSDHC */
+	fsl_host->clk_input = clk_get(&pdev->dev, "esdhc_clk");
+	if (IS_ERR(fsl_host->clk_input)) {
+		ret = PTR_ERR(fsl_host->clk_input);
+		printk(KERN_ERR "IMX MMC can't get clock.\n");
+		goto err_request_clk;
+	}
+	clk_enable(fsl_host->clk_input);
+
+	dev_dbg(&pdev->dev, "SDHC:%d clock:%lu\n",
+			pdev->id, clk_get_rate(fsl_host->clk_input));
+
+	host->hw_name = "sdhci-fsl";
+	host->ops = &sdhci_fsl_ops;
+	host->irq = platform_get_irq(pdev, 0);
+
+	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
+		| SDHCI_QUIRK_32BIT_DMA_ADDR
+		| SDHCI_QUIRK_32BIT_ADMA_SIZE
+		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+		| SDHCI_QUIRK_NO_BUSY_IRQ
+		| SDHCI_QUIRK_BROKEN_CARD_DETECTION
+		| SDHCI_QUIRK_NONSTANDARD_CLOCK
+		| SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET
+		| SDHCI_QUIRK_32BIT_CMD_TRANS_COMBINATION
+		| SDHCI_QUIRK_NONSTANDARD_HOST_CTL;
+	if (!request_mem_region(iomem->start, resource_size(iomem),
+		mmc_hostname(host->mmc))) {
+		dev_err(&pdev->dev, "cannot request region\n");
+		ret = -EBUSY;
+		goto err_request_mem;
+	}
+
+	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
+	if (!host->ioaddr) {
+		dev_err(&pdev->dev, "failed to remap registers\n");
+		ret = -ENOMEM;
+		goto err_remap;
+	}
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_add_host;
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+
+err_add_host:
+	iounmap(host->ioaddr);
+err_remap:
+	release_mem_region(iomem->start, resource_size(iomem));
+err_request_mem:
+	if (fsl_host->clk_input) {
+		clk_disable(fsl_host->clk_input);
+		clk_put(fsl_host->clk_input);
+	}
+err_request_clk:
+	if (fsl_host->regulator_mmc) {
+		regulator_disable(fsl_host->regulator_mmc);
+		regulator_put(fsl_host->regulator_mmc);
+	}
+	sdhci_free_host(host);
+err:
+	printk(KERN_ERR"Probing of sdhci-pltfm failed: %d\n", ret);
+	return ret;
+}
+
+static int __devexit sdhci_fsl_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int dead;
+	u32 scratch;
+
+	dead = 0;
+	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+	if (scratch == (u32)-1)
+		dead = 1;
+
+	sdhci_remove_host(host, dead);
+	iounmap(host->ioaddr);
+	release_mem_region(iomem->start, resource_size(iomem));
+	sdhci_free_host(host);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver sdhci_fsl_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_fsl_probe,
+	.remove		= __devexit_p(sdhci_fsl_remove),
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __init sdhci_fsl_init(void)
+{
+	return platform_driver_register(&sdhci_fsl_driver);
+}
+
+static void __exit sdhci_fsl_exit(void)
+{
+	platform_driver_unregister(&sdhci_fsl_driver);
+}
+
+module_init(sdhci_fsl_init);
+module_exit(sdhci_fsl_exit);
+
+MODULE_DESCRIPTION("IMX Secure Digital Host Controller Interface driver");
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:sdhci-fsl");
-- 
1.7.0
