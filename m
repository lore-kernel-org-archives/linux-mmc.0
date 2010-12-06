From: Simon Horman <horms@verge.net.au>
Subject: [patch 2/3] mmc, sh: Remove sh_mmcif_boot_slurp()
Date: Mon, 06 Dec 2010 09:12:45 +0900
Message-ID: <20101206001310.744889412@vergenet.net>
References: <20101206001243.949375995@vergenet.net>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline; filename=no-slurp.patch
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

As the only caller of sh_mmcif_boot_do_read() is
sh_mmcif_boot_slurp() the configuration portion of
sh_mmcif_boot_slurp() can be merged into sh_mmcif_boot_do_read().

Once this is done sh_mmcif_boot_slurp() is only a call
to sh_mmcif_boot_do_read() with platform specific information -
the offset that images are stored on MMC. So make the
sh_mmcif_boot_do_read() call directly from platform code
and remove sh_mmcif_boot_slurp() altogether.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

This patch applies on top of
"sh, mmc: Use defines when setting CE_CLK_CTR"
which has been merged into the common/mmcif
branch of Paul Mundt's sh-2.6 tree.
Index: linux-2.6-ap4/arch/sh/boot/romimage/mmcif-sh7724.c
===================================================================
--- linux-2.6-ap4.orig/arch/sh/boot/romimage/mmcif-sh7724.c	2010-12-06 09:08:13.000000000 +0900
+++ linux-2.6-ap4/arch/sh/boot/romimage/mmcif-sh7724.c	2010-12-06 09:08:14.000000000 +0900
@@ -60,7 +60,9 @@ asmlinkage void mmcif_loader(unsigned ch
 	mmcif_update_progress(MMCIF_PROGRESS_LOAD);
 
 	/* load kernel via MMCIF interface */
-	sh_mmcif_boot_slurp(MMCIF_BASE, buf, no_bytes);
+	sh_mmcif_boot_do_read(MMCIF_BASE, 512,
+	                      (no_bytes + SH_MMCIF_BBS - 1) / SH_MMCIF_BBS,
+			      buf);
 
 	/* disable clock to the MMCIF hardware block */
 	__raw_writel(__raw_readl(MSTPCR2) | 0x20000000, MSTPCR2);
Index: linux-2.6-ap4/include/linux/mmc/sh_mmcif.h
===================================================================
--- linux-2.6-ap4.orig/include/linux/mmc/sh_mmcif.h	2010-12-06 09:08:13.000000000 +0900
+++ linux-2.6-ap4/include/linux/mmc/sh_mmcif.h	2010-12-06 09:08:14.000000000 +0900
@@ -162,6 +162,17 @@ static inline int sh_mmcif_boot_do_read(
 	unsigned long k;
 	int ret = 0;
 
+	/* In data transfer mode: Set clock to Bus clock/4 (about 20Mhz) */
+	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL,
+			CLK_ENABLE | CLKDIV_4 | SRSPTO_256 |
+			SRBSYTO_29 | SRWDTO_29 | SCCSTO_29);
+
+	/* CMD9 - Get CSD */
+	sh_mmcif_boot_cmd(base, 0x09806000, 0x00010000);
+
+	/* CMD7 - Select the card */
+	sh_mmcif_boot_cmd(base, 0x07400000, 0x00010000);
+
 	/* CMD16 - Set the block size */
 	sh_mmcif_boot_cmd(base, 0x10400000, SH_MMCIF_BBS);
 
@@ -205,27 +216,4 @@ static inline void sh_mmcif_boot_init(vo
 	sh_mmcif_boot_cmd(base, 0x03400040, 0x00010000);
 }
 
-static inline void sh_mmcif_boot_slurp(void __iomem *base,
-				       unsigned char *buf,
-				       unsigned long no_bytes)
-{
-	unsigned long tmp;
-
-	/* In data transfer mode: Set clock to Bus clock/4 (about 20Mhz) */
-	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL,
-			CLK_ENABLE | CLKDIV_4 | SRSPTO_256 |
-			SRBSYTO_29 | SRWDTO_29 | SCCSTO_29);
-
-	/* CMD9 - Get CSD */
-	sh_mmcif_boot_cmd(base, 0x09806000, 0x00010000);
-
-	/* CMD7 - Select the card */
-	sh_mmcif_boot_cmd(base, 0x07400000, 0x00010000);
-
-	tmp = no_bytes / SH_MMCIF_BBS;
-	tmp += (no_bytes % SH_MMCIF_BBS) ? 1 : 0;
-
-	sh_mmcif_boot_do_read(base, 512, tmp, buf);
-}
-
 #endif /* __SH_MMCIF_H__ */

