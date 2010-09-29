From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 6/6] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Wed, 29 Sep 2010 22:08:04 +0200
Message-ID: <1285790884-3516-7-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34119 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635Ab0I2UIX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 16:08:23 -0400
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

This driver adds basic support for the esdhc-core found on e.g.
imx35/51. It adds up to the pltfm-core.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
---

Changes since last version:

* some more -imx suffixes added
* reworked the clock-matching. Now matching the pdev

 drivers/mmc/host/Kconfig           |   10 +++
 drivers/mmc/host/Makefile          |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c |  143 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c     |    3 +
 drivers/mmc/host/sdhci-pltfm.h     |    1 +
 5 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6f12d5d..3c8c286 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -143,6 +143,16 @@ config MMC_SDHCI_MV
 
 	  If unsure, say N.
 
+config MMC_SDHCI_ESDHC_IMX
+	bool "SDHCI platform support for the Freescale eSDHC i.MX controller"
+	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Freescale eSDHC controller support on the platform
+	  bus, found on platforms like mx35/51.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
 	depends on MMC_SDHCI && PLAT_SAMSUNG
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index ef32c32..5f283b5 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MMC_USHC)		+= ushc.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
 sdhci-platform-y				:= sdhci-pltfm.o
 sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
+sdhci-platform-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
 
 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
new file mode 100644
index 0000000..68cf78c
--- /dev/null
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -0,0 +1,143 @@
+/*
+ * Freescale eSDHC i.MX controller driver for the platform bus.
+ *
+ * derived from the OF-version.
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
+#include <linux/clk.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdhci-pltfm.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+#include "sdhci-esdhc.h"
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
+		/*
+		 * FSL put some DMA bits here
+		 * If your board has a regulator, code should be here
+		 */
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
+static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk);
+}
+
+static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk) / 256 / 16;
+}
+
+static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pdata)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct clk *clk;
+
+	clk = clk_get(mmc_dev(host->mmc), NULL);
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
+static void esdhc_pltfm_exit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	clk_disable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+}
+
+static struct sdhci_ops sdhci_esdhc_ops = {
+	.read_w = esdhc_readw_le,
+	.write_w = esdhc_writew_le,
+	.write_b = esdhc_writeb_le,
+	.set_clock = esdhc_set_clock,
+	.get_max_clock = esdhc_pltfm_get_max_clock,
+	.get_min_clock = esdhc_pltfm_get_min_clock,
+};
+
+struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTIBLOCK
+			| SDHCI_QUIRK_BROKEN_ADMA,
+	/* ADMA has issues. Might be fixable */
+	/* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207) */
+	.ops = &sdhci_esdhc_ops,
+	.init = esdhc_pltfm_init,
+	.exit = esdhc_pltfm_exit,
+};
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 2b315e9..9ef7050 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -164,6 +164,9 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
 #ifdef CONFIG_MMC_SDHCI_CNS3XXX
 	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
 #endif
+#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
+	{ "sdhci-esdhc-imx", (kernel_ulong_t)&sdhci_esdhc_imx_pdata },
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 562b929..c1bfe48 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -21,5 +21,6 @@ struct sdhci_pltfm_host {
 };
 
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
+extern struct sdhci_pltfm_data sdhci_esdhc_imx_pdata;
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
-- 
1.7.1

