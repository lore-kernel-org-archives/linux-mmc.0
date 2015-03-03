From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 4/6] ARM: OMAP2: HSMMC: platform_data: explicit gpio_cover / gpio_cd fields
Date: Tue,  3 Mar 2015 13:28:16 +0100
Message-ID: <1425385698-6588-5-git-send-email-afenkart@gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Cover detection and card detection are not equivalent, cover detection
is like a warning that something might happen (cover removed, card is
accessible), card detection a notification that something has happened.
You could use both in parallel.
Technically this is not possible, since there is only one gpio for both
and a 'cover' flag to indicate either or. With this commit we push that
de-multiplexing of that gpio + flag out of the driver into the platform
specific init code.
It's not pushed down into omap2_hsmmc_info which is used to initialize
the platform data, since we would have to go over all board files
and set the new gpio_cover pin to -EINVAL. That would be dangerous
since '0' is a valid pin number.
FYI: only board-rx51 uses cover_only detection

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/hsmmc.c              | 33 ++++++++++++++++++++++++--------
 drivers/mmc/host/omap_hsmmc.c            | 11 ++++++-----
 include/linux/platform_data/hsmmc-omap.h |  6 ++----
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index dc6e79c..0e54aac 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -150,9 +150,13 @@ static int nop_mmc_set_power(struct device *dev, int power_on, int vdd)
 static inline void omap_hsmmc_mux(struct omap_hsmmc_platform_data
 				  *mmc_controller, int controller_nr)
 {
-	if (gpio_is_valid(mmc_controller->switch_pin) &&
-	    (mmc_controller->switch_pin < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->switch_pin,
+	if (gpio_is_valid(mmc_controller->gpio_cd) &&
+	    (mmc_controller->gpio_cd < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->gpio_cd,
+				   OMAP_PIN_INPUT_PULLUP);
+	if (gpio_is_valid(mmc_controller->gpio_cover) &&
+	    (mmc_controller->gpio_cover < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->gpio_cover,
 				   OMAP_PIN_INPUT_PULLUP);
 	if (gpio_is_valid(mmc_controller->gpio_wp) &&
 	    (mmc_controller->gpio_wp < OMAP_MAX_GPIO_LINES))
@@ -250,15 +254,20 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->internal_clock = !c->ext_clock;
 	mmc->reg_offset = 0;
 
-	mmc->switch_pin = c->gpio_cd;
+	if (c->cover_only) {
+		/* detect if mobile phone cover removed */
+		mmc->gpio_cd = -EINVAL;
+		mmc->gpio_cover = c->gpio_cd;
+	} else {
+		/* card detect pin on the mmc socket itself */
+		mmc->gpio_cd = c->gpio_cd;
+		mmc->gpio_cover = -EINVAL;
+	}
 	mmc->gpio_wp = c->gpio_wp;
 
 	mmc->remux = c->remux;
 	mmc->init_card = c->init_card;
 
-	if (c->cover_only)
-		mmc->cover = 1;
-
 	if (c->nonremovable)
 		mmc->nonremovable = 1;
 
@@ -358,7 +367,15 @@ void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
 		if (!mmc_pdata)
 			continue;
 
-		mmc_pdata->switch_pin = c->gpio_cd;
+		if (c->cover_only) {
+			/* detect if mobile phone cover removed */
+			mmc_pdata->gpio_cd = -EINVAL;
+			mmc_pdata->gpio_cover = c->gpio_cd;
+		} else {
+			/* card detect pin on the mmc socket itself */
+			mmc_pdata->gpio_cd = c->gpio_cd;
+			mmc_pdata->gpio_cover = -EINVAL;
+		}
 		mmc_pdata->gpio_wp = c->gpio_wp;
 
 		res = omap_device_register(pdev);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 38239fb..ed68e55 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -427,15 +427,15 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
 {
 	int ret;
 
-	if (pdata->cover && gpio_is_valid(pdata->switch_pin)) {
-		ret = mmc_gpio_request_cd(mmc, pdata->switch_pin, 0);
+	if (gpio_is_valid(pdata->gpio_cover)) {
+		ret = mmc_gpio_request_cd(mmc, pdata->gpio_cover, 0);
 		if (ret)
 			return ret;
 
 		host->get_cover_state = omap_hsmmc_get_cover_state;
 		mmc_gpio_set_cd_isr(mmc, omap_hsmmc_cover_irq);
-	} else if (!pdata->cover && gpio_is_valid(pdata->switch_pin)) {
-		ret = mmc_gpio_request_cd(mmc, pdata->switch_pin, 0);
+	} else if (gpio_is_valid(pdata->gpio_cd)) {
+		ret = mmc_gpio_request_cd(mmc, pdata->gpio_cd, 0);
 		if (ret)
 			return ret;
 
@@ -1932,7 +1932,8 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,dual-volt", NULL))
 		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
 
-	pdata->switch_pin = -EINVAL;
+	pdata->gpio_cd = -EINVAL;
+	pdata->gpio_cover = -EINVAL;
 	pdata->gpio_wp = -EINVAL;
 
 	if (of_find_property(np, "ti,non-removable", NULL)) {
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 67bbcf0..9bd6703 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -55,9 +55,6 @@ struct omap_hsmmc_platform_data {
 	u32 caps;	/* Used for the MMC driver on 2430 and later */
 	u32 pm_caps;	/* PM capabilities of the mmc */
 
-	/* switch pin can be for card detect (default) or card cover */
-	unsigned cover:1;
-
 	/* use the internal clock */
 	unsigned internal_clock:1;
 
@@ -73,7 +70,8 @@ struct omap_hsmmc_platform_data {
 #define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
 	unsigned features;
 
-	int switch_pin;			/* gpio (card detect) */
+	int gpio_cd;			/* gpio (card detect) */
+	int gpio_cover;			/* gpio (cover detect) */
 	int gpio_wp;			/* gpio (write protect) */
 
 	int (*set_power)(struct device *dev, int power_on, int vdd);
-- 
2.1.4

