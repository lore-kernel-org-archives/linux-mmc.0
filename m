From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 5/8] omap_hsmmc: RX51: set padconfs to pull down when powering off eMMC
Date: Wed, 13 Jan 2010 13:40:48 +0200
Message-ID: <20100113114048.7615.51097.sendpatchset@ahunter-work.research.nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

>From 060702bca6c60dd0f63f4e82e381ae1b8b112dec Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Tue, 5 Jan 2010 13:46:57 +0200
Subject: [PATCH] omap_hsmmc: RX51: set padconfs to pull down when powering off eMMC

It has been discovered that, when eMMC is powered off, current
will flow from OMAP eMMC data pull-ups to the eMMC voltage supply.
Configuring pads for off-mode does not help because eMMC is
powered off independently of off-mode.  Hence the pads are now
re-configured when eMMC is powered on or off.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   27 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/hsmmc.c                  |    2 +
 arch/arm/mach-omap2/hsmmc.h                  |    2 +
 arch/arm/plat-omap/include/plat/control.h    |    6 +++++
 arch/arm/plat-omap/include/plat/mmc.h        |    1 +
 drivers/mmc/host/omap_hsmmc.c                |    8 +++++++
 6 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index b6318b1..4d9dbb4 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,6 +32,7 @@
 #include <plat/gpmc.h>
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/control.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -225,6 +226,29 @@ static void rx51_mmc_set_pm_constraints(struct device *dev, int on)
 #define rx51_mmc_set_pm_constraints NULL
 #endif
 
+/*
+ * Current flows to eMMC when eMMC is off and the data lines are pulled up,
+ * so pull them down. N.B. we pull 8 lines because we are using 8 lines.
+ */
+static void rx51_mmc_2_pad_conf(struct device *dev, int slot, int power_on)
+{
+	if (power_on) {
+		/* Pull up */
+		omap_ctrl_writew(    0x118, OMAP343X_PADCONF_MMC2_CMD);
+		omap_ctrl_writel(0x1180118, OMAP343X_PADCONF_MMC2_DAT0);
+		omap_ctrl_writel(0x1180118, OMAP343X_PADCONF_MMC2_DAT2);
+		omap_ctrl_writel(0x1180118, OMAP343X_PADCONF_MMC2_DAT4);
+		omap_ctrl_writel(0x1180118, OMAP343X_PADCONF_MMC2_DAT6);
+	} else {
+		/* Pull down */
+		omap_ctrl_writew(    0x108, OMAP343X_PADCONF_MMC2_CMD);
+		omap_ctrl_writel(0x1080108, OMAP343X_PADCONF_MMC2_DAT0);
+		omap_ctrl_writel(0x1080108, OMAP343X_PADCONF_MMC2_DAT2);
+		omap_ctrl_writel(0x1080108, OMAP343X_PADCONF_MMC2_DAT4);
+		omap_ctrl_writel(0x1080108, OMAP343X_PADCONF_MMC2_DAT6);
+	}
+}
+
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
@@ -239,12 +263,13 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "internal",
 		.mmc		= 2,
-		.wires		= 8,
+		.wires		= 8, /* See also rx51_mmc_2_pad_conf */
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
 		.set_pm_constraints = rx51_mmc_set_pm_constraints,
+		.pad_conf	= rx51_mmc_2_pad_conf,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 1211d15..e82b299 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -81,6 +81,8 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->slots[0].switch_pin = c->gpio_cd;
 		mmc->slots[0].gpio_wp = c->gpio_wp;
 
+		mmc->slots[0].pad_conf = c->pad_conf;
+
 		if (c->cover_only)
 			mmc->slots[0].cover = 1;
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index ad437f3..0960dcb 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -21,6 +21,8 @@ struct omap2_hsmmc_info {
 	int	ocr_mask;	/* temporary HACK */
 	/* Set/drop DVFS/PM constraints */
 	void (*set_pm_constraints)(struct device *dev, int on);
+	/* Pad configuation when powering on/off */
+	void (*pad_conf)(struct device *dev, int slot, int power_on);
 };
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index a745d62..3dfda2b 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -183,6 +183,12 @@
 #define OMAP343X_PADCONF_ETK_D14	OMAP343X_PADCONF_ETK(16)
 #define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
 
+#define OMAP343X_PADCONF_MMC2_CMD	(OMAP2_CONTROL_PADCONFS + 0x12A)
+#define OMAP343X_PADCONF_MMC2_DAT0	(OMAP2_CONTROL_PADCONFS + 0x12C)
+#define OMAP343X_PADCONF_MMC2_DAT2	(OMAP2_CONTROL_PADCONFS + 0x130)
+#define OMAP343X_PADCONF_MMC2_DAT4	(OMAP2_CONTROL_PADCONFS + 0x134)
+#define OMAP343X_PADCONF_MMC2_DAT6	(OMAP2_CONTROL_PADCONFS + 0x138)
+
 /* 34xx GENERAL_WKUP regist offsets */
 #define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
 						0x008 + (i))
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index c3e0c34..ca09022 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -107,6 +107,7 @@ struct omap_mmc_platform_data {
 		int (* get_ro)(struct device *dev, int slot);
 		int (*set_sleep)(struct device *dev, int slot, int sleep,
 				 int vdd, int cardsleep);
+		void (*pad_conf)(struct device *dev, int slot, int power_on);
 
 		/* return MMC cover switch state, can be NULL if not supported.
 		 *
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e2f63a5..554fcb2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -263,6 +263,8 @@ static int omap_hsmmc_1_set_power(struct device *dev, int slot, int power_on,
 	 * FIXME handle VMMC1A as needed ...
 	 */
 	if (power_on) {
+		if (mmc_slot(host).pad_conf)
+			mmc_slot(host).pad_conf(host->dev, host->slot_id, 1);
 		if (cpu_is_omap2430()) {
 			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
 			if ((1 << vdd) >= MMC_VDD_30_31)
@@ -302,6 +304,8 @@ static int omap_hsmmc_1_set_power(struct device *dev, int slot, int power_on,
 			reg |= OMAP2_PBIASLITEVMODE0;
 		omap_ctrl_writel(reg, control_pbias_offset);
 	} else {
+		if (mmc_slot(host).pad_conf)
+			mmc_slot(host).pad_conf(host->dev, host->slot_id, 0);
 		reg = omap_ctrl_readl(control_pbias_offset);
 		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
 		omap_ctrl_writel(reg, control_pbias_offset);
@@ -348,6 +352,8 @@ static int omap_hsmmc_23_set_power(struct device *dev, int slot, int power_on,
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
+		if (mmc_slot(host).pad_conf)
+			mmc_slot(host).pad_conf(host->dev, host->slot_id, 1);
 		/* Only MMC2 supports a CLKIN */
 		if (mmc->slots[0].internal_clock) {
 			u32 reg;
@@ -369,6 +375,8 @@ static int omap_hsmmc_23_set_power(struct device *dev, int slot, int power_on,
 				ret = mmc_regulator_set_ocr(host->vcc, 0);
 		}
 	} else {
+		if (mmc_slot(host).pad_conf)
+			mmc_slot(host).pad_conf(host->dev, host->slot_id, 0);
 		if (host->vcc_aux && (ret = regulator_is_enabled(host->vcc_aux)) > 0)
 			ret = regulator_disable(host->vcc_aux);
 		if (ret == 0)
-- 
1.6.0.4

