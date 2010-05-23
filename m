From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 9/9 v2] ARM: mach-shmobile: add DMA support to sh7372, enable
 DMA for SDHI
Date: Sun, 23 May 2010 15:49:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005231546310.3571@axis700.grange>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
 <Pine.LNX.4.64.1005041424330.4925@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56739 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754607Ab0EWNte (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 23 May 2010 09:49:34 -0400
In-Reply-To: <Pine.LNX.4.64.1005041424330.4925@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, Paul Mundt <lethal@linux-sh.org>

This adds DMA support for the sh7372 sh-mobile ARM core, using the shdma
dmaengine driver, and uses DMA for the SDHI SD-card controller on this SoC.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

1. updated to the current genesis tree HEAD
2. adjusted the topic line to match platform preferences
3. moved DMA platform devices to the top of the file, so that other 
devices can reference them.

Paul, this should be ready for you to merge now.

 arch/arm/mach-shmobile/board-ap4evb.c        |    9 +
 arch/arm/mach-shmobile/include/mach/sh7372.h |   10 ++
 arch/arm/mach-shmobile/setup-sh7372.c        |  223 ++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 4d197e3..6905ec4 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
@@ -224,6 +225,11 @@ static struct platform_device keysc_device = {
 };
 
 /* SDHI0 */
+static struct sh_mobile_sdhi_info sdhi0_info = {
+	.dma_slave_tx = SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx = SHDMA_SLAVE_SDHI0_RX,
+};
+
 static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -242,6 +248,9 @@ static struct platform_device sdhi0_device = {
 	.num_resources  = ARRAY_SIZE(sdhi0_resources),
 	.resource       = sdhi0_resources,
 	.id             = 0,
+	.dev	= {
+		.platform_data	= &sdhi0_info,
+	},
 };
 
 /* USB1 */
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index dc34f00..57e033a 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -431,4 +431,14 @@ enum {
 	GPIO_FN_SDENC_DV_CLKI,
 };
 
+/* DMA slave IDs */
+enum {
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_SDHI1_TX,
+	SHDMA_SLAVE_SDHI2_RX,
+	SHDMA_SLAVE_SDHI2_TX,
+};
+
 #endif /* __ASM_SH7372_H__ */
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 885dfaa..0a834d3 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -26,12 +26,232 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/sh7372.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* DMA */
+/* Transmit sizes and respective CHCR register values */
+enum {
+	XMIT_SZ_8BIT		= 0,
+	XMIT_SZ_16BIT		= 1,
+	XMIT_SZ_32BIT		= 2,
+	XMIT_SZ_64BIT		= 7,
+	XMIT_SZ_128BIT		= 3,
+	XMIT_SZ_256BIT		= 4,
+	XMIT_SZ_512BIT		= 5,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+#define TS_SHIFT {			\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_64BIT]		= 3,	\
+	[XMIT_SZ_128BIT]	= 4,	\
+	[XMIT_SZ_256BIT]	= 5,	\
+	[XMIT_SZ_512BIT]	= 6,	\
+}
+
+#define TS_INDEX2VAL(i) ((((i) & 3) << 3) | \
+			 (((i) & 0xc) << (20 - 2)))
+
+static const struct sh_dmae_slave_config sh7724_dmae_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
+		.addr		= 0xe6850030,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_RX,
+		.addr		= 0xe6850030,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc2,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI1_TX,
+		.addr		= 0xe6860030,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc9,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI1_RX,
+		.addr		= 0xe6860030,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xca,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI2_TX,
+		.addr		= 0xe6870030,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xcd,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI2_RX,
+		.addr		= 0xe6870030,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xce,
+	},
+};
+
+static const struct sh_dmae_channel sh7724_dmae_channels[] = {
+	{
+		.offset = 0,
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static const unsigned int ts_shift[] = TS_SHIFT;
+
+static struct sh_dmae_pdata dma_platform_data = {
+	.slave		= sh7724_dmae_slaves,
+	.slave_num	= ARRAY_SIZE(sh7724_dmae_slaves),
+	.channel	= sh7724_dmae_channels,
+	.channel_num	= ARRAY_SIZE(sh7724_dmae_channels),
+	.ts_low_shift	= 3,
+	.ts_low_mask	= 0x18,
+	.ts_high_shift	= (20 - 2),	/* 2 bits for shifted low TS */
+	.ts_high_mask	= 0x00300000,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_DME,
+};
+
+/* Resource order important! */
+static struct resource sh7724_dmae0_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xfe008020,
+		.end	= 0xfe00808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xfe009000,
+		.end	= 0xfe00900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ */
+		.start	= 246,
+		.end	= 246,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-5 */
+		.start	= 240,
+		.end	= 245,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+/* Resource order important! */
+static struct resource sh7724_dmae1_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xfe018020,
+		.end	= 0xfe01808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xfe019000,
+		.end	= 0xfe01900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ */
+		.start	= 254,
+		.end	= 254,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-5 */
+		.start	= 248,
+		.end	= 253,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+/* Resource order important! */
+static struct resource sh7724_dmae2_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xfe028020,
+		.end	= 0xfe02808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xfe029000,
+		.end	= 0xfe02900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ */
+		.start	= 262,
+		.end	= 262,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-5 */
+		.start	= 256,
+		.end	= 261,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dma0_device = {
+	.name		= "sh-dma-engine",
+	.id		= 0,
+	.resource	= sh7724_dmae0_resources,
+	.num_resources	= ARRAY_SIZE(sh7724_dmae0_resources),
+	.dev		= {
+		.platform_data	= &dma_platform_data,
+	},
+};
+
+static struct platform_device dma1_device = {
+	.name		= "sh-dma-engine",
+	.id		= 1,
+	.resource	= sh7724_dmae1_resources,
+	.num_resources	= ARRAY_SIZE(sh7724_dmae1_resources),
+	.dev		= {
+		.platform_data	= &dma_platform_data,
+	},
+};
+
+static struct platform_device dma2_device = {
+	.name		= "sh-dma-engine",
+	.id		= 2,
+	.resource	= sh7724_dmae2_resources,
+	.num_resources	= ARRAY_SIZE(sh7724_dmae2_resources),
+	.dev		= {
+		.platform_data	= &dma_platform_data,
+	},
+};
+
 /* SCIF */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
@@ -225,6 +445,9 @@ static struct platform_device *sh7372_early_devices[] __initdata = {
 	&cmt10_device,
 	&iic0_device,
 	&iic1_device,
+	&dma0_device,
+	&dma1_device,
+	&dma2_device,
 };
 
 void __init sh7372_add_standard_devices(void)

-- 
1.6.2.4

