From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 2/6] omap_hsmmc: remove unused callbacks from platform data struct
Date: Mon, 22 Sep 2014 13:55:07 +0200
Message-ID: <1411386911-8158-3-git-send-email-afenkart@gmail.com>
References: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35262 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbaIVLzZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Sep 2014 07:55:25 -0400
In-Reply-To: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

driver never references these fields

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/hsmmc.c              | 9 ---------
 arch/arm/mach-omap2/hsmmc.h              | 4 ----
 drivers/mmc/host/omap_hsmmc.c            | 9 ---------
 include/linux/platform_data/hsmmc-omap.h | 4 ----
 4 files changed, 26 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index e3555f2..d599195 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -49,9 +49,6 @@ static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 	u32 reg, prog_io;
 	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
-	if (mmc->slots[0].remux)
-		mmc->slots[0].remux(dev, slot, power_on);
-
 	/*
 	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
 	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
@@ -137,9 +134,6 @@ static void hsmmc2_before_set_reg(struct device *dev, int slot,
 {
 	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
-	if (mmc->slots[0].remux)
-		mmc->slots[0].remux(dev, slot, power_on);
-
 	if (power_on)
 		hsmmc2_select_input_clk_src(mmc);
 }
@@ -271,9 +265,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].switch_pin = c->gpio_cd;
 	mmc->slots[0].gpio_wp = c->gpio_wp;
 
-	mmc->slots[0].remux = c->remux;
-	mmc->slots[0].init_card = c->init_card;
-
 	if (c->cover_only)
 		mmc->slots[0].cover = 1;
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 7f2e790..a8bc0c2 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -29,10 +29,6 @@ struct omap2_hsmmc_info {
 	int	ocr_mask;	/* temporary HACK */
 	int	max_freq;	/* maximum clock, if constrained by external
 				 * circuitry, or 0 for default */
-	/* Remux (pad configuration) when powering on/off */
-	void (*remux)(struct device *dev, int slot, int power_on);
-	/* init some special card */
-	void (*init_card)(struct mmc_card *card);
 };
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5f2b5b7..02f3438 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1682,14 +1682,6 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 	return mmc_slot(host).get_ro(host->dev, 0);
 }
 
-static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	if (mmc_slot(host).init_card)
-		mmc_slot(host).init_card(card);
-}
-
 static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
@@ -1838,7 +1830,6 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
-	.init_card = omap_hsmmc_init_card,
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index cb91db4..7620c21 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -116,19 +116,15 @@ struct omap_hsmmc_platform_data {
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 
-		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (*set_power)(struct device *dev, int slot,
 				 int power_on, int vdd);
 		int (*get_ro)(struct device *dev, int slot);
-		void (*remux)(struct device *dev, int slot, int power_on);
 		/* Call back before enabling / disabling regulators */
 		void (*before_set_reg)(struct device *dev, int slot,
 				       int power_on, int vdd);
 		/* Call back after enabling / disabling regulators */
 		void (*after_set_reg)(struct device *dev, int slot,
 				      int power_on, int vdd);
-		/* if we have special card, init it using this callback */
-		void (*init_card)(struct mmc_card *card);
 
 		/* return MMC cover switch state, can be NULL if not supported.
 		 *
-- 
2.1.0

