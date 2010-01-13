From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 1/8] omap_hsmmc: move gpio and regulator control from board file
Date: Wed, 13 Jan 2010 13:40:18 +0200
Message-ID: <20100113114018.7615.66637.sendpatchset@ahunter-work.research.nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20708 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920Ab0AMLki (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2010 06:40:38 -0500
In-Reply-To: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

>From c2ed3074a73fc13d088c53193af546c01d1061b1 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 4 Jan 2010 13:44:36 +0200
Subject: [PATCH] omap_hsmmc: move gpio and regulator control from board file

This patch moves the setup code for GPIO's and Voltage
Regulators from the board file mmc-twl4030.c to the
driver omap_hsmmc.c.

Moving GPIO code to the driver makes the board initialisation
code independent of when GPIO's are defined.  That makes the
board initialisation now entirely independent of its original
twl4030 roots.

Moving Voltage Regulator code to the driver allows for further
development of regulator support in the core MMC code.  It also
permits the MMC core to be compiled as a module, because the
board code no longer calls MMC core functions.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/configs/rx51_defconfig       |    4 +-
 arch/arm/mach-omap2/control.c         |    2 +
 arch/arm/mach-omap2/mmc-twl4030.c     |  419 +--------------------------------
 arch/arm/mach-omap2/mmc-twl4030.h     |    4 +-
 arch/arm/plat-omap/include/plat/mmc.h |    2 +-
 drivers/mmc/host/omap_hsmmc.c         |  417 +++++++++++++++++++++++++++++++-
 6 files changed, 419 insertions(+), 429 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index b6eeebb..426ae94 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -1354,7 +1354,7 @@ CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
 # CONFIG_ISP1301_OMAP is not set
 CONFIG_TWL4030_USB=y
-CONFIG_MMC=y
+CONFIG_MMC=m
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
 
@@ -1362,7 +1362,7 @@ CONFIG_MMC=y
 # MMC/SD/SDIO Card Drivers
 #
 CONFIG_MMC_BLOCK=m
-CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
 # CONFIG_SDIO_UART is not set
 # CONFIG_MMC_TEST is not set
 
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index cdd1f35..f3e31dc 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -162,6 +162,7 @@ u32 omap_ctrl_readl(u16 offset)
 {
 	return __raw_readl(OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_readl);
 
 void omap_ctrl_writeb(u8 val, u16 offset)
 {
@@ -177,6 +178,7 @@ void omap_ctrl_writel(u32 val, u16 offset)
 {
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
+EXPORT_SYMBOL(omap_ctrl_writel);
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 /*
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 0c3c72d..e846d56 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -9,195 +9,22 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/mmc/host.h>
-#include <linux/regulator/consumer.h>
-
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <mach/hardware.h>
-#include <plat/control.h>
 #include <plat/mmc.h>
-#include <plat/board.h>
 
 #include "mmc-twl4030.h"
 
-
-#if defined(CONFIG_REGULATOR) && \
-	(defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE))
-
-static u16 control_pbias_offset;
-static u16 control_devconf1_offset;
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 #define HSMMC_NAME_LEN	9
 
 static struct twl_mmc_controller {
-	struct omap_mmc_platform_data	*mmc;
-	/* Vcc == configured supply
-	 * Vcc_alt == optional
-	 *   -	MMC1, supply for DAT4..DAT7
-	 *   -	MMC2/MMC2, external level shifter voltage supply, for
-	 *	chip (SDIO, eMMC, etc) or transceiver (MMC2 only)
-	 */
-	struct regulator		*vcc;
-	struct regulator		*vcc_aux;
 	char				name[HSMMC_NAME_LEN + 1];
 } hsmmc[OMAP34XX_NR_MMC];
 
-static int twl_mmc_card_detect(int irq)
-{
-	unsigned i;
-
-	for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
-		struct omap_mmc_platform_data *mmc;
-
-		mmc = hsmmc[i].mmc;
-		if (!mmc)
-			continue;
-		if (irq != mmc->slots[0].card_detect_irq)
-			continue;
-
-		/* NOTE: assumes card detect signal is active-low */
-		return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
-	}
-	return -ENOSYS;
-}
-
-static int twl_mmc_get_ro(struct device *dev, int slot)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-
-	/* NOTE: assumes write protect signal is active-high */
-	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
-}
-
-static int twl_mmc_get_cover_state(struct device *dev, int slot)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-
-	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
-}
-
-/*
- * MMC Slot Initialization.
- */
-static int twl_mmc_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-	int ret = 0;
-	int i;
-
-	/* MMC/SD/SDIO doesn't require a card detect switch */
-	if (gpio_is_valid(mmc->slots[0].switch_pin)) {
-		ret = gpio_request(mmc->slots[0].switch_pin, "mmc_cd");
-		if (ret)
-			goto done;
-		ret = gpio_direction_input(mmc->slots[0].switch_pin);
-		if (ret)
-			goto err;
-	}
-
-	/* require at least main regulator */
-	for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
-		if (hsmmc[i].name == mmc->slots[0].name) {
-			struct regulator *reg;
-
-			hsmmc[i].mmc = mmc;
-
-			reg = regulator_get(dev, "vmmc");
-			if (IS_ERR(reg)) {
-				dev_dbg(dev, "vmmc regulator missing\n");
-				/* HACK: until fixed.c regulator is usable,
-				 * we don't require a main regulator
-				 * for MMC2 or MMC3
-				 */
-				if (i != 0)
-					break;
-				ret = PTR_ERR(reg);
-				hsmmc[i].vcc = NULL;
-				goto err;
-			}
-			hsmmc[i].vcc = reg;
-			mmc->slots[0].ocr_mask = mmc_regulator_get_ocrmask(reg);
-
-			/* allow an aux regulator */
-			reg = regulator_get(dev, "vmmc_aux");
-			hsmmc[i].vcc_aux = IS_ERR(reg) ? NULL : reg;
-
-			/* UGLY HACK:  workaround regulator framework bugs.
-			 * When the bootloader leaves a supply active, it's
-			 * initialized with zero usecount ... and we can't
-			 * disable it without first enabling it.  Until the
-			 * framework is fixed, we need a workaround like this
-			 * (which is safe for MMC, but not in general).
-			 */
-			if (regulator_is_enabled(hsmmc[i].vcc) > 0) {
-				regulator_enable(hsmmc[i].vcc);
-				regulator_disable(hsmmc[i].vcc);
-			}
-			if (hsmmc[i].vcc_aux) {
-				if (regulator_is_enabled(reg) > 0) {
-					regulator_enable(reg);
-					regulator_disable(reg);
-				}
-			}
-
-			break;
-		}
-	}
-
-	return 0;
-
-err:
-	gpio_free(mmc->slots[0].switch_pin);
-done:
-	mmc->slots[0].card_detect_irq = 0;
-	mmc->slots[0].card_detect = NULL;
-
-	dev_err(dev, "err %d configuring card detect\n", ret);
-	return ret;
-}
-
-static void twl_mmc_cleanup(struct device *dev)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-	int i;
-
-	gpio_free(mmc->slots[0].switch_pin);
-	for(i = 0; i < ARRAY_SIZE(hsmmc); i++) {
-		regulator_put(hsmmc[i].vcc);
-		regulator_put(hsmmc[i].vcc_aux);
-	}
-}
-
-#ifdef CONFIG_PM
-
-static int twl_mmc_suspend(struct device *dev, int slot)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-
-	disable_irq(mmc->slots[0].card_detect_irq);
-	return 0;
-}
-
-static int twl_mmc_resume(struct device *dev, int slot)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-
-	enable_irq(mmc->slots[0].card_detect_irq);
-	return 0;
-}
-
-#else
-#define twl_mmc_suspend	NULL
-#define twl_mmc_resume	NULL
-#endif
-
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 
 static int twl4030_mmc_get_context_loss(struct device *dev)
@@ -210,198 +37,6 @@ static int twl4030_mmc_get_context_loss(struct device *dev)
 #define twl4030_mmc_get_context_loss NULL
 #endif
 
-static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
-				int vdd)
-{
-	u32 reg, prog_io;
-	int ret = 0;
-	struct twl_mmc_controller *c = &hsmmc[0];
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-
-	/*
-	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
-	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
-	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
-	 *
-	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
-	 * is most naturally TWL VSIM; those pins also use PBIAS.
-	 *
-	 * FIXME handle VMMC1A as needed ...
-	 */
-	if (power_on) {
-		if (cpu_is_omap2430()) {
-			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
-			if ((1 << vdd) >= MMC_VDD_30_31)
-				reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
-			else
-				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
-			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
-		}
-
-		if (mmc->slots[0].internal_clock) {
-			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
-			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
-		}
-
-		reg = omap_ctrl_readl(control_pbias_offset);
-		if (cpu_is_omap3630()) {
-			/* Set MMC I/O to 52Mhz */
-			prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
-			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
-			omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
-		} else {
-			reg |= OMAP2_PBIASSPEEDCTRL0;
-		}
-		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
-		omap_ctrl_writel(reg, control_pbias_offset);
-
-		ret = mmc_regulator_set_ocr(c->vcc, vdd);
-
-		/* 100ms delay required for PBIAS configuration */
-		msleep(100);
-		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
-		if ((1 << vdd) <= MMC_VDD_165_195)
-			reg &= ~OMAP2_PBIASLITEVMODE0;
-		else
-			reg |= OMAP2_PBIASLITEVMODE0;
-		omap_ctrl_writel(reg, control_pbias_offset);
-	} else {
-		reg = omap_ctrl_readl(control_pbias_offset);
-		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
-		omap_ctrl_writel(reg, control_pbias_offset);
-
-		ret = mmc_regulator_set_ocr(c->vcc, 0);
-
-		/* 100ms delay required for PBIAS configuration */
-		msleep(100);
-		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
-			OMAP2_PBIASLITEVMODE0);
-		omap_ctrl_writel(reg, control_pbias_offset);
-	}
-
-	return ret;
-}
-
-static int twl_mmc23_set_power(struct device *dev, int slot, int power_on, int vdd)
-{
-	int ret = 0;
-	struct twl_mmc_controller *c = NULL;
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-	int i;
-
-	for (i = 1; i < ARRAY_SIZE(hsmmc); i++) {
-		if (mmc == hsmmc[i].mmc) {
-			c = &hsmmc[i];
-			break;
-		}
-	}
-
-	if (c == NULL)
-		return -ENODEV;
-
-	/* If we don't see a Vcc regulator, assume it's a fixed
-	 * voltage always-on regulator.
-	 */
-	if (!c->vcc)
-		return 0;
-
-	/*
-	 * Assume Vcc regulator is used only to power the card ... OMAP
-	 * VDDS is used to power the pins, optionally with a transceiver to
-	 * support cards using voltages other than VDDS (1.8V nominal).  When a
-	 * transceiver is used, DAT3..7 are muxed as transceiver control pins.
-	 *
-	 * In some cases this regulator won't support enable/disable;
-	 * e.g. it's a fixed rail for a WLAN chip.
-	 *
-	 * In other cases vcc_aux switches interface power.  Example, for
-	 * eMMC cards it represents VccQ.  Sometimes transceivers or SDIO
-	 * chips/cards need an interface voltage rail too.
-	 */
-	if (power_on) {
-		/* only MMC2 supports a CLKIN */
-		if (mmc->slots[0].internal_clock) {
-			u32 reg;
-
-			reg = omap_ctrl_readl(control_devconf1_offset);
-			reg |= OMAP2_MMCSDIO2ADPCLKISEL;
-			omap_ctrl_writel(reg, control_devconf1_offset);
-		}
-		ret = mmc_regulator_set_ocr(c->vcc, vdd);
-		/* enable interface voltage rail, if needed */
-		if (ret == 0 && c->vcc_aux) {
-			ret = regulator_enable(c->vcc_aux);
-			if (ret < 0)
-				ret = mmc_regulator_set_ocr(c->vcc, 0);
-		}
-	} else {
-		if (c->vcc_aux && (ret = regulator_is_enabled(c->vcc_aux)) > 0)
-			ret = regulator_disable(c->vcc_aux);
-		if (ret == 0)
-			ret = mmc_regulator_set_ocr(c->vcc, 0);
-	}
-
-	return ret;
-}
-
-static int twl_mmc1_set_sleep(struct device *dev, int slot, int sleep, int vdd,
-			      int cardsleep)
-{
-	struct twl_mmc_controller *c = &hsmmc[0];
-	int mode = sleep ? REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
-
-	return regulator_set_mode(c->vcc, mode);
-}
-
-static int twl_mmc23_set_sleep(struct device *dev, int slot, int sleep, int vdd,
-			       int cardsleep)
-{
-	struct twl_mmc_controller *c = NULL;
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-	int i, err, mode;
-
-	for (i = 1; i < ARRAY_SIZE(hsmmc); i++) {
-		if (mmc == hsmmc[i].mmc) {
-			c = &hsmmc[i];
-			break;
-		}
-	}
-
-	if (c == NULL)
-		return -ENODEV;
-
-	/*
-	 * If we don't see a Vcc regulator, assume it's a fixed
-	 * voltage always-on regulator.
-	 */
-	if (!c->vcc)
-		return 0;
-
-	mode = sleep ? REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
-
-	if (!c->vcc_aux)
-		return regulator_set_mode(c->vcc, mode);
-
-	if (cardsleep) {
-		/* VCC can be turned off if card is asleep */
-		struct regulator *vcc_aux = c->vcc_aux;
-
-		c->vcc_aux = NULL;
-		if (sleep)
-			err = twl_mmc23_set_power(dev, slot, 0, 0);
-		else
-			err = twl_mmc23_set_power(dev, slot, 1, vdd);
-		c->vcc_aux = vcc_aux;
-	} else
-		err = regulator_set_mode(c->vcc, mode);
-	if (err)
-		return err;
-	return regulator_set_mode(c->vcc_aux, mode);
-}
-
 static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
 
 void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
@@ -409,15 +44,6 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 	struct twl4030_hsmmc_info *c;
 	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
 
-	if (cpu_is_omap2430()) {
-		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
-		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
-		nr_hsmmc = 2;
-	} else {
-		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
-		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
-	}
-
 	for (c = controllers; c->mmc; c++) {
 		struct twl_mmc_controller *twl = hsmmc + c->mmc - 1;
 		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
@@ -447,35 +73,15 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		mmc->slots[0].wires = c->wires;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
-		mmc->init = twl_mmc_late_init;
-
-		/* note: twl4030 card detect GPIOs can disable VMMCx ... */
-		if (gpio_is_valid(c->gpio_cd)) {
-			mmc->cleanup = twl_mmc_cleanup;
-			mmc->suspend = twl_mmc_suspend;
-			mmc->resume = twl_mmc_resume;
-
-			mmc->slots[0].switch_pin = c->gpio_cd;
-			mmc->slots[0].card_detect_irq = gpio_to_irq(c->gpio_cd);
-			if (c->cover_only)
-				mmc->slots[0].get_cover_state = twl_mmc_get_cover_state;
-			else
-				mmc->slots[0].card_detect = twl_mmc_card_detect;
-		} else
-			mmc->slots[0].switch_pin = -EINVAL;
 
 		mmc->get_context_loss_count =
 				twl4030_mmc_get_context_loss;
 
-		/* write protect normally uses an OMAP gpio */
-		if (gpio_is_valid(c->gpio_wp)) {
-			gpio_request(c->gpio_wp, "mmc_wp");
-			gpio_direction_input(c->gpio_wp);
+		mmc->slots[0].switch_pin = c->gpio_cd;
+		mmc->slots[0].gpio_wp = c->gpio_wp;
 
-			mmc->slots[0].gpio_wp = c->gpio_wp;
-			mmc->slots[0].get_ro = twl_mmc_get_ro;
-		} else
-			mmc->slots[0].gpio_wp = -EINVAL;
+		if (c->cover_only)
+			mmc->slots[0].cover = 1;
 
 		if (c->nonremovable)
 			mmc->slots[0].nonremovable = 1;
@@ -493,10 +99,6 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 
 		switch (c->mmc) {
 		case 1:
-			/* on-chip level shifting via PBIAS0/PBIAS1 */
-			mmc->slots[0].set_power = twl_mmc1_set_power;
-			mmc->slots[0].set_sleep = twl_mmc1_set_sleep;
-
 			/* Omap3630 HSMMC1 supports only 4-bit */
 			if (cpu_is_omap3630() && c->wires > 4) {
 				c->wires = 4;
@@ -508,11 +110,8 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 				c->transceiver = 1;
 			if (c->transceiver && c->wires > 4)
 				c->wires = 4;
-			/* FALLTHROUGH */
+			break;
 		case 3:
-			/* off-chip level shifting, or none */
-			mmc->slots[0].set_power = twl_mmc23_set_power;
-			mmc->slots[0].set_sleep = twl_mmc23_set_sleep;
 			break;
 		default:
 			pr_err("MMC%d configuration not supported!\n", c->mmc);
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index a47e685..87d67c1 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -21,9 +21,7 @@ struct twl4030_hsmmc_info {
 	int	ocr_mask;	/* temporary HACK */
 };
 
-#if defined(CONFIG_REGULATOR) && \
-	(defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
-	 defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE))
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 void twl4030_mmc_init(struct twl4030_hsmmc_info *);
 
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 2993713..6af87b0 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -118,7 +118,7 @@ struct omap_mmc_platform_data {
 
 		/* Card detection IRQs */
 		int card_detect_irq;
-		int (* card_detect)(int irq);
+		int (* card_detect)(struct device *dev, int slot);
 
 		unsigned int ban_openended:1;
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4b23225..63d24df 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -30,11 +30,14 @@
 #include <linux/mmc/core.h>
 #include <linux/io.h>
 #include <linux/semaphore.h>
+#include <linux/gpio.h>
+#include <linux/regulator/consumer.h>
 #include <plat/dma.h>
 #include <mach/hardware.h>
 #include <plat/board.h>
 #include <plat/mmc.h>
 #include <plat/cpu.h>
+#include <plat/control.h>
 
 /* OMAP HSMMC Host Controller Registers */
 #define OMAP_HSMMC_SYSCONFIG	0x0010
@@ -146,6 +149,15 @@ struct omap_hsmmc_host {
 	struct	clk		*fclk;
 	struct	clk		*iclk;
 	struct	clk		*dbclk;
+	/*
+	 * vcc == configured supply
+	 * vcc_aux == optional
+	 *   -	MMC1, supply for DAT4..DAT7
+	 *   -	MMC2/MMC2, external level shifter voltage supply, for
+	 *	chip (SDIO, eMMC, etc) or transceiver (MMC2 only)
+	 */
+	struct	regulator	*vcc;
+	struct	regulator	*vcc_aux;
 	struct	semaphore	sem;
 	struct	work_struct	mmc_carddetect_work;
 	void	__iomem		*base;
@@ -171,10 +183,372 @@ struct omap_hsmmc_host {
 	int			vdd;
 	int			protect_card;
 	int			reqs_blocked;
+	int			use_reg;
 
 	struct	omap_mmc_platform_data	*pdata;
 };
 
+static int omap_hsmmc_card_detect(struct device *dev, int slot)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	/* NOTE: assumes card detect signal is active-low */
+	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+}
+
+static int omap_hsmmc_get_wp(struct device *dev, int slot)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	/* NOTE: assumes write protect signal is active-high */
+	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
+}
+
+static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	/* NOTE: assumes card detect signal is active-low */
+	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+}
+
+#ifdef CONFIG_PM
+
+static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	disable_irq(mmc->slots[0].card_detect_irq);
+	return 0;
+}
+
+static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	enable_irq(mmc->slots[0].card_detect_irq);
+	return 0;
+}
+
+#else
+
+#define omap_hsmmc_suspend_cdirq	NULL
+#define omap_hsmmc_resume_cdirq		NULL
+
+#endif
+
+static int omap_hsmmc_1_set_power(struct device *dev, int slot, int power_on,
+				  int vdd)
+{
+	struct omap_hsmmc_host *host =
+		platform_get_drvdata(to_platform_device(dev));
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	u16 control_pbias_offset;
+	u32 reg, prog_io;
+	int ret = 0;
+
+	if (cpu_is_omap2430())
+		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
+	else
+		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
+
+	/*
+	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
+	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
+	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
+	 *
+	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
+	 * is most naturally TWL VSIM; those pins also use PBIAS.
+	 *
+	 * FIXME handle VMMC1A as needed ...
+	 */
+	if (power_on) {
+		if (cpu_is_omap2430()) {
+			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
+			if ((1 << vdd) >= MMC_VDD_30_31)
+				reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
+			else
+				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
+			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
+		}
+
+		if (mmc->slots[0].internal_clock) {
+			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
+			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
+		}
+
+		reg = omap_ctrl_readl(control_pbias_offset);
+		if (cpu_is_omap3630()) {
+			/* Set MMC I/O to 52Mhz */
+			prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
+			prog_io |= OMAP3630_PRG_SDMMC1_SPEEDCTRL;
+			omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
+		} else {
+			reg |= OMAP2_PBIASSPEEDCTRL0;
+		}
+		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
+		omap_ctrl_writel(reg, control_pbias_offset);
+
+		ret = mmc_regulator_set_ocr(host->vcc, vdd);
+
+		/* 100ms delay required for PBIAS configuration */
+		msleep(100);
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
+		if ((1 << vdd) <= MMC_VDD_165_195)
+			reg &= ~OMAP2_PBIASLITEVMODE0;
+		else
+			reg |= OMAP2_PBIASLITEVMODE0;
+		omap_ctrl_writel(reg, control_pbias_offset);
+	} else {
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
+		omap_ctrl_writel(reg, control_pbias_offset);
+
+		ret = mmc_regulator_set_ocr(host->vcc, 0);
+
+		/* 100ms delay required for PBIAS configuration */
+		msleep(100);
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
+			OMAP2_PBIASLITEVMODE0);
+		omap_ctrl_writel(reg, control_pbias_offset);
+	}
+
+	return ret;
+}
+
+static int omap_hsmmc_23_set_power(struct device *dev, int slot, int power_on,
+				   int vdd)
+{
+	struct omap_hsmmc_host *host =
+		platform_get_drvdata(to_platform_device(dev));
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	int ret = 0;
+
+	/*
+	 * If we don't see a Vcc regulator, assume it's a fixed
+	 * voltage always-on regulator.
+	 */
+	if (!host->vcc)
+		return 0;
+
+	/*
+	 * Assume Vcc regulator is used only to power the card ... OMAP
+	 * VDDS is used to power the pins, optionally with a transceiver to
+	 * support cards using voltages other than VDDS (1.8V nominal).  When a
+	 * transceiver is used, DAT3..7 are muxed as transceiver control pins.
+	 *
+	 * In some cases this regulator won't support enable/disable;
+	 * e.g. it's a fixed rail for a WLAN chip.
+	 *
+	 * In other cases vcc_aux switches interface power.  Example, for
+	 * eMMC cards it represents VccQ.  Sometimes transceivers or SDIO
+	 * chips/cards need an interface voltage rail too.
+	 */
+	if (power_on) {
+		/* Only MMC2 supports a CLKIN */
+		if (mmc->slots[0].internal_clock) {
+			u32 reg;
+			u16 offs;
+
+			if (cpu_is_omap2430())
+				offs = OMAP243X_CONTROL_DEVCONF1;
+			else
+				offs = OMAP343X_CONTROL_DEVCONF1;
+			reg = omap_ctrl_readl(offs);
+			reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+			omap_ctrl_writel(reg, offs);
+		}
+		ret = mmc_regulator_set_ocr(host->vcc, vdd);
+		/* Enable interface voltage rail, if needed */
+		if (ret == 0 && host->vcc_aux) {
+			ret = regulator_enable(host->vcc_aux);
+			if (ret < 0)
+				ret = mmc_regulator_set_ocr(host->vcc, 0);
+		}
+	} else {
+		if (host->vcc_aux && (ret = regulator_is_enabled(host->vcc_aux)) > 0)
+			ret = regulator_disable(host->vcc_aux);
+		if (ret == 0)
+			ret = mmc_regulator_set_ocr(host->vcc, 0);
+	}
+
+	return ret;
+}
+
+static int omap_hsmmc_1_set_sleep(struct device *dev, int slot, int sleep,
+				  int vdd, int cardsleep)
+{
+	struct omap_hsmmc_host *host =
+		platform_get_drvdata(to_platform_device(dev));
+	int mode = sleep ? REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
+
+	return regulator_set_mode(host->vcc, mode);
+}
+
+static int omap_hsmmc_23_set_sleep(struct device *dev, int slot, int sleep,
+				   int vdd, int cardsleep)
+{
+	struct omap_hsmmc_host *host =
+		platform_get_drvdata(to_platform_device(dev));
+	int err, mode;
+
+	/*
+	 * If we don't see a Vcc regulator, assume it's a fixed
+	 * voltage always-on regulator.
+	 */
+	if (!host->vcc)
+		return 0;
+
+	mode = sleep ? REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
+
+	if (!host->vcc_aux)
+		return regulator_set_mode(host->vcc, mode);
+
+	if (cardsleep) {
+		/* VCC can be turned off if card is asleep */
+		if (sleep)
+			err = mmc_regulator_set_ocr(host->vcc, 0);
+		else
+			err = mmc_regulator_set_ocr(host->vcc, vdd);
+	} else
+		err = regulator_set_mode(host->vcc, mode);
+	if (err)
+		return err;
+	return regulator_set_mode(host->vcc_aux, mode);
+}
+
+static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
+{
+	int ret;
+
+	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
+		pdata->suspend = omap_hsmmc_suspend_cdirq;
+		pdata->resume = omap_hsmmc_resume_cdirq;
+		if (pdata->slots[0].cover)
+			pdata->slots[0].get_cover_state = omap_hsmmc_get_cover_state;
+		else
+			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
+		pdata->slots[0].card_detect_irq = gpio_to_irq(pdata->slots[0].switch_pin);
+		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
+		if (ret)
+			return ret;
+		ret = gpio_direction_input(pdata->slots[0].switch_pin);
+		if (ret)
+			goto err_free_sp;
+	} else
+		pdata->slots[0].switch_pin = -EINVAL;
+
+	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
+		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
+		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
+		if (ret)
+			goto err_free_cd;
+		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
+		if (ret)
+			goto err_free_wp;
+	} else
+		pdata->slots[0].gpio_wp = -EINVAL;
+
+	return 0;
+
+err_free_wp:
+	gpio_free(pdata->slots[0].gpio_wp);
+err_free_cd:
+	if (gpio_is_valid(pdata->slots[0].switch_pin))
+err_free_sp:
+		gpio_free(pdata->slots[0].switch_pin);
+	return ret;
+}
+
+static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
+{
+	if (gpio_is_valid(pdata->slots[0].gpio_wp))
+		gpio_free(pdata->slots[0].gpio_wp);
+	if (gpio_is_valid(pdata->slots[0].switch_pin))
+		gpio_free(pdata->slots[0].switch_pin);
+}
+
+static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
+{
+	struct regulator *reg;
+	int ret = 0;
+
+	switch (host->id) {
+	case OMAP_MMC1_DEVID:
+		/* On-chip level shifting via PBIAS0/PBIAS1 */
+		mmc_slot(host).set_power = omap_hsmmc_1_set_power;
+		mmc_slot(host).set_sleep = omap_hsmmc_1_set_sleep;
+		break;
+	case OMAP_MMC2_DEVID:
+	case OMAP_MMC3_DEVID:
+		/* Off-chip level shifting, or none */
+		mmc_slot(host).set_power = omap_hsmmc_23_set_power;
+		mmc_slot(host).set_sleep = omap_hsmmc_23_set_sleep;
+		break;
+	default:
+		pr_err("MMC%d configuration not supported!\n", host->id);
+		return -EINVAL;
+	}
+
+	reg = regulator_get(host->dev, "vmmc");
+	if (IS_ERR(reg)) {
+		dev_dbg(host->dev, "vmmc regulator missing\n");
+		/*
+		* HACK: until fixed.c regulator is usable,
+		* we don't require a main regulator
+		* for MMC2 or MMC3
+		*/
+		if (host->id == OMAP_MMC1_DEVID) {
+			ret = PTR_ERR(reg);
+			goto err;
+		}
+	} else {
+		host->vcc = reg;
+		mmc_slot(host).ocr_mask = mmc_regulator_get_ocrmask(reg);
+
+		/* Allow an aux regulator */
+		reg = regulator_get(host->dev, "vmmc_aux");
+		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
+
+		/*
+		* UGLY HACK:  workaround regulator framework bugs.
+		* When the bootloader leaves a supply active, it's
+		* initialized with zero usecount ... and we can't
+		* disable it without first enabling it.  Until the
+		* framework is fixed, we need a workaround like this
+		* (which is safe for MMC, but not in general).
+		*/
+		if (regulator_is_enabled(host->vcc) > 0) {
+			regulator_enable(host->vcc);
+			regulator_disable(host->vcc);
+		}
+		if (host->vcc_aux) {
+			if (regulator_is_enabled(reg) > 0) {
+				regulator_enable(reg);
+				regulator_disable(reg);
+			}
+		}
+	}
+
+	return 0;
+
+err:
+	mmc_slot(host).set_power = NULL;
+	mmc_slot(host).set_sleep = NULL;
+	return ret;
+}
+
+static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
+{
+	regulator_put(host->vcc);
+	regulator_put(host->vcc_aux);
+	mmc_slot(host).set_power = NULL;
+	mmc_slot(host).set_sleep = NULL;
+}
+
 /*
  * Stop clock to the card
  */
@@ -835,7 +1209,7 @@ static void omap_hsmmc_detect(struct work_struct *work)
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 
 	if (slot->card_detect)
-		carddetect = slot->card_detect(slot->card_detect_irq);
+		carddetect = slot->card_detect(host->dev, host->slot_id);
 	else {
 		omap_hsmmc_protect_card(host);
 		carddetect = -ENOSYS;
@@ -1242,7 +1616,7 @@ static int omap_hsmmc_get_cd(struct mmc_host *mmc)
 
 	if (!mmc_slot(host).card_detect)
 		return -ENOSYS;
-	return mmc_slot(host).card_detect(mmc_slot(host).card_detect_irq);
+	return mmc_slot(host).card_detect(host->dev, host->slot_id);
 }
 
 static int omap_hsmmc_get_ro(struct mmc_host *mmc)
@@ -1616,7 +1990,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
-	int ret = 0, irq;
+	int ret, irq;
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "Platform Data is missing\n");
@@ -1638,10 +2012,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL)
 		return -EBUSY;
 
+	ret = omap_hsmmc_gpio_init(pdata);
+	if (ret)
+		goto err;
+
 	mmc = mmc_alloc_host(sizeof(struct omap_hsmmc_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
-		goto err;
+		goto err_alloc;
 	}
 
 	host		= mmc_priv(mmc);
@@ -1781,7 +2159,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	/* initialize power supplies, gpios, etc */
 	if (pdata->init != NULL) {
 		if (pdata->init(&pdev->dev) != 0) {
 			dev_dbg(mmc_dev(host->mmc),
@@ -1789,6 +2166,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 			goto err_irq_cd_init;
 		}
 	}
+
+	if (!mmc_slot(host).set_power) {
+		ret = omap_hsmmc_reg_get(host);
+		if (ret)
+			goto err_reg;
+		host->use_reg = 1;
+	}
+
 	mmc->ocr_avail = mmc_slot(host).ocr_mask;
 
 	/* Request IRQ for card detect */
@@ -1823,19 +2208,22 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		ret = device_create_file(&mmc->class_dev,
 					&dev_attr_cover_switch);
 		if (ret < 0)
-			goto err_cover_switch;
+			goto err_slot_name;
 	}
 
 	omap_hsmmc_debugfs(mmc);
 
 	return 0;
 
-err_cover_switch:
-	device_remove_file(&mmc->class_dev, &dev_attr_cover_switch);
 err_slot_name:
 	mmc_remove_host(mmc);
-err_irq_cd:
 	free_irq(mmc_slot(host).card_detect_irq, host);
+err_irq_cd:
+	if (host->use_reg)
+		omap_hsmmc_reg_put(host);
+err_reg:
+	if (host->pdata->cleanup)
+		host->pdata->cleanup(&pdev->dev);
 err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
@@ -1847,14 +2235,14 @@ err_irq:
 		clk_disable(host->dbclk);
 		clk_put(host->dbclk);
 	}
-
 err1:
 	iounmap(host->base);
+	platform_set_drvdata(pdev, NULL);
+	mmc_free_host(mmc);
+err_alloc:
+	omap_hsmmc_gpio_free(pdata);
 err:
-	dev_dbg(mmc_dev(host->mmc), "Probe Failed\n");
 	release_mem_region(res->start, res->end - res->start + 1);
-	if (host)
-		mmc_free_host(mmc);
 	return ret;
 }
 
@@ -1866,6 +2254,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host) {
 		mmc_host_enable(host->mmc);
 		mmc_remove_host(host->mmc);
+		if (host->use_reg)
+			omap_hsmmc_reg_put(host);
 		if (host->pdata->cleanup)
 			host->pdata->cleanup(&pdev->dev);
 		free_irq(host->irq, host);
@@ -1884,6 +2274,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
 		mmc_free_host(host->mmc);
 		iounmap(host->base);
+		omap_hsmmc_gpio_free(pdev->dev.platform_data);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.6.0.4

