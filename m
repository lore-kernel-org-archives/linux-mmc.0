From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 22/30] omap_hsmmc: cleanup macro usage
Date: Wed, 09 Sep 2009 14:59:19 +0300
Message-ID: <20090909115919.12833.33542.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43110 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbZIIL7r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:59:47 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>

>From 5f9c3e4511904ff58ab1cf619f35a10cc528a94f Mon Sep 17 00:00:00 2001
From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Date: Thu, 14 May 2009 09:11:38 +0200
Subject: [PATCH] omap_hsmmc: cleanup macro usage

Use macro mmc_slot() in omap_hsmmc.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   42 ++++++++++++++++++----------------------
 1 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 243ad97..a669757 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -366,9 +366,8 @@ int mmc_omap_cover_is_closed(struct mmc_omap_host *host)
 {
 	int r = 1;
 
-	if (host->pdata->slots[host->slot_id].get_cover_state)
-		r = host->pdata->slots[host->slot_id].get_cover_state(host->dev,
-			host->slot_id);
+	if (mmc_slot(host).get_cover_state)
+		r = mmc_slot(host).get_cover_state(host->dev, host->slot_id);
 	return r;
 }
 
@@ -391,9 +390,8 @@ mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
 {
 	struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
 	struct mmc_omap_host *host = mmc_priv(mmc);
-	struct omap_mmc_slot_data slot = host->pdata->slots[host->slot_id];
 
-	return sprintf(buf, "%s\n", slot.name);
+	return sprintf(buf, "%s\n", mmc_slot(host).name);
 }
 
 static DEVICE_ATTR(slot_name, S_IRUGO, mmc_omap_show_slot_name, NULL);
@@ -625,7 +623,8 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 			(status & CMD_CRC)) {
 			if (host->cmd) {
 				if (status & CMD_TIMEOUT) {
-					mmc_omap_reset_controller_fsm(host, SRC);
+					mmc_omap_reset_controller_fsm(host,
+								      SRC);
 					host->cmd->error = -ETIMEDOUT;
 				} else {
 					host->cmd->error = -EILSEQ;
@@ -768,7 +767,7 @@ static void mmc_omap_detect(struct work_struct *work)
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 
-	if (mmc_slot(host).card_detect)
+	if (slot->card_detect)
 		carddetect = slot->card_detect(slot->card_detect_irq);
 	else
 		carddetect = -ENOSYS;
@@ -823,7 +822,7 @@ static void mmc_omap_config_dma_params(struct mmc_omap_host *host,
 			sg_dma_address(sgl), 0, 0);
 	} else {
 		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-					(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
+			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
 		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
 			sg_dma_address(sgl), 0, 0);
 	}
@@ -911,7 +910,7 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
 	}
 
 	ret = omap_request_dma(mmc_omap_get_dma_sync_dev(host, data), "MMC/SD",
-			       mmc_omap_dma_cb,host, &dma_ch);
+			       mmc_omap_dma_cb, host, &dma_ch);
 	if (ret != 0) {
 		dev_err(mmc_dev(host->mmc),
 			"%s: omap_request_dma() failed with %d\n",
@@ -1131,21 +1130,19 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
 {
 	struct mmc_omap_host *host = mmc_priv(mmc);
-	struct omap_mmc_platform_data *pdata = host->pdata;
 
-	if (!pdata->slots[0].card_detect)
+	if (!mmc_slot(host).card_detect)
 		return -ENOSYS;
-	return pdata->slots[0].card_detect(pdata->slots[0].card_detect_irq);
+	return mmc_slot(host).card_detect(mmc_slot(host).card_detect_irq);
 }
 
 static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 {
 	struct mmc_omap_host *host = mmc_priv(mmc);
-	struct omap_mmc_platform_data *pdata = host->pdata;
 
-	if (!pdata->slots[0].get_ro)
+	if (!mmc_slot(host).get_ro)
 		return -ENOSYS;
-	return pdata->slots[0].get_ro(host->dev, 0);
+	return mmc_slot(host).get_ro(host->dev, 0);
 }
 
 static void omap_hsmmc_init(struct mmc_omap_host *host)
@@ -1556,7 +1553,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
 
-	if (pdata->slots[host->slot_id].power_saving)
+	if (mmc_slot(host).power_saving)
 		mmc->ops	= &mmc_omap_ps_ops;
 	else
 		mmc->ops	= &mmc_omap_ops;
@@ -1626,12 +1623,12 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY;
 
-	if (pdata->slots[host->slot_id].wires >= 8)
+	if (mmc_slot(host).wires >= 8)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
-	else if (pdata->slots[host->slot_id].wires >= 4)
+	else if (mmc_slot(host).wires >= 4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
-	if (pdata->slots[host->slot_id].nonremovable)
+	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 
 	omap_hsmmc_init(host);
@@ -1693,13 +1690,12 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 
 	mmc_add_host(mmc);
 
-	if (host->pdata->slots[host->slot_id].name != NULL) {
+	if (mmc_slot(host).name != NULL) {
 		ret = device_create_file(&mmc->class_dev, &dev_attr_slot_name);
 		if (ret < 0)
 			goto err_slot_name;
 	}
-	if (mmc_slot(host).card_detect_irq &&
-	    host->pdata->slots[host->slot_id].get_cover_state) {
+	if (mmc_slot(host).card_detect_irq && mmc_slot(host).get_cover_state) {
 		ret = device_create_file(&mmc->class_dev,
 					&dev_attr_cover_switch);
 		if (ret < 0)
@@ -1805,7 +1801,7 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 
 
 			OMAP_HSMMC_WRITE(host->base, HCTL,
-					 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
+				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			mmc_host_disable(host->mmc);
 			clk_disable(host->iclk);
 			clk_disable(host->dbclk);
-- 
1.5.6.3

