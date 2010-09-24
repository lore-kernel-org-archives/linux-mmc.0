From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 3/4] esdhc-3 esdhc: fsl esdhc driver based on sdhci driver
Date: Fri, 24 Sep 2010 11:43:07 +0800
Message-ID: <1285299788-32209-4-git-send-email-r65037@freescale.com>
References: <1285299788-32209-1-git-send-email-r65037@freescale.com>
 <1285299788-32209-2-git-send-email-r65037@freescale.com>
 <1285299788-32209-3-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:55636
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753741Ab0IXDk2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 23:40:28 -0400
Received: from mail40-db3 (localhost.localdomain [127.0.0.1])	by
 mail40-db3-R.bigfish.com (Postfix) with ESMTP id A8D146D05FC	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:40:24 +0000 (UTC)
Received: from DB3EHSMHS007.bigfish.com (unknown [10.3.81.254])	by
 mail40-db3.bigfish.com (Postfix) with ESMTP id 294CACC804F	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:39:31 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o8O3dS6W012703	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 20:39:28 -0700 (MST)
Received: from shlinux1.ap.freescale.net ([10.192.225.216])	by
 de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o8O3svD9023587	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 22:54:57 -0500 (CDT)
In-Reply-To: <1285299788-32209-3-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

Based on SDHCI API, esdhc driver supports PIO and simple internal
DMA modes.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/mmc/host/Kconfig     |   13 ++
 drivers/mmc/host/Makefile    |    1 +
 drivers/mmc/host/sdhci-imx.c |  395 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 409 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-imx.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 283190b..ce2840c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -130,6 +130,19 @@ config MMC_SDHCI_CNS3XXX
 
 	  If unsure, say N.
 
+config MMC_SDHCI_IMX
+	tristate "Freescale i.MX platform eSDHCI support"
+	depends on ARCH_MX5 && MMC_SDHCI
+	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Freescale i.MX Enhanced Secure Card Host
+	  Controller Interface.
+	  If you have a i.MX platform with a Multimedia Card slot,
+	  say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
 	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 840bcb5..ae7c3e7 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
 sdhci-platform-y				:= sdhci-pltfm.o
 sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
+sdhci-platform-$(CONFIG_MMC_SDHCI_IMX)		+= sdhci-imx.o
 
 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
diff --git a/drivers/mmc/host/sdhci-imx.c b/drivers/mmc/host/sdhci-imx.c
new file mode 100644
index 0000000..6e34bcd
--- /dev/null
+++ b/drivers/mmc/host/sdhci-imx.c
@@ -0,0 +1,395 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * sdhci-imx.c Support for SDHCI platform devices
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
+ * SDHCI imx devices
+ *
+ * Inspired by sdhci-pci.c, by Pierre Ossman
+ */
+
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/mmc/host.h>
+#include <linux/sdhci-pltfm.h>
+
+#include <mach/mmc.h>
+
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+/* Vendor specified registors */
+#define	FSL_SDHCI_WML 		0x44
+#define	FSL_SDHCI_WML_16_WORDS 	0x08100810
+#define	FSL_SDHCI_WML_32_WORDS 	0x08200820
+#define	FSL_SDHCI_WML_64_WORDS 	0x08400840
+#define	FSL_SDHCI_WML_128_WORDS 0x08800880
+
+/* Non-standard clock control registor */
+#define ESDHC_SYSTEM_CONTROL	0x2C
+#define ESDHC_CLOCK_MASK	0x0000FFF0
+#define ESDHC_PREDIV_SHIFT	8
+#define ESDHC_DIVIDER_SHIFT	4
+#define ESDHC_CLOCK_PEREN	0x00000004
+#define ESDHC_CLOCK_HCKEN	0x00000002
+#define ESDHC_CLOCK_IPGEN	0x00000001
+
+/* Non-standard host control registor */
+#define	ESDHC_SDHCI_CTRL_8BITBUS 	0x00000004
+#define	FSL_ESDHC_HOST_CONTROL_RES 	0x33E
+#define ESDHC_HOST_CONTROL_LE 		0x20
+
+/*****************************************************************************\
+ *                                                                           *
+ * SDHCI core callbacks                                                      *
+ *                                                                           *
+\*****************************************************************************/
+
+static u32 sdhci_imx_readl(struct sdhci_host *host, int reg)
+{
+	return readl(host->ioaddr + reg);
+}
+
+static u16 sdhci_imx_readw(struct sdhci_host *host, int reg)
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
+static u8 sdhci_imx_readb(struct sdhci_host *host, int reg)
+{
+	u32 val;
+	u8 rc;
+
+	val = readl(host->ioaddr + (reg / 4) * 4);
+	rc = (val >> (reg % 4) * 8) & 0xFF;
+	if (reg == SDHCI_HOST_CONTROL) {
+		/* Bus width */
+		if (val & ESDHC_SDHCI_CTRL_8BITBUS) {
+			rc |= SDHCI_CTRL_8BITBUS;
+			rc &= ~SDHCI_CTRL_4BITBUS;
+		} else if (val & SDHCI_CTRL_4BITBUS) {
+			rc &= ~SDHCI_CTRL_8BITBUS;
+			rc |= SDHCI_CTRL_4BITBUS;
+		} else {
+			rc &= ~SDHCI_CTRL_8BITBUS;
+			rc &= ~SDHCI_CTRL_4BITBUS;
+		}
+		/* DMA */
+		if (val & (SDHCI_CTRL_DMA_MASK << 5))
+			rc |= ((val >> 5) & SDHCI_CTRL_DMA_MASK);
+		/* FIXME D3CD */
+	}
+
+	return rc;
+}
+
+static void sdhci_imx_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	writel(val, host->ioaddr + reg);
+}
+
+static void sdhci_imx_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	u32 io_val;
+
+	if (reg % 4 == 3) {
+		printk(KERN_ERR "Invalid reg address!\n");
+		return;
+	}
+
+	if (reg == SDHCI_BLOCK_SIZE) {
+		/*
+		 * Two last DMA bits are reserved, and first one is used for
+		 * non-standard blksz of 4096 bytes that we don't support
+		 * yet. So clear the DMA boundary bits.
+		 */
+		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
+	}
+
+	io_val = readl(host->ioaddr + (reg / 4) * 4);
+	io_val &= ~(0xFFFF << ((reg % 4) * 8));
+	io_val |= val << ((reg % 4) * 8);
+
+	switch (reg) {
+	case SDHCI_TRANSFER_MODE:
+		/*
+		 * Postpone this write, we must do it together with a
+		 * command write that is down below.
+		 */
+		pltfm_host->scratchpad = val;
+		return;
+	case SDHCI_COMMAND:
+		writel(io_val | pltfm_host->scratchpad,
+				    host->ioaddr +  SDHCI_TRANSFER_MODE);
+		/*
+		 * Make a double check that the warte mark level register is
+		 * configured properly. default value is FSL_SDHCI_WML_16_WORDS
+		 */
+		if (readl(host->ioaddr + FSL_SDHCI_WML)
+				== FSL_SDHCI_WML_16_WORDS) {
+			if (host->flags & SDHCI_REQ_USE_DMA)
+				writel(FSL_SDHCI_WML_64_WORDS,
+						host->ioaddr + FSL_SDHCI_WML);
+			else
+				writel(FSL_SDHCI_WML_128_WORDS,
+						host->ioaddr + FSL_SDHCI_WML);
+		}
+		return;
+	}
+
+	writel(io_val, host->ioaddr + (reg / 4) * 4);
+}
+
+static void sdhci_imx_set_power(struct sdhci_host *host, u8 power)
+{
+	int voltage = 0;
+
+	/* There is no sdhci standard PWR CTL REG in imx sdhci */
+	if (host->pwr == power)
+		return;
+
+	if (host->vmmc) {
+		if (power == (unsigned short)-1) {
+			regulator_disable(host->vmmc);
+			dev_dbg(mmc_dev(host->mmc), "mmc power off\n");
+		} else {
+			if (power == 7)
+				voltage = 1800000;
+			else if (power >= 8)
+				voltage = 2000000 + (power - 8) * 100000;
+			regulator_set_voltage(host->vmmc, voltage, voltage);
+
+			if (regulator_enable(host->vmmc) == 0) {
+				dev_dbg(mmc_dev(host->mmc), "mmc power on\n");
+				msleep(1);
+			}
+		}
+	}
+
+	host->pwr = power;
+}
+
+static void sdhci_imx_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	u32 io_val;
+
+	/* Since there is no power register in FSL eSDHC, handle it in SW */
+	if (reg == SDHCI_POWER_CONTROL) {
+		sdhci_imx_set_power(host, val);
+		return;
+	}
+
+	if (reg == SDHCI_HOST_CONTROL) {
+		io_val = readl(host->ioaddr + SDHCI_HOST_CONTROL);
+		/* Bit7~6, andi bit0 */
+		io_val |= (val & ~FSL_ESDHC_HOST_CONTROL_RES);
+		/* Ensure the LE mode */
+		io_val |= ESDHC_HOST_CONTROL_LE;
+		/* Configure the bus_width 8bits, 4bits, or 1bit*/
+		if (val & SDHCI_CTRL_8BITBUS) {
+			io_val |= ESDHC_SDHCI_CTRL_8BITBUS;
+			io_val &= ~SDHCI_CTRL_4BITBUS;
+		} else if (val & SDHCI_CTRL_4BITBUS) {
+			io_val &= ~ESDHC_SDHCI_CTRL_8BITBUS;
+			io_val |= SDHCI_CTRL_4BITBUS;
+		} else {
+			io_val &= ~ESDHC_SDHCI_CTRL_8BITBUS;
+			io_val &= ~SDHCI_CTRL_4BITBUS;
+		}
+
+		/* Configure the DMA */
+		if (val & SDHCI_CTRL_DMA_MASK)
+			io_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
+		writel(io_val, host->ioaddr + SDHCI_HOST_CONTROL);
+
+		return;
+	}
+
+	io_val = readl(host->ioaddr + (reg / 4) * 4);
+	io_val &= ~(0xFF << ((reg % 4) * 8));
+	io_val |= val << ((reg % 4) * 8);
+
+	writel(io_val, host->ioaddr + (reg / 4) * 4);
+}
+
+static unsigned int sdhci_imx_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk);
+}
+
+static unsigned int sdhci_imx_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk) / 256 / 16;
+}
+
+static unsigned int sdhci_imx_get_timeout_clock(struct sdhci_host *host)
+{
+	return sdhci_imx_get_max_clock(host) / 1000000;
+}
+
+static unsigned int sdhci_imx_get_ro(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return gpio_get_value(pltfm_host->wp_gpio);
+}
+
+static void sdhci_imx_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	int pre_div = 2;
+	int div = 1;
+	u32 temp;
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+			| ESDHC_CLOCK_MASK);
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
+			| (div << ESDHC_DIVIDER_SHIFT)
+			| (pre_div << ESDHC_PREDIV_SHIFT));
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+	mdelay(10);
+out:
+	host->clock = clock;
+}
+
+static int sdhci_imx_enable_dma(struct sdhci_host *host)
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
+static int __match_sdhci_imx(struct device *dev, void *data)
+{
+	return !strncmp(dev_name(dev), "imx-sdhci", 9);
+}
+static int sdhci_imx_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct clk *clk;
+	struct device *dev;
+
+	dev = device_find_child(mmc_dev(host->mmc), NULL, __match_sdhci_imx);
+	clk = clk_get(dev, "imx_sdhc_clk");
+	if (IS_ERR(clk)) {
+		dev_err(mmc_dev(host->mmc), "clk err\n");
+		return -ENODEV;
+	}
+	clk_enable(clk);
+	pltfm_host->clk = clk;
+	dev_dbg(dev, "SDHC clock:%lu\n", clk_get_rate(clk));
+
+	return 0;
+}
+
+static void sdhci_imx_exit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	clk_disable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+}
+
+
+static struct sdhci_ops sdhci_imx_ops = {
+	.read_l 		= sdhci_imx_readl,
+	.read_w 		= sdhci_imx_readw,
+	.read_b 		= sdhci_imx_readb,
+	.write_l 		= sdhci_imx_writel,
+	.write_w 		= sdhci_imx_writew,
+	.write_b 		= sdhci_imx_writeb,
+	.set_clock 		= sdhci_imx_set_clock,
+	.enable_dma 		= sdhci_imx_enable_dma,
+	.get_max_clock 		= sdhci_imx_get_max_clock,
+	.get_min_clock 		= sdhci_imx_get_min_clock,
+	.get_timeout_clock 	= sdhci_imx_get_timeout_clock,
+	.get_ro 		= sdhci_imx_get_ro,
+};
+
+struct sdhci_pltfm_data sdhci_imx_pdata = {
+	.ops = &sdhci_imx_ops,
+	.quirks = SDHCI_QUIRK_BROKEN_ADMA
+		| SDHCI_QUIRK_32BIT_DMA_ADDR
+		| SDHCI_QUIRK_32BIT_ADMA_SIZE
+		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+		| SDHCI_QUIRK_NO_BUSY_IRQ
+		| SDHCI_QUIRK_BROKEN_CARD_DETECTION
+		| SDHCI_QUIRK_NONSTANDARD_CLOCK
+		| SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET,
+	.init = sdhci_imx_init,
+	.exit = sdhci_imx_exit,
+};
-- 
1.7.0


