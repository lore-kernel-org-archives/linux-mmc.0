From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 6/6] omap_hsmmc: remove un-initialized get_cover_state callback
Date: Mon, 22 Sep 2014 13:55:11 +0200
Message-ID: <1411386911-8158-7-git-send-email-afenkart@gmail.com>
References: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36960 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbaIVLzl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Sep 2014 07:55:41 -0400
In-Reply-To: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/hsmmc.c              |  3 --
 arch/arm/mach-omap2/hsmmc.h              |  1 -
 drivers/mmc/host/omap_hsmmc.c            | 83 ++------------------------------
 include/linux/platform_data/hsmmc-omap.h | 10 ----
 4 files changed, 4 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9ed9f70..068ccf5 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -252,9 +252,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].switch_pin = c->gpio_cd;
 	mmc->slots[0].gpio_wp = c->gpio_wp;
 
-	if (c->cover_only)
-		mmc->slots[0].cover = 1;
-
 	if (c->nonremovable)
 		mmc->slots[0].nonremovable = 1;
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index b18059b..1c4a363 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -14,7 +14,6 @@ struct omap2_hsmmc_info {
 				 * capabilities OR'd (ref. linux/mmc/host.h) */
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
-	bool	cover_only;	/* No card detect - just cover switch */
 	bool	nonremovable;	/* Nonremovable e.g. eMMC */
 	bool	deferred;	/* mmc needs a deferred probe */
 	int	gpio_cd;	/* or -EINVAL */
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 465c34e..a558c87 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -248,15 +248,6 @@ static int omap_hsmmc_get_wp(struct device *dev, int slot)
 	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
 }
 
-static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
-{
-	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_hsmmc_platform_data *mmc = host->pdata;
-
-	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
-}
-
 #ifdef CONFIG_PM
 
 static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
@@ -454,11 +445,7 @@ static int omap_hsmmc_gpio_init(struct omap_hsmmc_platform_data *pdata)
 	int ret;
 
 	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
-		if (pdata->slots[0].cover)
-			pdata->slots[0].get_cover_state =
-					omap_hsmmc_get_cover_state;
-		else
-			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
+		pdata->slots[0].card_detect = omap_hsmmc_card_detect;
 		pdata->slots[0].card_detect_irq =
 				gpio_to_irq(pdata->slots[0].switch_pin);
 		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
@@ -786,29 +773,6 @@ static void send_init_stream(struct omap_hsmmc_host *host)
 	enable_irq(host->irq);
 }
 
-static inline
-int omap_hsmmc_cover_is_closed(struct omap_hsmmc_host *host)
-{
-	int r = 1;
-
-	if (mmc_slot(host).get_cover_state)
-		r = mmc_slot(host).get_cover_state(host->dev, host->slot_id);
-	return r;
-}
-
-static ssize_t
-omap_hsmmc_show_cover_switch(struct device *dev, struct device_attribute *attr,
-			   char *buf)
-{
-	struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	return sprintf(buf, "%s\n",
-			omap_hsmmc_cover_is_closed(host) ? "closed" : "open");
-}
-
-static DEVICE_ATTR(cover_switch, S_IRUGO, omap_hsmmc_show_cover_switch, NULL);
-
 static ssize_t
 omap_hsmmc_show_slot_name(struct device *dev, struct device_attribute *attr,
 			char *buf)
@@ -1256,30 +1220,6 @@ err:
 	return ret;
 }
 
-/* Protect the card while the cover is open */
-static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
-{
-	if (!mmc_slot(host).get_cover_state)
-		return;
-
-	host->reqs_blocked = 0;
-	if (mmc_slot(host).get_cover_state(host->dev, host->slot_id)) {
-		if (host->protect_card) {
-			dev_info(host->dev, "%s: cover is closed, "
-					 "card is now accessible\n",
-					 mmc_hostname(host->mmc));
-			host->protect_card = 0;
-		}
-	} else {
-		if (!host->protect_card) {
-			dev_info(host->dev, "%s: cover is open, "
-					 "card is now inaccessible\n",
-					 mmc_hostname(host->mmc));
-			host->protect_card = 1;
-		}
-	}
-}
-
 /*
  * irq handler to notify the core about card insertion/removal
  */
@@ -1289,15 +1229,10 @@ static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 	struct omap_hsmmc_slot_data *slot = &mmc_slot(host);
 	int carddetect;
 
-	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
-
-	if (slot->card_detect)
-		carddetect = slot->card_detect(host->dev, host->slot_id);
-	else {
-		omap_hsmmc_protect_card(host);
-		carddetect = -ENOSYS;
-	}
+	if (!slot->card_detect)
+		return IRQ_HANDLED;
 
+	carddetect = slot->card_detect(host->dev, host->slot_id);
 	if (carddetect)
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
 	else
@@ -2234,8 +2169,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (!ret)
 		mmc->caps |= MMC_CAP_SDIO_IRQ;
 
-	omap_hsmmc_protect_card(host);
-
 	mmc_add_host(mmc);
 
 	if (mmc_slot(host).name != NULL) {
@@ -2243,12 +2176,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_slot_name;
 	}
-	if (mmc_slot(host).card_detect_irq && mmc_slot(host).get_cover_state) {
-		ret = device_create_file(&mmc->class_dev,
-					&dev_attr_cover_switch);
-		if (ret < 0)
-			goto err_slot_name;
-	}
 
 	omap_hsmmc_debugfs(mmc);
 	pm_runtime_mark_last_busy(host->dev);
@@ -2368,8 +2295,6 @@ static int omap_hsmmc_resume(struct device *dev)
 	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
 		omap_hsmmc_conf_bus_power(host);
 
-	omap_hsmmc_protect_card(host);
-
 	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
 	    !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
 		enable_irq(host->wake_irq);
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 066075c..e856301 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -63,8 +63,6 @@ struct omap_hsmmc_platform_data {
 		u32 caps;	/* Used for the MMC driver on 2430 and later */
 		u32 pm_caps;	/* PM capabilities of the mmc */
 
-		/* switch pin can be for card detect (default) or card cover */
-		unsigned cover:1;
 
 		/* use the internal clock */
 		unsigned internal_clock:1;
@@ -94,14 +92,6 @@ struct omap_hsmmc_platform_data {
 		void (*after_set_reg)(struct device *dev, int slot,
 				      int power_on, int vdd);
 
-		/* return MMC cover switch state, can be NULL if not supported.
-		 *
-		 * possible return values:
-		 *   0 - closed
-		 *   1 - open
-		 */
-		int (*get_cover_state)(struct device *dev, int slot);
-
 		const char *name;
 		u32 ocr_mask;
 
-- 
2.1.0

