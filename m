From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/2] [rfc] mmc, sh: Read MMCIF during zboot
Date: Sat, 27 Nov 2010 08:05:56 +0900
Message-ID: <1290812757-20571-2-git-send-email-horms@verge.net.au>
References: <1290812757-20571-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1290812757-20571-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This is a prototype of code to read the MMCIF during
zboot initialisation. The intention is that it will form
part of enabling booting from MMC. Very roughly the plan is

1) The Mask Rom will load a small boot program from MMC.
   Essentially this will be the first portion of
   the kernel to be booted.
2) That program will load the remainder of the kernel
   from MMC and boot from it.

This patch demonstrates code to perform the read portion of 2).
It uses a dummy buffer and only reads in one 512 byte sector.
A full implementation of 2) would of course read much more.

The patch currently hooks into head-shmobile.S as it
depends on initialisation that occurs in that file.
However, it is likely that the final implementation
will need to be located in head.S where relocation is
currently handled.

I used a multi-voltage MMC mobile card to test this code.
I observed that a single-voltage MMC and MMCplus card caused
the code to time-out in sh_mmcif_boot_init() which causes
the boot to stop.

This patch depends on "ARM: mach-shmobile: Add zboot support for SuperH
Mobile ARM" and "mmc, sh: Correct value for reset".

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/compressed/Makefile        |    4 +
 arch/arm/boot/compressed/head-shmobile.S |   16 +++++
 arch/arm/boot/compressed/mmcif-sh7372.c  |  100 ++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/compressed/mmcif-sh7372.c

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 0a8f748..f730c10 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -49,6 +49,10 @@ ifeq ($(CONFIG_ARCH_SHMOBILE),y)
 OBJS		+= head-shmobile.o
 endif
 
+ifeq ($(CONFIG_ARCH_SH7372),y)
+OBJS		+= mmcif-sh7372.o
+endif
+
 #
 # We now have a PIC decompressor implementation.  Decompressors running
 # from RAM should not define ZTEXTADDR.  Decompressors running directly
diff --git a/arch/arm/boot/compressed/head-shmobile.S b/arch/arm/boot/compressed/head-shmobile.S
index 30973b7..700d622 100644
--- a/arch/arm/boot/compressed/head-shmobile.S
+++ b/arch/arm/boot/compressed/head-shmobile.S
@@ -26,6 +26,22 @@
 #include <mach/zboot.h>
 
 	b	1f
+	.align
+__tmp_stack:
+	.space	128
+__dummy_buf:
+	.space	512
+__dummy_buf_size:
+	.long	512
+1:
+	adr	sp, __tmp_stack
+	add	sp, sp, #128
+	adr	r0, __dummy_buf
+	ldr	r1, __dummy_buf_size
+	mov	lr, pc
+	b	mmcif_loader
+
+	b	1f
 __atags:@ tag #1
 	.long	12			@ tag->hdr.size = tag_size(tag_core);
 	.long	0x54410001		@ tag->hdr.tag = ATAG_CORE;
diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boot/compressed/mmcif-sh7372.c
new file mode 100644
index 0000000..7ffaf27
--- /dev/null
+++ b/arch/arm/boot/compressed/mmcif-sh7372.c
@@ -0,0 +1,100 @@
+/*
+ * sh7372 MMCIF loader
+ *
+ * Copyright (C) 2010 Magnus Damm
+ * Copyright (C) 2010 Simon Horman
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/mmc/sh_mmcif.h>
+
+#define MMCIF_BASE      (void __iomem *)0xe6bd0000
+
+#define PORT84CR	0xe6050054
+#define PORT85CR	0xe6050055
+#define PORT86CR	0xe6050056
+#define PORT87CR	0xe6050057
+#define PORT88CR	0xe6050058
+#define PORT89CR	0xe6050059
+#define PORT90CR	0xe605005a
+#define PORT91CR	0xe605005b
+#define PORT92CR	0xe605005c
+#define PORT99CR	0xe6050063
+#define PORT185CR	0xe60520b9
+#define PORT186CR	0xe60520ba
+#define PORT187CR	0xe60520bb
+#define PORT188CR	0xe60520bc
+#define PORTR191_160DR  0xe6056014
+
+#define SMSTPCR3	0xe615013c
+
+enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
+       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
+
+static void mmcif_update_progress(int n)
+{
+	__raw_writel((__raw_readl(PORTR191_160DR) & ~(0xf << 25)) |
+		     (1 << (25 + n)), PORTR191_160DR);
+}
+
+/* SH7372 specific MMCIF loader
+ *
+ * loads the romImage from an MMC card starting from block 512
+ * use the following line to write the romImage to an MMC card
+ * # dd if=arch/sh/boot/romImage of=/dev/sdx bs=512 seek=512
+ */
+asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
+{
+	/* Initialise LEDS1-4
+	 * registers: PORT185CR-PORT188CR (LED1-LED4 Control)
+	 * value:     0x10 - enable output
+	 */
+	__raw_writeb(0x10, PORT185CR);
+	__raw_writeb(0x10, PORT186CR);
+	__raw_writeb(0x10, PORT187CR);
+	__raw_writeb(0x10, PORT188CR);
+
+	mmcif_update_progress(MMCIF_PROGRESS_ENTER);
+
+	/* Initialise MMC
+	 * registers: PORT84CR-PORT92CR
+	 *            (MMCD0_0-MMCD0_7,MMCCMD0 Control)
+	 * value: 0x04 - select function 4
+	 */
+	 __raw_writeb(0x04, PORT84CR);
+	 __raw_writeb(0x04, PORT85CR);
+	 __raw_writeb(0x04, PORT86CR);
+	 __raw_writeb(0x04, PORT87CR);
+	 __raw_writeb(0x04, PORT88CR);
+	 __raw_writeb(0x04, PORT89CR);
+	 __raw_writeb(0x04, PORT90CR);
+	 __raw_writeb(0x04, PORT91CR);
+	 __raw_writeb(0x04, PORT92CR);
+
+	/* Initialise MMC
+	 * registers: PORT99CR (MMCCLK0 Control)
+	 * value: 0x10 | 0x04 - enable output | select function 4
+	 */
+	__raw_writeb(0x14, PORT99CR);
+
+	/* Enable clock to MMC hardware block */
+	__raw_writel(__raw_readl(SMSTPCR3) & ~(1 << 12), SMSTPCR3);
+
+	mmcif_update_progress(MMCIF_PROGRESS_INIT);
+
+	/* setup MMCIF hardware */
+	sh_mmcif_boot_init(MMCIF_BASE);
+
+	mmcif_update_progress(MMCIF_PROGRESS_LOAD);
+
+	/* load kernel via MMCIF interface */
+	sh_mmcif_boot_slurp(MMCIF_BASE, buf, no_bytes);
+
+	/* Disable clock to MMC hardware block */
+	__raw_writel(__raw_readl(SMSTPCR3) & (1 << 12), SMSTPCR3);
+
+	mmcif_update_progress(MMCIF_PROGRESS_DONE);
+}
-- 
1.7.2.3

