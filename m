From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH] mmc: s3cmci: moved mach/regs-sdi.h into s3cmci device driver
Date: Fri, 01 Feb 2013 16:45:17 -0800
Message-ID: <1359765917-11219-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Since mach/regs-sdi.h is used only for s3cmci.c, so this moves the
header file into the driver file, drivers/mmc/host/s3cmci.c file.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/dma-s3c2410.c           |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c           |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c           |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c           |    1 -
 arch/arm/mach-s3c24xx/include/mach/regs-sdi.h |  127 -------------------------
 drivers/mmc/host/s3cmci.c                     |   83 +++++++++++++++-
 6 files changed, 81 insertions(+), 133 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-sdi.h

diff --git a/arch/arm/mach-s3c24xx/dma-s3c2410.c b/arch/arm/mach-s3c24xx/dma-s3c2410.c
index 4803338..6eb5be9 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2410.c
@@ -29,7 +29,6 @@
 #include <plat/regs-dma.h>
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
-#include <mach/regs-sdi.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2412.c b/arch/arm/mach-s3c24xx/dma-s3c2412.c
index 38472ac..f239d09 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2412.c
@@ -29,7 +29,6 @@
 #include <plat/regs-dma.h>
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
-#include <mach/regs-sdi.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2440.c b/arch/arm/mach-s3c24xx/dma-s3c2440.c
index 5f0a0c8..ca98189 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2440.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2440.c
@@ -29,7 +29,6 @@
 #include <plat/regs-dma.h>
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
-#include <mach/regs-sdi.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2443.c b/arch/arm/mach-s3c24xx/dma-s3c2443.c
index 2d94228..d3448f6 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2443.c
@@ -29,7 +29,6 @@
 #include <plat/regs-dma.h>
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
-#include <mach/regs-sdi.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-sdi.h b/arch/arm/mach-s3c24xx/include/mach/regs-sdi.h
deleted file mode 100644
index cbf2d88..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/regs-sdi.h
+++ /dev/null
@@ -1,127 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-sdi.h
- *
- * Copyright (c) 2004 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 MMC/SDIO register definitions
-*/
-
-#ifndef __ASM_ARM_REGS_SDI
-#define __ASM_ARM_REGS_SDI "regs-sdi.h"
-
-#define S3C2410_SDICON                (0x00)
-#define S3C2410_SDIPRE                (0x04)
-#define S3C2410_SDICMDARG             (0x08)
-#define S3C2410_SDICMDCON             (0x0C)
-#define S3C2410_SDICMDSTAT            (0x10)
-#define S3C2410_SDIRSP0               (0x14)
-#define S3C2410_SDIRSP1               (0x18)
-#define S3C2410_SDIRSP2               (0x1C)
-#define S3C2410_SDIRSP3               (0x20)
-#define S3C2410_SDITIMER              (0x24)
-#define S3C2410_SDIBSIZE              (0x28)
-#define S3C2410_SDIDCON               (0x2C)
-#define S3C2410_SDIDCNT               (0x30)
-#define S3C2410_SDIDSTA               (0x34)
-#define S3C2410_SDIFSTA               (0x38)
-
-#define S3C2410_SDIDATA               (0x3C)
-#define S3C2410_SDIIMSK               (0x40)
-
-#define S3C2440_SDIDATA               (0x40)
-#define S3C2440_SDIIMSK               (0x3C)
-
-#define S3C2440_SDICON_SDRESET        (1<<8)
-#define S3C2440_SDICON_MMCCLOCK       (1<<5)
-#define S3C2410_SDICON_BYTEORDER      (1<<4)
-#define S3C2410_SDICON_SDIOIRQ        (1<<3)
-#define S3C2410_SDICON_RWAITEN        (1<<2)
-#define S3C2410_SDICON_FIFORESET      (1<<1)
-#define S3C2410_SDICON_CLOCKTYPE      (1<<0)
-
-#define S3C2410_SDICMDCON_ABORT       (1<<12)
-#define S3C2410_SDICMDCON_WITHDATA    (1<<11)
-#define S3C2410_SDICMDCON_LONGRSP     (1<<10)
-#define S3C2410_SDICMDCON_WAITRSP     (1<<9)
-#define S3C2410_SDICMDCON_CMDSTART    (1<<8)
-#define S3C2410_SDICMDCON_SENDERHOST  (1<<6)
-#define S3C2410_SDICMDCON_INDEX       (0x3f)
-
-#define S3C2410_SDICMDSTAT_CRCFAIL    (1<<12)
-#define S3C2410_SDICMDSTAT_CMDSENT    (1<<11)
-#define S3C2410_SDICMDSTAT_CMDTIMEOUT (1<<10)
-#define S3C2410_SDICMDSTAT_RSPFIN     (1<<9)
-#define S3C2410_SDICMDSTAT_XFERING    (1<<8)
-#define S3C2410_SDICMDSTAT_INDEX      (0xff)
-
-#define S3C2440_SDIDCON_DS_BYTE       (0<<22)
-#define S3C2440_SDIDCON_DS_HALFWORD   (1<<22)
-#define S3C2440_SDIDCON_DS_WORD       (2<<22)
-#define S3C2410_SDIDCON_IRQPERIOD     (1<<21)
-#define S3C2410_SDIDCON_TXAFTERRESP   (1<<20)
-#define S3C2410_SDIDCON_RXAFTERCMD    (1<<19)
-#define S3C2410_SDIDCON_BUSYAFTERCMD  (1<<18)
-#define S3C2410_SDIDCON_BLOCKMODE     (1<<17)
-#define S3C2410_SDIDCON_WIDEBUS       (1<<16)
-#define S3C2410_SDIDCON_DMAEN         (1<<15)
-#define S3C2410_SDIDCON_STOP          (1<<14)
-#define S3C2440_SDIDCON_DATSTART      (1<<14)
-#define S3C2410_SDIDCON_DATMODE	      (3<<12)
-#define S3C2410_SDIDCON_BLKNUM        (0x7ff)
-
-/* constants for S3C2410_SDIDCON_DATMODE */
-#define S3C2410_SDIDCON_XFER_READY    (0<<12)
-#define S3C2410_SDIDCON_XFER_CHKSTART (1<<12)
-#define S3C2410_SDIDCON_XFER_RXSTART  (2<<12)
-#define S3C2410_SDIDCON_XFER_TXSTART  (3<<12)
-
-#define S3C2410_SDIDCON_BLKNUM_MASK   (0xFFF)
-#define S3C2410_SDIDCNT_BLKNUM_SHIFT  (12)
-
-#define S3C2410_SDIDSTA_RDYWAITREQ    (1<<10)
-#define S3C2410_SDIDSTA_SDIOIRQDETECT (1<<9)
-#define S3C2410_SDIDSTA_FIFOFAIL      (1<<8)	/* reserved on 2440 */
-#define S3C2410_SDIDSTA_CRCFAIL       (1<<7)
-#define S3C2410_SDIDSTA_RXCRCFAIL     (1<<6)
-#define S3C2410_SDIDSTA_DATATIMEOUT   (1<<5)
-#define S3C2410_SDIDSTA_XFERFINISH    (1<<4)
-#define S3C2410_SDIDSTA_BUSYFINISH    (1<<3)
-#define S3C2410_SDIDSTA_SBITERR       (1<<2)	/* reserved on 2410a/2440 */
-#define S3C2410_SDIDSTA_TXDATAON      (1<<1)
-#define S3C2410_SDIDSTA_RXDATAON      (1<<0)
-
-#define S3C2440_SDIFSTA_FIFORESET      (1<<16)
-#define S3C2440_SDIFSTA_FIFOFAIL       (3<<14)  /* 3 is correct (2 bits) */
-#define S3C2410_SDIFSTA_TFDET          (1<<13)
-#define S3C2410_SDIFSTA_RFDET          (1<<12)
-#define S3C2410_SDIFSTA_TFHALF         (1<<11)
-#define S3C2410_SDIFSTA_TFEMPTY        (1<<10)
-#define S3C2410_SDIFSTA_RFLAST         (1<<9)
-#define S3C2410_SDIFSTA_RFFULL         (1<<8)
-#define S3C2410_SDIFSTA_RFHALF         (1<<7)
-#define S3C2410_SDIFSTA_COUNTMASK      (0x7f)
-
-#define S3C2410_SDIIMSK_RESPONSECRC    (1<<17)
-#define S3C2410_SDIIMSK_CMDSENT        (1<<16)
-#define S3C2410_SDIIMSK_CMDTIMEOUT     (1<<15)
-#define S3C2410_SDIIMSK_RESPONSEND     (1<<14)
-#define S3C2410_SDIIMSK_READWAIT       (1<<13)
-#define S3C2410_SDIIMSK_SDIOIRQ        (1<<12)
-#define S3C2410_SDIIMSK_FIFOFAIL       (1<<11)
-#define S3C2410_SDIIMSK_CRCSTATUS      (1<<10)
-#define S3C2410_SDIIMSK_DATACRC        (1<<9)
-#define S3C2410_SDIIMSK_DATATIMEOUT    (1<<8)
-#define S3C2410_SDIIMSK_DATAFINISH     (1<<7)
-#define S3C2410_SDIIMSK_BUSYFINISH     (1<<6)
-#define S3C2410_SDIIMSK_SBITERR        (1<<5)	/* reserved 2440/2410a */
-#define S3C2410_SDIIMSK_TXFIFOHALF     (1<<4)
-#define S3C2410_SDIIMSK_TXFIFOEMPTY    (1<<3)
-#define S3C2410_SDIIMSK_RXFIFOLAST     (1<<2)
-#define S3C2410_SDIIMSK_RXFIFOFULL     (1<<1)
-#define S3C2410_SDIIMSK_RXFIFOHALF     (1<<0)
-
-#endif /* __ASM_ARM_REGS_SDI */
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 63fb265..8d6794c 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -25,14 +25,93 @@
 
 #include <mach/dma.h>
 
-#include <mach/regs-sdi.h>
-
 #include <linux/platform_data/mmc-s3cmci.h>
 
 #include "s3cmci.h"
 
 #define DRIVER_NAME "s3c-mci"
 
+#define S3C2410_SDICON			(0x00)
+#define S3C2410_SDIPRE			(0x04)
+#define S3C2410_SDICMDARG		(0x08)
+#define S3C2410_SDICMDCON		(0x0C)
+#define S3C2410_SDICMDSTAT		(0x10)
+#define S3C2410_SDIRSP0			(0x14)
+#define S3C2410_SDIRSP1			(0x18)
+#define S3C2410_SDIRSP2			(0x1C)
+#define S3C2410_SDIRSP3			(0x20)
+#define S3C2410_SDITIMER		(0x24)
+#define S3C2410_SDIBSIZE		(0x28)
+#define S3C2410_SDIDCON			(0x2C)
+#define S3C2410_SDIDCNT			(0x30)
+#define S3C2410_SDIDSTA			(0x34)
+#define S3C2410_SDIFSTA			(0x38)
+
+#define S3C2410_SDIDATA			(0x3C)
+#define S3C2410_SDIIMSK			(0x40)
+
+#define S3C2440_SDIDATA			(0x40)
+#define S3C2440_SDIIMSK			(0x3C)
+
+#define S3C2440_SDICON_SDRESET		(1 << 8)
+#define S3C2410_SDICON_SDIOIRQ		(1 << 3)
+#define S3C2410_SDICON_FIFORESET	(1 << 1)
+#define S3C2410_SDICON_CLOCKTYPE	(1 << 0)
+
+#define S3C2410_SDICMDCON_LONGRSP	(1 << 10)
+#define S3C2410_SDICMDCON_WAITRSP	(1 << 9)
+#define S3C2410_SDICMDCON_CMDSTART	(1 << 8)
+#define S3C2410_SDICMDCON_SENDERHOST	(1 << 6)
+#define S3C2410_SDICMDCON_INDEX		(0x3f)
+
+#define S3C2410_SDICMDSTAT_CRCFAIL	(1 << 12)
+#define S3C2410_SDICMDSTAT_CMDSENT	(1 << 11)
+#define S3C2410_SDICMDSTAT_CMDTIMEOUT	(1 << 10)
+#define S3C2410_SDICMDSTAT_RSPFIN	(1 << 9)
+
+#define S3C2440_SDIDCON_DS_WORD		(2 << 22)
+#define S3C2410_SDIDCON_TXAFTERRESP	(1 << 20)
+#define S3C2410_SDIDCON_RXAFTERCMD	(1 << 19)
+#define S3C2410_SDIDCON_BLOCKMODE	(1 << 17)
+#define S3C2410_SDIDCON_WIDEBUS		(1 << 16)
+#define S3C2410_SDIDCON_DMAEN		(1 << 15)
+#define S3C2410_SDIDCON_STOP		(1 << 14)
+#define S3C2440_SDIDCON_DATSTART	(1 << 14)
+
+#define S3C2410_SDIDCON_XFER_RXSTART	(2 << 12)
+#define S3C2410_SDIDCON_XFER_TXSTART	(3 << 12)
+
+#define S3C2410_SDIDCON_BLKNUM_MASK	(0xFFF)
+
+#define S3C2410_SDIDSTA_SDIOIRQDETECT	(1 << 9)
+#define S3C2410_SDIDSTA_FIFOFAIL	(1 << 8)
+#define S3C2410_SDIDSTA_CRCFAIL		(1 << 7)
+#define S3C2410_SDIDSTA_RXCRCFAIL	(1 << 6)
+#define S3C2410_SDIDSTA_DATATIMEOUT	(1 << 5)
+#define S3C2410_SDIDSTA_XFERFINISH	(1 << 4)
+#define S3C2410_SDIDSTA_TXDATAON	(1 << 1)
+#define S3C2410_SDIDSTA_RXDATAON	(1 << 0)
+
+#define S3C2440_SDIFSTA_FIFORESET	(1 << 16)
+#define S3C2440_SDIFSTA_FIFOFAIL	(3 << 14)
+#define S3C2410_SDIFSTA_TFDET		(1 << 13)
+#define S3C2410_SDIFSTA_RFDET		(1 << 12)
+#define S3C2410_SDIFSTA_COUNTMASK	(0x7f)
+
+#define S3C2410_SDIIMSK_RESPONSECRC	(1 << 17)
+#define S3C2410_SDIIMSK_CMDSENT		(1 << 16)
+#define S3C2410_SDIIMSK_CMDTIMEOUT	(1 << 15)
+#define S3C2410_SDIIMSK_RESPONSEND	(1 << 14)
+#define S3C2410_SDIIMSK_SDIOIRQ		(1 << 12)
+#define S3C2410_SDIIMSK_FIFOFAIL	(1 << 11)
+#define S3C2410_SDIIMSK_CRCSTATUS	(1 << 10)
+#define S3C2410_SDIIMSK_DATACRC		(1 << 9)
+#define S3C2410_SDIIMSK_DATATIMEOUT	(1 << 8)
+#define S3C2410_SDIIMSK_DATAFINISH	(1 << 7)
+#define S3C2410_SDIIMSK_TXFIFOHALF	(1 << 4)
+#define S3C2410_SDIIMSK_RXFIFOLAST	(1 << 2)
+#define S3C2410_SDIIMSK_RXFIFOHALF	(1 << 0)
+
 enum dbg_channels {
 	dbg_err   = (1 << 0),
 	dbg_debug = (1 << 1),
-- 
1.7.10.4
