From: alex lemberg <alex.lemberg@sandisk.com>
Subject: [PATCH 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Thu, 1 Sep 2016 17:24:50 +0300
Message-ID: <1472739890-3384-4-git-send-email-alex.lemberg@sandisk.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:48064
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932680AbcIAPCg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 11:02:36 -0400
In-Reply-To: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: avi.shchislowski@sandisk.com, alex lemberg <alex.lemberg@sandisk.com>

Rescheduling Suspend in case of BKOPS Level >= 1
in order to let eMMC device to complete its internal GC.
Applicable for Runtime Suspend Only.

Signed-off-by: alex lemberg <alex.lemberg@sandisk.com>
---
 drivers/mmc/core/mmc.c  | 30 +++++++++++++++++++++++-------
 include/linux/mmc/mmc.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e2e987f..c4c6326 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1904,7 +1904,8 @@ static void mmc_detect(struct mmc_host *host)
 	}
 }
 
-static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
+static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
+	bool is_runtime_pm)
 {
 	int err = 0;
 	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
@@ -1918,10 +1919,25 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (mmc_card_suspended(host->card))
 		goto out;
 
-	if (mmc_card_doing_bkops(host->card)) {
-		err = mmc_stop_bkops(host->card);
-		if (err)
+	if (mmc_card_doing_bkops(host->card) ||
+		host->card->ext_csd.auto_bkops_en) {
+		err = mmc_read_bkops_status(host->card);
+		if (err) {
+			pr_err("%s: error %d reading BKOPS Status\n",
+				mmc_hostname(host), err);
+			goto out;
+		}
+		if (is_runtime_pm && host->card->ext_csd.raw_bkops_status >=
+				EXT_CSD_BKOPS_LEVEL_1) {
+			pm_schedule_suspend(&host->card->dev,
+				MMC_RUNTIME_SUSPEND_DELAY_MS);
 			goto out;
+		}
+		if (mmc_card_doing_bkops(host->card)) {
+			err = mmc_stop_bkops(host->card);
+			if (err)
+				goto out;
+		}
 	}
 
 	err = mmc_flush_cache(host->card);
@@ -1952,7 +1968,7 @@ static int mmc_suspend(struct mmc_host *host)
 {
 	int err;
 
-	err = _mmc_suspend(host, true);
+	err = _mmc_suspend(host, true, false);
 	if (!err) {
 		pm_runtime_disable(&host->card->dev);
 		pm_runtime_set_suspended(&host->card->dev);
@@ -2002,7 +2018,7 @@ static int mmc_shutdown(struct mmc_host *host)
 		err = _mmc_resume(host);
 
 	if (!err)
-		err = _mmc_suspend(host, false);
+		err = _mmc_suspend(host, false, false);
 
 	return err;
 }
@@ -2026,7 +2042,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	err = _mmc_suspend(host, true);
+	err = _mmc_suspend(host, true, true);
 	if (err)
 		pr_err("%s: error %d doing aggressive suspend\n",
 			mmc_hostname(host), err);
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 0fe3908..0f08d5c 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -430,6 +430,7 @@ struct _mmc_csd {
 /*
  * BKOPS status level
  */
+#define EXT_CSD_BKOPS_LEVEL_1		0x1
 #define EXT_CSD_BKOPS_LEVEL_2		0x2
 
 /*
-- 
1.9.1

