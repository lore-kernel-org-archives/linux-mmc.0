From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 9/9] omap_hsmmc: remove unused slot_id parameter
Date: Mon, 29 Sep 2014 11:32:59 +0200
Message-ID: <1411983179-28677-10-git-send-email-afenkart@gmail.com>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:58395 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbaI2Jda (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 05:33:30 -0400
In-Reply-To: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

omap_hsmmc only supports one slot. So slot id is always zero, and
slot id is never used in the callbacks

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 0a8ac84..3d5040f 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -484,7 +484,7 @@ static struct omap_mux_partition *partition;
  * Current flows to eMMC when eMMC is off and the data lines are pulled up,
  * so pull them down. N.B. we pull 8 lines because we are using 8 lines.
  */
-static void rx51_mmc2_remux(struct device *dev, int slot, int power_on)
+static void rx51_mmc2_remux(struct device *dev, int power_on)
 {
 	if (power_on)
 		omap_mux_write_array(partition, rx51_mmc2_on_mux);
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a535cd3..bdc0402 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -32,14 +32,14 @@ static u16 control_devconf1_offset;
 
 #define HSMMC_NAME_LEN	9
 
-static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
-				  int power_on, int vdd)
+static void omap_hsmmc1_before_set_reg(struct device *dev,
+				       int power_on, int vdd)
 {
 	u32 reg, prog_io;
 	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
 	if (mmc->remux)
-		mmc->remux(dev, slot, power_on);
+		mmc->remux(dev, power_on);
 
 	/*
 	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
@@ -85,8 +85,7 @@ static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 	}
 }
 
-static void omap_hsmmc1_after_set_reg(struct device *dev, int slot,
-				 int power_on, int vdd)
+static void omap_hsmmc1_after_set_reg(struct device *dev, int power_on, int vdd)
 {
 	u32 reg;
 
@@ -121,20 +120,18 @@ static void hsmmc2_select_input_clk_src(struct omap_hsmmc_platform_data *mmc)
 	omap_ctrl_writel(reg, control_devconf1_offset);
 }
 
-static void hsmmc2_before_set_reg(struct device *dev, int slot,
-				   int power_on, int vdd)
+static void hsmmc2_before_set_reg(struct device *dev, int power_on, int vdd)
 {
 	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
 	if (mmc->remux)
-		mmc->remux(dev, slot, power_on);
+		mmc->remux(dev, power_on);
 
 	if (power_on)
 		hsmmc2_select_input_clk_src(mmc);
 }
 
-static int am35x_hsmmc2_set_power(struct device *dev, int slot,
-				  int power_on, int vdd)
+static int am35x_hsmmc2_set_power(struct device *dev, int power_on, int vdd)
 {
 	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
@@ -144,8 +141,7 @@ static int am35x_hsmmc2_set_power(struct device *dev, int slot,
 	return 0;
 }
 
-static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
-							int vdd)
+static int nop_mmc_set_power(struct device *dev, int power_on, int vdd)
 {
 	return 0;
 }
@@ -249,7 +245,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 		snprintf(hc_name, (HSMMC_NAME_LEN + 1), "mmc%islot%i",
 								c->mmc, 1);
 	mmc->name = hc_name;
-	mmc->nr_slots = 1;
 	mmc->caps = c->caps;
 	mmc->internal_clock = !c->ext_clock;
 	mmc->reg_offset = 0;
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 30c78c1..148cd9b 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -23,7 +23,7 @@ struct omap2_hsmmc_info {
 	struct platform_device *pdev;	/* mmc controller instance */
 	int	ocr_mask;	/* temporary HACK */
 	/* Remux (pad configuration) when powering on/off */
-	void (*remux)(struct device *dev, int slot, int power_on);
+	void (*remux)(struct device *dev, int power_on);
 	/* init some special card */
 	void (*init_card)(struct mmc_card *card);
 };
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0a1398a..c063882 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -207,7 +207,6 @@ struct omap_hsmmc_host {
 	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
-	int			slot_id;
 	int			response_busy;
 	int			context_loss;
 	int			protect_card;
@@ -223,8 +222,8 @@ struct omap_hsmmc_host {
 	struct	omap_hsmmc_platform_data	*pdata;
 
 	/* To handle board related suspend/resume functionality for MMC */
-	int (*suspend)(struct device *dev, int slot);
-	int (*resume)(struct device *dev, int slot);
+	int (*suspend)(struct device *dev);
+	int (*resume)(struct device *dev);
 
 	/* return MMC cover switch state, can be NULL if not supported.
 	 *
@@ -232,13 +231,13 @@ struct omap_hsmmc_host {
 	 *   0 - closed
 	 *   1 - open
 	 */
-	int (*get_cover_state)(struct device *dev, int slot);
+	int (*get_cover_state)(struct device *dev);
 
 	/* Card detection IRQs */
 	int card_detect_irq;
 
-	int (*card_detect)(struct device *dev, int slot);
-	int (*get_ro)(struct device *dev, int slot);
+	int (*card_detect)(struct device *dev);
+	int (*get_ro)(struct device *dev);
 
 };
 
@@ -249,7 +248,7 @@ struct omap_mmc_of_data {
 
 static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host);
 
-static int omap_hsmmc_card_detect(struct device *dev, int slot)
+static int omap_hsmmc_card_detect(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 	struct omap_hsmmc_platform_data *mmc = host->pdata;
@@ -258,7 +257,7 @@ static int omap_hsmmc_card_detect(struct device *dev, int slot)
 	return !gpio_get_value_cansleep(mmc->switch_pin);
 }
 
-static int omap_hsmmc_get_wp(struct device *dev, int slot)
+static int omap_hsmmc_get_wp(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 	struct omap_hsmmc_platform_data *mmc = host->pdata;
@@ -267,7 +266,7 @@ static int omap_hsmmc_get_wp(struct device *dev, int slot)
 	return gpio_get_value_cansleep(mmc->gpio_wp);
 }
 
-static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
+static int omap_hsmmc_get_cover_state(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 	struct omap_hsmmc_platform_data *mmc = host->pdata;
@@ -278,7 +277,7 @@ static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 
 #ifdef CONFIG_PM
 
-static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
+static int omap_hsmmc_suspend_cdirq(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
@@ -286,7 +285,7 @@ static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
 	return 0;
 }
 
-static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
+static int omap_hsmmc_resume_cdirq(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
@@ -303,8 +302,7 @@ static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 
 #ifdef CONFIG_REGULATOR
 
-static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
-				   int vdd)
+static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 {
 	struct omap_hsmmc_host *host =
 		platform_get_drvdata(to_platform_device(dev));
@@ -318,7 +316,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 		return 0;
 
 	if (mmc_pdata(host)->before_set_reg)
-		mmc_pdata(host)->before_set_reg(dev, slot, power_on, vdd);
+		mmc_pdata(host)->before_set_reg(dev, power_on, vdd);
 
 	if (host->pbias) {
 		if (host->pbias_enabled == 1) {
@@ -381,7 +379,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	}
 
 	if (mmc_pdata(host)->after_set_reg)
-		mmc_pdata(host)->after_set_reg(dev, slot, power_on, vdd);
+		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
 
 error_set_power:
 	return ret;
@@ -431,8 +429,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	    (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
 		int vdd = ffs(mmc_pdata(host)->ocr_mask) - 1;
 
-		mmc_pdata(host)->set_power(host->dev, host->slot_id, 1, vdd);
-		mmc_pdata(host)->set_power(host->dev, host->slot_id, 0, 0);
+		mmc_pdata(host)->set_power(host->dev, 1, vdd);
+		mmc_pdata(host)->set_power(host->dev, 0, 0);
 	}
 
 	return 0;
@@ -813,7 +811,7 @@ int omap_hsmmc_cover_is_closed(struct omap_hsmmc_host *host)
 	int r = 1;
 
 	if (host->get_cover_state)
-		r = host->get_cover_state(host->dev, host->slot_id);
+		r = host->get_cover_state(host->dev);
 	return r;
 }
 
@@ -1231,12 +1229,11 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 		clk_disable_unprepare(host->dbclk);
 
 	/* Turn the power off */
-	ret = mmc_pdata(host)->set_power(host->dev, host->slot_id, 0, 0);
+	ret = mmc_pdata(host)->set_power(host->dev, 0, 0);
 
 	/* Turn the power ON with given VDD 1.8 or 3.0v */
 	if (!ret)
-		ret = mmc_pdata(host)->set_power(host->dev, host->slot_id, 1,
-						 vdd);
+		ret = mmc_pdata(host)->set_power(host->dev, 1, vdd);
 	pm_runtime_get_sync(host->dev);
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
@@ -1284,7 +1281,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 		return;
 
 	host->reqs_blocked = 0;
-	if (host->get_cover_state(host->dev, host->slot_id)) {
+	if (host->get_cover_state(host->dev)) {
 		if (host->protect_card) {
 			dev_info(host->dev, "%s: cover is closed, "
 					 "card is now accessible\n",
@@ -1312,7 +1309,7 @@ static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 
 	if (host->card_detect)
-		carddetect = host->card_detect(host->dev, host->slot_id);
+		carddetect = host->card_detect(host->dev);
 	else {
 		omap_hsmmc_protect_card(host);
 		carddetect = -ENOSYS;
@@ -1638,12 +1635,10 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
-			mmc_pdata(host)->set_power(host->dev, host->slot_id,
-						   0, 0);
+			mmc_pdata(host)->set_power(host->dev, 0, 0);
 			break;
 		case MMC_POWER_UP:
-			mmc_pdata(host)->set_power(host->dev, host->slot_id,
-						   1, ios->vdd);
+			mmc_pdata(host)->set_power(host->dev, 1, ios->vdd);
 			break;
 		case MMC_POWER_ON:
 			do_send_init_stream = 1;
@@ -1690,7 +1685,7 @@ static int omap_hsmmc_get_cd(struct mmc_host *mmc)
 
 	if (!host->card_detect)
 		return -ENOSYS;
-	return host->card_detect(host->dev, host->slot_id);
+	return host->card_detect(host->dev);
 }
 
 static int omap_hsmmc_get_ro(struct mmc_host *mmc)
@@ -1699,7 +1694,7 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 
 	if (!host->get_ro)
 		return -ENOSYS;
-	return host->get_ro(host->dev, 0);
+	return host->get_ro(host->dev);
 }
 
 static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
@@ -1986,8 +1981,6 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,dual-volt", NULL))
 		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
 
-	/* This driver only supports 1 slot */
-	pdata->nr_slots = 1;
 	pdata->switch_pin = cd_gpio;
 	pdata->gpio_wp = wp_gpio;
 
@@ -2058,11 +2051,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	if (pdata->nr_slots == 0) {
-		dev_err(&pdev->dev, "No Slots\n");
-		return -ENXIO;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (res == NULL || irq < 0)
@@ -2085,7 +2073,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
-	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
@@ -2338,7 +2325,7 @@ static int omap_hsmmc_prepare(struct device *dev)
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
 	if (host->suspend)
-		return host->suspend(dev, host->slot_id);
+		return host->suspend(dev);
 
 	return 0;
 }
@@ -2348,7 +2335,7 @@ static void omap_hsmmc_complete(struct device *dev)
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
 	if (host->resume)
-		host->resume(dev, host->slot_id);
+		host->resume(dev);
 
 }
 
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 0069d27..ef778e1 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -36,9 +36,6 @@ struct omap_hsmmc_platform_data {
 	/* back-link to device */
 	struct device *dev;
 
-	/* number of slots per controller */
-	unsigned nr_slots:2;
-
 	/* set if your board has components or wiring that limits the
 	 * maximum frequency on the MMC bus */
 	unsigned int max_freq;
@@ -77,15 +74,12 @@ struct omap_hsmmc_platform_data {
 	int switch_pin;			/* gpio (card detect) */
 	int gpio_wp;			/* gpio (write protect) */
 
-	int (*set_power)(struct device *dev, int slot,
-			 int power_on, int vdd);
-	void (*remux)(struct device *dev, int slot, int power_on);
+	int (*set_power)(struct device *dev, int power_on, int vdd);
+	void (*remux)(struct device *dev, int power_on);
 	/* Call back before enabling / disabling regulators */
-	void (*before_set_reg)(struct device *dev, int slot,
-			       int power_on, int vdd);
+	void (*before_set_reg)(struct device *dev, int power_on, int vdd);
 	/* Call back after enabling / disabling regulators */
-	void (*after_set_reg)(struct device *dev, int slot,
-			      int power_on, int vdd);
+	void (*after_set_reg)(struct device *dev, int power_on, int vdd);
 	/* if we have special card, init it using this callback */
 	void (*init_card)(struct mmc_card *card);
 
-- 
2.1.0

