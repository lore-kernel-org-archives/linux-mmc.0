From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/27] mmc: msm_sdcc: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:33 +0200
Message-ID: <1380207292-16968-9-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Additionally, remove dead code which also used the deprecated APIs.

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/msm_sdcc.c |   27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index b900de4..9405ecd 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1416,28 +1416,10 @@ ioremap_free:
 }
 
 #ifdef CONFIG_PM
-#ifdef CONFIG_MMC_MSM7X00A_RESUME_IN_WQ
-static void
-do_resume_work(struct work_struct *work)
-{
-	struct msmsdcc_host *host =
-		container_of(work, struct msmsdcc_host, resume_task);
-	struct mmc_host	*mmc = host->mmc;
-
-	if (mmc) {
-		mmc_resume_host(mmc);
-		if (host->stat_irq)
-			enable_irq(host->stat_irq);
-	}
-}
-#endif
-
-
 static int
 msmsdcc_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct mmc_host *mmc = mmc_get_drvdata(dev);
-	int rc = 0;
 
 	if (mmc) {
 		struct msmsdcc_host *host = mmc_priv(mmc);
@@ -1445,14 +1427,11 @@ msmsdcc_suspend(struct platform_device *dev, pm_message_t state)
 		if (host->stat_irq)
 			disable_irq(host->stat_irq);
 
-		if (mmc->card && mmc->card->type != MMC_TYPE_SDIO)
-			rc = mmc_suspend_host(mmc);
-		if (!rc)
-			msmsdcc_writel(host, 0, MMCIMASK0);
+		msmsdcc_writel(host, 0, MMCIMASK0);
 		if (host->clks_on)
 			msmsdcc_disable_clocks(host, 0);
 	}
-	return rc;
+	return 0;
 }
 
 static int
@@ -1467,8 +1446,6 @@ msmsdcc_resume(struct platform_device *dev)
 
 		msmsdcc_writel(host, host->saved_irq0mask, MMCIMASK0);
 
-		if (mmc->card && mmc->card->type != MMC_TYPE_SDIO)
-			mmc_resume_host(mmc);
 		if (host->stat_irq)
 			enable_irq(host->stat_irq);
 #if BUSCLK_PWRSAVE
-- 
1.7.9.5
