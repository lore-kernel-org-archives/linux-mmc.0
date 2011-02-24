From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v4 5/6] OMAP: adapt hsmmc to hwmod framework
Date: Fri, 25 Feb 2011 00:56:53 +0530
Message-ID: <1298575614-9388-6-git-send-email-kishore.kadiyala@ti.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

Changes involves:
1) Remove controller reset in devices.c which is taken care of
   by hwmod framework.
2) Omap2420 platform consists of mmc block as in omap1 and not the
   hsmmc block as present in omap2430, omap3, omap4 platforms.
   Removing all base address macro defines except keeping one for OMAP2420.
3) Using omap-device layer to register device and utilizing data from
   hwmod data file for base address, dma channel number, Irq_number,
   device attribute.
4) Update the driver to use dev_attr to find whether controller
   supports dual volt cards

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/devices.c         |  251 --------------------
 arch/arm/mach-omap2/hsmmc.c           |  417 +++++++++++++++++++++------------
 arch/arm/plat-omap/include/plat/mmc.h |   20 +--
 drivers/mmc/host/omap_hsmmc.c         |    4 +-
 4 files changed, 274 insertions(+), 418 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 100bb42..31632ac 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -544,112 +544,6 @@ static inline void omap_init_aes(void) { }
 
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
@@ -706,150 +600,6 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 
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
@@ -919,7 +669,6 @@ static int __init omap2_init_devices(void)
 	 * please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_hsmmc_reset();
 	omap_init_audio();
 	omap_init_camera();
 	omap_init_mbox();
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 5496bc7..c370c75 100644
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
 
@@ -28,10 +32,6 @@ static u16 control_mmc1;
 
 #define HSMMC_NAME_LEN	9
 
-static struct hsmmc_controller {
-	char				name[HSMMC_NAME_LEN + 1];
-} hsmmc[OMAP34XX_NR_MMC];
-
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 
 static int hsmmc_get_context_loss(struct device *dev)
@@ -204,179 +204,304 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
 	return 0;
 }
 
-static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
-
-void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
+static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
+			int controller_nr)
 {
-	struct omap2_hsmmc_info *c;
-	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
-	int i;
-	u32 reg;
-
-	if (!cpu_is_omap44xx()) {
-		if (cpu_is_omap2430()) {
-			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
-			control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
-		} else {
-			control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
-			control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
-		}
-	} else {
-		control_pbias_offset =
-			OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE;
-		control_mmc1 = OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MMC1;
-		reg = omap4_ctrl_pad_readl(control_mmc1);
-		reg |= (OMAP4_SDMMC1_PUSTRENGTH_GRP0_MASK |
-			OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK);
-		reg &= ~(OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK |
-			OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK);
-		reg |= (OMAP4_USBC1_DR0_SPEEDCTRL_MASK|
-			OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK |
-			OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK);
-		omap4_ctrl_pad_writel(reg, control_mmc1);
-	}
-
-	for (c = controllers; c->mmc; c++) {
-		struct hsmmc_controller *hc = hsmmc + c->mmc - 1;
-		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
-
-		if (!c->mmc || c->mmc > nr_hsmmc) {
-			pr_debug("MMC%d: no such controller\n", c->mmc);
-			continue;
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
 		}
-		if (mmc) {
-			pr_debug("MMC%d: already configured\n", c->mmc);
-			continue;
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
 		}
 
-		mmc = kzalloc(sizeof(struct omap_mmc_platform_data),
-			      GFP_KERNEL);
-		if (!mmc) {
-			pr_err("Cannot allocate memory for mmc device!\n");
-			goto done;
-		}
+		/*
+		 * For MMC3 the pins need to be muxed in the board-*.c files
+		 */
+	}
+}
 
-		if (c->name)
-			strncpy(hc->name, c->name, HSMMC_NAME_LEN);
-		else
-			snprintf(hc->name, ARRAY_SIZE(hc->name),
-				"mmc%islot%i", c->mmc, 1);
-		mmc->slots[0].name = hc->name;
-		mmc->nr_slots = 1;
-		mmc->slots[0].caps = c->caps;
-		mmc->slots[0].internal_clock = !c->ext_clock;
-		mmc->dma_mask = 0xffffffff;
-		if (cpu_is_omap44xx())
-			mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
-		else
-			mmc->reg_offset = 0;
+static struct omap_mmc_platform_data *mmc __initdata;
 
-		mmc->get_context_loss_count = hsmmc_get_context_loss;
+static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c)
+{
+		char *hc_name;
 
-		mmc->slots[0].switch_pin = c->gpio_cd;
-		mmc->slots[0].gpio_wp = c->gpio_wp;
+	if (!c->mmc) {
+		pr_debug("MMC%d: no such controller\n", c->mmc);
+		return -ENXIO;
+	}
 
-		mmc->slots[0].remux = c->remux;
-		mmc->slots[0].init_card = c->init_card;
+	hc_name = kzalloc(sizeof(char) * (HSMMC_NAME_LEN + 1), GFP_KERNEL);
+	if (!hc_name) {
+		pr_err("Cannot allocate memory for controller slot name\n");
+		kfree(hc_name);
+		return -ENOMEM;
+	}
 
-		if (c->cover_only)
-			mmc->slots[0].cover = 1;
+	if (c->name)
+		strncpy(hc_name, c->name, HSMMC_NAME_LEN);
+	else
+		snprintf(hc_name, (HSMMC_NAME_LEN + 1), "mmc%islot%i",
+								c->mmc, 1);
+	mmc->slots[0].name = hc_name;
+	mmc->nr_slots = 1;
+	mmc->slots[0].caps = c->caps;
+	mmc->slots[0].internal_clock = !c->ext_clock;
+	mmc->dma_mask = 0xffffffff;
+	if (cpu_is_omap44xx())
+		mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
+	else
+	mmc->reg_offset = 0;
 
-		if (c->nonremovable)
-			mmc->slots[0].nonremovable = 1;
+	mmc->get_context_loss_count = hsmmc_get_context_loss;
 
-		if (c->power_saving)
-			mmc->slots[0].power_saving = 1;
+	mmc->slots[0].switch_pin = c->gpio_cd;
+	mmc->slots[0].gpio_wp = c->gpio_wp;
 
-		if (c->no_off)
-			mmc->slots[0].no_off = 1;
+	mmc->slots[0].remux = c->remux;
+	mmc->slots[0].init_card = c->init_card;
 
-		if (c->vcc_aux_disable_is_sleep)
-			mmc->slots[0].vcc_aux_disable_is_sleep = 1;
+	if (c->cover_only)
+		mmc->slots[0].cover = 1;
 
-		/* NOTE:  MMC slots should have a Vcc regulator set up.
-		 * This may be from a TWL4030-family chip, another
-		 * controllable regulator, or a fixed supply.
-		 *
-		 * temporary HACK: ocr_mask instead of fixed supply
-		 */
-		mmc->slots[0].ocr_mask = c->ocr_mask;
+	if (c->nonremovable)
+		mmc->slots[0].nonremovable = 1;
 
-		if (cpu_is_omap3517() || cpu_is_omap3505())
-			mmc->slots[0].set_power = nop_mmc_set_power;
-		else
-			mmc->slots[0].features |= HSMMC_HAS_PBIAS;
+	if (c->power_saving)
+		mmc->slots[0].power_saving = 1;
 
-		if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
-			mmc->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
+	if (c->no_off)
+		mmc->slots[0].no_off = 1;
 
-		switch (c->mmc) {
-		case 1:
-			if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
-				/* on-chip level shifting via PBIAS0/PBIAS1 */
-				if (cpu_is_omap44xx()) {
-					mmc->slots[0].before_set_reg =
+	if (c->vcc_aux_disable_is_sleep)
+		mmc->slots[0].vcc_aux_disable_is_sleep = 1;
+
+	/* NOTE:  MMC slots should have a Vcc regulator set up.
+	 * This may be from a TWL4030-family chip, another
+	 * controllable regulator, or a fixed supply.
+	 *
+	 * temporary HACK: ocr_mask instead of fixed supply
+	 */
+	mmc->slots[0].ocr_mask = c->ocr_mask;
+
+	if (cpu_is_omap3517() || cpu_is_omap3505())
+		mmc->slots[0].set_power = nop_mmc_set_power;
+	else
+		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
+
+	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
+		mmc->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
+
+	switch (c->mmc) {
+	case 1:
+		if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
+			/* on-chip level shifting via PBIAS0/PBIAS1 */
+			if (cpu_is_omap44xx()) {
+				mmc->slots[0].before_set_reg =
 						omap4_hsmmc1_before_set_reg;
-					mmc->slots[0].after_set_reg =
+				mmc->slots[0].after_set_reg =
 						omap4_hsmmc1_after_set_reg;
-				} else {
-					mmc->slots[0].before_set_reg =
+			} else {
+				mmc->slots[0].before_set_reg =
 						omap_hsmmc1_before_set_reg;
-					mmc->slots[0].after_set_reg =
+				mmc->slots[0].after_set_reg =
 						omap_hsmmc1_after_set_reg;
-				}
 			}
+		}
 
-			/* Omap3630 HSMMC1 supports only 4-bit */
-			if (cpu_is_omap3630() &&
-					(c->caps & MMC_CAP_8_BIT_DATA)) {
-				c->caps &= ~MMC_CAP_8_BIT_DATA;
-				c->caps |= MMC_CAP_4_BIT_DATA;
-				mmc->slots[0].caps = c->caps;
-			}
-			break;
-		case 2:
-			if (c->ext_clock)
-				c->transceiver = 1;
-			if (c->transceiver && (c->caps & MMC_CAP_8_BIT_DATA)) {
-				c->caps &= ~MMC_CAP_8_BIT_DATA;
-				c->caps |= MMC_CAP_4_BIT_DATA;
-			}
-			/* FALLTHROUGH */
-		case 3:
-			if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
-				/* off-chip level shifting, or none */
-				mmc->slots[0].before_set_reg = hsmmc23_before_set_reg;
-				mmc->slots[0].after_set_reg = NULL;
-			}
-			break;
-		case 4:
-		case 5:
-			mmc->slots[0].before_set_reg = NULL;
+		/* Omap3630 HSMMC1 supports only 4-bit */
+		if (cpu_is_omap3630() &&
+				(c->caps & MMC_CAP_8_BIT_DATA)) {
+			c->caps &= ~MMC_CAP_8_BIT_DATA;
+			c->caps |= MMC_CAP_4_BIT_DATA;
+			mmc->slots[0].caps = c->caps;
+		}
+		break;
+	case 2:
+		if (c->ext_clock)
+			c->transceiver = 1;
+		if (c->transceiver && (c->caps & MMC_CAP_8_BIT_DATA)) {
+			c->caps &= ~MMC_CAP_8_BIT_DATA;
+			c->caps |= MMC_CAP_4_BIT_DATA;
+		}
+		/* FALLTHROUGH */
+	case 3:
+		if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
+			/* off-chip level shifting, or none */
+			mmc->slots[0].before_set_reg = hsmmc23_before_set_reg;
 			mmc->slots[0].after_set_reg = NULL;
-			break;
-		default:
-			pr_err("MMC%d configuration not supported!\n", c->mmc);
-			kfree(mmc);
-			continue;
 		}
-		hsmmc_data[c->mmc - 1] = mmc;
+		break;
+	case 4:
+	case 5:
+		mmc->slots[0].before_set_reg = NULL;
+		mmc->slots[0].after_set_reg = NULL;
+		break;
+	default:
+		pr_err("MMC%d configuration not supported!\n", c->mmc);
+		return -ENODEV;
 	}
+	return 0;
+}
 
-	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
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
 
-	/* pass the device nodes back to board setup code */
-	for (c = controllers; c->mmc; c++) {
-		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
+static int omap_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
+{
+	struct omap_device *od;
+	struct omap_device_pm_latency *ohl;
+	char *name;
+	int ohl_cnt = 0;
+	struct omap_mmc_dev_attr *mmc_dev_attr = oh->dev_attr;
+	struct omap2_hsmmc_info *c = (struct omap2_hsmmc_info *) hsmmcinfo;
+	int idx;
+	static int mmc_num;
+
+	c += mmc_num;
+	if (!c->mmc) {
+		pr_err("omap_hsmmc_info is not updated in board file\n");
+		return 0;
+	}
+	mmc = kzalloc(sizeof(struct omap_mmc_platform_data),
+							GFP_KERNEL);
+	if (!mmc) {
+		pr_err("Cannot allocate memory for mmc device!\n");
+		kfree(mmc);
+		return -ENOMEM;
+	}
 
-		if (!c->mmc || c->mmc > nr_hsmmc)
-			continue;
-		c->dev = mmc->dev;
+	if (omap_hsmmc_pdata_init(c) < 0) {
+		pr_err("%s fails!\n", __func__);
+		return -ENXIO;
 	}
 
-done:
-	for (i = 0; i < nr_hsmmc; i++)
-		kfree(hsmmc_data[i]);
+	idx = c->mmc - 1 ;
+	name = "mmci-omap-hs";
+	ohl = omap_hsmmc_latency;
+	ohl_cnt = ARRAY_SIZE(omap_hsmmc_latency);
+	omap_hsmmc_mux(mmc, idx);
+
+	if (mmc_dev_attr != NULL)
+		mmc->controller_flags = mmc_dev_attr->flags;
+
+	od = omap_device_build(name, idx, oh, mmc,
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
+	kfree(mmc);
+	mmc_num++;
+	return 0;
 }
 
+void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
+{
+	u32 reg;
+
+	if (!cpu_is_omap44xx()) {
+		if (cpu_is_omap2430()) {
+			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
+			control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
+		} else {
+			control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
+			control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
+		}
+	} else {
+		control_pbias_offset =
+			OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE;
+		control_mmc1 = OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MMC1;
+		reg = omap4_ctrl_pad_readl(control_mmc1);
+		reg |= (OMAP4_SDMMC1_PUSTRENGTH_GRP0_MASK |
+			OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK);
+		reg &= ~(OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK |
+			OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK);
+		reg |= (OMAP4_USBC1_DR0_SPEEDCTRL_MASK|
+			OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK |
+			OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK);
+		omap4_ctrl_pad_writel(reg, control_mmc1);
+	}
+	omap_hwmod_for_each_by_class("mmc", omap_mmc_init, controllers);
+}
 #endif
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index a7afab0..f38fef9 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -24,22 +24,10 @@
 #define OMAP1_MMC2_BASE		0xfffb7c00	/* omap16xx only */
 
 #define OMAP24XX_NR_MMC		2
-#define OMAP34XX_NR_MMC		3
-#define OMAP44XX_NR_MMC		5
 #define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
-#define OMAP3_HSMMC_SIZE	0x200
-#define OMAP4_HSMMC_SIZE	0x1000
 #define OMAP2_MMC1_BASE		0x4809c000
-#define OMAP2_MMC2_BASE		0x480b4000
-#define OMAP3_MMC3_BASE		0x480ad000
-#define OMAP4_MMC4_BASE		0x480d1000
-#define OMAP4_MMC5_BASE		0x480d5000
+
 #define OMAP4_MMC_REG_OFFSET	0x100
-#define HSMMC5			(1 << 4)
-#define HSMMC4			(1 << 3)
-#define HSMMC3			(1 << 2)
-#define HSMMC2			(1 << 1)
-#define HSMMC1			(1 << 0)
 
 #define OMAP_MMC_MAX_SLOTS	2
 
@@ -169,8 +157,6 @@ extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
 void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
 void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
-void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
-				int nr_controllers);
 int omap_mmc_add(const char *name, int id, unsigned long base,
 				unsigned long size, unsigned int irq,
 				struct omap_mmc_platform_data *data);
@@ -182,10 +168,6 @@ static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
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
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8c42573..d0bd2b4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1571,7 +1571,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		/* Only MMC1 can interface at 3V without some flavor
 		 * of external transceiver; but they all handle 1.8V.
 		 */
@@ -1663,7 +1663,7 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 	u32 hctl, capa, value;
 
 	/* Only MMC1 supports 3.0V */
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		hctl = SDVS30;
 		capa = VS30 | VS18;
 	} else {
-- 
1.7.1

