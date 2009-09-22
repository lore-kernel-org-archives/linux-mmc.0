From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] Move MMCI header to amba include dir
Date: Tue, 22 Sep 2009 15:26:12 +0200
Message-ID: <1253625972-19407-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:45558 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753659AbZIVN0d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Sep 2009 09:26:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Catalin Marinas <catalin.marinas@arm.com>

This moves the mmci platform data definition struct away from
arch/arm/include/asm/mach/mmc.h into the more proper place among
the other primecells in include/linux/amba/mmci.h and at the same
time renames it to "mmci.h", and also the struct in this file
confusingly named mmc_platform_data has been renamed
mmci_platform_data for clarity.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
This patch is against the devel branch in Russells git, and was
compiled with no errors against realview_defconfig,
versatile_defconfig, integrator_defconfig and u300_defconfig.
Some minor tweaks were needed to compile, since devel is not yet
rebased to master (vic.c #include <linux/device.h> patch and
the new clocksource code are the culprits).
---
 arch/arm/include/asm/mach/mmc.h          |   18 ------------------
 arch/arm/mach-integrator/integrator_cp.c |    4 ++--
 arch/arm/mach-realview/core.c            |    6 +++---
 arch/arm/mach-realview/core.h            |    4 ++--
 arch/arm/mach-realview/realview_eb.c     |    2 +-
 arch/arm/mach-realview/realview_pb1176.c |    2 +-
 arch/arm/mach-realview/realview_pb11mp.c |    2 +-
 arch/arm/mach-realview/realview_pba8.c   |    2 +-
 arch/arm/mach-realview/realview_pbx.c    |    2 +-
 arch/arm/mach-u300/mmc.c                 |    4 ++--
 arch/arm/mach-versatile/core.c           |    4 ++--
 arch/arm/mach-versatile/versatile_pb.c   |    4 ++--
 drivers/mmc/host/mmci.c                  |    4 ++--
 drivers/mmc/host/mmci.h                  |    2 +-
 include/linux/amba/mmci.h                |   18 ++++++++++++++++++
 15 files changed, 39 insertions(+), 39 deletions(-)
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
index 5a5e1f7..a2083b6 100644
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
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index c0795ea..1d65e64 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -24,6 +24,7 @@
 #include <linux/sysdev.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
+#include <linux/amba/mmci.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -37,7 +38,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/mmc.h>
 #include <asm/mach/time.h>
 
 #include <mach/board-eb.h>
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 395dc18..2817fe0 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -24,6 +24,7 @@
 #include <linux/sysdev.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
+#include <linux/amba/mmci.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -37,7 +38,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/mmc.h>
 #include <asm/mach/time.h>
 
 #include <mach/board-pb1176.h>
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index c0c9e35..94680fc 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -24,6 +24,7 @@
 #include <linux/sysdev.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
+#include <linux/amba/mmci.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -38,7 +39,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <asm/mach/mmc.h>
 #include <asm/mach/time.h>
 
 #include <mach/board-pb11mp.h>
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 4fc64e1..941beb2 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -24,6 +24,7 @@
 #include <linux/sysdev.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
+#include <linux/amba/mmci.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -34,7 +35,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/mmc.h>
 #include <asm/mach/time.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index cf68b54..7e4bc6c 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -23,6 +23,7 @@
 #include <linux/sysdev.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
+#include <linux/amba/mmci.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -34,7 +35,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/mmc.h>
 #include <asm/mach/time.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index 82af247..7b6b016 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -19,8 +19,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
+#include <linux/amba/mmci.h>
 
-#include <asm/mach/mmc.h>
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
index 975eae4..e13be7c 100644
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
@@ -369,7 +369,7 @@ unsigned int mmc_status(struct device *dev)
 	return readl(VERSATILE_SYSMCI) & mask;
 }
 
-static struct mmc_platform_data mmc0_plat_data = {
+static struct mmci_platform_data mmc0_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.status		= mmc_status,
 	.gpio_wp	= -1,
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
index bf7c05b..79205e5 100644
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

