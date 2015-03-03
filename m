From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 3/6] mmc: omap_hsmmc: use distinctive code paths for cover / card detect logic
Date: Tue,  3 Mar 2015 13:28:15 +0100
Message-ID: <1425385698-6588-4-git-send-email-afenkart@gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Mobile phones (some) have no card detect pin, but can detect if the
cover is removed. The purpose is the same; detect if card is being
added/removed, but the details differ.
When the cover is removed, it does not mean the card is gone. But it
might, since it is accessible now. It's like a warning. All the driver
does is to limit write access to the card, see protect_card flag.
In contrast, card detect notifies us after the fact, e.g.
card is gone, card is inserted. We can't take precautions, but we can
rely on those events, -- the card is really gone, or do scan the card.
To summarize there is not much code sharing between cover and card
detect, it only increases confusion. By splitting, both will be
simplified in a followup patch.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 56 +++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 77ad471..38239fb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -230,9 +230,6 @@ struct omap_hsmmc_host {
 	 */
 	int (*get_cover_state)(struct device *dev);
 
-	/* Card detection IRQs */
-	int card_detect_irq;
-
 	int (*card_detect)(struct device *dev);
 };
 
@@ -422,6 +419,7 @@ static inline int omap_hsmmc_have_reg(void)
 #endif
 
 static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id);
+static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id);
 
 static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
 				struct omap_hsmmc_host *host,
@@ -429,20 +427,20 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
 {
 	int ret;
 
-	if (gpio_is_valid(pdata->switch_pin)) {
-		if (pdata->cover)
-			host->get_cover_state =
-				omap_hsmmc_get_cover_state;
-		else
-			host->card_detect = omap_hsmmc_card_detect;
-		host->card_detect_irq =
-				gpio_to_irq(pdata->switch_pin);
-		mmc_gpio_set_cd_isr(mmc, omap_hsmmc_detect);
+	if (pdata->cover && gpio_is_valid(pdata->switch_pin)) {
 		ret = mmc_gpio_request_cd(mmc, pdata->switch_pin, 0);
 		if (ret)
 			return ret;
-	} else {
-		pdata->switch_pin = -EINVAL;
+
+		host->get_cover_state = omap_hsmmc_get_cover_state;
+		mmc_gpio_set_cd_isr(mmc, omap_hsmmc_cover_irq);
+	} else if (!pdata->cover && gpio_is_valid(pdata->switch_pin)) {
+		ret = mmc_gpio_request_cd(mmc, pdata->switch_pin, 0);
+		if (ret)
+			return ret;
+
+		host->card_detect = omap_hsmmc_card_detect;
+		mmc_gpio_set_cd_isr(mmc, omap_hsmmc_detect);
 	}
 
 	if (gpio_is_valid(pdata->gpio_wp)) {
@@ -1236,15 +1234,37 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 }
 
 /*
- * irq handler to notify the core about card insertion/removal
+ * irq handler when (cell-phone) cover is mounted/removed
  */
-static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
+static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id)
 {
 	struct omap_hsmmc_host *host = dev_id;
 	int carddetect;
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 
+	if (host->card_detect) {
+		carddetect = host->card_detect(host->dev);
+	} else {
+		omap_hsmmc_protect_card(host);
+		carddetect = -ENOSYS;
+	}
+
+	if (carddetect)
+		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
+	else
+		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
+	return IRQ_HANDLED;
+}
+
+/*
+ * irq handler to notify the core about card insertion/removal
+ */
+static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
+{
+	struct omap_hsmmc_host *host = dev_id;
+	int carddetect;
+
 	if (host->card_detect)
 		carddetect = host->card_detect(host->dev);
 	else {
@@ -2164,9 +2184,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_slot_name;
 	}
-	if (host->card_detect_irq && host->get_cover_state) {
+	if (host->get_cover_state) {
 		ret = device_create_file(&mmc->class_dev,
-					&dev_attr_cover_switch);
+					 &dev_attr_cover_switch);
 		if (ret < 0)
 			goto err_slot_name;
 	}
-- 
2.1.4

