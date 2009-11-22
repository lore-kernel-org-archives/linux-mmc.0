From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH v2] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Sun, 22 Nov 2009 11:34:44 -0800
Message-ID: <1258918484.31123.7.camel@runt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:37369 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZKVTej (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Nov 2009 14:34:39 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

The omap850 and omap730 use 16-bit registers instead of 32-bit, requiri=
ng
a modification of the register addresses in the mmc-omap driver.

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 drivers/mmc/host/omap.c |   56 ++++++++++++++++++++++++---------------=
-------
 1 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5f970e2..892400b 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -2,7 +2,7 @@
  *  linux/drivers/mmc/host/omap.c
  *
  *  Copyright (C) 2004 Nokia Corporation
- *  Written by Tuukka Tikkanen and Juha Yrj=C3=B6l=C3=A4<juha.yrjola@n=
okia.com>
+ *  Written by Tuukka Tikkanen and Juha Yrj=C3=AF=C2=BF=C5=93l=C3=AF=C2=
=BF=C5=93<juha.yrjola@nokia.com>
  *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
  *  Other hacks (DMA, SD, etc) by David Brownell
  *
@@ -37,31 +37,33 @@
 #include <plat/mux.h>
 #include <plat/fpga.h>
=20
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
+#define	OMAP_MMC_REGISTER_SIZE		(cpu_is_omap7xx() ? 2 : 4)
+
+#define	OMAP_MMC_REG_CMD		(0x00*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_ARGL		(0x01*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_ARGH		(0x02*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_CON		(0x03*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_STAT		(0x04*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_IE			(0x05*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_CTO		(0x06*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_DTO		(0x07*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_DATA		(0x08*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_BLEN		(0x09*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_NBLK		(0x0a*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_BUF		(0x0b*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_SDIO		(0x0d*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_REV		(0x0f*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_RSP0		(0x10*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_RSP1		(0x11*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_RSP2		(0x12*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_RSP3		(0x13*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_RSP4		(0x14*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_RSP5		(0x15*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_RSP6		(0x16*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_RSP7		(0x17*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_IOSR		(0x18*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_SYSC		(0x19*OMAP_MMC_REGISTER_SIZE)
+#define	OMAP_MMC_REG_SYSS		(0x1a*OMAP_MMC_REGISTER_SIZE)
=20
 #define	OMAP_MMC_STAT_CARD_ERR		(1 << 14)
 #define	OMAP_MMC_STAT_CARD_IRQ		(1 << 13)
@@ -1619,4 +1621,4 @@ module_exit(mmc_omap_exit);
 MODULE_DESCRIPTION("OMAP Multimedia Card driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
-MODULE_AUTHOR("Juha Yrj=C3=B6l=C3=A4");
+MODULE_AUTHOR("Juha Yrj=C3=AF=C2=BF=C5=93l=C3=AF=C2=BF=C5=93");
--=20
1.6.3.3


