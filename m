From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 8/9] omap_hsmmc: Remove unnecessary callbacks from platform data
Date: Mon, 29 Sep 2014 11:32:58 +0200
Message-ID: <1411983179-28677-9-git-send-email-afenkart@gmail.com>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:59977 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbaI2Jd1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 05:33:27 -0400
In-Reply-To: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

These callbacks are set during driver probe and not from the platform
init, -- evtl. they had been for oamp 1/2 -- for omap3 they are local
functions of the driver. These indirection could be dropped
altogether in favor of regular function calls TODO

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f8cd3b3..0a1398a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -221,6 +221,25 @@ struct omap_hsmmc_host {
 #define HSMMC_WAKE_IRQ_ENABLED	(1 << 2)
 	struct omap_hsmmc_next	next_data;
 	struct	omap_hsmmc_platform_data	*pdata;
+
+	/* To handle board related suspend/resume functionality for MMC */
+	int (*suspend)(struct device *dev, int slot);
+	int (*resume)(struct device *dev, int slot);
+
+	/* return MMC cover switch state, can be NULL if not supported.
+	 *
+	 * possible return values:
+	 *   0 - closed
+	 *   1 - open
+	 */
+	int (*get_cover_state)(struct device *dev, int slot);
+
+	/* Card detection IRQs */
+	int card_detect_irq;
+
+	int (*card_detect)(struct device *dev, int slot);
+	int (*get_ro)(struct device *dev, int slot);
+
 };
 
 struct omap_mmc_of_data {
@@ -262,18 +281,16 @@ static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
-	disable_irq(mmc->card_detect_irq);
+	disable_irq(host->card_detect_irq);
 	return 0;
 }
 
 static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
-	enable_irq(mmc->card_detect_irq);
+	enable_irq(host->card_detect_irq);
 	return 0;
 }
 
@@ -456,11 +473,11 @@ static int omap_hsmmc_gpio_init(struct omap_hsmmc_host *host,
 
 	if (gpio_is_valid(pdata->switch_pin)) {
 		if (pdata->cover)
-			pdata->get_cover_state =
-					omap_hsmmc_get_cover_state;
+			host->get_cover_state =
+				omap_hsmmc_get_cover_state;
 		else
-			pdata->card_detect = omap_hsmmc_card_detect;
-		pdata->card_detect_irq =
+			host->card_detect = omap_hsmmc_card_detect;
+		host->card_detect_irq =
 				gpio_to_irq(pdata->switch_pin);
 		ret = gpio_request(pdata->switch_pin, "mmc_cd");
 		if (ret)
@@ -473,7 +490,7 @@ static int omap_hsmmc_gpio_init(struct omap_hsmmc_host *host,
 	}
 
 	if (gpio_is_valid(pdata->gpio_wp)) {
-		pdata->get_ro = omap_hsmmc_get_wp;
+		host->get_ro = omap_hsmmc_get_wp;
 		ret = gpio_request(pdata->gpio_wp, "mmc_wp");
 		if (ret)
 			goto err_free_cd;
@@ -795,8 +812,8 @@ int omap_hsmmc_cover_is_closed(struct omap_hsmmc_host *host)
 {
 	int r = 1;
 
-	if (mmc_pdata(host)->get_cover_state)
-		r = mmc_pdata(host)->get_cover_state(host->dev, host->slot_id);
+	if (host->get_cover_state)
+		r = host->get_cover_state(host->dev, host->slot_id);
 	return r;
 }
 
@@ -1263,11 +1280,11 @@ err:
 /* Protect the card while the cover is open */
 static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 {
-	if (!mmc_pdata(host)->get_cover_state)
+	if (!host->get_cover_state)
 		return;
 
 	host->reqs_blocked = 0;
-	if (mmc_pdata(host)->get_cover_state(host->dev, host->slot_id)) {
+	if (host->get_cover_state(host->dev, host->slot_id)) {
 		if (host->protect_card) {
 			dev_info(host->dev, "%s: cover is closed, "
 					 "card is now accessible\n",
@@ -1290,13 +1307,12 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 {
 	struct omap_hsmmc_host *host = dev_id;
-	struct omap_hsmmc_platform_data *pdata = host->pdata;
 	int carddetect;
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 
-	if (pdata->card_detect)
-		carddetect = pdata->card_detect(host->dev, host->slot_id);
+	if (host->card_detect)
+		carddetect = host->card_detect(host->dev, host->slot_id);
 	else {
 		omap_hsmmc_protect_card(host);
 		carddetect = -ENOSYS;
@@ -1672,18 +1688,18 @@ static int omap_hsmmc_get_cd(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	if (!mmc_pdata(host)->card_detect)
+	if (!host->card_detect)
 		return -ENOSYS;
-	return mmc_pdata(host)->card_detect(host->dev, host->slot_id);
+	return host->card_detect(host->dev, host->slot_id);
 }
 
 static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	if (!mmc_pdata(host)->get_ro)
+	if (!host->get_ro)
 		return -ENOSYS;
-	return mmc_pdata(host)->get_ro(host->dev, 0);
+	return host->get_ro(host->dev, 0);
 }
 
 static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
@@ -2218,9 +2234,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
 
 	/* Request IRQ for card detect */
-	if ((mmc_pdata(host)->card_detect_irq)) {
+	if (host->card_detect_irq) {
 		ret = devm_request_threaded_irq(&pdev->dev,
-						mmc_pdata(host)->card_detect_irq,
+						host->card_detect_irq,
 						NULL, omap_hsmmc_detect,
 					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   mmc_hostname(mmc), host);
@@ -2229,8 +2245,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 				"Unable to grab MMC CD IRQ\n");
 			goto err_irq_cd;
 		}
-		pdata->suspend = omap_hsmmc_suspend_cdirq;
-		pdata->resume = omap_hsmmc_resume_cdirq;
+		host->suspend = omap_hsmmc_suspend_cdirq;
+		host->resume = omap_hsmmc_resume_cdirq;
 	}
 
 	omap_hsmmc_disable_irq(host);
@@ -2256,8 +2272,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_slot_name;
 	}
-	if (mmc_pdata(host)->card_detect_irq &&
-	    mmc_pdata(host)->get_cover_state) {
+	if (host->card_detect_irq && host->get_cover_state) {
 		ret = device_create_file(&mmc->class_dev,
 					&dev_attr_cover_switch);
 		if (ret < 0)
@@ -2322,8 +2337,8 @@ static int omap_hsmmc_prepare(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
-	if (host->pdata->suspend)
-		return host->pdata->suspend(dev, host->slot_id);
+	if (host->suspend)
+		return host->suspend(dev, host->slot_id);
 
 	return 0;
 }
@@ -2332,8 +2347,8 @@ static void omap_hsmmc_complete(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
-	if (host->pdata->resume)
-		host->pdata->resume(dev, host->slot_id);
+	if (host->resume)
+		host->resume(dev, host->slot_id);
 
 }
 
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index f84eebe..0069d27 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -43,10 +43,6 @@ struct omap_hsmmc_platform_data {
 	 * maximum frequency on the MMC bus */
 	unsigned int max_freq;
 
-	/* To handle board related suspend/resume functionality for MMC */
-	int (*suspend)(struct device *dev, int slot);
-	int (*resume)(struct device *dev, int slot);
-
 	/* Integrating attributes from the omap_hwmod layer */
 	u8 controller_flags;
 
@@ -83,7 +79,6 @@ struct omap_hsmmc_platform_data {
 
 	int (*set_power)(struct device *dev, int slot,
 			 int power_on, int vdd);
-	int (*get_ro)(struct device *dev, int slot);
 	void (*remux)(struct device *dev, int slot, int power_on);
 	/* Call back before enabling / disabling regulators */
 	void (*before_set_reg)(struct device *dev, int slot,
@@ -94,19 +89,6 @@ struct omap_hsmmc_platform_data {
 	/* if we have special card, init it using this callback */
 	void (*init_card)(struct mmc_card *card);
 
-	/* return MMC cover switch state, can be NULL if not supported.
-	 *
-	 * possible return values:
-	 *   0 - closed
-	 *   1 - open
-	 */
-	int (*get_cover_state)(struct device *dev, int slot);
-
 	const char *name;
 	u32 ocr_mask;
-
-	/* Card detection IRQs */
-	int card_detect_irq;
-
-	int (*card_detect)(struct device *dev, int slot);
 };
-- 
2.1.0

