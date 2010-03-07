From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Sun,  7 Mar 2010 09:47:58 -0800
Message-ID: <1267984078-6036-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59791 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab0CGRsS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Mar 2010 12:48:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Marek Belisko <marek.belisko@open-nandra.com>, Cory Maccarrone <darkstar6262@gmail.com>

From: Marek Belisko <marek.belisko@open-nandra.com>

The omap850 and omap730 use 16-bit registers instead of 32-bit, requiring
a modification of the register addresses in the mmc-omap driver.  To resolve
this, a bit shift is performed on base register addresses, either by 1 or 2
bits depending on the CPU in use.  This yields the correct registers for
each CPU.

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap.c |   62 +++++++++++++++++++++++++----------------------
 1 files changed, 33 insertions(+), 29 deletions(-)

This is a resubmit of a patch I sent in several months ago.  Tony Lindgren merged
this into linux-omap's master and testing branches but has stated that he will not
merge it further as linux-mmc needs to approve this.  There hasn't been any comments
raised on either of the linux-omap or linux-mmc mailing lists about problems.  Due to
the unique nature of the omap7xx platform, this patch is required for MMC card access.
Is there any chance this can be included into the next -rc cycle, as it is a fix for
devices that have 16-bit registers?

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index c6d7e8e..53362c4 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -38,30 +38,30 @@
 #include <plat/fpga.h>
 
 #define	OMAP_MMC_REG_CMD	0x00
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
+#define	OMAP_MMC_REG_ARGL	0x01
+#define	OMAP_MMC_REG_ARGH	0x02
+#define	OMAP_MMC_REG_CON	0x03
+#define	OMAP_MMC_REG_STAT	0x04
+#define	OMAP_MMC_REG_IE		0x05
+#define	OMAP_MMC_REG_CTO	0x06
+#define	OMAP_MMC_REG_DTO	0x07
+#define	OMAP_MMC_REG_DATA	0x08
+#define	OMAP_MMC_REG_BLEN	0x09
+#define	OMAP_MMC_REG_NBLK	0x0a
+#define	OMAP_MMC_REG_BUF	0x0b
+#define	OMAP_MMC_REG_SDIO	0x0d
+#define	OMAP_MMC_REG_REV	0x0f
+#define	OMAP_MMC_REG_RSP0	0x10
+#define	OMAP_MMC_REG_RSP1	0x11
+#define	OMAP_MMC_REG_RSP2	0x12
+#define	OMAP_MMC_REG_RSP3	0x13
+#define	OMAP_MMC_REG_RSP4	0x14
+#define	OMAP_MMC_REG_RSP5	0x15
+#define	OMAP_MMC_REG_RSP6	0x16
+#define	OMAP_MMC_REG_RSP7	0x17
+#define	OMAP_MMC_REG_IOSR	0x18
+#define	OMAP_MMC_REG_SYSC	0x19
+#define	OMAP_MMC_REG_SYSS	0x1a
 
 #define	OMAP_MMC_STAT_CARD_ERR		(1 << 14)
 #define	OMAP_MMC_STAT_CARD_IRQ		(1 << 13)
@@ -77,8 +77,9 @@
 #define	OMAP_MMC_STAT_CARD_BUSY		(1 <<  2)
 #define	OMAP_MMC_STAT_END_OF_CMD	(1 <<  0)
 
-#define OMAP_MMC_READ(host, reg)	__raw_readw((host)->virt_base + OMAP_MMC_REG_##reg)
-#define OMAP_MMC_WRITE(host, reg, val)	__raw_writew((val), (host)->virt_base + OMAP_MMC_REG_##reg)
+#define OMAP_MMC_REG(host, reg)		(OMAP_MMC_REG_##reg << (host)->reg_shift)
+#define OMAP_MMC_READ(host, reg)	__raw_readw((host)->virt_base + OMAP_MMC_REG(host, reg))
+#define OMAP_MMC_WRITE(host, reg, val)	__raw_writew((val), (host)->virt_base + OMAP_MMC_REG(host, reg))
 
 /*
  * Command types
@@ -132,6 +133,7 @@ struct mmc_omap_host {
 	int			irq;
 	unsigned char		bus_mode;
 	unsigned char		hw_bus_mode;
+	unsigned int		reg_shift;
 
 	struct work_struct	cmd_abort_work;
 	unsigned		abort:1;
@@ -679,9 +681,9 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	host->data->bytes_xfered += n;
 
 	if (write) {
-		__raw_writesw(host->virt_base + OMAP_MMC_REG_DATA, host->buffer, n);
+		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffer, n);
 	} else {
-		__raw_readsw(host->virt_base + OMAP_MMC_REG_DATA, host->buffer, n);
+		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA), host->buffer, n);
 	}
 }
 
@@ -899,7 +901,7 @@ mmc_omap_prepare_dma(struct mmc_omap_host *host, struct mmc_data *data)
 	int dst_port = 0;
 	int sync_dev = 0;
 
-	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
+	data_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
 	frame = data->blksz;
 	count = sg_dma_len(sg);
 
@@ -1492,6 +1494,8 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		}
 	}
 
+	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
+
 	return 0;
 
 err_plat_cleanup:
-- 
1.6.3.3

