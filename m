From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 3/3] Move MMCI header to amba include dir
Date: Wed,  9 Sep 2009 22:55:27 +0200
Message-ID: <1252529727-7957-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:56809 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753902AbZIIUzz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Sep 2009 16:55:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@stericsson.com>

This moves the mmci platform data definition struct away from
arch/arm/include/asm/mach/mmc.h into the more proper place among
the other primecells in include/linux/amba/mmci.h and at the same
time renames it to "mmci.h", and also the struct in this file
confusingly named mmc_platform_data has been renamed
mmci_platform_data for clarity.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/include/asm/mach/mmc.h          |   18 ------------------
 arch/arm/mach-integrator/integrator_cp.c |    4 ++--
 arch/arm/mach-realview/core.c            |    6 +++---
 arch/arm/mach-realview/core.h            |    4 ++--
 arch/arm/mach-u300/mmc.c                 |    4 ++--
 arch/arm/mach-versatile/core.c           |    2 +-
 arch/arm/mach-versatile/versatile_pb.c   |    4 ++--
 drivers/mmc/host/mmci.c                  |    4 ++--
 drivers/mmc/host/mmci.h                  |    2 +-
 include/linux/amba/mmci.h                |   18 ++++++++++++++++++
 10 files changed, 33 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach/mmc.h
 create mode 100644 include/linux/amba/mmci.h

diff --git a/arch/arm/include/asm/mach/mmc.h b/arch/arm/include/asm/mach/mmc.h
deleted file mode 100644
index 27bec55..0000000
--- a/arch/arm/include/asm/mach/mmc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  arch/arm/include/asm/mach/mmc.h
- */
-#ifndef ASMARM_MACH_MMC_H
-#define ASMARM_MACH_MMC_H
-
-#include <linux/mmc/host.h>
-
-struct mmc_platform_data {
-	unsigned int ocr_mask;			/* available voltages */
-	u32 (*translate_vdd)(struct device *, unsigned int);
-	unsigned int (*status)(struct device *);
-	int	gpio_wp;
-	int	gpio_cd;
-	unsigned long capabilities;
-};
-
-#endif
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 2a318eb..3f35293 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -19,6 +19,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/kmi.h>
 #include <linux/amba/clcd.h>
+#include <linux/amba/mmci.h>
 #include <linux/io.h>
 
 #include <asm/clkdev.h>
@@ -35,7 +36,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
-#include <asm/mach/mmc.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
@@ -400,7 +400,7 @@ static unsigned int mmc_status(struct device *dev)
 	return status & 8;
 }
 
-static struct mmc_platform_data mmc_data = {
+static struct mmci_platform_data mmc_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.status		= mmc_status,
 	.gpio_wp	= -1,
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index dc3519c..e98b3f3 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -30,6 +30,7 @@
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/ata_platform.h>
+#include <linux/amba/mmci.h>
 
 #include <asm/clkdev.h>
 #include <asm/system.h>
@@ -44,7 +45,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
-#include <asm/mach/mmc.h>
 
 #include <asm/hardware/gic.h>
 
@@ -237,14 +237,14 @@ static unsigned int realview_mmc_status(struct device *dev)
 	return readl(REALVIEW_SYSMCI) & mask;
 }
 
-struct mmc_platform_data realview_mmc0_plat_data = {
+struct mmci_platform_data realview_mmc0_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.status		= realview_mmc_status,
 	.gpio_wp	= 17,
 	.gpio_cd	= 16,
 };
 
-struct mmc_platform_data realview_mmc1_plat_data = {
+struct mmci_platform_data realview_mmc1_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.status		= realview_mmc_status,
 	.gpio_wp	= 19,
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 59a337b..46cd6ac 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -47,8 +47,8 @@ static struct amba_device name##_device = {			\
 extern struct platform_device realview_flash_device;
 extern struct platform_device realview_cf_device;
 extern struct platform_device realview_i2c_device;
-extern struct mmc_platform_data realview_mmc0_plat_data;
-extern struct mmc_platform_data realview_mmc1_plat_data;
+extern struct mmci_platform_data realview_mmc0_plat_data;
+extern struct mmci_platform_data realview_mmc1_plat_data;
 extern struct clcd_board clcd_plat_data;
 extern void __iomem *gic_cpu_base_addr;
 extern void __iomem *timer0_va_base;
diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index 82af247..70f0ca5 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -20,7 +20,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
 
-#include <asm/mach/mmc.h>
+#include <linux/amba/mmci.h>
 #include "mmc.h"
 #include "padmux.h"
 
@@ -28,7 +28,7 @@ struct mmci_card_event {
 	struct input_dev *mmc_input;
 	int mmc_inserted;
 	struct work_struct workq;
-	struct mmc_platform_data mmc0_plat_data;
+	struct mmci_platform_data mmc0_plat_data;
 };
 
 static unsigned int mmc_status(struct device *dev)
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 975eae4..7b4b7d6 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -27,6 +27,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 #include <linux/amba/pl061.h>
+#include <linux/amba/mmci.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cnt32_to_63.h>
@@ -47,7 +48,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <asm/mach/mmc.h>
 
 #include "core.h"
 #include "clock.h"
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 9af8d81..239cd30 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -24,6 +24,7 @@
 #include <linux/sysdev.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
+#include <linux/amba/mmci.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -31,7 +32,6 @@
 #include <asm/mach-types.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/mmc.h>
 
 #include "core.h"
 
@@ -41,7 +41,7 @@
 #define IRQ_MMCI1A	IRQ_SIC_MMCI1A
 #endif
 
-static struct mmc_platform_data mmc1_plat_data = {
+static struct mmci_platform_data mmc1_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.status		= mmc_status,
 	.gpio_wp	= -1,
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index cee91e9..c78e478 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -22,12 +22,12 @@
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
 #include <linux/gpio.h>
+#include <linux/amba/mmci.h>
 
 #include <asm/cacheflush.h>
 #include <asm/div64.h>
 #include <asm/io.h>
 #include <asm/sizes.h>
-#include <asm/mach/mmc.h>
 
 #include "mmci.h"
 
@@ -537,7 +537,7 @@ static void mmci_check_status(unsigned long data)
 
 static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 {
-	struct mmc_platform_data *plat = dev->dev.platform_data;
+	struct mmci_platform_data *plat = dev->dev.platform_data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
 	int ret;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 839f264..a7f9a51 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -161,7 +161,7 @@ struct mmci_host {
 	unsigned int		mclk;
 	unsigned int		cclk;
 	u32			pwr;
-	struct mmc_platform_data *plat;
+	struct mmci_platform_data *plat;
 
 	u8			hw_designer;
 	u8			hw_revision:4;
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
new file mode 100644
index 0000000..6b42417
--- /dev/null
+++ b/include/linux/amba/mmci.h
@@ -0,0 +1,18 @@
+/*
+ *  include/linux/amba/mmci.h
+ */
+#ifndef AMBA_MMCI_H
+#define AMBA_MMCI_H
+
+#include <linux/mmc/host.h>
+
+struct mmci_platform_data {
+	unsigned int ocr_mask;			/* available voltages */
+	u32 (*translate_vdd)(struct device *, unsigned int);
+	unsigned int (*status)(struct device *);
+	int	gpio_wp;
+	int	gpio_cd;
+	unsigned long capabilities;
+};
+
+#endif
-- 
1.6.2.1

