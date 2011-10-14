From: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Subject: [PATCH V5 2/3] ARM: SAMSUNG: Remove SDHCI bus clocks from platform data
Date: Fri, 14 Oct 2011 15:58:45 +0530
Message-ID: <1318588126-19167-3-git-send-email-rajeshwari.s@samsung.com>
References: <1318588126-19167-1-git-send-email-rajeshwari.s@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1318588126-19167-1-git-send-email-rajeshwari.s@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The bus clocks previously sent through platform data to SDHCI controller
are removed.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-exynos4/Makefile             |    1 -
 arch/arm/mach-exynos4/setup-sdhci.c        |   22 -------------------
 arch/arm/mach-s3c2416/Makefile             |    1 -
 arch/arm/mach-s3c2416/setup-sdhci.c        |   24 ---------------------
 arch/arm/mach-s3c64xx/Makefile             |    1 -
 arch/arm/mach-s3c64xx/setup-sdhci.c        |   24 ---------------------
 arch/arm/mach-s5pc100/Makefile             |    1 -
 arch/arm/mach-s5pc100/setup-sdhci.c        |   23 --------------------
 arch/arm/mach-s5pv210/Makefile             |    1 -
 arch/arm/mach-s5pv210/setup-sdhci.c        |   22 -------------------
 arch/arm/plat-samsung/include/plat/sdhci.h |   31 ----------------------------
 11 files changed, 0 insertions(+), 151 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c64xx/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 2bb18f4..c47aae3 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -55,7 +55,6 @@ obj-$(CONFIG_EXYNOS4_SETUP_I2C5)	+= setup-i2c5.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C6)	+= setup-i2c6.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C7)	+= setup-i2c7.o
 obj-$(CONFIG_EXYNOS4_SETUP_KEYPAD)	+= setup-keypad.o
-obj-$(CONFIG_EXYNOS4_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_EXYNOS4_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 obj-$(CONFIG_EXYNOS4_SETUP_USB_PHY)	+= setup-usb-phy.o
diff --git a/arch/arm/mach-exynos4/setup-sdhci.c b/arch/arm/mach-exynos4/setup-sdhci.c
deleted file mode 100644
index 92937b4..0000000
--- a/arch/arm/mach-exynos4/setup-sdhci.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/* linux/arch/arm/mach-exynos4/setup-sdhci.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - Helper functions for settign up SDHCI device(s) (HSMMC)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/types.h>
-
-/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
-
-char *exynos4_hsmmc_clksrcs[4] = {
-	[0] = NULL,
-	[1] = NULL,
-	[2] = "sclk_mmc",	/* mmc_bus */
-	[3] = NULL,
-};
diff --git a/arch/arm/mach-s3c2416/Makefile b/arch/arm/mach-s3c2416/Makefile
index 7b805b2..ca0cd22 100644
--- a/arch/arm/mach-s3c2416/Makefile
+++ b/arch/arm/mach-s3c2416/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_S3C2416_PM)	+= pm.o
 #obj-$(CONFIG_S3C2416_DMA)	+= dma.o
 
 # Device setup
-obj-$(CONFIG_S3C2416_SETUP_SDHCI) += setup-sdhci.o
 obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 
 # Machine support
diff --git a/arch/arm/mach-s3c2416/setup-sdhci.c b/arch/arm/mach-s3c2416/setup-sdhci.c
deleted file mode 100644
index cee5395..0000000
--- a/arch/arm/mach-s3c2416/setup-sdhci.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/* linux/arch/arm/mach-s3c2416/setup-sdhci.c
- *
- * Copyright 2010 Promwad Innovation Company
- *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
- *
- * S3C2416 - Helper functions for settign up SDHCI device(s) (HSMMC)
- *
- * Based on mach-s3c64xx/setup-sdhci.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/types.h>
-
-/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
-
-char *s3c2416_hsmmc_clksrcs[4] = {
-	[0] = "hsmmc",
-	[1] = "hsmmc",
-	[2] = "hsmmc-if",
-	/* [3] = "48m", - note not successfully used yet */
-};
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index cfc0b99..e32093c 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
 obj-$(CONFIG_S3C64XX_SETUP_IDE) += setup-ide.o
 obj-$(CONFIG_S3C64XX_SETUP_KEYPAD) += setup-keypad.o
-obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci.c b/arch/arm/mach-s3c64xx/setup-sdhci.c
deleted file mode 100644
index c75a71b..0000000
--- a/arch/arm/mach-s3c64xx/setup-sdhci.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/setup-sdhci.c
- *
- * Copyright 2008 Simtec Electronics
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C6400/S3C6410 - Helper functions for settign up SDHCI device(s) (HSMMC)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/types.h>
-
-/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
-
-char *s3c64xx_hsmmc_clksrcs[4] = {
-	[0] = "hsmmc",
-	[1] = "hsmmc",
-	[2] = "mmc_bus",
-	/* [3] = "48m", - note not successfully used yet */
-};
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index a5e6e60..2320e54 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_S5PC100_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PC100_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PC100_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PC100_SETUP_KEYPAD)	+= setup-keypad.o
-obj-$(CONFIG_S5PC100_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # device support
diff --git a/arch/arm/mach-s5pc100/setup-sdhci.c b/arch/arm/mach-s5pc100/setup-sdhci.c
deleted file mode 100644
index 6418c6e..0000000
--- a/arch/arm/mach-s5pc100/setup-sdhci.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/setup-sdhci.c
- *
- * Copyright 2008 Samsung Electronics
- *
- * S5PC100 - Helper functions for settign up SDHCI device(s) (HSMMC)
- *
- * Based on mach-s3c6410/setup-sdhci.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/types.h>
-
-/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
-
-char *s5pc100_hsmmc_clksrcs[4] = {
-	[0] = "hsmmc",		/* HCLK */
-	/* [1] = "hsmmc",	- duplicate HCLK entry */
-	[2] = "sclk_mmc",	/* mmc_bus */
-	/* [3] = "48m",		- note not successfully used yet */
-};
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 009fbe5..53c346a 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -35,5 +35,4 @@ obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
 obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
-obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c b/arch/arm/mach-s5pv210/setup-sdhci.c
deleted file mode 100644
index 6b8ccc4..0000000
--- a/arch/arm/mach-s5pv210/setup-sdhci.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/setup-sdhci.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV210 - Helper functions for settign up SDHCI device(s) (HSMMC)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/types.h>
-
-/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
-
-char *s5pv210_hsmmc_clksrcs[4] = {
-	[0] = "hsmmc",		/* HCLK */
-	/* [1] = "hsmmc",	- duplicate HCLK entry */
-	[2] = "sclk_mmc",	/* mmc_bus */
-	/* [3] = NULL,		- reserved */
-};
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index e7b3c75..dcff7dd 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -66,8 +66,6 @@ struct s3c_sdhci_platdata {
 	enum cd_types	cd_type;
 	enum clk_types	clk_type;
 
-	char		**clocks;	/* set of clock sources */
-
 	int		ext_cd_gpio;
 	bool		ext_cd_gpio_invert;
 	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
@@ -129,12 +127,9 @@ extern void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
 /* S3C2416 SDHCI setup */
 
 #ifdef CONFIG_S3C2416_SETUP_SDHCI
-extern char *s3c2416_hsmmc_clksrcs[4];
-
 static inline void s3c2416_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c2416_setup_sdhci0_cfg_gpio;
 #endif /* CONFIG_S3C_DEV_HSMMC */
 }
@@ -142,7 +137,6 @@ static inline void s3c2416_default_sdhci0(void)
 static inline void s3c2416_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c2416_setup_sdhci1_cfg_gpio;
 #endif /* CONFIG_S3C_DEV_HSMMC1 */
 }
@@ -155,12 +149,9 @@ static inline void s3c2416_default_sdhci1(void) { }
 /* S3C64XX SDHCI setup */
 
 #ifdef CONFIG_S3C64XX_SETUP_SDHCI
-extern char *s3c64xx_hsmmc_clksrcs[4];
-
 static inline void s3c6400_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
 #endif
 }
@@ -168,7 +159,6 @@ static inline void s3c6400_default_sdhci0(void)
 static inline void s3c6400_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -176,7 +166,6 @@ static inline void s3c6400_default_sdhci1(void)
 static inline void s3c6400_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -184,7 +173,6 @@ static inline void s3c6400_default_sdhci2(void)
 static inline void s3c6410_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
 #endif
 }
@@ -192,7 +180,6 @@ static inline void s3c6410_default_sdhci0(void)
 static inline void s3c6410_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -200,7 +187,6 @@ static inline void s3c6410_default_sdhci1(void)
 static inline void s3c6410_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -218,12 +204,9 @@ static inline void s3c6400_default_sdhci2(void) { }
 /* S5PC100 SDHCI setup */
 
 #ifdef CONFIG_S5PC100_SETUP_SDHCI
-extern char *s5pc100_hsmmc_clksrcs[4];
-
 static inline void s5pc100_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s5pc100_setup_sdhci0_cfg_gpio;
 #endif
 }
@@ -231,7 +214,6 @@ static inline void s5pc100_default_sdhci0(void)
 static inline void s5pc100_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s5pc100_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -239,7 +221,6 @@ static inline void s5pc100_default_sdhci1(void)
 static inline void s5pc100_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s5pc100_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -254,12 +235,9 @@ static inline void s5pc100_default_sdhci2(void) { }
 /* S5PV210 SDHCI setup */
 
 #ifdef CONFIG_S5PV210_SETUP_SDHCI
-extern char *s5pv210_hsmmc_clksrcs[4];
-
 static inline void s5pv210_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s5pv210_setup_sdhci0_cfg_gpio;
 #endif
 }
@@ -267,7 +245,6 @@ static inline void s5pv210_default_sdhci0(void)
 static inline void s5pv210_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s5pv210_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -275,7 +252,6 @@ static inline void s5pv210_default_sdhci1(void)
 static inline void s5pv210_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s5pv210_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -283,7 +259,6 @@ static inline void s5pv210_default_sdhci2(void)
 static inline void s5pv210_default_sdhci3(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC3
-	s3c_hsmmc3_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv210_setup_sdhci3_cfg_gpio;
 #endif
 }
@@ -298,12 +273,9 @@ static inline void s5pv210_default_sdhci3(void) { }
 
 /* EXYNOS4 SDHCI setup */
 #ifdef CONFIG_EXYNOS4_SETUP_SDHCI
-extern char *exynos4_hsmmc_clksrcs[4];
-
 static inline void exynos4_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = exynos4_setup_sdhci0_cfg_gpio;
 #endif
 }
@@ -311,7 +283,6 @@ static inline void exynos4_default_sdhci0(void)
 static inline void exynos4_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = exynos4_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -319,7 +290,6 @@ static inline void exynos4_default_sdhci1(void)
 static inline void exynos4_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = exynos4_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -327,7 +297,6 @@ static inline void exynos4_default_sdhci2(void)
 static inline void exynos4_default_sdhci3(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC3
-	s3c_hsmmc3_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc3_def_platdata.cfg_gpio = exynos4_setup_sdhci3_cfg_gpio;
 #endif
 }
-- 
1.7.4.4
