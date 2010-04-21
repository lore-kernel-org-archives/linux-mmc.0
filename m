From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 4/7] OMAP4-HSMMC: Addind MMC-TWL regulator changes
Date: Wed, 21 Apr 2010 23:50:48 +0530 (IST)
Message-ID: <63579.10.24.255.18.1271874048.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33748 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990Ab0DUSU7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Apr 2010 14:20:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

This patch adds PBIAS Configuration during POWER ON and OFF.
Also it adds MMC1 Card detect configuration on Phoenix

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c               |  145 +++++++++++++++++++++++------
 arch/arm/plat-omap/include/plat/control.h |   17 ++++
 2 files changed, 134 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index ca3d4c9..7653434 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -26,11 +26,18 @@

 static u16 control_pbias_offset;
 static u16 control_devconf1_offset;
+static u16 control_mmc1;

 #define HSMMC_NAME_LEN	9

 /* Phoenix Registers */
-#define TWL6030_MMCCTRL	0xEE
+#define TWL6030_MMCCTRL		0xEE
+#define VMMC_AUTO_OFF		(0x1 << 3)
+#define SW_FC			(0x1 << 2)
+
+#define TWL6030_CFG_INPUT_PUPD3	0xF2
+#define MMC_PU			(0x1 << 3)
+#define MMC_PD			(0x1 << 2)

 static struct hsmmc_controller {
 	struct omap_mmc_platform_data   *mmc;
@@ -120,27 +127,38 @@ static void hsmmc1_before_set_reg(struct device *dev, int slot,
 				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
 			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
 		}
+		if (!cpu_is_omap44xx()) {
+			if (mmc->slots[0].internal_clock) {
+				reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+				reg |= OMAP2_MMCSDIO1ADPCLKISEL;
+				omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
+			}

-		if (mmc->slots[0].internal_clock) {
-			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
-			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
-		}
-
-		reg = omap_ctrl_readl(control_pbias_offset);
-		if (cpu_is_omap3630()) {
-			/* Set MMC I/O to 52Mhz */
-			prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
-			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
-			omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
+			reg = omap_ctrl_readl(control_pbias_offset);
+			if (cpu_is_omap3630()) {
+				/* Set MMC I/O to 52Mhz */
+				prog_io =
+				omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
+				prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
+				omap_ctrl_writel(prog_io,
+						OMAP343X_CONTROL_PROG_IO1);
+			} else {
+				reg |= OMAP2_PBIASSPEEDCTRL0;
+			}
+			reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		} else {
-			reg |= OMAP2_PBIASSPEEDCTRL0;
+			reg = omap_ctrl_readl(control_pbias_offset);
+			reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ |
+						OMAP4_MMC1_PWRDNZ);
 		}
-		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);
 	} else {
 		reg = omap_ctrl_readl(control_pbias_offset);
-		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
+		if (!cpu_is_omap44xx())
+			reg &= ~OMAP2_PBIASLITEPWRDNZ0;
+		else
+			reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ |
+					OMAP4_MMC1_PWRDNZ);
 		omap_ctrl_writel(reg, control_pbias_offset);
 	}
 }
@@ -155,16 +173,36 @@ static void hsmmc1_after_set_reg(struct device *dev, int slot,

 	if (power_on) {
 		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
-		if ((1 << vdd) <= MMC_VDD_165_195)
-			reg &= ~OMAP2_PBIASLITEVMODE0;
+		if (!cpu_is_omap44xx())
+			reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
 		else
-			reg |= OMAP2_PBIASLITEVMODE0;
+			reg |= OMAP4_MMC1_PBIASLITE_PWRDNZ;
+		if ((1 << vdd) <= MMC_VDD_165_195) {
+			if (!cpu_is_omap44xx()) {
+				reg &= ~OMAP2_PBIASLITEVMODE0;
+			} else {
+				reg &= ~OMAP4_MMC1_PBIASLITE_VMODE;
+				reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ |
+						OMAP4_MMC1_PWRDNZ);
+			}
+		} else {
+			if (!cpu_is_omap44xx())
+				reg |= OMAP2_PBIASLITEVMODE0;
+			else
+				reg |= (OMAP4_MMC1_PBIASLITE_VMODE |
+				OMAP4_MMC1_PBIASLITE_PWRDNZ |
+					OMAP4_MMC1_PWRDNZ);
+		}
 		omap_ctrl_writel(reg, control_pbias_offset);
 	} else {
 		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
-			OMAP2_PBIASLITEVMODE0);
+		if (!cpu_is_omap44xx())
+			reg |= (OMAP2_PBIASSPEEDCTRL0 |
+				OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASLITEVMODE0);
+		else
+			 reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ |
+				OMAP4_MMC1_PBIASLITE_VMODE |
+				OMAP4_MMC1_PWRDNZ);
 		omap_ctrl_writel(reg, control_pbias_offset);
 	}
 }
@@ -189,6 +227,41 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
 	}
 }

+static int mmc_twl_late_init(struct device *dev)
+{
+	int i;
+	u8  reg_val = 0;
+	unsigned res;
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
+		/* Acquire Card detect line for MMC1 */
+		if ((hsmmc[i].name == mmc->slots[0].name) && (i == 0)) {
+			if (twl_class_is_6030()) {
+				twl6030_interrupt_unmask(
+				TWL6030_MMCDETECT_INT_MASK,
+						REG_INT_MSK_LINE_B);
+				twl6030_interrupt_unmask(
+				TWL6030_MMCDETECT_INT_MASK,
+						REG_INT_MSK_STS_B);
+				/* Configuring Card detect for MMC on TWL6030 */
+				reg_val |= (SW_FC & ~VMMC_AUTO_OFF);
+				twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
+							TWL6030_MMCCTRL);
+				res = twl_i2c_read_u8(TWL6030_MODULE_ID0,
+					&reg_val, TWL6030_CFG_INPUT_PUPD3);
+				if (res < 0)
+					return -EINVAL;
+				reg_val = 0;
+				reg_val &= ~(MMC_PU | MMC_PD);
+				twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
+						TWL6030_CFG_INPUT_PUPD3);
+			}
+		}
+	}
+	return 0;
+}
+
 static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;

 void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
@@ -196,13 +269,28 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info
 	struct omap2_hsmmc_info *c;
 	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
 	int i;
+	u32 reg;

-	if (cpu_is_omap2430()) {
-		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
-		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
+	if (!cpu_is_omap44xx()) {
+		if (cpu_is_omap2430()) {
+			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
+			control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
+		} else {
+			control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
+			control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
+		}
 	} else {
-		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
-		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
+		control_pbias_offset = OMAP44XX_CONTROL_PBIAS_LITE;
+		control_mmc1 = OMAP44XX_CONTROL_MMC1;
+		reg = omap_ctrl_readl(control_mmc1);
+		reg |= (OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP0 |
+			OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP1);
+		reg &= ~(OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP2 |
+			OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP3);
+		reg |= (OMAP4_CONTROL_SDMMC1_DR0_SPEEDCTRL |
+			OMAP4_CONTROL_SDMMC1_DR1_SPEEDCTRL |
+			OMAP4_CONTROL_SDMMC1_DR2_SPEEDCTRL);
+		omap_ctrl_writel(reg, control_mmc1);
 	}

 	for (c = controllers; c->mmc; c++) {
@@ -235,6 +323,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info
 		mmc->slots[0].wires = c->wires;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
+		mmc->init = mmc_twl_late_init;

 		mmc->get_context_loss_count = hsmmc_get_context_loss;

diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index a56deee..2cd28a4 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -207,6 +207,9 @@
 /* 44xx control status register offset */
 #define OMAP44XX_CONTROL_STATUS		0x2c4

+/* 44xx-only CONTROL_GENERAL register offsets */
+#define OMAP44XX_CONTROL_MMC1           0x628
+#define OMAP44XX_CONTROL_PBIAS_LITE     0x600
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
  * that should be added.
@@ -252,6 +255,20 @@
 #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
 #define OMAP2_PBIASLITEVMODE0		(1 << 0)

+/* CONTROL_PBIAS_LITE bits for OMAP4 */
+#define OMAP4_MMC1_PWRDNZ                      (1 << 26)
+#define OMAP4_MMC1_PBIASLITE_HIZ_MODE           (1 << 25)
+#define OMAP4_MMC1_PBIASLITE_PWRDNZ             (1 << 22)
+#define OMAP4_MMC1_PBIASLITE_VMODE              (1 << 21)
+
+#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP0     (1 << 31)
+#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP1     (1 << 30)
+#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP2     (1 << 29)
+#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP3     (1 << 28)
+#define OMAP4_CONTROL_SDMMC1_DR0_SPEEDCTRL      (1 << 27)
+#define OMAP4_CONTROL_SDMMC1_DR1_SPEEDCTRL      (1 << 26)
+#define OMAP4_CONTROL_SDMMC1_DR2_SPEEDCTRL      (1 << 25)
+
 /* CONTROL_PROG_IO1 bits */
 #define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)

-- 
1.6.3.3

