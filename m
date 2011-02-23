From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v3 5/5] OMAP: adapt hsmmc to hwmod framework
Date: Wed, 23 Feb 2011 23:17:11 +0530
Message-ID: <1298483231-29622-6-git-send-email-kishore.kadiyala@ti.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44690 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab1BWRjr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Feb 2011 12:39:47 -0500
In-Reply-To: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

Changes involves:
1) Remove controller reset in devices.c which is taken care of
   by hwmod framework.
2) Removing all base address macro defines except keeping one for OMAP2420.
3) Using omap-device layer to register device and utilizing data from
   hwmod data file for base address, dma channel number, Irq_number,
   device attribute.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/devices.c         |  251 ---------------------------------
 arch/arm/mach-omap2/hsmmc.c           |  153 ++++++++++++++++++--
 arch/arm/plat-omap/include/plat/mmc.h |   14 --
 3 files changed, 141 insertions(+), 277 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7b35c87..2d2deb6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -503,112 +503,6 @@ static inline void omap_init_aes(void) { }
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-
-#define MMCHS_SYSCONFIG			0x0010
-#define MMCHS_SYSCONFIG_SWRESET		(1 << 1)
-#define MMCHS_SYSSTATUS			0x0014
-#define MMCHS_SYSSTATUS_RESETDONE	(1 << 0)
-
-static struct platform_device dummy_pdev = {
-	.dev = {
-		.bus = &platform_bus_type,
-	},
-};
-
-/**
- * omap_hsmmc_reset() - Full reset of each HS-MMC controller
- *
- * Ensure that each MMC controller is fully reset.  Controllers
- * left in an unknown state (by bootloader) may prevent retention
- * or OFF-mode.  This is especially important in cases where the
- * MMC driver is not enabled, _or_ built as a module.
- *
- * In order for reset to work, interface, functional and debounce
- * clocks must be enabled.  The debounce clock comes from func_32k_clk
- * and is not under SW control, so we only enable i- and f-clocks.
- **/
-static void __init omap_hsmmc_reset(void)
-{
-	u32 i, nr_controllers;
-	struct clk *iclk, *fclk;
-
-	if (cpu_is_omap242x())
-		return;
-
-	nr_controllers = cpu_is_omap44xx() ? OMAP44XX_NR_MMC :
-		(cpu_is_omap34xx() ? OMAP34XX_NR_MMC : OMAP24XX_NR_MMC);
-
-	for (i = 0; i < nr_controllers; i++) {
-		u32 v, base = 0;
-		struct device *dev = &dummy_pdev.dev;
-
-		switch (i) {
-		case 0:
-			base = OMAP2_MMC1_BASE;
-			break;
-		case 1:
-			base = OMAP2_MMC2_BASE;
-			break;
-		case 2:
-			base = OMAP3_MMC3_BASE;
-			break;
-		case 3:
-			if (!cpu_is_omap44xx())
-				return;
-			base = OMAP4_MMC4_BASE;
-			break;
-		case 4:
-			if (!cpu_is_omap44xx())
-				return;
-			base = OMAP4_MMC5_BASE;
-			break;
-		}
-
-		if (cpu_is_omap44xx())
-			base += OMAP4_MMC_REG_OFFSET;
-
-		dummy_pdev.id = i;
-		dev_set_name(&dummy_pdev.dev, "mmci-omap-hs.%d", i);
-		iclk = clk_get(dev, "ick");
-		if (IS_ERR(iclk))
-			goto err1;
-		if (clk_enable(iclk))
-			goto err2;
-
-		fclk = clk_get(dev, "fck");
-		if (IS_ERR(fclk))
-			goto err3;
-		if (clk_enable(fclk))
-			goto err4;
-
-		omap_writel(MMCHS_SYSCONFIG_SWRESET, base + MMCHS_SYSCONFIG);
-		v = omap_readl(base + MMCHS_SYSSTATUS);
-		while (!(omap_readl(base + MMCHS_SYSSTATUS) &
-			 MMCHS_SYSSTATUS_RESETDONE))
-			cpu_relax();
-
-		clk_disable(fclk);
-		clk_put(fclk);
-		clk_disable(iclk);
-		clk_put(iclk);
-	}
-	return;
-
-err4:
-	clk_put(fclk);
-err3:
-	clk_disable(iclk);
-err2:
-	clk_put(iclk);
-err1:
-	printk(KERN_WARNING "%s: Unable to enable clocks for MMC%d, "
-			    "cannot reset.\n",  __func__, i);
-}
-#else
-static inline void omap_hsmmc_reset(void) {}
-#endif
-
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
 static inline void omap242x_mmc_mux(struct omap_mmc_platform_data
@@ -665,150 +559,6 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 
 #endif
 
-#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-
-static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
-			int controller_nr)
-{
-	if ((mmc_controller->slots[0].switch_pin > 0) && \
-		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
-					OMAP_PIN_INPUT_PULLUP);
-	if ((mmc_controller->slots[0].gpio_wp > 0) && \
-		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
-					OMAP_PIN_INPUT_PULLUP);
-	if (cpu_is_omap34xx()) {
-		if (controller_nr == 0) {
-			omap_mux_init_signal("sdmmc1_clk",
-				OMAP_PIN_INPUT_PULLUP);
-			omap_mux_init_signal("sdmmc1_cmd",
-				OMAP_PIN_INPUT_PULLUP);
-			omap_mux_init_signal("sdmmc1_dat0",
-				OMAP_PIN_INPUT_PULLUP);
-			if (mmc_controller->slots[0].caps &
-				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
-				omap_mux_init_signal("sdmmc1_dat1",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc1_dat2",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc1_dat3",
-					OMAP_PIN_INPUT_PULLUP);
-			}
-			if (mmc_controller->slots[0].caps &
-						MMC_CAP_8_BIT_DATA) {
-				omap_mux_init_signal("sdmmc1_dat4",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc1_dat5",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc1_dat6",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc1_dat7",
-					OMAP_PIN_INPUT_PULLUP);
-			}
-		}
-		if (controller_nr == 1) {
-			/* MMC2 */
-			omap_mux_init_signal("sdmmc2_clk",
-				OMAP_PIN_INPUT_PULLUP);
-			omap_mux_init_signal("sdmmc2_cmd",
-				OMAP_PIN_INPUT_PULLUP);
-			omap_mux_init_signal("sdmmc2_dat0",
-				OMAP_PIN_INPUT_PULLUP);
-
-			/*
-			 * For 8 wire configurations, Lines DAT4, 5, 6 and 7 need to be muxed
-			 * in the board-*.c files
-			 */
-			if (mmc_controller->slots[0].caps &
-				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
-				omap_mux_init_signal("sdmmc2_dat1",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc2_dat2",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc2_dat3",
-					OMAP_PIN_INPUT_PULLUP);
-			}
-			if (mmc_controller->slots[0].caps &
-							MMC_CAP_8_BIT_DATA) {
-				omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc2_dat6.sdmmc2_dat6",
-					OMAP_PIN_INPUT_PULLUP);
-				omap_mux_init_signal("sdmmc2_dat7.sdmmc2_dat7",
-					OMAP_PIN_INPUT_PULLUP);
-			}
-		}
-
-		/*
-		 * For MMC3 the pins need to be muxed in the board-*.c files
-		 */
-	}
-}
-
-void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
-			int nr_controllers)
-{
-	int i;
-	char *name;
-
-	for (i = 0; i < nr_controllers; i++) {
-		unsigned long base, size;
-		unsigned int irq = 0;
-
-		if (!mmc_data[i])
-			continue;
-
-		omap2_mmc_mux(mmc_data[i], i);
-
-		switch (i) {
-		case 0:
-			base = OMAP2_MMC1_BASE;
-			irq = INT_24XX_MMC_IRQ;
-			break;
-		case 1:
-			base = OMAP2_MMC2_BASE;
-			irq = INT_24XX_MMC2_IRQ;
-			break;
-		case 2:
-			if (!cpu_is_omap44xx() && !cpu_is_omap34xx())
-				return;
-			base = OMAP3_MMC3_BASE;
-			irq = INT_34XX_MMC3_IRQ;
-			break;
-		case 3:
-			if (!cpu_is_omap44xx())
-				return;
-			base = OMAP4_MMC4_BASE;
-			irq = OMAP44XX_IRQ_MMC4;
-			break;
-		case 4:
-			if (!cpu_is_omap44xx())
-				return;
-			base = OMAP4_MMC5_BASE;
-			irq = OMAP44XX_IRQ_MMC5;
-			break;
-		default:
-			continue;
-		}
-
-		if (cpu_is_omap44xx()) {
-			if (i < 3)
-				irq += OMAP44XX_IRQ_GIC_START;
-			size = OMAP4_HSMMC_SIZE;
-			name = "mmci-omap-hs";
-		} else {
-			size = OMAP3_HSMMC_SIZE;
-			name = "mmci-omap-hs";
-		}
-		omap_mmc_add(name, i, base, size, irq, mmc_data[i]);
-	};
-}
-
-#endif
-
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
@@ -878,7 +628,6 @@ static int __init omap2_init_devices(void)
 	 * please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_hsmmc_reset();
 	omap_init_audio();
 	omap_init_camera();
 	omap_init_mbox();
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 34272e4..b6e1eae 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -16,7 +16,11 @@
 #include <mach/hardware.h>
 #include <plat/mmc.h>
 #include <plat/omap-pm.h>
+#include <plat/mux.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
+#include "mux.h"
 #include "hsmmc.h"
 #include "control.h"
 
@@ -30,7 +34,7 @@ static u16 control_mmc1;
 
 static struct hsmmc_controller {
 	char				name[HSMMC_NAME_LEN + 1];
-} hsmmc[OMAP34XX_NR_MMC];
+} hsmmc[OMAP44XX_NR_MMC];
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 
@@ -204,7 +208,141 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
 	return 0;
 }
 
-static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
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
+	if (cpu_is_omap34xx()) {
+		if (controller_nr == 0) {
+			omap_mux_init_signal("sdmmc1_clk",
+				OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc1_cmd",
+				OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc1_dat0",
+				OMAP_PIN_INPUT_PULLUP);
+			if (mmc_controller->slots[0].caps &
+				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
+				omap_mux_init_signal("sdmmc1_dat1",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat2",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat3",
+					OMAP_PIN_INPUT_PULLUP);
+			}
+			if (mmc_controller->slots[0].caps &
+						MMC_CAP_8_BIT_DATA) {
+				omap_mux_init_signal("sdmmc1_dat4",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat5",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat6",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat7",
+					OMAP_PIN_INPUT_PULLUP);
+			}
+		}
+		if (controller_nr == 1) {
+			/* MMC2 */
+			omap_mux_init_signal("sdmmc2_clk",
+				OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc2_cmd",
+				OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc2_dat0",
+				OMAP_PIN_INPUT_PULLUP);
+
+			/*
+			 * For 8 wire configurations, Lines DAT4, 5, 6 and 7
+			 * need to be muxed in the board-*.c files
+			 */
+			if (mmc_controller->slots[0].caps &
+				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
+				omap_mux_init_signal("sdmmc2_dat1",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat2",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat3",
+					OMAP_PIN_INPUT_PULLUP);
+			}
+			if (mmc_controller->slots[0].caps &
+							MMC_CAP_8_BIT_DATA) {
+				omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat5.sdmmc2_dat5",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat6.sdmmc2_dat6",
+					OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc2_dat7.sdmmc2_dat7",
+					OMAP_PIN_INPUT_PULLUP);
+			}
+		}
+
+		/*
+		 * For MMC3 the pins need to be muxed in the board-*.c files
+		 */
+	}
+}
+
+static struct omap_mmc_platform_data *hsmmc_data[OMAP44XX_NR_MMC] __initdata;
+
+static struct omap_device_pm_latency omap_hsmmc_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func	 = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+	/*
+	 * XXX There should also be an entry here to power off/on the
+	 * MMC regulators/PBIAS cells, etc.
+	 */
+};
+
+static int omap2_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
+{
+	struct omap_device *od;
+	struct omap_device_pm_latency *ohl;
+	char *name;
+	int ohl_cnt = 0;
+	struct mmc_dev_attr *mmc_dattr = oh->dev_attr;
+	struct omap2_hsmmc_info *c = (struct omap2_hsmmc_info *) hsmmcinfo;
+	int idx;
+	static int mmc_num;
+
+	/* Initialization of controllers which are not updated
+	 * in board file will be skipped here.
+	 */
+	c += mmc_num;
+	if (!c->mmc) {
+		pr_err("omap_hsmmc_info is not updated in board file\n");
+		return 0;
+	}
+	idx = c->mmc - 1 ;
+	name = "mmci-omap-hs";
+	ohl = omap_hsmmc_latency;
+	ohl_cnt = ARRAY_SIZE(omap_hsmmc_latency);
+	omap2_mmc_mux(hsmmc_data[idx], idx);
+	hsmmc_data[idx]->controller_dev_attr = mmc_dattr->flags;
+	od = omap_device_build(name, idx, oh, hsmmc_data[idx],
+		sizeof(struct omap_mmc_platform_data), ohl, ohl_cnt, false);
+	if (IS_ERR(od)) {
+		WARN(1, "Cant build omap_device for %s:%s.\n",
+					name, oh->name);
+		return PTR_ERR(od);
+	}
+	/*
+	 * return device handle to board setup code
+	 * required to populate for regulator framework structure
+	 */
+	c->dev = &od->pdev.dev;
+	mmc_num++;
+	return 0;
+}
 
 void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
@@ -358,16 +496,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		hsmmc_data[c->mmc - 1] = mmc;
 	}
 
-	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
-
-	/* pass the device nodes back to board setup code */
-	for (c = controllers; c->mmc; c++) {
-		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
-
-		if (!c->mmc || c->mmc > nr_hsmmc)
-			continue;
-		c->dev = mmc->dev;
-	}
+	omap_hwmod_for_each_by_class("mmc", omap2_mmc_init, controllers);
 
 done:
 	for (i = 0; i < nr_hsmmc; i++)
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 7853130..6205984 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -24,20 +24,12 @@
 #define OMAP1_MMC2_BASE		0xfffb7c00	/* omap16xx only */
 
 #define OMAP24XX_NR_MMC		2
-#define OMAP34XX_NR_MMC		3
 #define OMAP44XX_NR_MMC		5
 #define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
-#define OMAP3_HSMMC_SIZE	0x200
 #define OMAP4_HSMMC_SIZE	0x1000
 #define OMAP2_MMC1_BASE		0x4809c000
 #define OMAP2_MMC2_BASE		0x480b4000
-#define OMAP3_MMC3_BASE		0x480ad000
-#define OMAP4_MMC4_BASE		0x480d1000
-#define OMAP4_MMC5_BASE		0x480d5000
 #define OMAP4_MMC_REG_OFFSET	0x100
-#define HSMMC5			(1 << 4)
-#define HSMMC4			(1 << 3)
-#define HSMMC3			(1 << 2)
 #define HSMMC2			(1 << 1)
 #define HSMMC1			(1 << 0)
 
@@ -170,8 +162,6 @@ extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
 void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
 void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
-void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
-				int nr_controllers);
 int omap_mmc_add(const char *name, int id, unsigned long base,
 				unsigned long size, unsigned int irq,
 				struct omap_mmc_platform_data *data);
@@ -183,10 +173,6 @@ static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 {
 }
-static inline void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
-				int nr_controllers)
-{
-}
 static inline int omap_mmc_add(const char *name, int id, unsigned long base,
 				unsigned long size, unsigned int irq,
 				struct omap_mmc_platform_data *data)
-- 
1.7.1

