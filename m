From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] mmc: tmio: maximize power saving
Date: Thu, 14 Jul 2011 01:31:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107140125460.30737@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52627 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab1GMXcE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 19:32:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, "Rafael J. Wysocki" <rjw@sisk.pl>

This patch uses runtime PM to allow the system to power down the MMC
controller, when the MMC closk is switched off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: Primarily tested on mackerel, with runtime PM and system-wide suspend, 
updated to the current core and sh-mobile runtime PM code. To avoid 
regression should go in after "ARM: mach-shmobile: use GPIO interrupt also 
for card eject on SDHI0 on mackerel":

http://article.gmane.org/gmane.linux.kernel.mmc/9230

 drivers/mmc/host/tmio_mmc.h     |    2 +
 drivers/mmc/host/tmio_mmc_pio.c |   66 ++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 5b83e46..d4396be 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -53,6 +53,8 @@ struct tmio_mmc_host {
 	void (*set_clk_div)(struct platform_device *host, int state);
 
 	int			pm_error;
+	/* recognise system-wide suspend in runtime PM methods */
+	bool			pm_global;
 
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index eabda39..a9a0ab6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -580,6 +580,7 @@ out:
 irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
+	struct mmc_host *mmc = host->mmc;
 	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned int ireg, irq_mask, status;
 	unsigned int sdio_ireg, sdio_irq_mask, sdio_status;
@@ -601,13 +602,13 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 		if (sdio_ireg && !host->sdio_irq_enabled) {
 			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! 0x%04x 0x%04x 0x%04x\n",
 				   sdio_status, sdio_irq_mask, sdio_ireg);
-			tmio_mmc_enable_sdio_irq(host->mmc, 0);
+			tmio_mmc_enable_sdio_irq(mmc, 0);
 			goto out;
 		}
 
-		if (host->mmc->caps & MMC_CAP_SDIO_IRQ &&
+		if (mmc->caps & MMC_CAP_SDIO_IRQ &&
 			sdio_ireg & TMIO_SDIO_STAT_IOIRQ)
-			mmc_signal_sdio_irq(host->mmc);
+			mmc_signal_sdio_irq(mmc);
 
 		if (sdio_ireg)
 			goto out;
@@ -631,8 +632,10 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 		if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
 			tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
 				TMIO_STAT_CARD_REMOVE);
-			if (!work_pending(&host->mmc->detect.work))
-				mmc_detect_change(host->mmc, msecs_to_jiffies(100));
+			if ((((ireg & TMIO_STAT_CARD_REMOVE) && mmc->card) ||
+			     ((ireg & TMIO_STAT_CARD_INSERT) && !mmc->card)) &&
+			    !work_pending(&mmc->detect.work))
+				mmc_detect_change(mmc, msecs_to_jiffies(100));
 		}
 
 		/* CRC and other errors */
@@ -789,33 +792,30 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (ios->clock)
-		tmio_mmc_set_clock(host, ios->clock);
-
-	/* Power sequence - OFF -> UP -> ON */
-	if (ios->power_mode == MMC_POWER_UP) {
-		if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) && !pdata->power) {
+	/*
+	 * pdata->power == false only if COLD_CD is available, otherwise only
+	 * in short time intervals during probing or resuming
+	 */
+	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
+		if (!pdata->power) {
 			pm_runtime_get_sync(&host->pdev->dev);
 			pdata->power = true;
 		}
+		tmio_mmc_set_clock(host, ios->clock);
 		/* power up SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 1);
-	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
-		/* power down SD bus */
-		if (ios->power_mode == MMC_POWER_OFF) {
-			if (host->set_pwr)
-				host->set_pwr(host->pdev, 0);
-			if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) &&
-			    pdata->power) {
-				pdata->power = false;
-				pm_runtime_put(&host->pdev->dev);
-			}
-		}
-		tmio_mmc_clk_stop(host);
-	} else {
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
+	} else if (ios->power_mode != MMC_POWER_UP) {
+		if (host->set_pwr)
+			host->set_pwr(host->pdev, 0);
+		if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) &&
+		    pdata->power) {
+			pdata->power = false;
+			pm_runtime_put(&host->pdev->dev);
+		}
+		tmio_mmc_clk_stop(host);
 	}
 
 	switch (ios->bus_width) {
@@ -943,8 +943,10 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	tmio_mmc_request_dma(_host, pdata);
 
 	/* We have to keep the device powered for its card detection to work */
-	if (!(pdata->flags & TMIO_MMC_HAS_COLD_CD))
+	if (!(pdata->flags & TMIO_MMC_HAS_COLD_CD)) {
+		pdata->power = true;
 		pm_runtime_get_noresume(&pdev->dev);
+	}
 
 	mmc_add_host(mmc);
 
@@ -1021,11 +1023,16 @@ int tmio_mmc_host_resume(struct device *dev)
 	/* The MMC core will perform the complete set up */
 	host->pdata->power = false;
 
+	host->pm_global = true;
 	if (!host->pm_error)
 		pm_runtime_get_sync(dev);
 
-	tmio_mmc_reset(mmc_priv(mmc));
-	tmio_mmc_request_dma(host, host->pdata);
+	if (host->pm_global) {
+		/* Runtime PM resume callback didn't run */
+		tmio_mmc_reset(host);
+		tmio_mmc_request_dma(host, host->pdata);
+		host->pm_global = false;
+	}
 
 	return mmc_resume_host(mmc);
 }
@@ -1046,12 +1053,15 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	struct tmio_mmc_data *pdata = host->pdata;
 
 	tmio_mmc_reset(host);
+	tmio_mmc_request_dma(host, host->pdata);
 
 	if (pdata->power) {
 		/* Only entered after a card-insert interrupt */
-		tmio_mmc_set_ios(mmc, &mmc->ios);
+		if (!mmc->card)
+			tmio_mmc_set_ios(mmc, &mmc->ios);
 		mmc_detect_change(mmc, msecs_to_jiffies(100));
 	}
+	host->pm_global = false;
 
 	return 0;
 }
-- 
1.7.2.5

