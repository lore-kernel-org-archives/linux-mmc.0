From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 2/3] mmc: add driver for imx35/51
Date: Mon,  6 Sep 2010 12:34:24 +0200
Message-ID: <1283769265-14147-3-git-send-email-w.sang@pengutronix.de>
References: <1283769265-14147-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51025 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab0IFKe4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 06:34:56 -0400
In-Reply-To: <1283769265-14147-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

WIP!

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/Kconfig       |    9 ++
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sdhci-esdhc.c |  194 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c |    3 +
 drivers/mmc/host/sdhci-pltfm.h |    1 +
 5 files changed, 208 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 68d1279..bba3aec 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -130,6 +130,15 @@ config MMC_SDHCI_CNS3XXX
 
 	  If unsure, say N.
 
+config MMC_SDHCI_ESDHC
+	bool "SDHCI platform support for the Freescale eSDHC controller"
+	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Freescale eSDHC controller support.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
 	depends on MMC_SDHCI && PLAT_SAMSUNG
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 840bcb5..7bde748 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
 sdhci-platform-y				:= sdhci-pltfm.o
 sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
+sdhci-platform-$(CONFIG_MMC_SDHCI_ESDHC)	+= sdhci-esdhc.o
 
 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
diff --git a/drivers/mmc/host/sdhci-esdhc.c b/drivers/mmc/host/sdhci-esdhc.c
new file mode 100644
index 0000000..dced0fd
--- /dev/null
+++ b/drivers/mmc/host/sdhci-esdhc.c
@@ -0,0 +1,194 @@
+/*
+ * Freescale eSDHC controller driver for the platform bus.
+ *
+ * derived from the OF-version. WIP!
+ *
+ * Copyright (c) 2010 Pengutronix e.K.
+ *   Author: Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ */
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/mmc/host.h>
+#include <linux/clk.h>
+#include <linux/sdhci-pltfm.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+/*
+ * Ops and quirks for the Freescale eSDHC controller.
+ */
+
+// FIXME: Share those with the OF-version
+#define ESDHC_SYSTEM_CONTROL	0x2c
+#define ESDHC_CLOCK_MASK	0x0000fff0
+#define ESDHC_PREDIV_SHIFT	8
+#define ESDHC_DIVIDER_SHIFT	4
+#define ESDHC_CLOCK_PEREN	0x00000004
+#define ESDHC_CLOCK_HCKEN	0x00000002
+#define ESDHC_CLOCK_IPGEN	0x00000001
+
+#define ESDHC_HOST_CONTROL_8BITBUS	0x04
+#define ESDHC_HOST_CONTROL_LE		0x20
+
+static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
+{
+	void __iomem *base = host->ioaddr + (reg & ~0x3);
+	u32 shift = (reg & 0x3) * 8;
+
+	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
+}
+
+static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
+{
+	if (unlikely(reg == SDHCI_HOST_VERSION))
+		reg ^= 2;
+
+	return readw(host->ioaddr + reg);
+}
+
+static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
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
+		writel(val << 16 | pltfm_host->scratchpad,
+			host->ioaddr + SDHCI_TRANSFER_MODE);
+		return;
+	case SDHCI_BLOCK_SIZE:
+		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
+		break;
+	}
+	esdhc_clrset_le(host, 0xffff, val, reg);
+}
+
+static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
+{
+	u32 new_val;
+
+	switch (reg) {
+	case SDHCI_POWER_CONTROL:
+		/* FSL put some DMA bits here */
+		//FIXME: Convert to regulator?
+		return;
+	case SDHCI_HOST_CONTROL:
+		/* FSL messed up here, so we can just keep those two */
+		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
+		/* ensure the endianess */
+		new_val |= ESDHC_HOST_CONTROL_LE;
+		/* DMA mode bits are shifted */
+		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
+
+		esdhc_clrset_le(host, 0xffff, new_val, reg);
+		return;
+	}
+	esdhc_clrset_le(host, 0xff, val, reg);
+}
+
+
+//FIXME: Share the next three with OF?
+static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	int pre_div = 2;
+	int div = 1;
+	u32 temp;
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
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
+	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN |
+		  (div << ESDHC_DIVIDER_SHIFT) | (pre_div << ESDHC_PREDIV_SHIFT));
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+	mdelay(100);
+out:
+	host->clock = clock;
+}
+
+static unsigned int esdhc_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	return clk_get_rate(pltfm_host->clk);
+}
+
+static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	return clk_get_rate(pltfm_host->clk) / 256 / 16;
+}
+
+static int esdhc_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct clk *clk;
+
+	clk = clk_get(NULL, "sdhc");
+	if (IS_ERR(clk)) {
+		dev_err(mmc_dev(host->mmc), "clk err\n");
+		return -ENODEV;
+	}
+	clk_enable(clk);
+	pltfm_host->clk = clk;
+
+	return 0;
+}
+
+static void esdhc_exit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	clk_enable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+}
+
+static struct sdhci_ops sdhci_esdhc_ops = {
+	.read_w = esdhc_readw_le,
+	.write_w = esdhc_writew_le,
+	.write_b = esdhc_writeb_le,
+	.set_clock = esdhc_set_clock,
+	.get_max_clock = esdhc_get_max_clock,
+	.get_min_clock = esdhc_get_min_clock,
+};
+
+struct sdhci_pltfm_data sdhci_esdhc_pdata = {
+	.quirks = SDHCI_QUIRK_FORCE_BLK_SZ_2048 |
+		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_NO_BUSY_IRQ |
+		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
+		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
+		  SDHCI_QUIRK_NO_CARD_NO_RESET,
+	.ops = &sdhci_esdhc_ops,
+	.init = esdhc_init,
+	.exit = esdhc_exit,
+};
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bf522a1..94be59f 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -164,6 +164,9 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
 #ifdef CONFIG_MMC_SDHCI_CNS3XXX
 	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
 #endif
+#ifdef CONFIG_MMC_SDHCI_ESDHC
+	{ "sdhci-esdhc", (kernel_ulong_t)&sdhci_esdhc_pdata },
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index c393289..4b1e1db 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -19,5 +19,6 @@ struct sdhci_pltfm_host {
 };
 
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
+extern struct sdhci_pltfm_data sdhci_esdhc_pdata;
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
-- 
1.7.1

