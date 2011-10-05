From: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Subject: [PATCH 2/3] ARM: SAMSUNG: Remove SDHCI bus clocks from platform data
Date: Wed, 05 Oct 2011 11:01:08 +0530
Message-ID: <1317792669-19925-3-git-send-email-rajeshwari.s@samsung.com>
References: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
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
index e19cd12..c18531f 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_EXYNOS4_SETUP_I2C5)	+= setup-i2c5.o
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
index 902ab9a..94de24b 100644
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
index ef7e466..bb5f438 100644
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
index 39a70ec..12f962d 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -61,8 +61,6 @@ struct s3c_sdhci_platdata {
 	unsigned int	host_caps;
 	enum cd_types	cd_type;
 
-	char		**clocks;	/* set of clock sources */
-
 	int		ext_cd_gpio;
 	bool		ext_cd_gpio_invert;
 	int	(*ext_cd_init)(void (*notify_func)(struct platform_device *,
@@ -124,12 +122,9 @@ extern void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
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
@@ -137,7 +132,6 @@ static inline void s3c2416_default_sdhci0(void)
 static inline void s3c2416_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c2416_setup_sdhci1_cfg_gpio;
 #endif /* CONFIG_S3C_DEV_HSMMC1 */
 }
@@ -150,12 +144,9 @@ static inline void s3c2416_default_sdhci1(void) { }
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
@@ -163,7 +154,6 @@ static inline void s3c6400_default_sdhci0(void)
 static inline void s3c6400_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -171,7 +161,6 @@ static inline void s3c6400_default_sdhci1(void)
 static inline void s3c6400_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -179,7 +168,6 @@ static inline void s3c6400_default_sdhci2(void)
 static inline void s3c6410_default_sdhci0(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
 #endif
 }
@@ -187,7 +175,6 @@ static inline void s3c6410_default_sdhci0(void)
 static inline void s3c6410_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -195,7 +182,6 @@ static inline void s3c6410_default_sdhci1(void)
 static inline void s3c6410_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -213,12 +199,9 @@ static inline void s3c6400_default_sdhci2(void) { }
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
@@ -226,7 +209,6 @@ static inline void s5pc100_default_sdhci0(void)
 static inline void s5pc100_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s5pc100_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -234,7 +216,6 @@ static inline void s5pc100_default_sdhci1(void)
 static inline void s5pc100_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s5pc100_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -249,12 +230,9 @@ static inline void s5pc100_default_sdhci2(void) { }
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
@@ -262,7 +240,6 @@ static inline void s5pv210_default_sdhci0(void)
 static inline void s5pv210_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = s5pv210_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -270,7 +247,6 @@ static inline void s5pv210_default_sdhci1(void)
 static inline void s5pv210_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = s5pv210_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -278,7 +254,6 @@ static inline void s5pv210_default_sdhci2(void)
 static inline void s5pv210_default_sdhci3(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC3
-	s3c_hsmmc3_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
 	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv210_setup_sdhci3_cfg_gpio;
 #endif
 }
@@ -293,12 +268,9 @@ static inline void s5pv210_default_sdhci3(void) { }
 
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
@@ -306,7 +278,6 @@ static inline void exynos4_default_sdhci0(void)
 static inline void exynos4_default_sdhci1(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc1_def_platdata.cfg_gpio = exynos4_setup_sdhci1_cfg_gpio;
 #endif
 }
@@ -314,7 +285,6 @@ static inline void exynos4_default_sdhci1(void)
 static inline void exynos4_default_sdhci2(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc2_def_platdata.cfg_gpio = exynos4_setup_sdhci2_cfg_gpio;
 #endif
 }
@@ -322,7 +292,6 @@ static inline void exynos4_default_sdhci2(void)
 static inline void exynos4_default_sdhci3(void)
 {
 #ifdef CONFIG_S3C_DEV_HSMMC3
-	s3c_hsmmc3_def_platdata.clocks = exynos4_hsmmc_clksrcs;
 	s3c_hsmmc3_def_platdata.cfg_gpio = exynos4_setup_sdhci3_cfg_gpio;
 #endif
 }
-- 
1.6.6.rc2
