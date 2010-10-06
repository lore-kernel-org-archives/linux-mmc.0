From: Jeongbae Seo <jeongbae.seo@samsung.com>
Subject: [PATCH V2 1/3] ARM: S5PV310: Add support HSMMC and SDHCI configuration
Date: Wed,  6 Oct 2010 15:00:44 +0900
Message-ID: <1286344846-21244-2-git-send-email-jeongbae.seo@samsung.com>
References: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org, cjb@laptop.org, Hyuk Lee <hyuk1.lee@samsung.com>, Jeongbae Seo <jeongbae.seo@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Hyuk Lee <hyuk1.lee@samsung.com>

This patch adds support HSMMC for S5PV310 and S5PC210 and
setup for HSMMC host controller and also related GPIO.
At most 4 channel can be used at the same time.
A user can configure SDHCI data bus as 8bit or 4bit.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
---
Changes since v1:
- Added drive strength handling in each SDMMC channel

 arch/arm/mach-s5pv310/Kconfig            |   39 ++++++++
 arch/arm/mach-s5pv310/Makefile           |    2 +
 arch/arm/mach-s5pv310/setup-sdhci-gpio.c |  152 ++++++++++++++++++++++++++++++
 arch/arm/mach-s5pv310/setup-sdhci.c      |   69 ++++++++++++++
 4 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/setup-sdhci-gpio.c
 create mode 100644 arch/arm/mach-s5pv310/setup-sdhci.c

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 9941852..8cb3dc5 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -24,6 +24,17 @@ config S5PV310_SETUP_I2C2
 	help
 	  Common setup code for i2c bus 2.
 
+config S5PV310_SETUP_SDHCI
+	bool
+	select S5PV310_SETUP_SDHCI_GPIO
+	help
+	  Internal helper functions for S5PV310 based SDHCI systems.
+
+config S5PV310_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+
 # machine support
 
 menu "S5PC210 Machines"
@@ -33,6 +44,11 @@ config MACH_SMDKC210
 	select CPU_S5PV310
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
+	select S3C_DEV_HSMMC3
+	select S5PV310_SETUP_SDHCI
 	help
 	  Machine support for Samsung SMDKC210
 	  S5PC210(MCP) is one of package option of S5PV310
@@ -53,9 +69,32 @@ config MACH_SMDKV310
 	select CPU_S5PV310
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
+	select S3C_DEV_HSMMC3
+	select S5PV310_SETUP_SDHCI
 	help
 	  Machine support for Samsung SMDKV310
 
 endmenu
 
+comment "Configuration for HSMMC bus width"
+
+menu "Use 8-bit bus width"
+
+config S5PV310_SDHCI_CH0_8BIT
+	bool "Channel 0 with 8-bit bus"
+	help
+	  Support HSMMC Channel 0 8-bit bus.
+	  If selected, Channel 1 is disabled.
+
+config S5PV310_SDHCI_CH2_8BIT
+	bool "Channel 2 with 8-bit bus"
+	help
+	  Support HSMMC Channel 2 8-bit bus.
+	  If selected, Channel 3 is disabled.
+
+endmenu
+
 endif
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index d17c8c7..a2fdc06 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -30,3 +30,5 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 
 obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
+obj-$(CONFIG_S5PV310_SETUP_SDHCI)	+= setup-sdhci.o
+obj-$(CONFIG_S5PV310_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5pv310/setup-sdhci-gpio.c b/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
new file mode 100644
index 0000000..86d38cc
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
@@ -0,0 +1,152 @@
+/* linux/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/regs-sdhci.h>
+#include <plat/sdhci.h>
+
+void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+	unsigned int gpio;
+
+	/* Set all the necessary GPK0[0:1] pins to special-function 2 */
+	for (gpio = S5PV310_GPK0(0); gpio < S5PV310_GPK0(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	switch (width) {
+	case 8:
+		for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
+			/* Data pin GPK1[3:6] to special-funtion 3 */
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+		}
+	case 4:
+		for (gpio = S5PV310_GPK0(3); gpio <= S5PV310_GPK0(6); gpio++) {
+			/* Data pin GPK0[3:6] to special-funtion 2 */
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+		}
+	default:
+		break;
+	}
+
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_cfgpin(S5PV310_GPK0(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5PV310_GPK0(2), S3C_GPIO_PULL_UP);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+}
+
+void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+	unsigned int gpio;
+
+	/* Set all the necessary GPK1[0:1] pins to special-function 2 */
+	for (gpio = S5PV310_GPK1(0); gpio < S5PV310_GPK1(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
+		/* Data pin GPK1[3:6] to special-function 2 */
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_cfgpin(S5PV310_GPK1(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5PV310_GPK1(2), S3C_GPIO_PULL_UP);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+}
+
+void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+	unsigned int gpio;
+
+	/* Set all the necessary GPK2[0:1] pins to special-function 2 */
+	for (gpio = S5PV310_GPK2(0); gpio < S5PV310_GPK2(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	switch (width) {
+	case 8:
+		for (gpio = S5PV310_GPK3(3); gpio <= S5PV310_GPK3(6); gpio++) {
+			/* Data pin GPK3[3:6] to special-function 3 */
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+		}
+	case 4:
+		for (gpio = S5PV310_GPK2(3); gpio <= S5PV310_GPK2(6); gpio++) {
+			/* Data pin GPK2[3:6] to special-function 2 */
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+			s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+		}
+	default:
+		break;
+	}
+
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_cfgpin(S5PV310_GPK2(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5PV310_GPK2(2), S3C_GPIO_PULL_UP);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+}
+
+void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+	unsigned int gpio;
+
+	/* Set all the necessary GPK3[0:1] pins to special-function 2 */
+	for (gpio = S5PV310_GPK3(0); gpio < S5PV310_GPK3(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PV310_GPK3(3); gpio <= S5PV310_GPK3(6); gpio++) {
+		/* Data pin GPK3[3:6] to special-function 2 */
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_cfgpin(S5PV310_GPK3(2), S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(S5PV310_GPK3(2), S3C_GPIO_PULL_UP);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+}
diff --git a/arch/arm/mach-s5pv310/setup-sdhci.c b/arch/arm/mach-s5pv310/setup-sdhci.c
new file mode 100644
index 0000000..db8358f
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-sdhci.c
@@ -0,0 +1,69 @@
+/* linux/arch/arm/mach-s5pv310/setup-sdhci.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - Helper functions for settign up SDHCI device(s) (HSMMC)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include <plat/regs-sdhci.h>
+
+/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
+
+char *s5pv310_hsmmc_clksrcs[4] = {
+	[0] = NULL,
+	[1] = NULL,
+	[2] = "sclk_mmc",	/* mmc_bus */
+	[3] = NULL,
+};
+
+void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev, void __iomem *r,
+				  struct mmc_ios *ios, struct mmc_card *card)
+{
+	u32 ctrl2, ctrl3;
+
+	/* don't need to alter anything acording to card-type */
+
+	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
+
+	/* select base clock source to HCLK */
+
+	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
+
+	/*
+	 * clear async mode, enable conflict mask, rx feedback ctrl, SD
+	 * clk hold and no use debounce count
+	 */
+
+	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
+		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
+		  S3C_SDHCI_CTRL2_ENFBCLKRX |
+		  S3C_SDHCI_CTRL2_DFCNT_NONE |
+		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
+
+	/* Tx and Rx feedback clock delay control */
+
+	if (ios->clock < 25 * 1000000)
+		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
+			 S3C_SDHCI_CTRL3_FCSEL2 |
+			 S3C_SDHCI_CTRL3_FCSEL1 |
+			 S3C_SDHCI_CTRL3_FCSEL0);
+	else
+		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
+
+	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
+	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
+}
-- 
1.6.2.5
