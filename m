From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 5/6] mmc: sdhci-of-esdhc: factor out common stuff
Date: Wed, 29 Sep 2010 22:08:03 +0200
Message-ID: <1285790884-3516-6-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34116 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab0I2UIX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 16:08:23 -0400
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

Put everything which can be shared between the OF and platform version
of this driver into a local .h-file.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Changes since last version:

* use inline for set_clock()

 drivers/mmc/host/sdhci-esdhc.h    |   81 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c |   70 ++++----------------------------
 2 files changed, 89 insertions(+), 62 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc.h

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
new file mode 100644
index 0000000..7ccc8cb
--- /dev/null
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -0,0 +1,81 @@
+/*
+ * Freescale eSDHC controller driver generics for OF and pltfm.
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2009 MontaVista Software, Inc.
+ * Copyright (c) 2010 Pengutronix e.K.
+ *   Author: Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ */
+
+#ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
+#define _DRIVERS_MMC_SDHCI_ESDHC_H
+
+/*
+ * Ops and quirks for the Freescale eSDHC controller.
+ */
+
+#define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
+				SDHCI_QUIRK_BROKEN_CARD_DETECTION | \
+				SDHCI_QUIRK_NO_BUSY_IRQ | \
+				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
+				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
+				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
+				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET | \
+				SDHCI_QUIRK_NO_CARD_NO_RESET)
+
+#define ESDHC_SYSTEM_CONTROL	0x2c
+#define ESDHC_CLOCK_MASK	0x0000fff0
+#define ESDHC_PREDIV_SHIFT	8
+#define ESDHC_DIVIDER_SHIFT	4
+#define ESDHC_CLOCK_PEREN	0x00000004
+#define ESDHC_CLOCK_HCKEN	0x00000002
+#define ESDHC_CLOCK_IPGEN	0x00000001
+
+/* pltfm-specific */
+#define ESDHC_HOST_CONTROL_LE	0x20
+
+/* OF-specific */
+#define ESDHC_DMA_SYSCTL	0x40c
+#define ESDHC_DMA_SNOOP		0x00000040
+
+#define ESDHC_HOST_CONTROL_RES	0x05
+
+static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
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
+#endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c8623de..277fcb9 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -18,23 +18,7 @@
 #include <linux/mmc/host.h>
 #include "sdhci-of.h"
 #include "sdhci.h"
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
+#include "sdhci-esdhc.c"
 
 static u16 esdhc_readw(struct sdhci_host *host, int reg)
 {
@@ -68,51 +52,20 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 	sdhci_be32bs_writeb(host, val, reg);
 }
 
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
+static int esdhc_of_enable_dma(struct sdhci_host *host)
 {
 	setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
 	return 0;
 }
 
-static unsigned int esdhc_get_max_clock(struct sdhci_host *host)
+static unsigned int esdhc_of_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_of_host *of_host = sdhci_priv(host);
 
 	return of_host->clock;
 }
 
-static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
+static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 {
 	struct sdhci_of_host *of_host = sdhci_priv(host);
 
@@ -120,14 +73,7 @@ static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
 }
 
 struct sdhci_of_data sdhci_esdhc = {
-	.quirks = SDHCI_QUIRK_FORCE_BLK_SZ_2048 |
-		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_NO_BUSY_IRQ |
-		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
-		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
-		  SDHCI_QUIRK_NO_CARD_NO_RESET,
+	.quirks = ESDHC_DEFAULT_QUIRKS,
 	.ops = {
 		.read_l = sdhci_be32bs_readl,
 		.read_w = esdhc_readw,
@@ -136,8 +82,8 @@ struct sdhci_of_data sdhci_esdhc = {
 		.write_w = esdhc_writew,
 		.write_b = esdhc_writeb,
 		.set_clock = esdhc_set_clock,
-		.enable_dma = esdhc_enable_dma,
-		.get_max_clock = esdhc_get_max_clock,
-		.get_min_clock = esdhc_get_min_clock,
+		.enable_dma = esdhc_of_enable_dma,
+		.get_max_clock = esdhc_of_get_max_clock,
+		.get_min_clock = esdhc_of_get_min_clock,
 	},
 };
-- 
1.7.1

