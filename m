From: Simon Horman <horms@verge.net.au>
Subject: [patch 3/3] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
Date: Mon, 06 Dec 2010 09:12:46 +0900
Message-ID: <20101206001310.825497890@vergenet.net>
References: <20101206001243.949375995@vergenet.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:59037 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab0LFAR1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Dec 2010 19:17:27 -0500
Content-Disposition: inline; filename=load-kernel-2.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

This allows a ROM-able zImage to be written to MMC and
for SuperH Mobile ARM to boot directly from the MMCIF
hardware block.

This is achieved by the MaskROM loading the first portion
of the image into MERAM and then jumping to it. This portion
contains loader code which copies the entire image to SDRAM
and jumps to it. From there the zImage boot code proceeds
as normal, uncompressing the image into its final location
and then jumping to it.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

This patch depends on "ARM: 6514/1: mach-shmobile: Add zboot support for
SuperH Mobile ARM" which has been merged into the devel branch
of Russell King's linux-2.6-arm tree.

Index: linux-2.6-ap4/arch/arm/boot/compressed/mmcif-sh7372.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ap4/arch/arm/boot/compressed/mmcif-sh7372.c	2010-12-06 09:11:42.000000000 +0900
@@ -0,0 +1,99 @@
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
+#include <mach/mmcif.h>
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
+
+#define SMSTPCR3	0xe615013c
+
+/* SH7372 specific MMCIF loader
+ *
+ * loads the zImage from an MMC card starting from block 1.
+ *
+ * The image must be start with a vrl4 header and
+ * the zImage must start at offset 512 of the image. That is,
+ * at block 2 (=byte 1024) on the media
+ *
+ * Use the following line to write the vrl4 formated zImage
+ * to an MMC card
+ * # dd if=vrl4.out of=/dev/sdx bs=512 seek=1
+ */
+asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
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
+	sh_mmcif_boot_do_read(MMCIF_BASE, 2, /* Kernel is at block 2 */
+			      (len + SH_MMCIF_BBS - 1) / SH_MMCIF_BBS, buf);
+
+
+	/* Disable clock to MMC hardware block */
+	__raw_writel(__raw_readl(SMSTPCR3) & (1 << 12), SMSTPCR3);
+
+	mmcif_update_progress(MMCIF_PROGRESS_DONE);
+}
Index: linux-2.6-ap4/arch/arm/boot/compressed/Makefile
===================================================================
--- linux-2.6-ap4.orig/arch/arm/boot/compressed/Makefile	2010-12-06 09:11:35.000000000 +0900
+++ linux-2.6-ap4/arch/arm/boot/compressed/Makefile	2010-12-06 09:11:42.000000000 +0900
@@ -49,6 +49,12 @@ ifeq ($(CONFIG_ARCH_SHMOBILE),y)
 OBJS		+= head-shmobile.o
 endif
 
+ifeq ($(CONFIG_ZBOOT_ROM_MMCIF),y)
+ifeq ($(CONFIG_ARCH_SH7372),y)
+OBJS		+= mmcif-sh7372.o
+endif
+endif
+
 #
 # We now have a PIC decompressor implementation.  Decompressors running
 # from RAM should not define ZTEXTADDR.  Decompressors running directly
Index: linux-2.6-ap4/arch/arm/boot/compressed/head-shmobile.S
===================================================================
--- linux-2.6-ap4.orig/arch/arm/boot/compressed/head-shmobile.S	2010-12-06 09:11:35.000000000 +0900
+++ linux-2.6-ap4/arch/arm/boot/compressed/head-shmobile.S	2010-12-06 09:11:42.000000000 +0900
@@ -18,14 +18,33 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifdef CONFIG_ZBOOT_ROM
+#if defined(CONFIG_ZBOOT_ROM) || defined(CONFIG_ZBOOT_ROM_MMCIF)
 
 	.section	".start", "ax"
 
 	/* load board-specific initialization code */
 #include <mach/zboot.h>
 
-	b	1f
+	/* Load image from MMC */
+	adr	sp, __tmp_stack
+	add	sp, sp, #128
+	ldr	r0, __image_start
+	ldr	r1, __image_end
+	subs	r1, r1, r0
+	ldr	r0, __load_base
+	mov	lr, pc
+	b	mmcif_loader
+
+	/* Jump to loaded code */
+	ldr	r0, __loaded
+	ldr	r1, __image_start
+	sub	r0, r0, r1
+	ldr	r1, __load_base
+	add	pc, r0, r1
+
+	.align
+__tmp_stack:
+	.space	128
 __atags:@ tag #1
 	.long	12			@ tag->hdr.size = tag_size(tag_core);
 	.long	0x54410001		@ tag->hdr.tag = ATAG_CORE;
@@ -40,14 +59,19 @@ __atags:@ tag #1
 	@ tag #3
 	.long	0			@ tag->hdr.size = 0
 	.long	0			@ tag->hdr.tag = ATAG_NONE;
-1:
+__mach_type:
+	.long	MACH_TYPE
+__image_start:
+	.long	_start
+__image_end:
+	.long	_got_end
+__load_base:
+	.long	CONFIG_MEMORY_START + 0x02000000 @ Load at 32Mb into SDRAM
+__loaded:
+	.long	__loaded
 
 	/* Set board ID necessary for boot */
-	ldr	r7, 1f				@ Set machine type register
+	ldr	r7, __mach_type			@ Set machine type register
 	adr	r8, __atags			@ Set atag register
-	b	2f
 
-1 :	.long MACH_TYPE
-2 :
-
-#endif /* CONFIG_ZBOOT_ROM */
+#endif /* CONFIG_ZBOOT_ROM || CONFIG_ZBOOT_ROM_MMCIF */
Index: linux-2.6-ap4/arch/arm/Kconfig
===================================================================
--- linux-2.6-ap4.orig/arch/arm/Kconfig	2010-12-06 09:11:35.000000000 +0900
+++ linux-2.6-ap4/arch/arm/Kconfig	2010-12-06 09:11:42.000000000 +0900
@@ -1587,6 +1587,18 @@ config ZBOOT_ROM
 	  Say Y here if you intend to execute your compressed kernel image
 	  (zImage) directly from ROM or flash.  If unsure, say N.
 
+config ZBOOT_ROM_MMCIF
+	bool "Include MMCIF loader in zImage (EXPERIMENTAL)"
+	depends on ZBOOT_ROM && ARCH_SH7372 && EXPERIMENTAL
+	help
+	  Say Y here to include experimental MMCIF loading code in the
+	  ROM-able zImage. With this enabled it is possible to write the
+	  the ROM-able zImage kernel image to an MMC card and boot the
+	  kernel straight from the reset vector. At reset the processor
+	  Mask ROM will load the first part of the the ROM-able zImage
+	  which in turn loads the rest the kernel image to RAM using the
+	  MMCIF hardware block.
+
 config CMDLINE
 	string "Default kernel command string"
 	default ""
Index: linux-2.6-ap4/arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ap4/arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h	2010-12-06 09:11:42.000000000 +0900
@@ -0,0 +1,12 @@
+#ifndef MMCIF_AP4EB_H
+#define MMCIF_AP4EB_H
+
+#define PORTR191_160DR 0xe6056014
+
+static void mmcif_update_progress(int n)
+{
+	__raw_writel((__raw_readl(PORTR191_160DR) & ~(0xf << 25)) |
+		     (1 << (25 + n)), PORTR191_160DR);
+}
+
+#endif /* MMCIF_AP4EB_H */
Index: linux-2.6-ap4/arch/arm/mach-shmobile/include/mach/mmcif.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ap4/arch/arm/mach-shmobile/include/mach/mmcif.h	2010-12-06 09:11:42.000000000 +0900
@@ -0,0 +1,16 @@
+#ifndef MMCIF_H
+#define MMCIF_H
+
+/**************************************************
+ *
+ *		board specific settings
+ *
+ **************************************************/
+
+#ifdef CONFIG_MACH_AP4EVB
+#include "mach/mmcif-ap4eb.h"
+#else
+#error "unsupported board."
+#endif
+
+#endif /* MMCIF_H */
Index: linux-2.6-ap4/Documentation/arm/SH-Mobile/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ap4/Documentation/arm/SH-Mobile/Makefile	2010-12-06 09:11:42.000000000 +0900
@@ -0,0 +1,8 @@
+BIN := vrl4
+
+.PHONY: all
+all: $(BIN)
+
+.PHONY: clean
+clean:
+	rm -f *.o $(BIN)
Index: linux-2.6-ap4/Documentation/arm/SH-Mobile/vrl4.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ap4/Documentation/arm/SH-Mobile/vrl4.c	2010-12-06 09:11:42.000000000 +0900
@@ -0,0 +1,167 @@
+/*
+ * vrl4 format generator
+ *
+ * Copyright (C) 2010 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+/*
+ * usage: vrl4 < zImage > out
+ *	  dd if=out of=/dev/sdx bs=512 seek=1 # Write the image to sector 1
+ *
+ * Reads a zImage from stdin and writes a vrl4 image to stdout.
+ * In practice this means writing a padded vrl4 header to stdout followed
+ * by the zImage.
+ *
+ * The padding places the zImage at ALIGN bytes into the output.
+ * The vrl4 uses ALIGN + START_BASE as the start_address.
+ * This is where the mask ROM will jump to after verifying the header.
+ *
+ * The header sets copy_size to min(sizeof(zImage), MAX_BOOT_PROG_LEN) + ALIGN.
+ * That is, the mask ROM will load the padded header (ALIGN bytes)
+ * And then MAX_BOOT_PROG_LEN bytes of the image, or the entire image,
+ * whichever is smaller.
+ *
+ * The zImage is not modified in any way.
+ */
+
+#include <unistd.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <errno.h>
+
+struct hdr {
+	uint32_t magic1;
+	uint32_t reserved1;
+	uint32_t magic2;
+	uint32_t reserved2;
+	uint16_t copy_size;
+	uint16_t boot_options;
+	uint32_t reserved3;
+	uint32_t start_address;
+	uint32_t reserved4;
+	uint32_t reserved5;
+	char     reserved6[308];
+};
+
+#define DECLARE_HDR(h)					\
+	struct hdr (h) = {				\
+		.magic1 =	0xea000000,		\
+		.reserved1 =	0x56,			\
+		.magic2 =	0xe59ff008,		\
+		.reserved3 =	0x1 }
+
+/* Align to 512 bytes, the MMCIF sector size */
+#define ALIGN_BITS	9
+#define ALIGN		(1 << ALIGN_BITS)
+
+#define START_BASE	0xe55b0000
+
+/*
+ * With an alignment of 512 the header uses the first sector.
+ * There is a 128 sector (64kbyte) limit on the data loaded by the mask ROM.
+ * So there are 127 sectors left for the boot programme. But in practice
+ * Only a small portion of a zImage is needed, 40 sectors should be more
+ * than enough.
+ *
+ * Note that this sets how much of the zImage is copied by the mask ROM.
+ * The entire zImage is present after the header and is loaded
+ * by the code in the boot program (which is the first portion of the zImage).
+ */
+#define	MAX_BOOT_PROG_LEN (40 * 512)
+
+#define ROUND_UP(x)	((x + ALIGN - 1) & ~(ALIGN - 1))
+
+ssize_t do_read(int fd, void *buf, size_t count)
+{
+	size_t offset = 0;
+	ssize_t l;
+
+	while (offset < count) {
+		l = read(fd, buf + offset, count - offset);
+		if (!l)
+			break;
+		if (l < 0) {
+			if (errno == EAGAIN || errno == EWOULDBLOCK)
+				continue;
+			perror("read");
+			return -1;
+		}
+		offset += l;
+	}
+
+	return offset;
+}
+
+ssize_t do_write(int fd, const void *buf, size_t count)
+{
+	size_t offset = 0;
+	ssize_t l;
+
+	while (offset < count) {
+		l = write(fd, buf + offset, count - offset);
+		if (l < 0) {
+			if (errno == EAGAIN || errno == EWOULDBLOCK)
+				continue;
+			perror("write");
+			return -1;
+		}
+		offset += l;
+	}
+
+	return offset;
+}
+
+ssize_t write_zero(int fd, size_t len)
+{
+	size_t i = len;
+
+	while (i--) {
+		const char x = 0;
+		if (do_write(fd, &x, 1) < 0)
+			return -1;
+	}
+
+	return len;
+}
+
+int main(void)
+{
+	DECLARE_HDR(hdr);
+	char boot_program[MAX_BOOT_PROG_LEN];
+	size_t aligned_hdr_len, alligned_prog_len;
+	ssize_t prog_len;
+
+	prog_len = do_read(0, boot_program, sizeof(boot_program));
+	if (prog_len <= 0)
+		return -1;
+
+	aligned_hdr_len = ROUND_UP(sizeof(hdr));
+	hdr.start_address = START_BASE + aligned_hdr_len;
+	alligned_prog_len = ROUND_UP(prog_len);
+	hdr.copy_size = aligned_hdr_len + alligned_prog_len;
+
+	if (do_write(1, &hdr, sizeof(hdr)) < 0)
+		return -1;
+	if (write_zero(1, aligned_hdr_len - sizeof(hdr)) < 0)
+		return -1;
+
+	if (do_write(1, boot_program, prog_len) < 0)
+		return 1;
+
+	/* Write out the rest of the kernel */
+	while (1) {
+		prog_len = do_read(0, boot_program, sizeof(boot_program));
+		if (prog_len < 0)
+			return 1;
+		if (prog_len == 0)
+			break;
+		if (do_write(1, boot_program, prog_len) < 0)
+			return 1;
+	}
+
+	return 0;
+}
Index: linux-2.6-ap4/Documentation/arm/SH-Mobile/zboot-rom-mmcif.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ap4/Documentation/arm/SH-Mobile/zboot-rom-mmcif.txt	2010-12-06 09:11:49.000000000 +0900
@@ -0,0 +1,29 @@
+ROM-able zImage boot from MMC
+-----------------------------
+
+An ROM-able zImage compiled with ZBOOT_ROM_MMCIF may be written to MMC and
+SuperH Mobile ARM will to boot directly from the MMCIF hardware block.
+
+This is achieved by the mask ROM loading the first portion of the image into
+MERAM and then jumping to it. This portion contains loader code which
+copies the entire image to SDRAM and jumps to it. From there the zImage
+boot code proceeds as normal, uncompressing the image into its final
+location and then jumping to it.
+
+This code has been tested on an AP4EB board using the developer 1A eMMC
+boot mode which is configured using the following jumper settings.
+The board used for testing required a patched mask ROM in order for
+this mode to function.
+
+   8 7 6 5 4 3 2 1
+   x|x|x|x|x| |x|
+S4 -+-+-+-+-+-+-+-
+    | | | | |x| |x on
+
+The zImage must be written to the MMC card at sector 1 (512 bytes) in
+vrl4 format. A utility vrl4 is supplied to accomplish this.
+
+e.g.
+	vrl4 < zImage | dd of=/dev/sdX bs=512 seek=1
+
+A dual-voltage MMC 4.0 card was used for testing.

