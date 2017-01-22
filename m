From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Sun, 22 Jan 2017 11:15:35 +0200
Message-ID: <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:20832
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751080AbdAVJaw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 22 Jan 2017 04:30:52 -0500
In-Reply-To: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, alex.lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>

In case of Runtime Suspend, check the device BKOPS level.
Return –EBUSY if device need more time to complete its internal BKOPS.

Changes in v2:
- return –EBUSY instead of delaying suspend
- remove define EXT_CSD_BKOPS_LEVEL_1

Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
---
 drivers/mmc/core/mmc.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f70f6a1..211b726 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1942,7 +1942,8 @@ static void mmc_detect(struct mmc_host *host)
 	}
 }
 
-static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
+static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
+	bool is_runtime_pm)
 {
 	int err = 0;
 	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
@@ -1954,6 +1955,24 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		goto out;
 
 	if (mmc_card_doing_bkops(host->card)) {
+		if (is_runtime_pm && host->card->ext_csd.auto_bkops_en) {
+			err = mmc_read_bkops_status(host->card);
+			if (err) {
+				pr_err("%s: error %d reading BKOPS Status\n",
+						mmc_hostname(host), err);
+				goto out;
+			}
+
+			if (host->card->ext_csd.raw_bkops_status >=
+					EXT_CSD_BKOPS_LEVEL_2) {
+				/*
+				 * We don’t allow Runtime Suspend while device
+				 * still needs time to complete internal BKOPS
+				 */
+				err = -EBUSY;
+				goto out;
+			}
+		}
 		err = mmc_stop_bkops(host->card);
 		if (err)
 			goto out;
@@ -1987,7 +2006,7 @@ static int mmc_suspend(struct mmc_host *host)
 {
 	int err;
 
-	err = _mmc_suspend(host, true);
+	err = _mmc_suspend(host, true, false);
 	if (!err) {
 		pm_runtime_disable(&host->card->dev);
 		pm_runtime_set_suspended(&host->card->dev);
@@ -2034,7 +2053,7 @@ static int mmc_shutdown(struct mmc_host *host)
 		err = _mmc_resume(host);
 
 	if (!err)
-		err = _mmc_suspend(host, false);
+		err = _mmc_suspend(host, false, false);
 
 	return err;
 }
@@ -2058,7 +2077,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	err = _mmc_suspend(host, true);
+	err = _mmc_suspend(host, true, true);
 	if (err)
 		pr_err("%s: error %d doing aggressive suspend\n",
 			mmc_hostname(host), err);
-- 
1.9.1

