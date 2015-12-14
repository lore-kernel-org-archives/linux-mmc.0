From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 1/6] soc: fsl: add GUTS driver for QorIQ platforms
Date: Mon, 14 Dec 2015 12:24:22 +0800
Message-ID: <1450067067-44869-2-git-send-email-yangbo.lu@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0105.outbound.protection.outlook.com ([65.55.169.105]:29340
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752261AbbLNErP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Dec 2015 23:47:15 -0500
In-Reply-To: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: scottwood@freescale.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

The global utilities block controls power management, I/O device
enabling, power-onreset(POR) configuration monitoring, alternate
function selection for multiplexed signals,and clock control.

This patch adds GUTS driver to manage and access global utilities
block.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
Changes for v4:
	- Added this patch
---
 drivers/soc/Kconfig      |   1 +
 drivers/soc/Makefile     |   1 +
 drivers/soc/fsl/Kconfig  |  19 ++++++++
 drivers/soc/fsl/Makefile |   4 ++
 drivers/soc/fsl/guts.c   | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fsl/guts.h | 103 +++++++++++++++++++++++--------------------
 6 files changed, 192 insertions(+), 48 deletions(-)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/Makefile
 create mode 100644 drivers/soc/fsl/guts.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 4e853ed..68b5b90 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -7,5 +7,6 @@ source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/versatile/Kconfig"
+source "drivers/soc/fsl/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index f2ba2e9..2747e58 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
+obj-$(CONFIG_SOC_FSL)		+= fsl/
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
new file mode 100644
index 0000000..09966f0
--- /dev/null
+++ b/drivers/soc/fsl/Kconfig
@@ -0,0 +1,19 @@
+#
+# FSL SOC drivers
+#
+menuconfig SOC_FSL
+	bool "Freescale SOC drivers support"
+
+if SOC_FSL
+
+config FSL_GUTS
+	tristate "QorIQ Platforms GUTS Driver"
+	help
+	  Say y here to enable Freescale QorIQ platforms GUTS driver support.
+	  The global utilities block controls power management, I/O device
+	  enabling, power-onreset(POR) configuration monitoring, alternate
+	  function selection for multiplexed signals,and clock control.
+
+	  If unsure, say N.
+
+endif # SOC_FSL
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
new file mode 100644
index 0000000..51e5c73
--- /dev/null
+++ b/drivers/soc/fsl/Makefile
@@ -0,0 +1,4 @@
+#
+# Freescale SOC drivers
+#
+obj-$(CONFIG_FSL_GUTS)	+= guts.o
diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
new file mode 100644
index 0000000..68e3367
--- /dev/null
+++ b/drivers/soc/fsl/guts.c
@@ -0,0 +1,112 @@
+/*
+ * Freescale QorIQ Platforms GUTS Driver
+ *
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * Author: Yangbo Lu <yangbo.lu@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/fsl/guts.h>
+
+/*
+ * Table for matching compatible strings, for device tree
+ * guts node, for Freescale QorIQ SOCs.
+ * "fsl,qoriq-device-config-2.0" corresponds to T4 & B4
+ * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
+ * string would be used.
+ */
+static const struct of_device_id guts_device_ids[] = {
+	{ .compatible = "fsl,qoriq-device-config-1.0", },
+	{ .compatible = "fsl,qoriq-device-config-2.0", },
+	{}
+};
+
+struct ccsr_guts __iomem *guts_regmap(void)
+{
+	struct device_node *guts_node;
+	struct ccsr_guts __iomem *guts;
+
+	guts_node = of_find_matching_node(NULL, guts_device_ids);
+	if (!guts_node)
+		return NULL;
+
+	guts = of_iomap(guts_node, 0);
+	if (!guts)
+		return NULL;
+
+	of_node_put(guts_node);
+	return guts;
+}
+EXPORT_SYMBOL_GPL(guts_regmap);
+
+u8 guts_get_reg8(void __iomem *reg)
+{
+	u8 val;
+
+	val = ioread8(reg);
+	return val;
+}
+EXPORT_SYMBOL_GPL(guts_get_reg8);
+
+void guts_set_reg8(void __iomem *reg, u8 value)
+{
+	iowrite8(value, reg);
+}
+EXPORT_SYMBOL_GPL(guts_set_reg8);
+
+u32 guts_get_reg32(void __iomem *reg)
+{
+	struct device_node *guts_node;
+	u32 val;
+
+	guts_node = of_find_matching_node(NULL, guts_device_ids);
+	if (!guts_node)
+		return 0;
+
+	if (of_property_read_bool(guts_node, "little-endian"))
+		val = ioread32(reg);
+	else
+		val = ioread32be(reg);
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(guts_get_reg32);
+
+void guts_set_reg32(void __iomem *reg, u32 value)
+{
+	struct device_node *guts_node;
+
+	guts_node = of_find_matching_node(NULL, guts_device_ids);
+	if (!guts_node)
+		return;
+
+	if (of_property_read_bool(guts_node, "little-endian"))
+		iowrite32(value, reg);
+	else
+		iowrite32be(value, reg);
+}
+EXPORT_SYMBOL_GPL(guts_set_reg32);
+
+static int __init guts_drv_init(void)
+{
+	pr_info("guts: Freescale QorIQ Platforms GUTS Driver\n");
+	return 0;
+}
+module_init(guts_drv_init);
+
+static void __exit guts_drv_exit(void)
+{
+}
+module_exit(guts_drv_exit);
+
+MODULE_AUTHOR("Yangbo Lu <yangbo.lu@freescale.com>");
+MODULE_DESCRIPTION("Freescale QorIQ Platforms GUTS Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index 84d971f..e3ae0af 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -29,83 +29,90 @@
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
+	u32	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and Control Register */
+	u32	pordevsr;	/* 0x.000c - POR I/O Device Status Register */
+	u32	pordbgmsr;	/* 0x.0010 - POR Debug Mode Status Register */
+	u32	pordevsr2;	/* 0x.0014 - POR device status register 2 */
 	u8	res018[0x20 - 0x18];
-	__be32	porcir;		/* 0x.0020 - POR Configuration Information Register */
+	u32	porcir;		/* 0x.0020 - POR Configuration Information Register */
 	u8	res024[0x30 - 0x24];
-	__be32	gpiocr;		/* 0x.0030 - GPIO Control Register */
+	u32	gpiocr;		/* 0x.0030 - GPIO Control Register */
 	u8	res034[0x40 - 0x34];
-	__be32	gpoutdr;	/* 0x.0040 - General-Purpose Output Data Register */
+	u32	gpoutdr;	/* 0x.0040 - General-Purpose Output Data Register */
 	u8	res044[0x50 - 0x44];
-	__be32	gpindr;		/* 0x.0050 - General-Purpose Input Data Register */
+	u32	gpindr;		/* 0x.0050 - General-Purpose Input Data Register */
 	u8	res054[0x60 - 0x54];
-	__be32	pmuxcr;		/* 0x.0060 - Alternate Function Signal Multiplex Control */
-        __be32  pmuxcr2;	/* 0x.0064 - Alternate function signal multiplex control 2 */
-        __be32  dmuxcr;		/* 0x.0068 - DMA Mux Control Register */
+	u32	pmuxcr;		/* 0x.0060 - Alternate Function Signal Multiplex Control */
+	u32	pmuxcr2;	/* 0x.0064 - Alternate function signal multiplex control 2 */
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
+	u32	pmjcr;		/* 0x.007c - 4 Power Management Jog Control Register */
+	u32	powmgtcsr;	/* 0x.0080 - Power Management Status and Control Register */
+	u32	pmrccr;		/* 0x.0084 - Power Management Reset Counter Configuration Register */
+	u32	pmpdccr;	/* 0x.0088 - Power Management Power Down Counter Configuration Register */
+	u32	pmcdr;		/* 0x.008c - 4Power management clock disable register */
+	u32	mcpsumr;	/* 0x.0090 - Machine Check Summary Register */
+	u32	rstrscr;	/* 0x.0094 - Reset Request Status and Control Register */
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
+	u32	cpfor;		/* 0x.0e24 - L2 charge pump fuse override register */
 	u8	rese28[0xf04 - 0xe28];
-	__be32	srds1cr0;	/* 0x.0f04 - SerDes1 Control Register 0 */
-	__be32	srds1cr1;	/* 0x.0f08 - SerDes1 Control Register 0 */
+	u32	srds1cr0;	/* 0x.0f04 - SerDes1 Control Register 0 */
+	u32	srds1cr1;	/* 0x.0f08 - SerDes1 Control Register 0 */
 	u8	resf0c[0xf2c - 0xf0c];
-	__be32  itcr;		/* 0x.0f2c - Internal transaction control register */
+	u32	itcr;		/* 0x.0f2c - Internal transaction control register */
 	u8	resf30[0xf40 - 0xf30];
-	__be32	srds2cr0;	/* 0x.0f40 - SerDes2 Control Register 0 */
-	__be32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
+	u32	srds2cr0;	/* 0x.0f40 - SerDes2 Control Register 0 */
+	u32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
+#ifdef CONFIG_FSL_GUTS
+extern struct ccsr_guts __iomem *guts_regmap(void);
+extern void guts_set_reg8(void __iomem *reg, u8 value);
+extern void guts_set_reg32(void __iomem *reg, u32 value);
+extern u8 guts_get_reg8(void __iomem *reg);
+extern u32 guts_get_reg32(void __iomem *reg);
+#endif
 
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
-- 
2.1.0.27.g96db324

