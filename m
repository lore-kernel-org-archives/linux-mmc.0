From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/2] mmc: sdhci-bcm2835: remove driver
Date: Fri,  3 Jun 2016 19:47:13 +0000
Message-ID: <1464983233-27001-3-git-send-email-stefan.wahren@i2se.com>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:57534 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964811AbcFCTsO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 15:48:14 -0400
In-Reply-To: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

The sdhci-bcm2835 is no more needed since it has been replaced
by sdhci-iproc.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/Kconfig         |   11 --
 drivers/mmc/host/Makefile        |    1 -
 drivers/mmc/host/sdhci-bcm2835.c |  204 --------------------------------------
 3 files changed, 216 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-bcm2835.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0aa484c..2cf124a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -296,17 +296,6 @@ config MMC_SDHCI_BCM_KONA
 
 	  If you have a controller with this interface, say Y or M here.
 
-config MMC_SDHCI_BCM2835
-	tristate "SDHCI platform support for the BCM2835 SD/MMC Controller"
-	depends on ARCH_BCM2835
-	depends on MMC_SDHCI_PLTFM
-	select MMC_SDHCI_IO_ACCESSORS
-	help
-	  This selects the BCM2835 SD/MMC controller. If you have a BCM2835
-	  platform with SD or MMC devices, say Y or M here.
-
-	  If unsure, say N.
-
 config MMC_SDHCI_F_SDH30
 	tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
 	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index af918d2..61a9345 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
-obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= sdhci-bcm2835.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
 obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
deleted file mode 100644
index 4a6a1d1..0000000
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ /dev/null
@@ -1,204 +0,0 @@
-/*
- * BCM2835 SDHCI
- * Copyright (C) 2012 Stephen Warren
- * Based on U-Boot's MMC driver for the BCM2835 by Oleksandr Tymoshenko & me
- * Portions of the code there were obviously based on the Linux kernel at:
- * git://github.com/raspberrypi/linux.git rpi-3.6.y
- * commit f5b930b "Main bcm2708 linux port" signed-off-by Dom Cobley.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/mmc/host.h>
-#include "sdhci-pltfm.h"
-
-/*
- * 400KHz is max freq for card ID etc. Use that as min card clock. We need to
- * know the min to enable static calculation of max BCM2835_SDHCI_WRITE_DELAY.
- */
-#define MIN_FREQ 400000
-
-/*
- * The Arasan has a bugette whereby it may lose the content of successive
- * writes to registers that are within two SD-card clock cycles of each other
- * (a clock domain crossing problem). It seems, however, that the data
- * register does not have this problem, which is just as well - otherwise we'd
- * have to nobble the DMA engine too.
- *
- * This should probably be dynamically calculated based on the actual card
- * frequency. However, this is the longest we'll have to wait, and doesn't
- * seem to slow access down too much, so the added complexity doesn't seem
- * worth it for now.
- *
- * 1/MIN_FREQ is (max) time per tick of eMMC clock.
- * 2/MIN_FREQ is time for two ticks.
- * Multiply by 1000000 to get uS per two ticks.
- * *1000000 for uSecs.
- * +1 for hack rounding.
- */
-#define BCM2835_SDHCI_WRITE_DELAY	(((2 * 1000000) / MIN_FREQ) + 1)
-
-struct bcm2835_sdhci {
-	u32 shadow;
-};
-
-static void bcm2835_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
-{
-	writel(val, host->ioaddr + reg);
-
-	udelay(BCM2835_SDHCI_WRITE_DELAY);
-}
-
-static inline u32 bcm2835_sdhci_readl(struct sdhci_host *host, int reg)
-{
-	u32 val = readl(host->ioaddr + reg);
-
-	if (reg == SDHCI_CAPABILITIES)
-		val |= SDHCI_CAN_VDD_330;
-
-	return val;
-}
-
-static void bcm2835_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct bcm2835_sdhci *bcm2835_host = sdhci_pltfm_priv(pltfm_host);
-	u32 oldval = (reg == SDHCI_COMMAND) ? bcm2835_host->shadow :
-		bcm2835_sdhci_readl(host, reg & ~3);
-	u32 word_num = (reg >> 1) & 1;
-	u32 word_shift = word_num * 16;
-	u32 mask = 0xffff << word_shift;
-	u32 newval = (oldval & ~mask) | (val << word_shift);
-
-	if (reg == SDHCI_TRANSFER_MODE)
-		bcm2835_host->shadow = newval;
-	else
-		bcm2835_sdhci_writel(host, newval, reg & ~3);
-}
-
-static u16 bcm2835_sdhci_readw(struct sdhci_host *host, int reg)
-{
-	u32 val = bcm2835_sdhci_readl(host, (reg & ~3));
-	u32 word_num = (reg >> 1) & 1;
-	u32 word_shift = word_num * 16;
-	u32 word = (val >> word_shift) & 0xffff;
-
-	return word;
-}
-
-static void bcm2835_sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
-{
-	u32 oldval = bcm2835_sdhci_readl(host, reg & ~3);
-	u32 byte_num = reg & 3;
-	u32 byte_shift = byte_num * 8;
-	u32 mask = 0xff << byte_shift;
-	u32 newval = (oldval & ~mask) | (val << byte_shift);
-
-	bcm2835_sdhci_writel(host, newval, reg & ~3);
-}
-
-static u8 bcm2835_sdhci_readb(struct sdhci_host *host, int reg)
-{
-	u32 val = bcm2835_sdhci_readl(host, (reg & ~3));
-	u32 byte_num = reg & 3;
-	u32 byte_shift = byte_num * 8;
-	u32 byte = (val >> byte_shift) & 0xff;
-
-	return byte;
-}
-
-static unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
-{
-	return MIN_FREQ;
-}
-
-static const struct sdhci_ops bcm2835_sdhci_ops = {
-	.write_l = bcm2835_sdhci_writel,
-	.write_w = bcm2835_sdhci_writew,
-	.write_b = bcm2835_sdhci_writeb,
-	.read_l = bcm2835_sdhci_readl,
-	.read_w = bcm2835_sdhci_readw,
-	.read_b = bcm2835_sdhci_readb,
-	.set_clock = sdhci_set_clock,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
-	.get_min_clock = bcm2835_sdhci_get_min_clock,
-	.set_bus_width = sdhci_set_bus_width,
-	.reset = sdhci_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
-};
-
-static const struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
-	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
-	.ops = &bcm2835_sdhci_ops,
-};
-
-static int bcm2835_sdhci_probe(struct platform_device *pdev)
-{
-	struct sdhci_host *host;
-	struct bcm2835_sdhci *bcm2835_host;
-	struct sdhci_pltfm_host *pltfm_host;
-	int ret;
-
-	host = sdhci_pltfm_init(pdev, &bcm2835_sdhci_pdata,
-				sizeof(*bcm2835_host));
-	if (IS_ERR(host))
-		return PTR_ERR(host);
-
-	pltfm_host = sdhci_priv(host);
-
-	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pltfm_host->clk)) {
-		ret = PTR_ERR(pltfm_host->clk);
-		goto err;
-	}
-	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable host clk\n");
-		goto err;
-	}
-
-	ret = sdhci_add_host(host);
-	if (ret)
-		goto err_clk;
-
-	return 0;
-err_clk:
-	clk_disable_unprepare(pltfm_host->clk);
-err:
-	sdhci_pltfm_free(pdev);
-	return ret;
-}
-
-static const struct of_device_id bcm2835_sdhci_of_match[] = {
-	{ .compatible = "brcm,bcm2835-sdhci" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, bcm2835_sdhci_of_match);
-
-static struct platform_driver bcm2835_sdhci_driver = {
-	.driver = {
-		.name = "sdhci-bcm2835",
-		.of_match_table = bcm2835_sdhci_of_match,
-		.pm = SDHCI_PLTFM_PMOPS,
-	},
-	.probe = bcm2835_sdhci_probe,
-	.remove = sdhci_pltfm_unregister,
-};
-module_platform_driver(bcm2835_sdhci_driver);
-
-MODULE_DESCRIPTION("BCM2835 SDHCI driver");
-MODULE_AUTHOR("Stephen Warren");
-MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

