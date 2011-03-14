From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/4] mmc: Add MMC_PROGRESS_*
Date: Mon, 14 Mar 2011 11:57:14 +0900
Message-ID: <1300071435-26759-4-git-send-email-horms@verge.net.au>
References: <1300071435-26759-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40265 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab1CNC51 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 22:57:27 -0400
In-Reply-To: <1300071435-26759-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

This is my second attempt to make this enum generally available.
The first attempt added MMCIF_PROGRESS_* to include/linux/mmc/sh_mmcif.h.
However this is not sufficiently generic as the enum will be
used by SDHI boot code.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/compressed/mmcif-sh7372.c |    8 ++++----
 arch/sh/boot/romimage/mmcif-sh7724.c    |    8 ++++----
 include/linux/mmc/boot.h                |    7 +++++++
 include/linux/mmc/sh_mmcif.h            |    3 ---
 4 files changed, 15 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/mmc/boot.h

diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boot/compressed/mmcif-sh7372.c
index 28bcf3c..86b26a1 100644
--- a/arch/arm/boot/compressed/mmcif-sh7372.c
+++ b/arch/arm/boot/compressed/mmcif-sh7372.c
@@ -42,7 +42,7 @@
 asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
 {
 	mmc_init_progress();
-	mmc_update_progress(MMCIF_PROGRESS_ENTER);
+	mmc_update_progress(MMC_PROGRESS_ENTER);
 
 	/* Initialise MMC
 	 * registers: PORT84CR-PORT92CR
@@ -68,12 +68,12 @@ asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
 	/* Enable clock to MMC hardware block */
 	__raw_writel(__raw_readl(SMSTPCR3) & ~(1 << 12), SMSTPCR3);
 
-	mmc_update_progress(MMCIF_PROGRESS_INIT);
+	mmc_update_progress(MMC_PROGRESS_INIT);
 
 	/* setup MMCIF hardware */
 	sh_mmcif_boot_init(MMCIF_BASE);
 
-	mmc_update_progress(MMCIF_PROGRESS_LOAD);
+	mmc_update_progress(MMC_PROGRESS_LOAD);
 
 	/* load kernel via MMCIF interface */
 	sh_mmcif_boot_do_read(MMCIF_BASE, 2, /* Kernel is at block 2 */
@@ -83,5 +83,5 @@ asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
 	/* Disable clock to MMC hardware block */
 	__raw_writel(__raw_readl(SMSTPCR3) & (1 << 12), SMSTPCR3);
 
-	mmc_update_progress(MMCIF_PROGRESS_DONE);
+	mmc_update_progress(MMC_PROGRESS_DONE);
 }
diff --git a/arch/sh/boot/romimage/mmcif-sh7724.c b/arch/sh/boot/romimage/mmcif-sh7724.c
index c84e783..1d13335 100644
--- a/arch/sh/boot/romimage/mmcif-sh7724.c
+++ b/arch/sh/boot/romimage/mmcif-sh7724.c
@@ -29,7 +29,7 @@
  */
 asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
 {
-	mmcif_update_progress(MMCIF_PROGRESS_ENTER);
+	mmcif_update_progress(MMC_PROGRESS_ENTER);
 
 	/* enable clock to the MMCIF hardware block */
 	__raw_writel(__raw_readl(MSTPCR2) & ~0x20000000, MSTPCR2);
@@ -52,12 +52,12 @@ asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
 	/* high drive capability for MMC pins */
 	__raw_writew(__raw_readw(DRVCRA) | 0x3000, DRVCRA);
 
-	mmcif_update_progress(MMCIF_PROGRESS_INIT);
+	mmcif_update_progress(MMC_PROGRESS_INIT);
 
 	/* setup MMCIF hardware */
 	sh_mmcif_boot_init(MMCIF_BASE);
 
-	mmcif_update_progress(MMCIF_PROGRESS_LOAD);
+	mmcif_update_progress(MMC_PROGRESS_LOAD);
 
 	/* load kernel via MMCIF interface */
 	sh_mmcif_boot_do_read(MMCIF_BASE, 512,
@@ -67,5 +67,5 @@ asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
 	/* disable clock to the MMCIF hardware block */
 	__raw_writel(__raw_readl(MSTPCR2) | 0x20000000, MSTPCR2);
 
-	mmcif_update_progress(MMCIF_PROGRESS_DONE);
+	mmcif_update_progress(MMC_PROGRESS_DONE);
 }
diff --git a/include/linux/mmc/boot.h b/include/linux/mmc/boot.h
new file mode 100644
index 0000000..39d787c
--- /dev/null
+++ b/include/linux/mmc/boot.h
@@ -0,0 +1,7 @@
+#ifndef MMC_BOOT_H
+#define MMC_BOOT_H
+
+enum { MMC_PROGRESS_ENTER, MMC_PROGRESS_INIT,
+       MMC_PROGRESS_LOAD, MMC_PROGRESS_DONE };
+
+#endif
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index 38d3930..9eb9b4b 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -104,9 +104,6 @@ static inline void sh_mmcif_writel(void __iomem *addr, int reg, u32 val)
 
 #define SH_MMCIF_BBS 512 /* boot block size */
 
-enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
-       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
-
 static inline void sh_mmcif_boot_cmd_send(void __iomem *base,
 					  unsigned long cmd, unsigned long arg)
 {
-- 
1.7.2.3

