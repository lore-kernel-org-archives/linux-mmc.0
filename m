From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 8/8] mmc: tmio: Remove redundant runtime PM calls
Date: Tue, 29 Mar 2016 09:31:13 +0200
Message-ID: <1459236673-5639-8-git-send-email-ulf.hansson@linaro.org>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35153 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977AbcC2Hbk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 03:31:40 -0400
Received: by mail-lb0-f177.google.com with SMTP id bc4so4678739lbc.2
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2016 00:31:34 -0700 (PDT)
In-Reply-To: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ian Molton <ian@mnementh.co.uk>

Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
devices"), made some calls to the runtime PM API from the driver
redundant. Especially those which deals with runtime PM reference
counting, so let's remove them.

Cc: Ian Molton <ian@mnementh.co.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc_pio.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 03f6e74..d822299 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -264,9 +264,6 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 
 	tmio_mmc_abort_dma(host);
 	mmc_request_done(host->mmc, mrq);
-
-	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
-	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 /* called with host->lock held, interrupts disabled */
@@ -296,9 +293,6 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 		tmio_mmc_abort_dma(host);
 
 	mmc_request_done(host->mmc, mrq);
-
-	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
-	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 static void tmio_mmc_done_work(struct work_struct *work)
@@ -812,8 +806,6 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	pm_runtime_get_sync(mmc_dev(mmc));
-
 	if (mrq->data) {
 		ret = tmio_mmc_start_data(host, mrq->data);
 		if (ret)
@@ -832,9 +824,6 @@ fail:
 	host->mrq = NULL;
 	mrq->cmd->error = ret;
 	mmc_request_done(mmc, mrq);
-
-	pm_runtime_mark_last_busy(mmc_dev(mmc));
-	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int tmio_mmc_clk_update(struct tmio_mmc_host *host)
@@ -925,8 +914,6 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct device *dev = &host->pdev->dev;
 	unsigned long flags;
 
-	pm_runtime_get_sync(mmc_dev(mmc));
-
 	mutex_lock(&host->ios_lock);
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -983,9 +970,6 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->clk_cache = ios->clock;
 
 	mutex_unlock(&host->ios_lock);
-
-	pm_runtime_mark_last_busy(mmc_dev(mmc));
-	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int tmio_mmc_get_ro(struct mmc_host *mmc)
@@ -996,11 +980,8 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 	if (ret >= 0)
 		return ret;
 
-	pm_runtime_get_sync(mmc_dev(mmc));
 	ret = !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
 		(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
-	pm_runtime_mark_last_busy(mmc_dev(mmc));
-	pm_runtime_put_autosuspend(mmc_dev(mmc));
 
 	return ret;
 }
-- 
1.9.1

