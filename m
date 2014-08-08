From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 2/3 resend] omap_hsmmc: separate card_detect/cover detect logic
Date: Fri,  8 Aug 2014 12:16:59 +0200
Message-ID: <1407493020-11566-3-git-send-email-afenkart@gmail.com>
References: <1407493020-11566-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1407493020-11566-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, daniel@zonque.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

assuming cover is the door like thing on cameras that needs to be closed
after replacing sd cards. card detect is a gpio connected to sdio slot.
in a follow up patch card_detect will be replaced by generic mmc/slot-gpio
a git bisect patch

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1c10e6c..1b9f279 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -447,19 +447,32 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
 	int ret;
 
 	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
-		if (pdata->slots[0].cover)
+		if (pdata->slots[0].cover) {
 			pdata->slots[0].get_cover_state =
 					omap_hsmmc_get_cover_state;
-		else
+			pdata->slots[0].cover_detect_irq =
+				gpio_to_irq(pdata->slots[0].switch_pin);
+
+			ret = gpio_request(pdata->slots[0].switch_pin,
+					   "mmc_cd");
+			if (ret)
+				return ret;
+			ret = gpio_direction_input(pdata->slots[0].switch_pin);
+			if (ret)
+				goto err_free_sp;
+		} else {
 			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
-		pdata->slots[0].card_detect_irq =
+			pdata->slots[0].card_detect_irq =
 				gpio_to_irq(pdata->slots[0].switch_pin);
-		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
-		if (ret)
-			return ret;
-		ret = gpio_direction_input(pdata->slots[0].switch_pin);
-		if (ret)
-			goto err_free_sp;
+
+			ret = gpio_request(pdata->slots[0].switch_pin,
+					   "mmc_cd");
+			if (ret)
+				return ret;
+			ret = gpio_direction_input(pdata->slots[0].switch_pin);
+			if (ret)
+				goto err_free_sp;
+		}
 	} else
 		pdata->slots[0].switch_pin = -EINVAL;
 
@@ -1282,19 +1295,18 @@ static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 	struct omap_mmc_slot_data *slot = &mmc_slot(host);
 	int carddetect;
 
-	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
-
-	if (slot->card_detect)
+	if (slot->card_detect) {
 		carddetect = slot->card_detect(host->dev, host->slot_id);
-	else {
+		if (carddetect)
+			mmc_detect_change(host->mmc, (HZ * 200) / 1000);
+		else
+			mmc_detect_change(host->mmc, (HZ * 50) / 1000);
+	} else {
+		sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 		omap_hsmmc_protect_card(host);
-		carddetect = -ENOSYS;
+		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
 	}
 
-	if (carddetect)
-		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
-	else
-		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
 	return IRQ_HANDLED;
 }
 
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 7fe0c14..d113005 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -136,6 +136,7 @@ struct omap_mmc_platform_data {
 		 *   0 - closed
 		 *   1 - open
 		 */
+		int cover_detect_irq;
 		int (*get_cover_state)(struct device *dev, int slot);
 
 		const char *name;
-- 
2.0.0

