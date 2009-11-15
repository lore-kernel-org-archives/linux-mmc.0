From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [mmc-omap] Add support for 16-bit and 32-bit registers
Date: Sat, 14 Nov 2009 19:24:55 -0800
Message-ID: <1258255495.4209.3.camel@runt>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:60316 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZKODYw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Nov 2009 22:24:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org

The omap850 and omap730 use 16-bit registers instead of 32-bit, requiring
a modification of the register addresses in the mmc-omap driver.  To
make this as portable as possible, I made the following changes:

* Moved register address offsets from drivers/mmc/host/omap.c to
  drivers/mmc/host/omap.h
* Implemented a lookup table for 16-bit and 32-bit register offsets
* Added a reg_size field in the mmc_omap_host structure
* Added code in mmc_omap_probe() to populate the reg_size
  field based on processor in use
* Added inline function to return the register offset based on
  the register size and register name
* Modified mmc-omap driver to use the new inline function to call out
  register names

This change should allow the omap7xx-series of processors to correctly
utilize the MMC driver.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 drivers/mmc/host/omap.c |   42 +++++------------
 drivers/mmc/host/omap.h |  115 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 30 deletions(-)
 create mode 100644 drivers/mmc/host/omap.h

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5f970e2..c0071b3 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -37,31 +37,7 @@
 #include <plat/mux.h>
 #include <plat/fpga.h>
 
-#define	OMAP_MMC_REG_CMD	0x00
-#define	OMAP_MMC_REG_ARGL	0x04
-#define	OMAP_MMC_REG_ARGH	0x08
-#define	OMAP_MMC_REG_CON	0x0c
-#define	OMAP_MMC_REG_STAT	0x10
-#define	OMAP_MMC_REG_IE		0x14
-#define	OMAP_MMC_REG_CTO	0x18
-#define	OMAP_MMC_REG_DTO	0x1c
-#define	OMAP_MMC_REG_DATA	0x20
-#define	OMAP_MMC_REG_BLEN	0x24
-#define	OMAP_MMC_REG_NBLK	0x28
-#define	OMAP_MMC_REG_BUF	0x2c
-#define OMAP_MMC_REG_SDIO	0x34
-#define	OMAP_MMC_REG_REV	0x3c
-#define	OMAP_MMC_REG_RSP0	0x40
-#define	OMAP_MMC_REG_RSP1	0x44
-#define	OMAP_MMC_REG_RSP2	0x48
-#define	OMAP_MMC_REG_RSP3	0x4c
-#define	OMAP_MMC_REG_RSP4	0x50
-#define	OMAP_MMC_REG_RSP5	0x54
-#define	OMAP_MMC_REG_RSP6	0x58
-#define	OMAP_MMC_REG_RSP7	0x5c
-#define	OMAP_MMC_REG_IOSR	0x60
-#define	OMAP_MMC_REG_SYSC	0x64
-#define	OMAP_MMC_REG_SYSS	0x68
+#include "omap.h"
 
 #define	OMAP_MMC_STAT_CARD_ERR		(1 << 14)
 #define	OMAP_MMC_STAT_CARD_IRQ		(1 << 13)
@@ -77,8 +53,10 @@
 #define	OMAP_MMC_STAT_CARD_BUSY		(1 <<  2)
 #define	OMAP_MMC_STAT_END_OF_CMD	(1 <<  0)
 
-#define OMAP_MMC_READ(host, reg)	__raw_readw((host)->virt_base + OMAP_MMC_REG_##reg)
-#define OMAP_MMC_WRITE(host, reg, val)	__raw_writew((val), (host)->virt_base + OMAP_MMC_REG_##reg)
+#define OMAP_MMC_REG(host, reg)		mmc_omap_get_register(host->reg_size, OMAP_MMC_REG_##reg)
+
+#define OMAP_MMC_READ(host, reg)	__raw_readw((host)->virt_base + OMAP_MMC_REG(host, reg))
+#define OMAP_MMC_WRITE(host, reg, val)	__raw_writew((val), (host)->virt_base + OMAP_MMC_REG(host, reg))
 
 /*
  * Command types
@@ -167,6 +145,8 @@ struct mmc_omap_host {
 	spinlock_t		clk_lock;     /* for changing enabled state */
 	unsigned int            fclk_enabled:1;
 
+	unsigned		reg_size:1;
+
 	struct omap_mmc_platform_data *pdata;
 };
 
@@ -679,9 +659,9 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	host->data->bytes_xfered += n;
 
 	if (write) {
-		__raw_writesw(host->virt_base + OMAP_MMC_REG_DATA, host->buffer, n);
+		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffer, n);
 	} else {
-		__raw_readsw(host->virt_base + OMAP_MMC_REG_DATA, host->buffer, n);
+		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffer, n);
 	}
 }
 
@@ -899,7 +879,7 @@ mmc_omap_prepare_dma(struct mmc_omap_host *host, struct mmc_data *data)
 	int dst_port = 0;
 	int sync_dev = 0;
 
-	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
+	data_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
 	frame = data->blksz;
 	count = sg_dma_len(sg);
 
@@ -1490,6 +1470,8 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		}
 	}
 
+	host->reg_size = (cpu_is_omap7xx() ? OMAP_MMC_REG_SIZE_2 : OMAP_MMC_REG_SIZE_4);
+
 	return 0;
 
 err_plat_cleanup:
diff --git a/drivers/mmc/host/omap.h b/drivers/mmc/host/omap.h
new file mode 100644
index 0000000..9a52203
--- /dev/null
+++ b/drivers/mmc/host/omap.h
@@ -0,0 +1,115 @@
+/*
+ *  linux/drivers/mmc/host/omap.h
+ *
+ *  Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MMC_MMC_OMAP_H
+#define MMC_MMC_OMAP_H
+
+/* MMC registers used for omap-mmc driver */
+enum {
+	OMAP_MMC_REG_CMD = 0,
+	OMAP_MMC_REG_ARGL,
+	OMAP_MMC_REG_ARGH,
+	OMAP_MMC_REG_CON,
+	OMAP_MMC_REG_STAT,
+	OMAP_MMC_REG_IE,
+	OMAP_MMC_REG_CTO,
+	OMAP_MMC_REG_DTO,
+	OMAP_MMC_REG_DATA,
+	OMAP_MMC_REG_BLEN,
+	OMAP_MMC_REG_NBLK,
+	OMAP_MMC_REG_BUF,
+	OMAP_MMC_REG_SDIO,
+	OMAP_MMC_REG_REV,
+	OMAP_MMC_REG_RSP0,
+	OMAP_MMC_REG_RSP1,
+	OMAP_MMC_REG_RSP2,
+	OMAP_MMC_REG_RSP3,
+	OMAP_MMC_REG_RSP4,
+	OMAP_MMC_REG_RSP5,
+	OMAP_MMC_REG_RSP6,
+	OMAP_MMC_REG_RSP7,
+	OMAP_MMC_REG_IOSR,
+	OMAP_MMC_REG_SYSC,
+	OMAP_MMC_REG_SYSS,
+};
+
+/* There are two known register sizes, 2-byte and 4-byte. */
+enum {
+	OMAP_MMC_REG_SIZE_2 = 0,
+	OMAP_MMC_REG_SIZE_4,
+};
+
+#define OMAP_MMC_MAX_REG	25
+#define OMAP_MMC_MAX_REG_SIZES	2
+
+/* MMC register table for 2 or 4-byte register sizes */
+static u8 omap_mmc_reg_map[OMAP_MMC_MAX_REG_SIZES][OMAP_MMC_MAX_REG] = {
+	[OMAP_MMC_REG_SIZE_2] = {
+		[OMAP_MMC_REG_CMD]	= 0x00,
+		[OMAP_MMC_REG_ARGL]	= 0x02,
+		[OMAP_MMC_REG_ARGH]	= 0x04,
+		[OMAP_MMC_REG_CON]	= 0x06,
+		[OMAP_MMC_REG_STAT]	= 0x08,
+		[OMAP_MMC_REG_IE]	= 0x0a,
+		[OMAP_MMC_REG_CTO]	= 0x0c,
+		[OMAP_MMC_REG_DTO]	= 0x0e,
+		[OMAP_MMC_REG_DATA]	= 0x10,
+		[OMAP_MMC_REG_BLEN]	= 0x12,
+		[OMAP_MMC_REG_NBLK]	= 0x14,
+		[OMAP_MMC_REG_BUF]	= 0x16,
+		[OMAP_MMC_REG_SDIO]	= 0x1a,
+		[OMAP_MMC_REG_REV]	= 0x1e,
+		[OMAP_MMC_REG_RSP0]	= 0x20,
+		[OMAP_MMC_REG_RSP1]	= 0x22,
+		[OMAP_MMC_REG_RSP2]	= 0x24,
+		[OMAP_MMC_REG_RSP3]	= 0x26,
+		[OMAP_MMC_REG_RSP4]	= 0x28,
+		[OMAP_MMC_REG_RSP5]	= 0x2a,
+		[OMAP_MMC_REG_RSP6]	= 0x2c,
+		[OMAP_MMC_REG_RSP7]	= 0x2e,
+		[OMAP_MMC_REG_IOSR]	= 0x30,
+		[OMAP_MMC_REG_SYSC]	= 0x32,
+		[OMAP_MMC_REG_SYSS]	= 0x34,
+	},
+	[OMAP_MMC_REG_SIZE_4] = {
+		[OMAP_MMC_REG_CMD]	= 0x00,
+		[OMAP_MMC_REG_ARGL]	= 0x04,
+		[OMAP_MMC_REG_ARGH]	= 0x08,
+		[OMAP_MMC_REG_CON]	= 0x0c,
+		[OMAP_MMC_REG_STAT]	= 0x10,
+		[OMAP_MMC_REG_IE]	= 0x14,
+		[OMAP_MMC_REG_CTO]	= 0x18,
+		[OMAP_MMC_REG_DTO]	= 0x1c,
+		[OMAP_MMC_REG_DATA]	= 0x20,
+		[OMAP_MMC_REG_BLEN]	= 0x24,
+		[OMAP_MMC_REG_NBLK]	= 0x28,
+		[OMAP_MMC_REG_BUF]	= 0x2c,
+		[OMAP_MMC_REG_SDIO]	= 0x34,
+		[OMAP_MMC_REG_REV]	= 0x3c,
+		[OMAP_MMC_REG_RSP0]	= 0x40,
+		[OMAP_MMC_REG_RSP1]	= 0x44,
+		[OMAP_MMC_REG_RSP2]	= 0x48,
+		[OMAP_MMC_REG_RSP3]	= 0x4c,
+		[OMAP_MMC_REG_RSP4]	= 0x50,
+		[OMAP_MMC_REG_RSP5]	= 0x54,
+		[OMAP_MMC_REG_RSP6]	= 0x58,
+		[OMAP_MMC_REG_RSP7]	= 0x5c,
+		[OMAP_MMC_REG_IOSR]	= 0x60,
+		[OMAP_MMC_REG_SYSC]	= 0x64,
+		[OMAP_MMC_REG_SYSS]	= 0x68,
+	},
+};
+
+static inline int mmc_omap_get_register(unsigned int reg_size, unsigned int reg)
+{
+	return omap_mmc_reg_map[reg_size][reg];
+}
+
+#endif /* MMC_MMC_OMAP_H */
-- 
1.6.3.3


