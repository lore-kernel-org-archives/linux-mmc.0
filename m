From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: core: Make runtime resume default behavior for MMC/SD
Date: Thu,  5 Nov 2015 16:01:32 +0100
Message-ID: <1446735693-11542-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, addy ke <addy.ke@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-pm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>
List-Id: linux-mmc@vger.kernel.org

MMC_CAP_RUNTIME_RESUME was invented to decrease system PM resume time for
systems that particularly needs this. As the feature has matured let's
make it the default behavior for MMC/SD.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 15 ++-------------
 drivers/mmc/core/sd.c  | 15 ++-------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c793fda..392fa8c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1862,16 +1862,8 @@ static int mmc_shutdown(struct mmc_host *host)
  */
 static int mmc_resume(struct mmc_host *host)
 {
-	int err = 0;
-
-	if (!(host->caps & MMC_CAP_RUNTIME_RESUME)) {
-		err = _mmc_resume(host);
-		pm_runtime_set_active(&host->card->dev);
-		pm_runtime_mark_last_busy(&host->card->dev);
-	}
 	pm_runtime_enable(&host->card->dev);
-
-	return err;
+	return 0;
 }
 
 /*
@@ -1899,12 +1891,9 @@ static int mmc_runtime_resume(struct mmc_host *host)
 {
 	int err;
 
-	if (!(host->caps & (MMC_CAP_AGGRESSIVE_PM | MMC_CAP_RUNTIME_RESUME)))
-		return 0;
-
 	err = _mmc_resume(host);
 	if (err)
-		pr_err("%s: error %d doing aggressive resume\n",
+		pr_err("%s: error %d doing runtime resume\n",
 			mmc_hostname(host), err);
 
 	return 0;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 141eaa9..8f3b46a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1128,16 +1128,8 @@ out:
  */
 static int mmc_sd_resume(struct mmc_host *host)
 {
-	int err = 0;
-
-	if (!(host->caps & MMC_CAP_RUNTIME_RESUME)) {
-		err = _mmc_sd_resume(host);
-		pm_runtime_set_active(&host->card->dev);
-		pm_runtime_mark_last_busy(&host->card->dev);
-	}
 	pm_runtime_enable(&host->card->dev);
-
-	return err;
+	return 0;
 }
 
 /*
@@ -1165,12 +1157,9 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 {
 	int err;
 
-	if (!(host->caps & (MMC_CAP_AGGRESSIVE_PM | MMC_CAP_RUNTIME_RESUME)))
-		return 0;
-
 	err = _mmc_sd_resume(host);
 	if (err)
-		pr_err("%s: error %d doing aggressive resume\n",
+		pr_err("%s: error %d doing runtime resume\n",
 			mmc_hostname(host), err);
 
 	return 0;
-- 
1.9.1

