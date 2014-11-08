From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v4 07/10] omap_hsmmc: remove unnecessary omap_hsmmc_slot_data indirection
Date: Sat,  8 Nov 2014 15:33:14 +0100
Message-ID: <1415457197-14294-8-git-send-email-afenkart@gmail.com>
References: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37141 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaKHOdp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Nov 2014 09:33:45 -0500
In-Reply-To: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

omap_hsmmc supports only one slot per controller, see OMAP_MMC_MAX_SLOTS.
This unnecessary indirection leads to confusion in the omap_hsmmc driver.
For example the card_detect callback is not installed by platform code
but from the driver probe function. So it should be a field of
omap_hsmmc_host. But since it is declared under the platform slot while
the drivers struct omap_hsmmc_host has no slot abstraction, this looks
like a bug, especially when not familiar that this driver only supports
1 slot anyway.
Either we should add a slot abstraction to omap_hsmmc_host or remove
it from the platform data struct. Removed since slot multiplexing is
an un-implemented feature

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/hsmmc.c              |  88 ++++++++--------
 drivers/mmc/host/omap_hsmmc.c            | 175 ++++++++++++++++---------------
 include/linux/platform_data/hsmmc-omap.h | 100 +++++++++---------
 3 files changed, 181 insertions(+), 182 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index c65efc3..4e2896a 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -39,8 +39,8 @@ static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 	u32 reg, prog_io;
 	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
-	if (mmc->slots[0].remux)
-		mmc->slots[0].remux(dev, slot, power_on);
+	if (mmc->remux)
+		mmc->remux(dev, slot, power_on);
 
 	/*
 	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
@@ -62,7 +62,7 @@ static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
 		}
 
-		if (mmc->slots[0].internal_clock) {
+		if (mmc->internal_clock) {
 			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
 			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
@@ -115,7 +115,7 @@ static void hsmmc2_select_input_clk_src(struct omap_hsmmc_platform_data *mmc)
 	u32 reg;
 
 	reg = omap_ctrl_readl(control_devconf1_offset);
-	if (mmc->slots[0].internal_clock)
+	if (mmc->internal_clock)
 		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
 	else
 		reg &= ~OMAP2_MMCSDIO2ADPCLKISEL;
@@ -127,8 +127,8 @@ static void hsmmc2_before_set_reg(struct device *dev, int slot,
 {
 	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
-	if (mmc->slots[0].remux)
-		mmc->slots[0].remux(dev, slot, power_on);
+	if (mmc->remux)
+		mmc->remux(dev, slot, power_on);
 
 	if (power_on)
 		hsmmc2_select_input_clk_src(mmc);
@@ -154,14 +154,14 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
 static inline void omap_hsmmc_mux(struct omap_hsmmc_platform_data
 				  *mmc_controller, int controller_nr)
 {
-	if (gpio_is_valid(mmc_controller->slots[0].switch_pin) &&
-		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
-					OMAP_PIN_INPUT_PULLUP);
-	if (gpio_is_valid(mmc_controller->slots[0].gpio_wp) &&
-		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
-					OMAP_PIN_INPUT_PULLUP);
+	if (gpio_is_valid(mmc_controller->switch_pin) &&
+	    (mmc_controller->switch_pin < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->switch_pin,
+				   OMAP_PIN_INPUT_PULLUP);
+	if (gpio_is_valid(mmc_controller->gpio_wp) &&
+	    (mmc_controller->gpio_wp < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->gpio_wp,
+				   OMAP_PIN_INPUT_PULLUP);
 	if (cpu_is_omap34xx()) {
 		if (controller_nr == 0) {
 			omap_mux_init_signal("sdmmc1_clk",
@@ -170,7 +170,7 @@ static inline void omap_hsmmc_mux(struct omap_hsmmc_platform_data
 				OMAP_PIN_INPUT_PULLUP);
 			omap_mux_init_signal("sdmmc1_dat0",
 				OMAP_PIN_INPUT_PULLUP);
-			if (mmc_controller->slots[0].caps &
+			if (mmc_controller->caps &
 				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
 				omap_mux_init_signal("sdmmc1_dat1",
 					OMAP_PIN_INPUT_PULLUP);
@@ -179,7 +179,7 @@ static inline void omap_hsmmc_mux(struct omap_hsmmc_platform_data
 				omap_mux_init_signal("sdmmc1_dat3",
 					OMAP_PIN_INPUT_PULLUP);
 			}
-			if (mmc_controller->slots[0].caps &
+			if (mmc_controller->caps &
 						MMC_CAP_8_BIT_DATA) {
 				omap_mux_init_signal("sdmmc1_dat4",
 					OMAP_PIN_INPUT_PULLUP);
@@ -204,7 +204,7 @@ static inline void omap_hsmmc_mux(struct omap_hsmmc_platform_data
 			 * For 8 wire configurations, Lines DAT4, 5, 6 and 7
 			 * need to be muxed in the board-*.c files
 			 */
-			if (mmc_controller->slots[0].caps &
+			if (mmc_controller->caps &
 				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
 				omap_mux_init_signal("sdmmc2_dat1",
 					OMAP_PIN_INPUT_PULLUP);
@@ -213,7 +213,7 @@ static inline void omap_hsmmc_mux(struct omap_hsmmc_platform_data
 				omap_mux_init_signal("sdmmc2_dat3",
 					OMAP_PIN_INPUT_PULLUP);
 			}
-			if (mmc_controller->slots[0].caps &
+			if (mmc_controller->caps &
 							MMC_CAP_8_BIT_DATA) {
 				omap_mux_init_signal("sdmmc2_dat4.sdmmc2_dat4",
 					OMAP_PIN_INPUT_PULLUP);
@@ -249,23 +249,23 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	else
 		snprintf(hc_name, (HSMMC_NAME_LEN + 1), "mmc%islot%i",
 								c->mmc, 1);
-	mmc->slots[0].name = hc_name;
+	mmc->name = hc_name;
 	mmc->nr_slots = 1;
-	mmc->slots[0].caps = c->caps;
-	mmc->slots[0].internal_clock = !c->ext_clock;
+	mmc->caps = c->caps;
+	mmc->internal_clock = !c->ext_clock;
 	mmc->reg_offset = 0;
 
-	mmc->slots[0].switch_pin = c->gpio_cd;
-	mmc->slots[0].gpio_wp = c->gpio_wp;
+	mmc->switch_pin = c->gpio_cd;
+	mmc->gpio_wp = c->gpio_wp;
 
-	mmc->slots[0].remux = c->remux;
-	mmc->slots[0].init_card = c->init_card;
+	mmc->remux = c->remux;
+	mmc->init_card = c->init_card;
 
 	if (c->cover_only)
-		mmc->slots[0].cover = 1;
+		mmc->cover = 1;
 
 	if (c->nonremovable)
-		mmc->slots[0].nonremovable = 1;
+		mmc->nonremovable = 1;
 
 	/*
 	 * NOTE:  MMC slots should have a Vcc regulator set up.
@@ -275,42 +275,42 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	 * temporary HACK: ocr_mask instead of fixed supply
 	 */
 	if (soc_is_am35xx())
-		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
+		mmc->ocr_mask = MMC_VDD_165_195 |
 					 MMC_VDD_26_27 |
 					 MMC_VDD_27_28 |
 					 MMC_VDD_29_30 |
 					 MMC_VDD_30_31 |
 					 MMC_VDD_31_32;
 	else
-		mmc->slots[0].ocr_mask = c->ocr_mask;
+		mmc->ocr_mask = c->ocr_mask;
 
 	if (!soc_is_am35xx())
-		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
+		mmc->features |= HSMMC_HAS_PBIAS;
 
 	switch (c->mmc) {
 	case 1:
-		if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
+		if (mmc->features & HSMMC_HAS_PBIAS) {
 			/* on-chip level shifting via PBIAS0/PBIAS1 */
-			mmc->slots[0].before_set_reg =
+			mmc->before_set_reg =
 					omap_hsmmc1_before_set_reg;
-			mmc->slots[0].after_set_reg =
+			mmc->after_set_reg =
 					omap_hsmmc1_after_set_reg;
 		}
 
 		if (soc_is_am35xx())
-			mmc->slots[0].set_power = nop_mmc_set_power;
+			mmc->set_power = nop_mmc_set_power;
 
 		/* OMAP3630 HSMMC1 supports only 4-bit */
 		if (cpu_is_omap3630() &&
 				(c->caps & MMC_CAP_8_BIT_DATA)) {
 			c->caps &= ~MMC_CAP_8_BIT_DATA;
 			c->caps |= MMC_CAP_4_BIT_DATA;
-			mmc->slots[0].caps = c->caps;
+			mmc->caps = c->caps;
 		}
 		break;
 	case 2:
 		if (soc_is_am35xx())
-			mmc->slots[0].set_power = am35x_hsmmc2_set_power;
+			mmc->set_power = am35x_hsmmc2_set_power;
 
 		if (c->ext_clock)
 			c->transceiver = 1;
@@ -318,17 +318,17 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			c->caps &= ~MMC_CAP_8_BIT_DATA;
 			c->caps |= MMC_CAP_4_BIT_DATA;
 		}
-		if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
+		if (mmc->features & HSMMC_HAS_PBIAS) {
 			/* off-chip level shifting, or none */
-			mmc->slots[0].before_set_reg = hsmmc2_before_set_reg;
-			mmc->slots[0].after_set_reg = NULL;
+			mmc->before_set_reg = hsmmc2_before_set_reg;
+			mmc->after_set_reg = NULL;
 		}
 		break;
 	case 3:
 	case 4:
 	case 5:
-		mmc->slots[0].before_set_reg = NULL;
-		mmc->slots[0].after_set_reg = NULL;
+		mmc->before_set_reg = NULL;
+		mmc->after_set_reg = NULL;
 		break;
 	default:
 		pr_err("MMC%d configuration not supported!\n", c->mmc);
@@ -363,8 +363,8 @@ void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
 		if (!mmc_pdata)
 			continue;
 
-		mmc_pdata->slots[0].switch_pin = c->gpio_cd;
-		mmc_pdata->slots[0].gpio_wp = c->gpio_wp;
+		mmc_pdata->switch_pin = c->gpio_cd;
+		mmc_pdata->gpio_wp = c->gpio_wp;
 
 		res = omap_device_register(pdev);
 		if (res)
@@ -464,7 +464,7 @@ put_pdev:
 	platform_device_put(pdev);
 
 free_name:
-	kfree(mmc_data->slots[0].name);
+	kfree(mmc_data->name);
 
 free_mmc:
 	kfree(mmc_data);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 03e8e9a..291b9e1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -155,7 +155,7 @@
  * omap.c controller driver. Luckily this is not currently done on any known
  * omap_hsmmc.c device.
  */
-#define mmc_slot(host)		(host->pdata->slots[host->slot_id])
+#define mmc_pdata(host)		host->pdata
 
 /*
  * MMC Host controller read/write API's
@@ -236,7 +236,7 @@ static int omap_hsmmc_card_detect(struct device *dev, int slot)
 	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+	return !gpio_get_value_cansleep(mmc->switch_pin);
 }
 
 static int omap_hsmmc_get_wp(struct device *dev, int slot)
@@ -245,7 +245,7 @@ static int omap_hsmmc_get_wp(struct device *dev, int slot)
 	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes write protect signal is active-high */
-	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
+	return gpio_get_value_cansleep(mmc->gpio_wp);
 }
 
 static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
@@ -254,7 +254,7 @@ static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+	return !gpio_get_value_cansleep(mmc->switch_pin);
 }
 
 #ifdef CONFIG_PM
@@ -264,7 +264,7 @@ static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
-	disable_irq(mmc->slots[0].card_detect_irq);
+	disable_irq(mmc->card_detect_irq);
 	return 0;
 }
 
@@ -273,7 +273,7 @@ static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
-	enable_irq(mmc->slots[0].card_detect_irq);
+	enable_irq(mmc->card_detect_irq);
 	return 0;
 }
 
@@ -300,8 +300,8 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	if (!host->vcc)
 		return 0;
 
-	if (mmc_slot(host).before_set_reg)
-		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
+	if (mmc_pdata(host)->before_set_reg)
+		mmc_pdata(host)->before_set_reg(dev, slot, power_on, vdd);
 
 	if (host->pbias) {
 		if (host->pbias_enabled == 1) {
@@ -363,8 +363,8 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 		}
 	}
 
-	if (mmc_slot(host).after_set_reg)
-		mmc_slot(host).after_set_reg(dev, slot, power_on, vdd);
+	if (mmc_pdata(host)->after_set_reg)
+		mmc_pdata(host)->after_set_reg(dev, slot, power_on, vdd);
 
 error_set_power:
 	return ret;
@@ -383,18 +383,18 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	} else {
 		host->vcc = reg;
 		ocr_value = mmc_regulator_get_ocrmask(reg);
-		if (!mmc_slot(host).ocr_mask) {
-			mmc_slot(host).ocr_mask = ocr_value;
+		if (!mmc_pdata(host)->ocr_mask) {
+			mmc_pdata(host)->ocr_mask = ocr_value;
 		} else {
-			if (!(mmc_slot(host).ocr_mask & ocr_value)) {
+			if (!(mmc_pdata(host)->ocr_mask & ocr_value)) {
 				dev_err(host->dev, "ocrmask %x is not supported\n",
-					mmc_slot(host).ocr_mask);
-				mmc_slot(host).ocr_mask = 0;
+					mmc_pdata(host)->ocr_mask);
+				mmc_pdata(host)->ocr_mask = 0;
 				return -EINVAL;
 			}
 		}
 	}
-	mmc_slot(host).set_power = omap_hsmmc_set_power;
+	mmc_pdata(host)->set_power = omap_hsmmc_set_power;
 
 	/* Allow an aux regulator */
 	reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
@@ -404,7 +404,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	host->pbias = IS_ERR(reg) ? NULL : reg;
 
 	/* For eMMC do not power off when not in sleep state */
-	if (mmc_slot(host).no_regulator_off_init)
+	if (mmc_pdata(host)->no_regulator_off_init)
 		return 0;
 	/*
 	 * To disable boot_on regulator, enable regulator
@@ -412,10 +412,10 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	 */
 	if ((host->vcc && regulator_is_enabled(host->vcc) > 0) ||
 	    (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
-		int vdd = ffs(mmc_slot(host).ocr_mask) - 1;
+		int vdd = ffs(mmc_pdata(host)->ocr_mask) - 1;
 
-		mmc_slot(host).set_power(host->dev, host->slot_id, 1, vdd);
-		mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
+		mmc_pdata(host)->set_power(host->dev, host->slot_id, 1, vdd);
+		mmc_pdata(host)->set_power(host->dev, host->slot_id, 0, 0);
 	}
 
 	return 0;
@@ -423,7 +423,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
 {
-	mmc_slot(host).set_power = NULL;
+	mmc_pdata(host)->set_power = NULL;
 }
 
 static inline int omap_hsmmc_have_reg(void)
@@ -453,51 +453,53 @@ static int omap_hsmmc_gpio_init(struct omap_hsmmc_platform_data *pdata)
 {
 	int ret;
 
-	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
-		if (pdata->slots[0].cover)
-			pdata->slots[0].get_cover_state =
+	if (gpio_is_valid(pdata->switch_pin)) {
+		if (pdata->cover)
+			pdata->get_cover_state =
 					omap_hsmmc_get_cover_state;
 		else
-			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
-		pdata->slots[0].card_detect_irq =
-				gpio_to_irq(pdata->slots[0].switch_pin);
-		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
+			pdata->card_detect = omap_hsmmc_card_detect;
+		pdata->card_detect_irq =
+				gpio_to_irq(pdata->switch_pin);
+		ret = gpio_request(pdata->switch_pin, "mmc_cd");
 		if (ret)
 			return ret;
-		ret = gpio_direction_input(pdata->slots[0].switch_pin);
+		ret = gpio_direction_input(pdata->switch_pin);
 		if (ret)
 			goto err_free_sp;
-	} else
-		pdata->slots[0].switch_pin = -EINVAL;
+	} else {
+		pdata->switch_pin = -EINVAL;
+	}
 
-	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
-		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
-		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
+	if (gpio_is_valid(pdata->gpio_wp)) {
+		pdata->get_ro = omap_hsmmc_get_wp;
+		ret = gpio_request(pdata->gpio_wp, "mmc_wp");
 		if (ret)
 			goto err_free_cd;
-		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
+		ret = gpio_direction_input(pdata->gpio_wp);
 		if (ret)
 			goto err_free_wp;
-	} else
-		pdata->slots[0].gpio_wp = -EINVAL;
+	} else {
+		pdata->gpio_wp = -EINVAL;
+	}
 
 	return 0;
 
 err_free_wp:
-	gpio_free(pdata->slots[0].gpio_wp);
+	gpio_free(pdata->gpio_wp);
 err_free_cd:
-	if (gpio_is_valid(pdata->slots[0].switch_pin))
+	if (gpio_is_valid(pdata->switch_pin))
 err_free_sp:
-		gpio_free(pdata->slots[0].switch_pin);
+		gpio_free(pdata->switch_pin);
 	return ret;
 }
 
 static void omap_hsmmc_gpio_free(struct omap_hsmmc_platform_data *pdata)
 {
-	if (gpio_is_valid(pdata->slots[0].gpio_wp))
-		gpio_free(pdata->slots[0].gpio_wp);
-	if (gpio_is_valid(pdata->slots[0].switch_pin))
-		gpio_free(pdata->slots[0].switch_pin);
+	if (gpio_is_valid(pdata->gpio_wp))
+		gpio_free(pdata->gpio_wp);
+	if (gpio_is_valid(pdata->switch_pin))
+		gpio_free(pdata->switch_pin);
 }
 
 /*
@@ -607,7 +609,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 	 *	  in capabilities register
 	 *	- MMC/SD clock coming out of controller > 25MHz
 	 */
-	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
+	if ((mmc_pdata(host)->features & HSMMC_HAS_HSPE_SUPPORT) &&
 	    (ios->timing != MMC_TIMING_MMC_DDR52) &&
 	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
 		regval = OMAP_HSMMC_READ(host->base, HCTL);
@@ -791,8 +793,8 @@ int omap_hsmmc_cover_is_closed(struct omap_hsmmc_host *host)
 {
 	int r = 1;
 
-	if (mmc_slot(host).get_cover_state)
-		r = mmc_slot(host).get_cover_state(host->dev, host->slot_id);
+	if (mmc_pdata(host)->get_cover_state)
+		r = mmc_pdata(host)->get_cover_state(host->dev, host->slot_id);
 	return r;
 }
 
@@ -816,7 +818,7 @@ omap_hsmmc_show_slot_name(struct device *dev, struct device_attribute *attr,
 	struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	return sprintf(buf, "%s\n", mmc_slot(host).name);
+	return sprintf(buf, "%s\n", mmc_pdata(host)->name);
 }
 
 static DEVICE_ATTR(slot_name, S_IRUGO, omap_hsmmc_show_slot_name, NULL);
@@ -1061,7 +1063,7 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 	 * OMAP4 ES2 and greater has an updated reset logic.
 	 * Monitor a 0->1 transition first
 	 */
-	if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
+	if (mmc_pdata(host)->features & HSMMC_HAS_UPDATED_RESET) {
 		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
 					&& (i++ < limit))
 			udelay(1);
@@ -1210,12 +1212,12 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 		clk_disable_unprepare(host->dbclk);
 
 	/* Turn the power off */
-	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
+	ret = mmc_pdata(host)->set_power(host->dev, host->slot_id, 0, 0);
 
 	/* Turn the power ON with given VDD 1.8 or 3.0v */
 	if (!ret)
-		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
-					       vdd);
+		ret = mmc_pdata(host)->set_power(host->dev, host->slot_id, 1,
+						 vdd);
 	pm_runtime_get_sync(host->dev);
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
@@ -1259,11 +1261,11 @@ err:
 /* Protect the card while the cover is open */
 static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 {
-	if (!mmc_slot(host).get_cover_state)
+	if (!mmc_pdata(host)->get_cover_state)
 		return;
 
 	host->reqs_blocked = 0;
-	if (mmc_slot(host).get_cover_state(host->dev, host->slot_id)) {
+	if (mmc_pdata(host)->get_cover_state(host->dev, host->slot_id)) {
 		if (host->protect_card) {
 			dev_info(host->dev, "%s: cover is closed, "
 					 "card is now accessible\n",
@@ -1286,13 +1288,13 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 {
 	struct omap_hsmmc_host *host = dev_id;
-	struct omap_hsmmc_slot_data *slot = &mmc_slot(host);
+	struct omap_hsmmc_platform_data *pdata = host->pdata;
 	int carddetect;
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 
-	if (slot->card_detect)
-		carddetect = slot->card_detect(host->dev, host->slot_id);
+	if (pdata->card_detect)
+		carddetect = pdata->card_detect(host->dev, host->slot_id);
 	else {
 		omap_hsmmc_protect_card(host);
 		carddetect = -ENOSYS;
@@ -1618,12 +1620,12 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
-			mmc_slot(host).set_power(host->dev, host->slot_id,
-						 0, 0);
+			mmc_pdata(host)->set_power(host->dev, host->slot_id,
+						   0, 0);
 			break;
 		case MMC_POWER_UP:
-			mmc_slot(host).set_power(host->dev, host->slot_id,
-						 1, ios->vdd);
+			mmc_pdata(host)->set_power(host->dev, host->slot_id,
+						   1, ios->vdd);
 			break;
 		case MMC_POWER_ON:
 			do_send_init_stream = 1;
@@ -1668,26 +1670,26 @@ static int omap_hsmmc_get_cd(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	if (!mmc_slot(host).card_detect)
+	if (!mmc_pdata(host)->card_detect)
 		return -ENOSYS;
-	return mmc_slot(host).card_detect(host->dev, host->slot_id);
+	return mmc_pdata(host)->card_detect(host->dev, host->slot_id);
 }
 
 static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	if (!mmc_slot(host).get_ro)
+	if (!mmc_pdata(host)->get_ro)
 		return -ENOSYS;
-	return mmc_slot(host).get_ro(host->dev, 0);
+	return mmc_pdata(host)->get_ro(host->dev, 0);
 }
 
 static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	if (mmc_slot(host).init_card)
-		mmc_slot(host).init_card(card);
+	if (mmc_pdata(host)->init_card)
+		mmc_pdata(host)->init_card(card);
 }
 
 static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
@@ -1978,33 +1980,33 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 
 	/* This driver only supports 1 slot */
 	pdata->nr_slots = 1;
-	pdata->slots[0].switch_pin = cd_gpio;
-	pdata->slots[0].gpio_wp = wp_gpio;
+	pdata->switch_pin = cd_gpio;
+	pdata->gpio_wp = wp_gpio;
 
 	if (of_find_property(np, "ti,non-removable", NULL)) {
-		pdata->slots[0].nonremovable = true;
-		pdata->slots[0].no_regulator_off_init = true;
+		pdata->nonremovable = true;
+		pdata->no_regulator_off_init = true;
 	}
 	of_property_read_u32(np, "bus-width", &bus_width);
 	if (bus_width == 4)
-		pdata->slots[0].caps |= MMC_CAP_4_BIT_DATA;
+		pdata->caps |= MMC_CAP_4_BIT_DATA;
 	else if (bus_width == 8)
-		pdata->slots[0].caps |= MMC_CAP_8_BIT_DATA;
+		pdata->caps |= MMC_CAP_8_BIT_DATA;
 
 	if (of_find_property(np, "ti,needs-special-reset", NULL))
-		pdata->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
+		pdata->features |= HSMMC_HAS_UPDATED_RESET;
 
 	if (!of_property_read_u32(np, "max-frequency", &max_freq))
 		pdata->max_freq = max_freq;
 
 	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
-		pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
+		pdata->features |= HSMMC_HAS_HSPE_SUPPORT;
 
 	if (of_find_property(np, "keep-power-in-suspend", NULL))
-		pdata->slots[0].pm_caps |= MMC_PM_KEEP_POWER;
+		pdata->pm_caps |= MMC_PM_KEEP_POWER;
 
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
-		pdata->slots[0].pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 
 	return pdata;
 }
@@ -2144,14 +2146,14 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
 
-	mmc->caps |= mmc_slot(host).caps;
+	mmc->caps |= mmc_pdata(host)->caps;
 	if (mmc->caps & MMC_CAP_8_BIT_DATA)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
-	if (mmc_slot(host).nonremovable)
+	if (mmc_pdata(host)->nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 
-	mmc->pm_caps = mmc_slot(host).pm_caps;
+	mmc->pm_caps = mmc_pdata(host)->pm_caps;
 
 	omap_hsmmc_conf_bus_power(host);
 
@@ -2204,19 +2206,19 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	if (omap_hsmmc_have_reg() && !mmc_slot(host).set_power) {
+	if (omap_hsmmc_have_reg() && !mmc_pdata(host)->set_power) {
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
 			goto err_irq;
 		host->use_reg = 1;
 	}
 
-	mmc->ocr_avail = mmc_slot(host).ocr_mask;
+	mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
 
 	/* Request IRQ for card detect */
-	if ((mmc_slot(host).card_detect_irq)) {
+	if ((mmc_pdata(host)->card_detect_irq)) {
 		ret = devm_request_threaded_irq(&pdev->dev,
-						mmc_slot(host).card_detect_irq,
+						mmc_pdata(host)->card_detect_irq,
 						NULL, omap_hsmmc_detect,
 					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   mmc_hostname(mmc), host);
@@ -2247,12 +2249,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc_add_host(mmc);
 
-	if (mmc_slot(host).name != NULL) {
+	if (mmc_pdata(host)->name != NULL) {
 		ret = device_create_file(&mmc->class_dev, &dev_attr_slot_name);
 		if (ret < 0)
 			goto err_slot_name;
 	}
-	if (mmc_slot(host).card_detect_irq && mmc_slot(host).get_cover_state) {
+	if (mmc_pdata(host)->card_detect_irq &&
+	    mmc_pdata(host)->get_cover_state) {
 		ret = device_create_file(&mmc->class_dev,
 					&dev_attr_cover_switch);
 		if (ret < 0)
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 35d494f..2691214 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -8,8 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#define OMAP_HSMMC_MAX_SLOTS	1
-
 /*
  * struct omap_hsmmc_dev_attr.flags possibilities
  *
@@ -57,62 +55,60 @@ struct omap_hsmmc_platform_data {
 	/* Register offset deviation */
 	u16 reg_offset;
 
-	struct omap_hsmmc_slot_data {
-		/*
-		 * 4/8 wires and any additional host capabilities
-		 * need to OR'd all capabilities (ref. linux/mmc/host.h)
-		 */
-		u32 caps;	/* Used for the MMC driver on 2430 and later */
-		u32 pm_caps;	/* PM capabilities of the mmc */
+	/*
+	 * 4/8 wires and any additional host capabilities
+	 * need to OR'd all capabilities (ref. linux/mmc/host.h)
+	 */
+	u32 caps;	/* Used for the MMC driver on 2430 and later */
+	u32 pm_caps;	/* PM capabilities of the mmc */
 
-		/* switch pin can be for card detect (default) or card cover */
-		unsigned cover:1;
+	/* switch pin can be for card detect (default) or card cover */
+	unsigned cover:1;
 
-		/* use the internal clock */
-		unsigned internal_clock:1;
+	/* use the internal clock */
+	unsigned internal_clock:1;
 
-		/* nonremovable e.g. eMMC */
-		unsigned nonremovable:1;
+	/* nonremovable e.g. eMMC */
+	unsigned nonremovable:1;
 
-		/* eMMC does not handle power off when not in sleep state */
-		unsigned no_regulator_off_init:1;
+	/* eMMC does not handle power off when not in sleep state */
+	unsigned no_regulator_off_init:1;
 
-		/* we can put the features above into this variable */
+	/* we can put the features above into this variable */
 #define HSMMC_HAS_PBIAS		(1 << 0)
 #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
 #define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
-		unsigned features;
-
-		int switch_pin;			/* gpio (card detect) */
-		int gpio_wp;			/* gpio (write protect) */
-
-		int (*set_power)(struct device *dev, int slot,
-				 int power_on, int vdd);
-		int (*get_ro)(struct device *dev, int slot);
-		void (*remux)(struct device *dev, int slot, int power_on);
-		/* Call back before enabling / disabling regulators */
-		void (*before_set_reg)(struct device *dev, int slot,
-				       int power_on, int vdd);
-		/* Call back after enabling / disabling regulators */
-		void (*after_set_reg)(struct device *dev, int slot,
-				      int power_on, int vdd);
-		/* if we have special card, init it using this callback */
-		void (*init_card)(struct mmc_card *card);
-
-		/* return MMC cover switch state, can be NULL if not supported.
-		 *
-		 * possible return values:
-		 *   0 - closed
-		 *   1 - open
-		 */
-		int (*get_cover_state)(struct device *dev, int slot);
-
-		const char *name;
-		u32 ocr_mask;
-
-		/* Card detection IRQs */
-		int card_detect_irq;
-
-		int (*card_detect)(struct device *dev, int slot);
-	} slots[OMAP_HSMMC_MAX_SLOTS];
+	unsigned features;
+
+	int switch_pin;			/* gpio (card detect) */
+	int gpio_wp;			/* gpio (write protect) */
+
+	int (*set_power)(struct device *dev, int slot,
+			 int power_on, int vdd);
+	int (*get_ro)(struct device *dev, int slot);
+	void (*remux)(struct device *dev, int slot, int power_on);
+	/* Call back before enabling / disabling regulators */
+	void (*before_set_reg)(struct device *dev, int slot,
+			       int power_on, int vdd);
+	/* Call back after enabling / disabling regulators */
+	void (*after_set_reg)(struct device *dev, int slot,
+			      int power_on, int vdd);
+	/* if we have special card, init it using this callback */
+	void (*init_card)(struct mmc_card *card);
+
+	/* return MMC cover switch state, can be NULL if not supported.
+	 *
+	 * possible return values:
+	 *   0 - closed
+	 *   1 - open
+	 */
+	int (*get_cover_state)(struct device *dev, int slot);
+
+	const char *name;
+	u32 ocr_mask;
+
+	/* Card detection IRQs */
+	int card_detect_irq;
+
+	int (*card_detect)(struct device *dev, int slot);
 };
-- 
2.1.1

