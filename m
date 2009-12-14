From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [RFC PATCH v2 4/4] sdhci-of: add support for the wii sdhci controller
Date: Mon, 14 Dec 2009 23:24:19 +0100
Message-ID: <1260829459-23518-5-git-send-email-albert_herranz@yahoo.es>
References: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp104.mail.ukl.yahoo.com ([77.238.184.36]:27069 "HELO
	smtp104.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933148AbZLNWYd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 17:24:33 -0500
In-Reply-To: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, Albert Herranz <albert_herranz@yahoo.es>

Add support for the Secure Digital Host Controller Interface found on the
"Hollywood" chipset of the Nintendo Wii video game console.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/mmc/host/Kconfig         |   13 +++++++-
 drivers/mmc/host/Makefile        |    1 +
 drivers/mmc/host/sdhci-of-core.c |    3 ++
 drivers/mmc/host/sdhci-of-hlwd.c |   65 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of.h      |    1 +
 5 files changed, 82 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-of-hlwd.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 92076b3..5b70707 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -55,7 +55,7 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 	  has the effect of scrambling the addresses and formats of data
 	  accessed in sizes other than the datum size.
 
-	  This is the case for the Freescale eSDHC.
+	  This is the case for the Freescale eSDHC and Nintendo Wii SDHCI.
 
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
@@ -103,6 +103,17 @@ config MMC_SDHCI_OF_ESDHC
 
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_HLWD
+	bool "SDHCI OF support for the Nintendo Wii SDHCI controllers"
+	depends on MMC_SDHCI_OF
+	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  found in the "Hollywood" chipset of the Nintendo Wii video game
+	  console.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_PLTFM
 	tristate "SDHCI support on the platform specific bus"
 	depends on MMC_SDHCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 2563c81..26f1726 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
 sdhci-of-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
+sdhci-of-$(CONFIG_MMC_SDHCI_OF_HLWD)	+= sdhci-of-hlwd.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index add2008..55e3313 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -196,6 +196,9 @@ static const struct of_device_id sdhci_of_match[] = {
 	{ .compatible = "fsl,mpc8536-esdhc", .data = &sdhci_esdhc, },
 	{ .compatible = "fsl,esdhc", .data = &sdhci_esdhc, },
 #endif
+#ifdef CONFIG_MMC_SDHCI_OF_HLWD
+	{ .compatible = "nintendo,hollywood-sdhci", .data = &sdhci_hlwd, },
+#endif
 	{ .compatible = "generic-sdhci", },
 	{},
 };
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
new file mode 100644
index 0000000..35117f3
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -0,0 +1,65 @@
+/*
+ * drivers/mmc/host/sdhci-of-hlwd.c
+ *
+ * Nintendo Wii Secure Digital Host Controller Interface.
+ * Copyright (C) 2009 The GameCube Linux Team
+ * Copyright (C) 2009 Albert Herranz
+ *
+ * Based on sdhci-of-esdhc.c
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
+#include <linux/delay.h>
+#include <linux/mmc/host.h>
+#include "sdhci-of.h"
+#include "sdhci.h"
+
+/*
+ * Ops and quirks for the Nintendo Wii SDHCI controllers.
+ */
+
+/*
+ * We need a small delay after each write, or things go horribly wrong.
+ */
+#define SDHCI_HLWD_WRITE_DELAY	5 /* usecs */
+
+static void sdhci_hlwd_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	sdhci_be32bs_writel(host, val, reg);
+	udelay(SDHCI_HLWD_WRITE_DELAY);
+}
+
+static void sdhci_hlwd_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	sdhci_be32bs_writew(host, val, reg);
+	udelay(SDHCI_HLWD_WRITE_DELAY);
+}
+
+static void sdhci_hlwd_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	sdhci_be32bs_writeb(host, val, reg);
+	udelay(SDHCI_HLWD_WRITE_DELAY);
+}
+
+struct sdhci_of_data sdhci_hlwd = {
+	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR |
+		  SDHCI_QUIRK_32BIT_DMA_SIZE,
+	.ops = {
+		.readl = sdhci_be32bs_readl,
+		.readw = sdhci_be32bs_readw,
+		.readb = sdhci_be32bs_readb,
+		.writel = sdhci_hlwd_writel,
+		.writew = sdhci_hlwd_writew,
+		.writeb = sdhci_hlwd_writeb,
+	},
+};
diff --git a/drivers/mmc/host/sdhci-of.h b/drivers/mmc/host/sdhci-of.h
index 17e873d..ad09ad9 100644
--- a/drivers/mmc/host/sdhci-of.h
+++ b/drivers/mmc/host/sdhci-of.h
@@ -37,5 +37,6 @@ extern void sdhci_be32bs_writew(struct sdhci_host *host, u16 val, int reg);
 extern void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg);
 
 extern struct sdhci_of_data sdhci_esdhc;
+extern struct sdhci_of_data sdhci_hlwd;
 
 #endif /* __SDHCI_OF_H */
-- 
1.6.3.3

