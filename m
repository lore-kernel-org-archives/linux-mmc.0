From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v5 1/8] omap: mmc: split out init for 2420
Date: Fri, 25 Feb 2011 22:39:36 +0530
Message-ID: <1298653783-26410-2-git-send-email-kishore.kadiyala@ti.com>
References: <1298653783-26410-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33041 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932573Ab1BYRCG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Feb 2011 12:02:06 -0500
In-Reply-To: <1298653783-26410-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Anand Gadiyar <gadiyar@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

The MMC controller on the OMAP2420 is different from those
on the OMAP2430, OMAP3 and OMAP4 families - all of the latter
are identical. The one on the OMAP2420 is closer to that
on OMAP1 chips.

Currently, the n8x0 is the only OMAP2420 platform supported
in mainline which registers the MMC controller. Upcoming
changes to register the controllers using hwmod data are
potentially invasive. To reduce the risk, separate out the
2420 controller registration from the common init function
and update its only user. Also seperating out mux settings
for OMAP2420.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
---
 arch/arm/mach-omap2/board-n8x0.c      |    2 +-
 arch/arm/mach-omap2/devices.c         |   88 +++++++++++++++++++++------------
 arch/arm/plat-omap/include/plat/mmc.h |    4 ++
 3 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index b36cbd2..e710cd9 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -536,7 +536,7 @@ static void __init n8x0_mmc_init(void)
 	}
 
 	mmc_data[0] = &mmc1_data;
-	omap2_init_mmc(mmc_data, OMAP24XX_NR_MMC);
+	omap242x_init_mmc(mmc_data);
 }
 #else
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9ee876f..100bb42 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -650,11 +650,10 @@ err1:
 static inline void omap_hsmmc_reset(void) {}
 #endif
 
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
-	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
-static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
-			int controller_nr)
+static inline void omap242x_mmc_mux(struct omap_mmc_platform_data
+							*mmc_controller)
 {
 	if ((mmc_controller->slots[0].switch_pin > 0) && \
 		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
@@ -665,33 +664,61 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
 					OMAP_PIN_INPUT_PULLUP);
 
-	if (cpu_is_omap2420() && controller_nr == 0) {
-		omap_mux_init_signal("sdmmc_cmd", 0);
-		omap_mux_init_signal("sdmmc_clki", 0);
-		omap_mux_init_signal("sdmmc_clko", 0);
-		omap_mux_init_signal("sdmmc_dat0", 0);
-		omap_mux_init_signal("sdmmc_dat_dir0", 0);
-		omap_mux_init_signal("sdmmc_cmd_dir", 0);
-		if (mmc_controller->slots[0].caps & MMC_CAP_4_BIT_DATA) {
-			omap_mux_init_signal("sdmmc_dat1", 0);
-			omap_mux_init_signal("sdmmc_dat2", 0);
-			omap_mux_init_signal("sdmmc_dat3", 0);
-			omap_mux_init_signal("sdmmc_dat_dir1", 0);
-			omap_mux_init_signal("sdmmc_dat_dir2", 0);
-			omap_mux_init_signal("sdmmc_dat_dir3", 0);
-		}
+	omap_mux_init_signal("sdmmc_cmd", 0);
+	omap_mux_init_signal("sdmmc_clki", 0);
+	omap_mux_init_signal("sdmmc_clko", 0);
+	omap_mux_init_signal("sdmmc_dat0", 0);
+	omap_mux_init_signal("sdmmc_dat_dir0", 0);
+	omap_mux_init_signal("sdmmc_cmd_dir", 0);
+	if (mmc_controller->slots[0].caps & MMC_CAP_4_BIT_DATA) {
+		omap_mux_init_signal("sdmmc_dat1", 0);
+		omap_mux_init_signal("sdmmc_dat2", 0);
+		omap_mux_init_signal("sdmmc_dat3", 0);
+		omap_mux_init_signal("sdmmc_dat_dir1", 0);
+		omap_mux_init_signal("sdmmc_dat_dir2", 0);
+		omap_mux_init_signal("sdmmc_dat_dir3", 0);
+	}
 
-		/*
-		 * Use internal loop-back in MMC/SDIO Module Input Clock
-		 * selection
-		 */
-		if (mmc_controller->slots[0].internal_clock) {
-			u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-			v |= (1 << 24);
-			omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-		}
+	/*
+	 * Use internal loop-back in MMC/SDIO Module Input Clock
+	 * selection
+	 */
+	if (mmc_controller->slots[0].internal_clock) {
+		u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+		v |= (1 << 24);
+		omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+	}
+}
+
+void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
+{
+	char *name = "mmci-omap";
+
+	if (!mmc_data[0]) {
+		pr_err("%s fails: Incomplete platform data\n", __func__);
+		return;
 	}
 
+	omap242x_mmc_mux(mmc_data[0]);
+	omap_mmc_add(name, 0, OMAP2_MMC1_BASE, OMAP2420_MMC_SIZE,
+					INT_24XX_MMC_IRQ, mmc_data[0]);
+}
+
+#endif
+
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+
+static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
+			int controller_nr)
+{
+	if ((mmc_controller->slots[0].switch_pin > 0) && \
+		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
+					OMAP_PIN_INPUT_PULLUP);
+	if ((mmc_controller->slots[0].gpio_wp > 0) && \
+		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
+					OMAP_PIN_INPUT_PULLUP);
 	if (cpu_is_omap34xx()) {
 		if (controller_nr == 0) {
 			omap_mux_init_signal("sdmmc1_clk",
@@ -808,10 +835,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			continue;
 		}
 
-		if (cpu_is_omap2420()) {
-			size = OMAP2420_MMC_SIZE;
-			name = "mmci-omap";
-		} else if (cpu_is_omap44xx()) {
+		if (cpu_is_omap44xx()) {
 			if (i < 3)
 				irq += OMAP44XX_IRQ_GIC_START;
 			size = OMAP4_HSMMC_SIZE;
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index f57f36a..e5de5d4 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -159,6 +159,7 @@ extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
+void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
 void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
 int omap_mmc_add(const char *name, int id, unsigned long base,
@@ -169,6 +170,9 @@ static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers)
 {
 }
+static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
+{
+}
 static inline void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers)
 {
-- 
1.7.1

