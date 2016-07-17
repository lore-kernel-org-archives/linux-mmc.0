From: Scott Wood <oss@buserror.net>
Subject: [PATCH v11 3/5] soc: fsl: add GUTS driver for QorIQ platforms
Date: Sat, 16 Jul 2016 21:50:20 -0500
Message-ID: <1468723822-30457-4-git-send-email-oss@buserror.net>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468723822-30457-1-git-send-email-oss@buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Scott Wood <oss@buserror.net>
List-Id: linux-mmc@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>

The global utilities block controls power management, I/O device
enabling, power-onreset(POR) configuration monitoring, alternate
function selection for multiplexed signals,and clock control.

This patch adds a driver to manage and access global utilities block.
Initially only reading SVR is supported.  Other guts accesses, such as
reading RCW, should eventually be moved into this driver as well.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
[scottwood: minor cleanup]
Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/platforms/85xx/common.c |   2 -
 drivers/soc/Kconfig                  |   2 +-
 drivers/soc/fsl/Kconfig              |   8 +++
 drivers/soc/fsl/Makefile             |   1 +
 drivers/soc/fsl/guts.c               | 113 +++++++++++++++++++++++++++++++
 include/linux/fsl/guts.h             | 126 ++++++++++++++++++++++-------------
 6 files changed, 201 insertions(+), 51 deletions(-)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/guts.c

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 28720a4..badd193 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -29,8 +29,6 @@ static const struct of_device_id mpc85xx_common_ids[] __initconst = {
 	{ .compatible = "fsl,srio", },
 	/* So that the DMA channel nodes can be probed individually: */
 	{ .compatible = "fsl,eloplus-dma", },
-	/* For the PMC driver */
-	{ .compatible = "fsl,mpc8548-guts", },
 	/* Probably unnecessary? */
 	{ .compatible = "gpio-leds", },
 	/* For all PCI controllers */
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index cb58ef0..7106463 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,7 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/brcmstb/Kconfig"
-source "drivers/soc/fsl/qe/Kconfig"
+source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
new file mode 100644
index 0000000..b313759
--- /dev/null
+++ b/drivers/soc/fsl/Kconfig
@@ -0,0 +1,8 @@
+#
+# Freescale SOC drivers
+#
+
+source "drivers/soc/fsl/qe/Kconfig"
+
+config FSL_GUTS
+	bool
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 203307f..02afb7f 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
+obj-$(CONFIG_FSL_GUTS)			+= guts.o
diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
new file mode 100644
index 0000000..b534654
--- /dev/null
+++ b/drivers/soc/fsl/guts.c
@@ -0,0 +1,113 @@
+/*
+ * Freescale QorIQ Platforms GUTS Driver
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/fsl/guts.h>
+
+struct guts {
+	struct ccsr_guts __iomem *regs;
+	bool little_endian;
+};
+
+static struct guts *guts;
+static DEFINE_MUTEX(guts_lock);
+
+u32 fsl_guts_get_svr(void)
+{
+	u32 svr = 0;
+
+	if (!guts || !guts->regs) {
+#ifdef CONFIG_PPC
+		svr =  mfspr(SPRN_SVR);
+#endif
+		return svr;
+	}
+
+	if (guts->little_endian)
+		svr = ioread32(&guts->regs->svr);
+	else
+		svr = ioread32be(&guts->regs->svr);
+
+	return svr;
+}
+EXPORT_SYMBOL(fsl_guts_get_svr);
+
+/*
+ * Table for matching compatible strings, for device tree
+ * guts node, for Freescale QorIQ SOCs.
+ */
+static const struct of_device_id guts_of_match[] = {
+	{ .compatible = "fsl,qoriq-device-config-1.0", },
+	{ .compatible = "fsl,qoriq-device-config-2.0", },
+	{ .compatible = "fsl,p1010-guts", },
+	{ .compatible = "fsl,p1020-guts", },
+	{ .compatible = "fsl,p1021-guts", },
+	{ .compatible = "fsl,p1022-guts", },
+	{ .compatible = "fsl,p1023-guts", },
+	{ .compatible = "fsl,p2020-guts", },
+	{ .compatible = "fsl,bsc9131-guts", },
+	{ .compatible = "fsl,bsc9132-guts", },
+	{ .compatible = "fsl,mpc8536-guts", },
+	{ .compatible = "fsl,mpc8544-guts", },
+	{ .compatible = "fsl,mpc8548-guts", },
+	{ .compatible = "fsl,mpc8568-guts", },
+	{ .compatible = "fsl,mpc8569-guts", },
+	{ .compatible = "fsl,mpc8572-guts", },
+	{ .compatible = "fsl,ls1021a-dcfg", },
+	{ .compatible = "fsl,ls1043a-dcfg", },
+	{ .compatible = "fsl,ls2080a-dcfg", },
+	{}
+};
+
+int fsl_guts_init(void)
+{
+	struct device_node *np;
+	int ret;
+
+	mutex_lock(&guts_lock);
+	/* Initialize guts only once */
+	if (guts) {
+		ret = guts->regs ? 0 : -ENOMEM;
+		goto out;
+	}
+
+	np = of_find_matching_node(NULL, guts_of_match);
+	if (!np) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	guts = kzalloc(sizeof(*guts), GFP_KERNEL);
+	if (!guts) {
+		ret = -ENOMEM;
+		goto out_np;
+	}
+
+	guts->little_endian = of_property_read_bool(np, "little-endian");
+
+	guts->regs = of_iomap(np, 0);
+	if (!guts->regs) {
+		ret = -ENOMEM;
+		goto out_np;
+	}
+
+	ret = 0;
+out_np:
+	of_node_put(np);
+out:
+	mutex_unlock(&guts_lock);
+	return ret;
+}
+EXPORT_SYMBOL(fsl_guts_init);
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index 649e917..7e1e22b 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -29,83 +29,113 @@
  * #ifdefs.
  */
 struct ccsr_guts {
-	__be32	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
-	__be32	porbmsr;	/* 0x.0004 - POR Boot Mode Status Register */
-	__be32	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and Control Register */
-	__be32	pordevsr;	/* 0x.000c - POR I/O Device Status Register */
-	__be32	pordbgmsr;	/* 0x.0010 - POR Debug Mode Status Register */
-	__be32	pordevsr2;	/* 0x.0014 - POR device status register 2 */
+	u32	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
+	u32	porbmsr;	/* 0x.0004 - POR Boot Mode Status Register */
+	u32	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and
+				 *           Control Register
+				 */
+	u32	pordevsr;	/* 0x.000c - POR I/O Device Status Register */
+	u32	pordbgmsr;	/* 0x.0010 - POR Debug Mode Status Register */
+	u32	pordevsr2;	/* 0x.0014 - POR device status register 2 */
 	u8	res018[0x20 - 0x18];
-	__be32	porcir;		/* 0x.0020 - POR Configuration Information Register */
+	u32	porcir;		/* 0x.0020 - POR Configuration Information
+				 *           Register
+				 */
 	u8	res024[0x30 - 0x24];
-	__be32	gpiocr;		/* 0x.0030 - GPIO Control Register */
+	u32	gpiocr;		/* 0x.0030 - GPIO Control Register */
 	u8	res034[0x40 - 0x34];
-	__be32	gpoutdr;	/* 0x.0040 - General-Purpose Output Data Register */
+	u32	gpoutdr;	/* 0x.0040 - General-Purpose Output Data
+				 *           Register
+				 */
 	u8	res044[0x50 - 0x44];
-	__be32	gpindr;		/* 0x.0050 - General-Purpose Input Data Register */
+	u32	gpindr;		/* 0x.0050 - General-Purpose Input Data
+				 *           Register
+				 */
 	u8	res054[0x60 - 0x54];
-	__be32	pmuxcr;		/* 0x.0060 - Alternate Function Signal Multiplex Control */
-        __be32  pmuxcr2;	/* 0x.0064 - Alternate function signal multiplex control 2 */
-        __be32  dmuxcr;		/* 0x.0068 - DMA Mux Control Register */
+	u32	pmuxcr;		/* 0x.0060 - Alternate Function Signal
+				 *           Multiplex Control
+				 */
+	u32	pmuxcr2;	/* 0x.0064 - Alternate function signal
+				 *           multiplex control 2
+				 */
+	u32	dmuxcr;		/* 0x.0068 - DMA Mux Control Register */
         u8	res06c[0x70 - 0x6c];
-	__be32	devdisr;	/* 0x.0070 - Device Disable Control */
+	u32	devdisr;	/* 0x.0070 - Device Disable Control */
 #define CCSR_GUTS_DEVDISR_TB1	0x00001000
 #define CCSR_GUTS_DEVDISR_TB0	0x00004000
-	__be32	devdisr2;	/* 0x.0074 - Device Disable Control 2 */
+	u32	devdisr2;	/* 0x.0074 - Device Disable Control 2 */
 	u8	res078[0x7c - 0x78];
-	__be32  pmjcr;		/* 0x.007c - 4 Power Management Jog Control Register */
-	__be32	powmgtcsr;	/* 0x.0080 - Power Management Status and Control Register */
-	__be32  pmrccr;		/* 0x.0084 - Power Management Reset Counter Configuration Register */
-	__be32  pmpdccr;	/* 0x.0088 - Power Management Power Down Counter Configuration Register */
-	__be32  pmcdr;		/* 0x.008c - 4Power management clock disable register */
-	__be32	mcpsumr;	/* 0x.0090 - Machine Check Summary Register */
-	__be32	rstrscr;	/* 0x.0094 - Reset Request Status and Control Register */
-	__be32  ectrstcr;	/* 0x.0098 - Exception reset control register */
-	__be32  autorstsr;	/* 0x.009c - Automatic reset status register */
-	__be32	pvr;		/* 0x.00a0 - Processor Version Register */
-	__be32	svr;		/* 0x.00a4 - System Version Register */
+	u32	pmjcr;		/* 0x.007c - 4 Power Management Jog Control
+				 *           Register
+				 */
+	u32	powmgtcsr;	/* 0x.0080 - Power Management Status and
+				 *           Control Register
+				 */
+	u32	pmrccr;		/* 0x.0084 - Power Management Reset Counter
+				 *           Configuration Register
+				 */
+	u32	pmpdccr;	/* 0x.0088 - Power Management Power Down Counter
+				 *           Configuration Register
+				 */
+	u32	pmcdr;		/* 0x.008c - 4Power management clock disable
+				 *           register
+				 */
+	u32	mcpsumr;	/* 0x.0090 - Machine Check Summary Register */
+	u32	rstrscr;	/* 0x.0094 - Reset Request Status and
+				 *           Control Register
+				 */
+	u32	ectrstcr;	/* 0x.0098 - Exception reset control register */
+	u32	autorstsr;	/* 0x.009c - Automatic reset status register */
+	u32	pvr;		/* 0x.00a0 - Processor Version Register */
+	u32	svr;		/* 0x.00a4 - System Version Register */
 	u8	res0a8[0xb0 - 0xa8];
-	__be32	rstcr;		/* 0x.00b0 - Reset Control Register */
+	u32	rstcr;		/* 0x.00b0 - Reset Control Register */
 	u8	res0b4[0xc0 - 0xb4];
-	__be32  iovselsr;	/* 0x.00c0 - I/O voltage select status register
+	u32	iovselsr;	/* 0x.00c0 - I/O voltage select status register
 					     Called 'elbcvselcr' on 86xx SOCs */
 	u8	res0c4[0x100 - 0xc4];
-	__be32	rcwsr[16];	/* 0x.0100 - Reset Control Word Status registers
+	u32	rcwsr[16];	/* 0x.0100 - Reset Control Word Status registers
 					     There are 16 registers */
 	u8	res140[0x224 - 0x140];
-	__be32  iodelay1;	/* 0x.0224 - IO delay control register 1 */
-	__be32  iodelay2;	/* 0x.0228 - IO delay control register 2 */
+	u32	iodelay1;	/* 0x.0224 - IO delay control register 1 */
+	u32	iodelay2;	/* 0x.0228 - IO delay control register 2 */
 	u8	res22c[0x604 - 0x22c];
-	__be32	pamubypenr; 	/* 0x.604 - PAMU bypass enable register */
+	u32	pamubypenr;	/* 0x.604 - PAMU bypass enable register */
 	u8	res608[0x800 - 0x608];
-	__be32	clkdvdr;	/* 0x.0800 - Clock Divide Register */
+	u32	clkdvdr;	/* 0x.0800 - Clock Divide Register */
 	u8	res804[0x900 - 0x804];
-	__be32	ircr;		/* 0x.0900 - Infrared Control Register */
+	u32	ircr;		/* 0x.0900 - Infrared Control Register */
 	u8	res904[0x908 - 0x904];
-	__be32	dmacr;		/* 0x.0908 - DMA Control Register */
+	u32	dmacr;		/* 0x.0908 - DMA Control Register */
 	u8	res90c[0x914 - 0x90c];
-	__be32	elbccr;		/* 0x.0914 - eLBC Control Register */
+	u32	elbccr;		/* 0x.0914 - eLBC Control Register */
 	u8	res918[0xb20 - 0x918];
-	__be32	ddr1clkdr;	/* 0x.0b20 - DDR1 Clock Disable Register */
-	__be32	ddr2clkdr;	/* 0x.0b24 - DDR2 Clock Disable Register */
-	__be32	ddrclkdr;	/* 0x.0b28 - DDR Clock Disable Register */
+	u32	ddr1clkdr;	/* 0x.0b20 - DDR1 Clock Disable Register */
+	u32	ddr2clkdr;	/* 0x.0b24 - DDR2 Clock Disable Register */
+	u32	ddrclkdr;	/* 0x.0b28 - DDR Clock Disable Register */
 	u8	resb2c[0xe00 - 0xb2c];
-	__be32	clkocr;		/* 0x.0e00 - Clock Out Select Register */
+	u32	clkocr;		/* 0x.0e00 - Clock Out Select Register */
 	u8	rese04[0xe10 - 0xe04];
-	__be32	ddrdllcr;	/* 0x.0e10 - DDR DLL Control Register */
+	u32	ddrdllcr;	/* 0x.0e10 - DDR DLL Control Register */
 	u8	rese14[0xe20 - 0xe14];
-	__be32	lbcdllcr;	/* 0x.0e20 - LBC DLL Control Register */
-	__be32  cpfor;		/* 0x.0e24 - L2 charge pump fuse override register */
+	u32	lbcdllcr;	/* 0x.0e20 - LBC DLL Control Register */
+	u32	cpfor;		/* 0x.0e24 - L2 charge pump fuse override
+				 *           register
+				 */
 	u8	rese28[0xf04 - 0xe28];
-	__be32	srds1cr0;	/* 0x.0f04 - SerDes1 Control Register 0 */
-	__be32	srds1cr1;	/* 0x.0f08 - SerDes1 Control Register 0 */
+	u32	srds1cr0;	/* 0x.0f04 - SerDes1 Control Register 0 */
+	u32	srds1cr1;	/* 0x.0f08 - SerDes1 Control Register 0 */
 	u8	resf0c[0xf2c - 0xf0c];
-	__be32  itcr;		/* 0x.0f2c - Internal transaction control register */
+	u32	itcr;		/* 0x.0f2c - Internal transaction control
+				 *           register
+				 */
 	u8	resf30[0xf40 - 0xf30];
-	__be32	srds2cr0;	/* 0x.0f40 - SerDes2 Control Register 0 */
-	__be32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
+	u32	srds2cr0;	/* 0x.0f40 - SerDes2 Control Register 0 */
+	u32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
+u32 fsl_guts_get_svr(void);
+int fsl_guts_init(void);
 
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
-- 
2.7.4
