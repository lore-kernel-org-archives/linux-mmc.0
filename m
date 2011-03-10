From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] [rfc v2] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
Date: Thu, 10 Mar 2011 17:14:00 +0900
Message-ID: <1299744840-5775-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38148 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab1CJIOO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 03:14:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This allows a ROM-able zImage to be written to eSD and for SuperH Mobile
ARM to boot directly from the SDHI hardware block.

This is achieved by the MaskROM loading the first portion of the image into
MERAM and then jumping to it.  This portion contains loader code which
copies the entire image to SDRAM and jumps to it. From there the zImage
boot code proceeds as normal, uncompressing the image into its final
location and then jumping to it.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

This patch is based on the for-next branch of
Russell King's linux-2.6-arm tree

* v2
  Consistently use __raw_readw().
  As pointed out by Paul Mundt
---
 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt     |   43 ++
 arch/arm/Kconfig                                   |   35 +-
 arch/arm/boot/compressed/Makefile                  |    9 +-
 arch/arm/boot/compressed/head-shmobile.S           |   12 +-
 arch/arm/boot/compressed/mmcif-sh7372.c            |    2 +-
 arch/arm/boot/compressed/sdhi-shmobile.c           |  573 ++++++++++++++++++++
 .../mach-shmobile/include/mach/mmcif-mackerel.h    |   13 +
 arch/sh/boot/romimage/mmcif-sh7724.c               |    2 +-
 8 files changed, 670 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt
 create mode 100644 arch/arm/boot/compressed/sdhi-shmobile.c

diff --git a/Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt b/Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt
new file mode 100644
index 0000000..dbd21ef
--- /dev/null
+++ b/Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt
@@ -0,0 +1,43 @@
+ROM-able zImage boot from eSD
+-----------------------------
+
+An ROM-able zImage compiled with ZBOOT_ROM_SDHI may be written to eSD and
+SuperH Mobile ARM will to boot directly from the SDHI hardware block.
+
+This is achieved by the mask ROM loading the first portion of the image into
+MERAM and then jumping to it. This portion contains loader code which
+copies the entire image to SDRAM and jumps to it. From there the zImage
+boot code proceeds as normal, uncompressing the image into its final
+location and then jumping to it.
+
+This code has been tested on an mackerel board using the developer 1A eSD
+boot mode which is configured using the following jumper settings.
+
+   8 7 6 5 4 3 2 1
+   x|x|x|x| |x|x|
+S4 -+-+-+-+-+-+-+-
+    | | | |x| | |x on
+
+The eSD card needs to be present in SDHI slot 1 (CN7).
+As such S1 and S33 also need to be configured as per
+the notes in arch/arm/mach-shmobile/board-mackerel.c.
+
+A partial zImage must be written to physical partition #1 (boot)
+of the eSD at sector 0 in vrl4 format. A utility vrl4 is supplied to
+accomplish this.
+
+e.g.
+	vrl4 < zImage | dd of=/dev/sdX bs=512 count=9
+
+A full copy of _the same_ zImage should be written to physical partition #1
+(boot) of the eSD at sector 0. This should _not_ be in vrl4 format.
+
+	vrl4 < zImage | dd of=/dev/sdX bs=512
+
+Note: The commands above assume that the physical partition has been
+switched. No such facility currently exists in the Linux Kernel.
+
+Physical partitions are described in the eSD specification.  At the time of
+writing they are not the same as partitions that are typically configured
+using fdisk and visible through /proc/partitions
+
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 574ce60..55892eb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1685,17 +1685,34 @@ config ZBOOT_ROM
 	  Say Y here if you intend to execute your compressed kernel image
 	  (zImage) directly from ROM or flash.  If unsure, say N.
 
+choice
+	prompt "Include SD/MMC loader in zImage (EXPERIMENTAL)"
+	depends on ZBOOT_ROM && ARCH_SHMOBILE && EXPERIMENTAL
+	default ZBOOT_ROM_NONE
+	help
+	  Include experimental SD/MMC loading code in the ROM-able zImage.
+	  With this enabled it is possible to write the the ROM-able zImage
+	  kernel image to an MMC or SD card and boot the kernel straight
+	  from the reset vector. At reset the processor Mask ROM will load
+	  the first part of the the ROM-able zImage which in turn loads the
+	  rest the kernel image to RAM.
+
+config ZBOOT_ROM_NONE
+	bool "No SD/MMC loader in zImage (EXPERIMENTAL)"
+	help
+	  Do not load image from SD or MMC
+
 config ZBOOT_ROM_MMCIF
 	bool "Include MMCIF loader in zImage (EXPERIMENTAL)"
-	depends on ZBOOT_ROM && ARCH_SH7372 && EXPERIMENTAL
-	help
-	  Say Y here to include experimental MMCIF loading code in the
-	  ROM-able zImage. With this enabled it is possible to write the
-	  the ROM-able zImage kernel image to an MMC card and boot the
-	  kernel straight from the reset vector. At reset the processor
-	  Mask ROM will load the first part of the the ROM-able zImage
-	  which in turn loads the rest the kernel image to RAM using the
-	  MMCIF hardware block.
+	help
+	  Load image from MMCIF hardware block.
+
+config ZBOOT_ROM_SH_MOBILE_SDHI
+	bool "Include SuperH Mobile SDHI loader in zImage (EXPERIMENTAL)"
+	help
+	  Load image from SDHI hardware block
+
+endchoice
 
 config CMDLINE
 	string "Default kernel command string"
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index f9f77c6..60bd76d 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -6,13 +6,18 @@
 
 OBJS		=
 
-# Ensure that mmcif loader code appears early in the image
+# Ensure that MMCIF loader code appears early in the image
 # to minimise that number of bocks that have to be read in
 # order to load it.
 ifeq ($(CONFIG_ZBOOT_ROM_MMCIF),y)
-ifeq ($(CONFIG_ARCH_SH7372),y)
 OBJS		+= mmcif-sh7372.o
 endif
+
+# Ensure that SDHI loader code appears early in the image
+# to minimise that number of bocks that have to be read in
+# order to load it.
+ifeq ($(CONFIG_ZBOOT_ROM_SH_MOBILE_SDHI),y)
+OBJS		+= sdhi-shmobile.o
 endif
 
 AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
diff --git a/arch/arm/boot/compressed/head-shmobile.S b/arch/arm/boot/compressed/head-shmobile.S
index c943d2e..fe3719b 100644
--- a/arch/arm/boot/compressed/head-shmobile.S
+++ b/arch/arm/boot/compressed/head-shmobile.S
@@ -25,14 +25,14 @@
 	/* load board-specific initialization code */
 #include <mach/zboot.h>
 
-#ifdef CONFIG_ZBOOT_ROM_MMCIF
-	/* Load image from MMC */
-	adr	sp, __tmp_stack + 128
+#if defined(CONFIG_ZBOOT_ROM_MMCIF) || defined(CONFIG_ZBOOT_ROM_SH_MOBILE_SDHI)
+	/* Load image from MMC/SD */
+	adr	sp, __tmp_stack + 256
 	ldr	r0, __image_start
 	ldr	r1, __image_end
 	subs	r1, r1, r0
 	ldr	r0, __load_base
-	bl	mmcif_loader
+	bl	mmc_loader
 
 	/* Jump to loaded code */
 	ldr	r0, __loaded
@@ -51,9 +51,9 @@ __loaded:
 	.long	__continue
 	.align
 __tmp_stack:
-	.space	128
+	.space	256
 __continue:
-#endif /* CONFIG_ZBOOT_ROM_MMCIF */
+#endif /* CONFIG_ZBOOT_ROM_MMC || CONFIG_ZBOOT_ROM_SH_MOBILE_SDHI */
 
 	b	1f
 __atags:@ tag #1
diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boot/compressed/mmcif-sh7372.c
index e6180af..74d24e4 100644
--- a/arch/arm/boot/compressed/mmcif-sh7372.c
+++ b/arch/arm/boot/compressed/mmcif-sh7372.c
@@ -39,7 +39,7 @@
  * to an MMC card
  * # dd if=vrl4.out of=/dev/sdx bs=512 seek=1
  */
-asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
+asmlinkage void mmc_loader(unsigned char *buf, unsigned long len)
 {
 	mmcif_init_progress();
 	mmcif_update_progress(MMCIF_PROGRESS_ENTER);
diff --git a/arch/arm/boot/compressed/sdhi-shmobile.c b/arch/arm/boot/compressed/sdhi-shmobile.c
new file mode 100644
index 0000000..d617f6f
--- /dev/null
+++ b/arch/arm/boot/compressed/sdhi-shmobile.c
@@ -0,0 +1,573 @@
+/*
+ * SuperH Mobile SDHI
+ *
+ * Copyright (C) 2010 Magnus Damm
+ * Copyright (C) 2010 Kuninori Morimoto
+ * Copyright (C) 2010 Simon Horman
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Parts inspired by u-boot
+ */
+
+#include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
+#include <mach/mmcif.h>
+
+#define PORT179CR	0xe60520b3
+#define PORT180CR	0xe60520b4
+#define PORT181CR	0xe60520b5
+#define PORT182CR	0xe60520b6
+#define PORT183CR	0xe60520b7
+#define PORT184CR	0xe60520b8
+
+#define SMSTPCR3	0xe615013c
+#define SDGENCNTA	0xfe40009c
+#define CR_INPUT_ENABLE 0x10
+#define CR_FUNCTION1	0x01
+
+#define SDHI_BBS	512
+
+#define CTL_SD_CMD		0x00
+#define CTL_ARG_REG		0x04
+#define CTL_RESPONSE		0x0c
+#define CTL_STATUS		0x1c
+#define CTL_IRQ_MASK		0x20
+#define CTL_SD_CARD_CLK_CTL	0x24
+#define CTL_SD_XFER_LEN		0x26
+#define CTL_SD_MEM_CARD_OPT	0x28
+#define CTL_RESET_SD		0xe0
+#define CTL_CLK_AND_WAIT_CTL	0x138
+
+/* Definitions for values the CTRL_STATUS register can take. */
+#define TMIO_STAT_CMDRESPEND	0x00000001
+#define TMIO_STAT_DATAEND	0x00000004
+#define TMIO_STAT_CMD_IDX_ERR	0x00010000
+#define TMIO_STAT_CRCFAIL	0x00020000
+#define TMIO_STAT_STOPBIT_ERR	0x00040000
+#define TMIO_STAT_DATATIMEOUT	0x00080000
+#define TMIO_STAT_RXOVERFLOW	0x00100000
+#define TMIO_STAT_TXUNDERRUN	0x00200000
+#define TMIO_STAT_CMDTIMEOUT	0x00400000
+#define TMIO_STAT_RXRDY		0x01000000
+#define TMIO_STAT_ILL_FUNC	0x20000000
+#define TMIO_STAT_CMD_BUSY	0x40000000
+#define TMIO_STAT_ILL_ACCESS	0x80000000
+
+#define OCR_FASTBOOT		(1<<29)
+#define OCR_HCS			(1<<30)
+#define OCR_BUSY		(1<<31)
+
+#define SDHI_EXT_SWAP		0xf0
+
+#define SDHI1_BASE		(void __iomem *)0xe6860000
+#define SDHI_BASE		 SDHI1_BASE
+
+/* The countdown of SDGENCNTA is controlled by
+ * ZB3D2CLK which runs at 149.5MHz.
+ * That is 149.5ticks/us. Approximate this as 150ticks/us.
+ */
+void udelay(int us)
+{
+	__raw_writel(us * 150, SDGENCNTA);
+	while(__raw_readl(SDGENCNTA)) ;
+}
+
+void msleep(int ms)
+{
+	udelay(ms * 1000);
+}
+
+static inline u16 sd_ctrl_read16(void __iomem *base, int addr)
+{
+        return __raw_readw(base + addr);
+}
+
+static inline u32 sd_ctrl_read32(void __iomem *base, int addr)
+{
+	return __raw_readw(base + addr) |
+	       __raw_readw(base + addr + 2) << 16;
+}
+
+static inline void sd_ctrl_write16(void __iomem *base, int addr, u16 val)
+{
+	__raw_writew(val, base + addr);
+}
+
+static inline void sd_ctrl_write32(void __iomem *base, int addr, u32 val)
+{
+	__raw_writew(val, base + addr);
+	__raw_writew(val >> 16, base + addr + 2);
+}
+
+#define ALL_ERROR (TMIO_STAT_CMD_IDX_ERR | TMIO_STAT_CRCFAIL |		\
+		   TMIO_STAT_STOPBIT_ERR | TMIO_STAT_DATATIMEOUT |	\
+		   TMIO_STAT_RXOVERFLOW | TMIO_STAT_TXUNDERRUN |	\
+		   TMIO_STAT_CMDTIMEOUT | TMIO_STAT_ILL_ACCESS |	\
+		   TMIO_STAT_ILL_FUNC)
+
+static int sdhi_intr(void __iomem *base)
+{
+	unsigned long state = sd_ctrl_read32(base, CTL_STATUS);
+
+	if (state & ALL_ERROR) {
+		sd_ctrl_write32(base, CTL_STATUS, ~ALL_ERROR);
+		sd_ctrl_write32(base, CTL_IRQ_MASK,
+				ALL_ERROR |
+				sd_ctrl_read32(base, CTL_IRQ_MASK));
+		return -EINVAL;
+	}
+	if (state & TMIO_STAT_CMDRESPEND) {
+		sd_ctrl_write32(base, CTL_STATUS, ~TMIO_STAT_CMDRESPEND);
+		sd_ctrl_write32(base, CTL_IRQ_MASK,
+				TMIO_STAT_CMDRESPEND |
+				sd_ctrl_read32(base, CTL_IRQ_MASK));
+		return 0;
+	}
+	if (state & TMIO_STAT_RXRDY) {
+		sd_ctrl_write32(base, CTL_STATUS, ~TMIO_STAT_RXRDY);
+		sd_ctrl_write32(base, CTL_IRQ_MASK,
+				TMIO_STAT_RXRDY | TMIO_STAT_TXUNDERRUN |
+				sd_ctrl_read32(base, CTL_IRQ_MASK));
+		return 0;
+	}
+	if (state & TMIO_STAT_DATAEND) {
+		sd_ctrl_write32(base, CTL_STATUS, ~TMIO_STAT_DATAEND);
+		sd_ctrl_write32(base, CTL_IRQ_MASK,
+				TMIO_STAT_DATAEND |
+				sd_ctrl_read32(base, CTL_IRQ_MASK));
+		return 0;
+	}
+
+	//mmcif_update_progress2(4<<1);
+	return -EAGAIN;
+}
+
+static int sdhi_boot_wait_resp_end(void __iomem *base)
+{
+	int err = -EAGAIN, timeout = 10000000;
+
+	while (timeout--) {
+		err = sdhi_intr(base);
+		if (err != -EAGAIN)
+			break;
+		udelay(1);
+	}
+
+	return err;
+}
+
+/* SDHI_CLK_CTRL */
+#define CLK_MMC_ENABLE                 (1 << 8)
+#define CLK_MMC_INIT                   (1 << 6)        /* clk / 256 */
+
+static void shdi_boot_mmc_clk_stop(void __iomem *base)
+{
+	sd_ctrl_write16(base, CTL_CLK_AND_WAIT_CTL, 0x0000);
+	msleep(10);
+	sd_ctrl_write16(base, CTL_SD_CARD_CLK_CTL, ~CLK_MMC_ENABLE &
+		sd_ctrl_read16(base, CTL_SD_CARD_CLK_CTL));
+	msleep(10);
+}
+
+static void shdi_boot_mmc_clk_start(void __iomem *base)
+{
+	sd_ctrl_write16(base, CTL_SD_CARD_CLK_CTL, CLK_MMC_ENABLE |
+		sd_ctrl_read16(base, CTL_SD_CARD_CLK_CTL));
+	msleep(10);
+	sd_ctrl_write16(base, CTL_CLK_AND_WAIT_CTL, CLK_MMC_ENABLE);
+	msleep(10);
+}
+
+static void sdhi_boot_reset(void __iomem *base)
+{
+	sd_ctrl_write16(base, CTL_RESET_SD, 0x0000);
+	msleep(10);
+	sd_ctrl_write16(base, CTL_RESET_SD, 0x0001);
+	msleep(10);
+}
+
+/* Set MMC clock / power.
+ * Note: This controller uses a simple divider scheme therefore it cannot
+ * run a MMC card at full speed (20MHz). The max clock is 24MHz on SD, but as
+ * MMC wont run that fast, it has to be clocked at 12MHz which is the next
+ * slowest setting.
+ */
+static int shdi_boot_mmc_set_ios(void __iomem *base, struct mmc_ios *ios)
+{
+	if (sd_ctrl_read32(base, CTL_STATUS) & TMIO_STAT_CMD_BUSY)
+		return -EBUSY;
+
+	if (ios->clock)
+		sd_ctrl_write16(base, CTL_SD_CARD_CLK_CTL,
+				ios->clock | CLK_MMC_ENABLE);
+
+	/* Power sequence - OFF -> ON -> UP */
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF: /* power down SD bus */
+		shdi_boot_mmc_clk_stop(base);
+		break;
+	case MMC_POWER_ON: /* power up SD bus */
+		break;
+	case MMC_POWER_UP: /* start bus clock */
+		shdi_boot_mmc_clk_start(base);
+		break;
+	}
+
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_1:
+		sd_ctrl_write16(base, CTL_SD_MEM_CARD_OPT, 0x80e0);
+	break;
+	case MMC_BUS_WIDTH_4:
+		sd_ctrl_write16(base, CTL_SD_MEM_CARD_OPT, 0x00e0);
+	break;
+	}
+
+	/* Let things settle. delay taken from winCE driver */
+	udelay(140);
+
+	return 0;
+}
+
+/* These are the bitmasks the tmio chip requires to implement the MMC response
+ * types. Note that R1 and R6 are the same in this scheme. */
+#define RESP_NONE      0x0300
+#define RESP_R1        0x0400
+#define RESP_R1B       0x0500
+#define RESP_R2        0x0600
+#define RESP_R3        0x0700
+#define DATA_PRESENT   0x0800
+#define TRANSFER_READ  0x1000
+
+static int sdhi_boot_request(void __iomem *base, struct mmc_command *cmd)
+{
+	int err, c = cmd->opcode;
+
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_NONE: c |= RESP_NONE; break;
+	case MMC_RSP_R1:   c |= RESP_R1;   break;
+	case MMC_RSP_R1B:  c |= RESP_R1B;  break;
+	case MMC_RSP_R2:   c |= RESP_R2;   break;
+	case MMC_RSP_R3:   c |= RESP_R3;   break;
+	default:
+		return -EINVAL;
+	}
+
+	/* No interrupts so this may not be cleared */
+	sd_ctrl_write32(base, CTL_STATUS, ~TMIO_STAT_CMDRESPEND);
+
+	sd_ctrl_write32(base, CTL_IRQ_MASK, TMIO_STAT_CMDRESPEND |
+			sd_ctrl_read32(base, CTL_IRQ_MASK));
+	sd_ctrl_write32(base, CTL_ARG_REG, cmd->arg);
+	sd_ctrl_write16(base, CTL_SD_CMD, c);
+
+
+	sd_ctrl_write32(base, CTL_IRQ_MASK,
+			~(TMIO_STAT_CMDRESPEND | ALL_ERROR) &
+			sd_ctrl_read32(base, CTL_IRQ_MASK));
+
+	err = sdhi_boot_wait_resp_end(base);
+	if (err)
+		return err;
+
+	cmd->resp[0] = sd_ctrl_read32(base, CTL_RESPONSE);
+
+	return 0;
+}
+
+static int sdhi_boot_do_read_single(void __iomem *base, int high_capacity,
+				    unsigned long block, unsigned short *buf)
+{
+	int err, i;
+
+	/* CMD17 - Read */
+	{
+		struct mmc_command cmd;
+
+		cmd.opcode = MMC_READ_SINGLE_BLOCK | \
+			     TRANSFER_READ | DATA_PRESENT;
+		if (high_capacity)
+			cmd.arg = block;
+		else
+			cmd.arg = block * SDHI_BBS;
+		cmd.flags = MMC_RSP_R1;
+		err = sdhi_boot_request(base, &cmd);
+		if (err)
+			return err;
+	}
+
+	sd_ctrl_write32(base, CTL_IRQ_MASK,
+			~(TMIO_STAT_DATAEND | TMIO_STAT_RXRDY |
+			  TMIO_STAT_TXUNDERRUN) &
+			sd_ctrl_read32(base, CTL_IRQ_MASK));
+	err = sdhi_boot_wait_resp_end(base);
+	if (err)
+		return err;
+
+	sd_ctrl_write16(base, CTL_SD_XFER_LEN, SDHI_BBS);
+	for (i = 0; i < SDHI_BBS / sizeof(*buf); i++)
+		*buf++ = sd_ctrl_read16(base, MMCIF_CE_RESP_CMD12);
+
+	err = sdhi_boot_wait_resp_end(base);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int sdhi_boot_do_read(void __iomem *base, int high_capacity,
+			     unsigned long offset, unsigned short count,
+			     unsigned short *buf)
+{
+	unsigned long i;
+	int err = 0;
+
+	for (i = 0; i < count; i++) {
+		if ((i & 0xf) == 0)
+			mmcif_update_progress2((i >> 4) & 0xf);
+		err = sdhi_boot_do_read_single(base, high_capacity, offset + i,
+					       buf + (i * SDHI_BBS /
+						      sizeof(*buf)));
+		if (err)
+			return err;
+	}
+
+	mmcif_update_progress2(0);
+	return 0;
+}
+
+#define VOLTAGES (MMC_VDD_32_33 | MMC_VDD_33_34)
+
+static int sdhi_boot_init(void __iomem *base)
+{
+	bool sd_v2 = false, sd_v1_0 = false;
+	unsigned short cid;
+	int err, high_capacity = 0;
+
+	shdi_boot_mmc_clk_stop(base);
+	sdhi_boot_reset(base);
+
+	/* mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0 */
+	{
+		struct mmc_ios ios;
+		ios.power_mode = MMC_POWER_ON;
+		ios.bus_width = MMC_BUS_WIDTH_1;
+		ios.clock = CLK_MMC_INIT;
+		err = shdi_boot_mmc_set_ios(base, &ios);
+		if (err)
+			return err;
+	}
+
+	/* CMD0 */
+	{
+		struct mmc_command cmd;
+		msleep(1);
+		cmd.opcode = MMC_GO_IDLE_STATE;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_NONE;
+		err = sdhi_boot_request(base, &cmd);
+		if (err)
+			return err;
+		msleep(2);
+	}
+
+	/* CMD8 - Test for SD version 2 */
+	{
+		struct mmc_command cmd;
+		cmd.opcode = SD_SEND_IF_COND;
+		cmd.arg = (VOLTAGES != 0) << 8 | 0xaa;
+		cmd.flags = MMC_RSP_R1;
+		err = sdhi_boot_request(base, &cmd); /* Ignore error */
+		if ((cmd.resp[0] & 0xff) == 0xaa)
+			sd_v2 = true;
+	}
+
+	/* CMD55 - Get OCR (SD) */
+	{
+		int timeout = 1000;
+		struct mmc_command cmd;
+
+		cmd.arg = 0;
+
+		do {
+			cmd.opcode = MMC_APP_CMD;
+			cmd.flags = MMC_RSP_R1;
+			cmd.arg = 0;
+			err = sdhi_boot_request(base, &cmd);
+			if (err)
+				break;
+
+			cmd.opcode = SD_APP_OP_COND;
+			cmd.flags = MMC_RSP_R3;
+			cmd.arg = (VOLTAGES & 0xff8000);
+			if (sd_v2)
+				cmd.arg |= OCR_HCS;
+			cmd.arg |= OCR_FASTBOOT;
+			err = sdhi_boot_request(base, &cmd);
+			if (err)
+				break;
+
+			msleep(1);
+		} while((!(cmd.resp[0] & OCR_BUSY)) && --timeout);
+
+		if (!err && timeout) {
+			if (!sd_v2)
+				sd_v1_0 = true;
+			high_capacity = (cmd.resp[0] & OCR_HCS) == OCR_HCS;
+		}
+	}
+
+	/* CMD1 - Get OCR (MMC) */
+	if (!sd_v2 && !sd_v1_0) {
+		int timeout = 1000;
+		struct mmc_command cmd;
+
+		do {
+			cmd.opcode = MMC_SEND_OP_COND;
+			cmd.arg = VOLTAGES | OCR_HCS;
+			cmd.flags = MMC_RSP_R3;
+			err = sdhi_boot_request(base, &cmd);
+			if (err)
+				return err;
+
+			msleep(1);
+		} while((!(cmd.resp[0] & OCR_BUSY)) && --timeout);
+
+		if (!timeout)
+			return -EAGAIN;
+
+		high_capacity = (cmd.resp[0] & OCR_HCS) == OCR_HCS;
+	}
+
+	/* CMD2 - Get CID */
+	{
+		struct mmc_command cmd;
+		cmd.opcode = MMC_ALL_SEND_CID;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R2;
+		err = sdhi_boot_request(base, &cmd);
+		if (err)
+			return err;
+	}
+
+	/* CMD3
+	 * MMC: Set the relative address
+	 * SD:  Get the relative address
+	 * Also puts the card into the standby state
+	 */
+	{
+		struct mmc_command cmd;
+		cmd.opcode = MMC_SET_RELATIVE_ADDR;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1;
+		err = sdhi_boot_request(base, &cmd);
+		if (err)
+			return err;
+		cid = cmd.resp[0] >> 16;
+	}
+
+	/* CMD9 - Get CSD */
+	{
+		struct mmc_command cmd;
+		cmd.opcode = MMC_SEND_CSD;
+		cmd.arg = cid << 16;
+		cmd.flags = MMC_RSP_R2;
+		err = sdhi_boot_request(base, &cmd);
+		if (err)
+			return err;
+	}
+
+	/* CMD7 - Select the card */
+	{
+		struct mmc_command cmd;
+		cmd.opcode = MMC_SELECT_CARD;
+		//cmd.arg = rca << 16;
+		cmd.arg = cid << 16;
+		//cmd.flags = MMC_RSP_R1B;
+		cmd.flags = MMC_RSP_R1;
+		err = sdhi_boot_request(base, &cmd);
+		if (err)
+			return err;
+	}
+
+	/* CMD16 - Set the block size */
+	{
+		struct mmc_command cmd;
+		cmd.opcode = MMC_SET_BLOCKLEN;
+		cmd.arg = SDHI_BBS;
+		cmd.flags = MMC_RSP_R1;
+		err = sdhi_boot_request(base, &cmd);
+		if (err)
+			return err;
+	}
+
+	return high_capacity;
+}
+
+/*  SuperH Mobile SDHI loader
+ *
+ * loads the zImage from an SD card starting from block 0
+ * on physical partition 1
+ *
+ * The image must be start with a vrl4 header and
+ * the zImage must start at offset 512 of the image. That is,
+ * at block 1 (=byte 512) of physical partition 1
+ *
+ * Use the following line to write the vrl4 formated zImage
+ * to an SD card
+ * # dd if=vrl4.out of=/dev/sdx bs=512
+ */
+asmlinkage void mmc_loader(unsigned short *buf, unsigned long len)
+{
+	int high_capacity;
+
+	mmcif_init_progress();
+	mmcif_update_progress(MMCIF_PROGRESS_ENTER);
+
+	/* Initialise SDHI1 */
+	/* PORT184CR: GPIO_FN_SDHICMD1 Control */
+	__raw_writeb(CR_FUNCTION1, PORT184CR);
+	/* PORT179CR: GPIO_FN_SDHICLK1 Control */
+	__raw_writeb(CR_INPUT_ENABLE|CR_FUNCTION1, PORT179CR);
+	/* PORT181CR: GPIO_FN_SDHID1_3 Control */
+	__raw_writeb(CR_FUNCTION1, PORT183CR);
+	/* PORT182CR: GPIO_FN_SDHID1_2 Control */
+	__raw_writeb(CR_FUNCTION1, PORT182CR);
+	/* PORT183CR: GPIO_FN_SDHID1_1 Control */
+	__raw_writeb(CR_FUNCTION1, PORT181CR);
+	/* PORT180CR: GPIO_FN_SDHID1_0 Control */
+	__raw_writeb(CR_FUNCTION1, PORT180CR);
+
+	/* Enable clock to SDHI1 hardware block */
+	__raw_writel(__raw_readl(SMSTPCR3) & ~(1 << 13), SMSTPCR3);
+
+	/* setup SDHI hardware */
+	mmcif_update_progress(MMCIF_PROGRESS_INIT);
+	high_capacity = sdhi_boot_init(SDHI_BASE);
+	if (high_capacity < 0)
+		goto err;
+
+	mmcif_update_progress(MMCIF_PROGRESS_LOAD);
+	/* load kernel */
+	if (sdhi_boot_do_read(SDHI_BASE, high_capacity,
+			      0, /* Kernel is at block 1 */
+			      (len + SDHI_BBS - 1) / SDHI_BBS, buf))
+		goto err;
+
+	/* Disable clock to SDHI1 hardware block */
+	__raw_writel(__raw_readl(SMSTPCR3) & (1 << 13), SMSTPCR3);
+
+	mmcif_update_progress(MMCIF_PROGRESS_DONE);
+
+	return;
+err:
+	__raw_writel(__raw_readl(PORTR031_000DR) | 1, PORTR031_000DR);
+	for(;;);
+
+}
+
diff --git a/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h b/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
index 4b4f694..0d13e7e 100644
--- a/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
+++ b/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
@@ -36,4 +36,17 @@ static inline void mmcif_update_progress(int n)
 		     PORTL159_128DR);
 }
 
+static inline void mmcif_update_progress2(int n)
+{
+	unsigned a, b;
+
+	a = n & 0x7;
+	b = ((n & 0x8) != 0) << 31;
+
+	__raw_writel((__raw_readl(PORTR031_000DR) & ~0x7) | a,
+		     PORTR031_000DR);
+	__raw_writel((__raw_readl(PORTL159_128DR) & ~(1 << 31)) | b,
+		     PORTL159_128DR);
+}
+
 #endif /* MMCIF_MACKEREL_H */
diff --git a/arch/sh/boot/romimage/mmcif-sh7724.c b/arch/sh/boot/romimage/mmcif-sh7724.c
index c84e783..4ded8ba 100644
--- a/arch/sh/boot/romimage/mmcif-sh7724.c
+++ b/arch/sh/boot/romimage/mmcif-sh7724.c
@@ -27,7 +27,7 @@
  * use the following line to write the romImage to an MMC card
  * # dd if=arch/sh/boot/romImage of=/dev/sdx bs=512 seek=512
  */
-asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
+asmlinkage void mmc_loader(unsigned char *buf, unsigned long no_bytes)
 {
 	mmcif_update_progress(MMCIF_PROGRESS_ENTER);
 
-- 
1.7.2.3

