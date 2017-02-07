From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [v3 3/3] mmc: Checking BKOPS status prior to Suspend
Date: Tue, 7 Feb 2017 18:00:02 +0200
Message-ID: <1486483202-5515-4-git-send-email-uri.yanai@sandisk.com>
References: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27744 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753829AbdBGQBw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 11:01:52 -0500
In-Reply-To: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Alex.Lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>, Alex Lemberg <alex.lemberg@sandisk.com>

In case of Runtime Suspend, check the device BKOPS level.
Return –EBUSY if device need more time to complete its internal BKOPS.

Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
---

Changes in v3:
- start with checking if *auto* BKOPS is enabled

Changes in v2:
- return –EBUSY instead of delaying suspend
- remove define EXT_CSD_BKOPS_LEVEL_1

---
 drivers/mmc/core/mmc.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f70f6a1..4888609 100644
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
@@ -1953,7 +1954,26 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (mmc_card_suspended(host->card))
 		goto out;
 
-	if (mmc_card_doing_bkops(host->card)) {
+	if (mmc_card_doing_bkops(host->card) ||
+			host->card->ext_csd.auto_bkops_en) {
+		if (is_runtime_pm) {
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
+				 * Device still needs time to complete
+				 * internal BKOPS
+				 */
+				err = -EBUSY;
+				goto out;
+			}
+		}
 		err = mmc_stop_bkops(host->card);
 		if (err)
 			goto out;
@@ -1987,7 +2007,7 @@ static int mmc_suspend(struct mmc_host *host)
 {
 	int err;
 
-	err = _mmc_suspend(host, true);
+	err = _mmc_suspend(host, true, false);
 	if (!err) {
 		pm_runtime_disable(&host->card->dev);
 		pm_runtime_set_suspended(&host->card->dev);
@@ -2034,7 +2054,7 @@ static int mmc_shutdown(struct mmc_host *host)
 		err = _mmc_resume(host);
 
 	if (!err)
-		err = _mmc_suspend(host, false);
+		err = _mmc_suspend(host, false, false);
 
 	return err;
 }
@@ -2058,7 +2078,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	err = _mmc_suspend(host, true);
+	err = _mmc_suspend(host, true, true);
 	if (err)
 		pr_err("%s: error %d doing aggressive suspend\n",
 			mmc_hostname(host), err);
-- 
1.9.1

