From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/8] mmc: tmio: Keep host active while serving requests
Date: Fri,  8 Nov 2013 07:06:13 +0100
Message-ID: <1383890776-6912-6-git-send-email-ulf.hansson@linaro.org>
References: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:40755 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3KHGGd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 01:06:33 -0500
Received: by mail-la0-f52.google.com with SMTP id ev20so1380184lab.11
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 22:06:31 -0800 (PST)
In-Reply-To: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Use runtime PM to keep the host active during I/O operations and other
requests which requires the tmio hardware to be powered.

Additionally make use of the runtime PM autosuspend feature with a
default timeout of 50 ms.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc_pio.c |   55 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 377157e..33a5e26 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -144,7 +144,8 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
 
 		host->sdio_irq_enabled = false;
-		pm_runtime_put(mmc_dev(mmc));
+		pm_runtime_mark_last_busy(mmc_dev(mmc));
+		pm_runtime_put_autosuspend(mmc_dev(mmc));
 	}
 }
 
@@ -258,6 +259,9 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 
 	tmio_mmc_abort_dma(host);
 	mmc_request_done(host->mmc, mrq);
+
+	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
+	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 /* called with host->lock held, interrupts disabled */
@@ -287,6 +291,9 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 		tmio_mmc_abort_dma(host);
 
 	mmc_request_done(host->mmc, mrq);
+
+	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
+	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 static void tmio_mmc_done_work(struct work_struct *work)
@@ -741,6 +748,8 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	pm_runtime_get_sync(mmc_dev(mmc));
+
 	if (mrq->data) {
 		ret = tmio_mmc_start_data(host, mrq->data);
 		if (ret)
@@ -759,6 +768,9 @@ fail:
 	host->mrq = NULL;
 	mrq->cmd->error = ret;
 	mmc_request_done(mmc, mrq);
+
+	pm_runtime_mark_last_busy(mmc_dev(mmc));
+	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int tmio_mmc_clk_update(struct mmc_host *mmc)
@@ -837,6 +849,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct device *dev = &host->pdev->dev;
 	unsigned long flags;
 
+	pm_runtime_get_sync(mmc_dev(mmc));
+
 	mutex_lock(&host->ios_lock);
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -872,7 +886,6 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
 		if (host->power != TMIO_MMC_ON_RUN) {
 			tmio_mmc_clk_update(mmc);
-			pm_runtime_get_sync(dev);
 			if (host->resuming) {
 				tmio_mmc_reset(host);
 				host->resuming = false;
@@ -902,7 +915,6 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		if (old_power == TMIO_MMC_ON_RUN) {
 			tmio_mmc_clk_stop(host);
-			pm_runtime_put(dev);
 			if (pdata->clk_disable)
 				pdata->clk_disable(host->pdev);
 		}
@@ -929,6 +941,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->mrq = NULL;
 
 	mutex_unlock(&host->ios_lock);
+
+	pm_runtime_mark_last_busy(mmc_dev(mmc));
+	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int tmio_mmc_get_ro(struct mmc_host *mmc)
@@ -939,8 +954,13 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 	if (ret >= 0)
 		return ret;
 
-	return !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
-		 (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
+	pm_runtime_get_sync(mmc_dev(mmc));
+	ret = !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
+		(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
+	pm_runtime_mark_last_busy(mmc_dev(mmc));
+	pm_runtime_put_autosuspend(mmc_dev(mmc));
+
+	return ret;
 }
 
 static const struct mmc_host_ops tmio_mmc_ops = {
@@ -1038,27 +1058,14 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  mmc->slot.cd_irq >= 0);
 
 	_host->power = TMIO_MMC_OFF_STOP;
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_resume(&pdev->dev);
-	if (ret < 0)
-		goto pm_disable;
-
 	if (tmio_mmc_clk_update(mmc) < 0) {
 		mmc->f_max = pdata->hclk;
 		mmc->f_min = mmc->f_max / 512;
 	}
 
 	/*
-	 * There are 4 different scenarios for the card detection:
-	 *  1) an external gpio irq handles the cd (best for power savings)
-	 *  2) internal sdhi irq handles the cd
-	 *  3) a worker thread polls the sdhi - indicated by MMC_CAP_NEEDS_POLL
-	 *  4) the medium is non-removable - indicated by MMC_CAP_NONREMOVABLE
-	 *
-	 *  While we increment the runtime PM counter for all scenarios when
-	 *  the mmc core activates us by calling an appropriate set_ios(), we
-	 *  must additionally ensure that in case 2) the tmio mmc hardware stays
-	 *  powered on during runtime for the card detection to work.
+	 * While using internal tmio hardware logic for card detection, we need
+	 * to ensure it stays powered for it to work.
 	 */
 	if (_host->native_hotplug)
 		pm_runtime_get_noresume(&pdev->dev);
@@ -1096,6 +1103,11 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = mmc_add_host(mmc);
 	if (pdata->clk_disable)
 		pdata->clk_disable(pdev);
@@ -1118,9 +1130,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	return 0;
 
-pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	iounmap(_host->ctl);
 host_free:
 	mmc_free_host(mmc);
 
-- 
1.7.9.5

