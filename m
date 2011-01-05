From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] ARM: tegra: harmony: add sdhci devices
Date: Tue,  4 Jan 2011 21:39:44 -0600
Message-ID: <1294198784-852-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:33712 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab1AEDkk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jan 2011 22:40:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Olof Johansson <olof@lixom.net>, Gary King <gking@nvidia.com>

Add platform devices for SDIO{1,2,4} on harmony, which goes to wifi and
the two card connectors on the board. SDIO4 (the non-bayonet connector)
is wired for 8-bit cards, SDIO2 is not.

Originally from:
Signed-off-by: Colin Cross <ccross@android.com>

SDIO1 pieces from:
Signed-off-by: Gary King <gking@nvidia.com>

Cleanup, move of GPIO setup to sdhci-plftm driver, etc:
Signed-off-by: Olof Johansson <olof@lixom.net>
---

Depends on the driver that has been merged into mmc-next.

 arch/arm/mach-tegra/Makefile               |    1 +
 arch/arm/mach-tegra/board-harmony-pinmux.c |   11 ++-
 arch/arm/mach-tegra/board-harmony-sdhci.c  |  117 ++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.c        |    1 +
 arch/arm/mach-tegra/board-harmony.h        |    1 +
 5 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-sdhci.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index cdbc68e..3b60d61 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
+obj-${CONFIG_MACH_HARMONY}		+= board-harmony-sdhci.o
diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 50b15d5..78980e4 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -15,11 +15,12 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <mach/pinmux.h>
 
 #include "board-harmony.h"
 
-static struct tegra_pingroup_config harmony_pinmux[] = {
+static __initdata struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -34,10 +35,10 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_I2C2,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_DTC,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_DTE,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
@@ -138,7 +139,7 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 };
 
-void harmony_pinmux_init(void)
+void __init harmony_pinmux_init(void)
 {
 	tegra_pinmux_config_table(harmony_pinmux, ARRAY_SIZE(harmony_pinmux));
 }
diff --git a/arch/arm/mach-tegra/board-harmony-sdhci.c b/arch/arm/mach-tegra/board-harmony-sdhci.c
new file mode 100644
index 0000000..3a0c1b1
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony-sdhci.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2010-2011 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/resource.h>
+#include <linux/platform_device.h>
+#include <mach/irqs.h>
+#include <mach/iomap.h>
+#include <mach/sdhci.h>
+
+#include "board-harmony.h"
+#include "gpio-names.h"
+
+static struct resource sdhci_resource1[] = {
+	[0] = {
+		.start  = INT_SDMMC1,
+		.end    = INT_SDMMC1,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start  = TEGRA_SDMMC1_BASE,
+		.end    = TEGRA_SDMMC1_BASE + TEGRA_SDMMC1_SIZE-1,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct resource sdhci_resource2[] = {
+	[0] = {
+		.start  = INT_SDMMC2,
+		.end    = INT_SDMMC2,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start	= TEGRA_SDMMC2_BASE,
+		.end	= TEGRA_SDMMC2_BASE + TEGRA_SDMMC2_SIZE-1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource sdhci_resource4[] = {
+	[0] = {
+		.start  = INT_SDMMC4,
+		.end    = INT_SDMMC4,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start	= TEGRA_SDMMC4_BASE,
+		.end	= TEGRA_SDMMC4_BASE + TEGRA_SDMMC4_SIZE-1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct tegra_sdhci_platform_data tegra_sdhci_platform_data1 = {
+	.cd_gpio	= -1,
+	.wp_gpio	= -1,
+	.power_gpio	= -1,
+};
+
+static struct tegra_sdhci_platform_data tegra_sdhci_platform_data2 = {
+	.cd_gpio	= TEGRA_GPIO_PI5,
+	.wp_gpio	= TEGRA_GPIO_PH1,
+	.power_gpio	= TEGRA_GPIO_PT3,
+};
+
+static struct tegra_sdhci_platform_data tegra_sdhci_platform_data4 = {
+	.cd_gpio	= TEGRA_GPIO_PH2,
+	.wp_gpio	= TEGRA_GPIO_PH3,
+	.power_gpio	= TEGRA_GPIO_PI6,
+	.is_8bit	= 1,
+};
+
+static struct platform_device tegra_sdhci_device1 = {
+	.name           = "sdhci-tegra",
+	.id             = 0,
+	.resource       = sdhci_resource1,
+	.num_resources  = ARRAY_SIZE(sdhci_resource1),
+	.dev = {
+		.platform_data = &tegra_sdhci_platform_data1,
+	},
+};
+
+static struct platform_device tegra_sdhci_device2 = {
+	.name		= "sdhci-tegra",
+	.id		= 1,
+	.resource	= sdhci_resource2,
+	.num_resources	= ARRAY_SIZE(sdhci_resource2),
+	.dev = {
+		.platform_data = &tegra_sdhci_platform_data2,
+	},
+};
+
+static struct platform_device tegra_sdhci_device4 = {
+	.name		= "sdhci-tegra",
+	.id		= 3,
+	.resource	= sdhci_resource4,
+	.num_resources	= ARRAY_SIZE(sdhci_resource4),
+	.dev = {
+		.platform_data = &tegra_sdhci_platform_data4,
+	},
+};
+
+void __init harmony_sdhci_init(void)
+{
+	platform_device_register(&tegra_sdhci_device1);
+	platform_device_register(&tegra_sdhci_device2);
+	platform_device_register(&tegra_sdhci_device4);
+}
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index b9dbdb1..42567d4 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -109,6 +109,7 @@ static void __init tegra_harmony_init(void)
 	tegra_clk_init_from_table(harmony_clk_init_table);
 
 	harmony_pinmux_init();
+	harmony_sdhci_init();
 
 	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
 }
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 09ca775..4bf414c 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -18,5 +18,6 @@
 #define _MACH_TEGRA_BOARD_HARMONY_H
 
 void harmony_pinmux_init(void);
+void harmony_sdhci_init(void);
 
 #endif
-- 
1.7.3.1

