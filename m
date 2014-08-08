From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 3/3 resend] omap_hsmmc: reuse mmc/slot-gpio for card detect instead of open-coded version
Date: Fri,  8 Aug 2014 12:17:00 +0200
Message-ID: <1407493020-11566-4-git-send-email-afenkart@gmail.com>
References: <1407493020-11566-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45148 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbaHHKRQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Aug 2014 06:17:16 -0400
In-Reply-To: <1407493020-11566-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, daniel@zonque.org, Andreas Fenkart <afenkart@gmail.com>

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1b9f279..25aafa6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -231,15 +231,6 @@ struct omap_mmc_of_data {
 
 static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host);
 
-static int omap_hsmmc_card_detect(struct device *dev, int slot)
-{
-	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_mmc_platform_data *mmc = host->pdata;
-
-	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
-}
-
 static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
@@ -256,7 +247,7 @@ static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 	struct omap_mmc_platform_data *mmc = host->pdata;
 
-	disable_irq(mmc->slots[0].card_detect_irq);
+	disable_irq(mmc->slots[0].cover_detect_irq);
 	return 0;
 }
 
@@ -265,7 +256,7 @@ static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 	struct omap_mmc_platform_data *mmc = host->pdata;
 
-	enable_irq(mmc->slots[0].card_detect_irq);
+	enable_irq(mmc->slots[0].cover_detect_irq);
 	return 0;
 }
 
@@ -458,23 +449,26 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
 			if (ret)
 				return ret;
 			ret = gpio_direction_input(pdata->slots[0].switch_pin);
-			if (ret)
-				goto err_free_sp;
+			if (ret) {
+				gpio_free(pdata->slots[0].switch_pin);
+				return ret;
+			}
 		} else {
-			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
-			pdata->slots[0].card_detect_irq =
-				gpio_to_irq(pdata->slots[0].switch_pin);
-
-			ret = gpio_request(pdata->slots[0].switch_pin,
-					   "mmc_cd");
-			if (ret)
+			/* copy & paste from from mmc_of_parse */
+			ret = mmc_gpio_request_cd(mmc,
+						  pdata->slots[0].switch_pin,
+						  0);
+			if (ret < 0) {
+				dev_err(pdata->dev,
+					"Failed to request CD GPIO #%d: %d!\n",
+					pdata->slots[0].switch_pin, ret);
 				return ret;
-			ret = gpio_direction_input(pdata->slots[0].switch_pin);
-			if (ret)
-				goto err_free_sp;
+			} else {
+				dev_info(pdata->dev, "Got CD GPIO #%d.\n",
+					pdata->slots[0].switch_pin);
+			}
 		}
-	} else
-		pdata->slots[0].switch_pin = -EINVAL;
+	}
 
 	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
 		/* copy & paste from from mmc_of_parse */
@@ -492,8 +486,9 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
 	return 0;
 
 err:
-	if (gpio_is_valid(pdata->slots[0].switch_pin))
-err_free_sp:
+	mmc_gpio_free_cd(mmc);
+	if (gpio_is_valid(pdata->slots[0].switch_pin) &&
+	    (pdata->slots[0].cover))
 		gpio_free(pdata->slots[0].switch_pin);
 	return ret;
 }
@@ -501,8 +496,11 @@ err_free_sp:
 static void omap_hsmmc_gpio_free(struct mmc_host *mmc,
 				 struct omap_mmc_platform_data *pdata)
 {
+	mmc_gpio_free_cd(mmc);
 	mmc_gpio_free_ro(mmc);
-	if (gpio_is_valid(pdata->slots[0].switch_pin))
+
+	if (gpio_is_valid(pdata->slots[0].switch_pin) &&
+	    (pdata->slots[0].cover))
 		gpio_free(pdata->slots[0].switch_pin);
 }
 
@@ -1289,24 +1287,13 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 /*
  * irq handler to notify the core about card insertion/removal
  */
-static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
+static irqreturn_t omap_hsmmc_cover_detect(int irq, void *dev_id)
 {
 	struct omap_hsmmc_host *host = dev_id;
-	struct omap_mmc_slot_data *slot = &mmc_slot(host);
-	int carddetect;
-
-	if (slot->card_detect) {
-		carddetect = slot->card_detect(host->dev, host->slot_id);
-		if (carddetect)
-			mmc_detect_change(host->mmc, (HZ * 200) / 1000);
-		else
-			mmc_detect_change(host->mmc, (HZ * 50) / 1000);
-	} else {
-		sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
-		omap_hsmmc_protect_card(host);
-		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
-	}
 
+	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
+	omap_hsmmc_protect_card(host);
+	mmc_detect_change(host->mmc, (HZ * 200) / 1000);
 	return IRQ_HANDLED;
 }
 
@@ -1669,15 +1656,6 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	pm_runtime_put_autosuspend(host->dev);
 }
 
-static int omap_hsmmc_get_cd(struct mmc_host *mmc)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	if (!mmc_slot(host).card_detect)
-		return -ENOSYS;
-	return mmc_slot(host).card_detect(host->dev, host->slot_id);
-}
-
 static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
@@ -1832,7 +1810,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.pre_req = omap_hsmmc_pre_req,
 	.request = omap_hsmmc_request,
 	.set_ios = omap_hsmmc_set_ios,
-	.get_cd = omap_hsmmc_get_cd,
+	.get_cd = mmc_gpio_get_cd,
 	.get_ro = mmc_gpio_get_ro,
 	.init_card = omap_hsmmc_init_card,
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
@@ -2228,10 +2206,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->ocr_avail = mmc_slot(host).ocr_mask;
 
 	/* Request IRQ for card detect */
-	if ((mmc_slot(host).card_detect_irq)) {
+	if ((mmc_slot(host).cover_detect_irq)) {
 		ret = devm_request_threaded_irq(&pdev->dev,
-						mmc_slot(host).card_detect_irq,
-						NULL, omap_hsmmc_detect,
+						mmc_slot(host).cover_detect_irq,
+						NULL, omap_hsmmc_cover_detect,
 					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   mmc_hostname(mmc), host);
 		if (ret) {
@@ -2266,7 +2244,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_slot_name;
 	}
-	if (mmc_slot(host).card_detect_irq && mmc_slot(host).get_cover_state) {
+	if (mmc_slot(host).cover_detect_irq && mmc_slot(host).get_cover_state) {
 		ret = device_create_file(&mmc->class_dev,
 					&dev_attr_cover_switch);
 		if (ret < 0)
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index d113005..250b437 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -142,10 +142,6 @@ struct omap_mmc_platform_data {
 		const char *name;
 		u32 ocr_mask;
 
-		/* Card detection IRQs */
-		int card_detect_irq;
-		int (*card_detect)(struct device *dev, int slot);
-
 		unsigned int ban_openended:1;
 
 	} slots[OMAP_MMC_MAX_SLOTS];
-- 
2.0.0

