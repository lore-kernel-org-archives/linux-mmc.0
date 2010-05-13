From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v3 4/5] OMAP4 HSMMC: Adding PBIAS Configuration for MMC1
     Controller
Date: Fri, 14 May 2010 01:41:58 +0530 (IST)
Message-ID: <12498.10.24.255.17.1273781518.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41648 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907Ab0EMUMN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 May 2010 16:12:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, manjugk@ti.com

In OMAP4 , MMC1 PBIAS and its associated IO is software-controlled
by CONTROL_PBIAS and CONTROL_MMC1 registers. This patch adds PBIAS
configuration for MMC1 Controller during power-ON and power-OFF
of regulator.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c               |  100 +++++++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/control.h |   20 ++++++
 2 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 679188c..0d7fffb 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -24,6 +24,7 @@

 static u16 control_pbias_offset;
 static u16 control_devconf1_offset;
+static u16 control_mmc1;

 #define HSMMC_NAME_LEN	9

@@ -42,7 +43,7 @@ static int hsmmc_get_context_loss(struct device *dev)
 #define hsmmc_get_context_loss NULL
 #endif

-static void hsmmc1_before_set_reg(struct device *dev, int slot,
+static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
 	u32 reg, prog_io;
@@ -95,7 +96,7 @@ static void hsmmc1_before_set_reg(struct device *dev, int slot,
 	}
 }

-static void hsmmc1_after_set_reg(struct device *dev, int slot,
+static void omap_hsmmc1_after_set_reg(struct device *dev, int slot,
 				 int power_on, int vdd)
 {
 	u32 reg;
@@ -119,6 +120,60 @@ static void hsmmc1_after_set_reg(struct device *dev, int slot,
 	}
 }

+static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
+				  int power_on, int vdd)
+{
+	u32 reg;
+
+	/*
+	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
+	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
+	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
+	 *
+	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
+	 * is most naturally TWL VSIM; those pins also use PBIAS.
+	 *
+	 * FIXME handle VMMC1A as needed ...
+	 */
+	reg = omap_ctrl_readl(control_pbias_offset);
+	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ | OMAP4_MMC1_PWRDNZ |
+					OMAP4_USBC1_ICUSB_PWRDNZ);
+	omap_ctrl_writel(reg, control_pbias_offset);
+}
+
+static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
+				 int power_on, int vdd)
+{
+	u32 reg;
+
+	if (power_on) {
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg |= OMAP4_MMC1_PBIASLITE_PWRDNZ;
+		if ((1 << vdd) <= MMC_VDD_165_195)
+			reg &= ~OMAP4_MMC1_PBIASLITE_VMODE;
+		else
+			reg |= OMAP4_MMC1_PBIASLITE_VMODE;
+		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ | OMAP4_MMC1_PWRDNZ |
+						OMAP4_USBC1_ICUSB_PWRDNZ);
+		omap_ctrl_writel(reg, control_pbias_offset);
+		/* 4 microsec delay for comparator to generate an error*/
+		udelay(4);
+		reg = omap_ctrl_readl(control_pbias_offset);
+		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR) {
+			pr_err("Pbias Voltage is not same as LDO\n");
+			/* Caution : On VMODE_ERROR Power Down MMC IO */
+			reg &= ~(OMAP4_MMC1_PWRDNZ | OMAP4_USBC1_ICUSB_PWRDNZ);
+			omap_ctrl_writel(reg, control_pbias_offset);
+		}
+	} else {
+		reg = omap_ctrl_readl(control_pbias_offset);
+		 reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ |
+			OMAP4_MMC1_PBIASLITE_VMODE | OMAP4_MMC1_PWRDNZ |
+			OMAP4_USBC1_ICUSB_PWRDNZ);
+		omap_ctrl_writel(reg, control_pbias_offset);
+	}
+}
+
 static void hsmmc23_before_set_reg(struct device *dev, int slot,
 				   int power_on, int vdd)
 {
@@ -146,13 +201,28 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
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
@@ -219,10 +289,18 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)

 		switch (c->mmc) {
 		case 1:
-			/* on-chip level shifting via PBIAS0/PBIAS1 */
-			mmc->slots[0].before_set_reg = hsmmc1_before_set_reg;
-			mmc->slots[0].after_set_reg = hsmmc1_after_set_reg;
-
+			if (cpu_is_omap44xx()) {
+				/* on-chip level shifting via PBIAS0/PBIAS1 */
+				mmc->slots[0].before_set_reg =
+						omap4_hsmmc1_before_set_reg;
+				mmc->slots[0].after_set_reg =
+						omap4_hsmmc1_after_set_reg;
+			} else {
+				mmc->slots[0].before_set_reg =
+						omap_hsmmc1_before_set_reg;
+				mmc->slots[0].after_set_reg =
+						omap_hsmmc1_after_set_reg;
+			}
 			/* Omap3630 HSMMC1 supports only 4-bit */
 			if (cpu_is_omap3630() && c->wires > 4) {
 				c->wires = 4;
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index a56deee..3bcf78d 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -207,6 +207,9 @@
 /* 44xx control status register offset */
 #define OMAP44XX_CONTROL_STATUS		0x2c4

+/* 44xx-only CONTROL_GENERAL register offsets */
+#define OMAP44XX_CONTROL_MMC1		0x628
+#define OMAP44XX_CONTROL_PBIAS_LITE	0x600
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
  * that should be added.
@@ -252,6 +255,23 @@
 #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
 #define OMAP2_PBIASLITEVMODE0		(1 << 0)

+/* CONTROL_PBIAS_LITE bits for OMAP4 */
+#define OMAP4_MMC1_PWRDNZ			(1 << 26)
+#define OMAP4_MMC1_PBIASLITE_HIZ_MODE		(1 << 25)
+#define OMAP4_MMC1_PBIASLITE_SUPPLY_HI_OUT	(1 << 24)
+#define OMAP4_MMC1_PBIASLITE_VMODE_ERROR	(1 << 23)
+#define OMAP4_MMC1_PBIASLITE_PWRDNZ		(1 << 22)
+#define OMAP4_MMC1_PBIASLITE_VMODE		(1 << 21)
+#define OMAP4_USBC1_ICUSB_PWRDNZ		(1 << 20)
+
+#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP0	(1 << 31)
+#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP1	(1 << 30)
+#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP2	(1 << 29)
+#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP3	(1 << 28)
+#define OMAP4_CONTROL_SDMMC1_DR0_SPEEDCTRL	(1 << 27)
+#define OMAP4_CONTROL_SDMMC1_DR1_SPEEDCTRL	(1 << 26)
+#define OMAP4_CONTROL_SDMMC1_DR2_SPEEDCTRL	(1 << 25)
+
 /* CONTROL_PROG_IO1 bits */
 #define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)

-- 
1.6.3.3


