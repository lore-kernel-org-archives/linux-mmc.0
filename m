From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/7] mmc: sh_mmcif: Use runtime PM to keep resourses active during I/O
Date: Wed,  2 Oct 2013 10:30:48 +0200
Message-ID: <1380702651-13389-5-git-send-email-ulf.hansson@linaro.org>
References: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:53787 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab3JBIbI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 04:31:08 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so341944lab.16
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 01:31:07 -0700 (PDT)
In-Reply-To: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

While I/O operations are ongoing, make sure the runtime PM resourses
are kept active. When returning the resourses, utilize the runtime PM
autosuspend feature with a default timeout set to 50 ms.

The reason for chosing a 50 ms timeout is to make sure we are able to
handle clock gating in a future possible runtime suspend callback.
According to the (e)MMC/SD/SDIO specification the clock must be
maintained for a minimum numbers of clock cycles even after responses
has been received. 50 ms will cover all cases.

Additionally, 50 ms has for other host drivers seemed reasonable, to
prevent bringing the runtime resourses up and down between each and
every request.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d032b08..f4532dc 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -959,6 +959,8 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host->mrq = mrq;
 
+	pm_runtime_get_sync(mmc_dev(mmc));
+
 	sh_mmcif_start_cmd(host, mrq);
 }
 
@@ -1000,6 +1002,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->state = STATE_IOS;
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	pm_runtime_get_sync(mmc_dev(mmc));
+
 	if (ios->power_mode == MMC_POWER_UP) {
 		if (!host->card_present) {
 			/* See if we also get DMA */
@@ -1017,20 +1021,18 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			}
 		}
 		if (host->power) {
-			pm_runtime_put_sync(&host->pd->dev);
 			clk_disable_unprepare(host->hclk);
 			host->power = false;
 			if (ios->power_mode == MMC_POWER_OFF)
 				sh_mmcif_set_power(host, ios);
 		}
 		host->state = STATE_IDLE;
-		return;
+		goto ret;
 	}
 
 	if (ios->clock) {
 		if (!host->power) {
 			sh_mmcif_clk_update(host);
-			pm_runtime_get_sync(&host->pd->dev);
 			host->power = true;
 			sh_mmcif_sync_reset(host);
 		}
@@ -1040,6 +1042,9 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->timing = ios->timing;
 	host->bus_width = ios->bus_width;
 	host->state = STATE_IDLE;
+ret:
+	pm_runtime_mark_last_busy(mmc_dev(mmc));
+	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int sh_mmcif_get_cd(struct mmc_host *mmc)
@@ -1253,6 +1258,9 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 
 	mutex_unlock(&host->thread_lock);
 
+	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
+	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
+
 	return IRQ_HANDLED;
 }
 
@@ -1341,6 +1349,9 @@ static void mmcif_timeout_work(struct work_struct *work)
 	host->wait_for = MMCIF_WAIT_FOR_REQUEST;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
+
+	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
+	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
@@ -1421,23 +1432,18 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	pm_runtime_enable(&pdev->dev);
 	host->power = false;
 
 	host->hclk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->hclk)) {
 		ret = PTR_ERR(host->hclk);
 		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
-		goto eclkget;
+		goto eofparse;
 	}
 	ret = sh_mmcif_clk_update(host);
 	if (ret < 0)
 		goto eclkupdate;
 
-	ret = pm_runtime_resume(&pdev->dev);
-	if (ret < 0)
-		goto eresume;
-
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
 	sh_mmcif_sync_reset(host);
@@ -1466,6 +1472,12 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	mutex_init(&host->thread_lock);
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	clk_disable_unprepare(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
@@ -1476,22 +1488,24 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
 	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return ret;
 
 emmcaddh:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 erqcd:
 	if (irq[1] >= 0)
 		free_irq(irq[1], host);
 ereqirq1:
 	free_irq(irq[0], host);
 ereqirq0:
-	pm_runtime_suspend(&pdev->dev);
-eresume:
 	clk_disable_unprepare(host->hclk);
 eclkupdate:
 	clk_put(host->hclk);
-eclkget:
-	pm_runtime_disable(&pdev->dev);
 eofparse:
 	mmc_free_host(mmc);
 ealloch:
@@ -1532,8 +1546,8 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(host->hclk);
 	mmc_free_host(host->mmc);
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
 }
-- 
1.7.9.5

