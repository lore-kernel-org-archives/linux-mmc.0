From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] mmc: core: Improve runtime PM support during suspend/resume for sd/mmc
Date: Fri, 11 Oct 2013 14:28:17 +0200
Message-ID: <1381494498-16699-4-git-send-email-ulf.hansson@linaro.org>
References: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:52365 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab3JKM2s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Oct 2013 08:28:48 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so3409214lab.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2013 05:28:47 -0700 (PDT)
In-Reply-To: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Colin Cross <ccross@android.com>, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

The card device is considered as in-active after it has been suspended.
To prevent any further runtime PM requests in suspend state, we then
disable runtime PM.

After the card device has been resumed, we shall consider it as active,
like we also do after a probe sequence. When resumed, we can safely
enable runtime PM again.

This will make sure the PM core can request the card device to go to
in-active state after a resume has been completed. Previously we had to
wait for new pm_runtime_get->pm_runtime_put cycle to be executed.

Additionally, once a resume has been carried out, update the last busy
mark. At the moment this will have no effect but if the PM core will
respect autosuspend enabled devices, when it directly triggers a
runtime_suspend from a runtime_idle, it will mean the card device will
be scheduled for a delayed runtime_suspend instead of done immediately.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c |   38 ++++++++++++++++++++++++++++++--------
 drivers/mmc/core/sd.c  |   45 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 907f0a0..1e29dbc 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -1509,20 +1510,26 @@ out:
 }
 
 /*
- * Suspend callback from host.
+ * Suspend callback
  */
 static int mmc_suspend(struct mmc_host *host)
 {
-	return _mmc_suspend(host, true);
+	int err;
+
+	err = _mmc_suspend(host, true);
+	if (!err) {
+		pm_runtime_disable(&host->card->dev);
+		pm_runtime_set_suspended(&host->card->dev);
+	}
+
+	return err;
 }
 
 /*
- * Resume callback from host.
- *
  * This function tries to determine if the same card is still present
  * and, if so, restore all state to it.
  */
-static int mmc_resume(struct mmc_host *host)
+static int _mmc_resume(struct mmc_host *host)
 {
 	int err = 0;
 
@@ -1557,7 +1564,7 @@ static int mmc_shutdown(struct mmc_host *host)
 	 */
 	if (mmc_can_poweroff_notify(host->card) &&
 		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
-		err = mmc_resume(host);
+		err = _mmc_resume(host);
 
 	if (!err)
 		err = _mmc_suspend(host, false);
@@ -1566,6 +1573,21 @@ static int mmc_shutdown(struct mmc_host *host)
 }
 
 /*
+ * Callback for resume.
+ */
+static int mmc_resume(struct mmc_host *host)
+{
+	int err;
+
+	err = _mmc_resume(host);
+	pm_runtime_set_active(&host->card->dev);
+	pm_runtime_mark_last_busy(&host->card->dev);
+	pm_runtime_enable(&host->card->dev);
+
+	return err;
+}
+
+/*
  * Callback for runtime_suspend.
  */
 static int mmc_runtime_suspend(struct mmc_host *host)
@@ -1575,7 +1597,7 @@ static int mmc_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	err = mmc_suspend(host);
+	err = _mmc_suspend(host, true);
 	if (err)
 		pr_err("%s: error %d doing aggessive suspend\n",
 			mmc_hostname(host), err);
@@ -1593,7 +1615,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	err = mmc_resume(host);
+	err = _mmc_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
 			mmc_hostname(host), err);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 2287ceb..57940a8 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -1064,10 +1065,7 @@ static void mmc_sd_detect(struct mmc_host *host)
 	}
 }
 
-/*
- * Suspend callback from host.
- */
-static int mmc_sd_suspend(struct mmc_host *host)
+static int _mmc_sd_suspend(struct mmc_host *host)
 {
 	int err = 0;
 
@@ -1093,12 +1091,26 @@ out:
 }
 
 /*
- * Resume callback from host.
- *
+ * Callback for suspend
+ */
+static int mmc_sd_suspend(struct mmc_host *host)
+{
+	int err;
+
+	err = _mmc_sd_suspend(host);
+	if (!err) {
+		pm_runtime_disable(&host->card->dev);
+		pm_runtime_set_suspended(&host->card->dev);
+	}
+
+	return err;
+}
+
+/*
  * This function tries to determine if the same card is still present
  * and, if so, restore all state to it.
  */
-static int mmc_sd_resume(struct mmc_host *host)
+static int _mmc_sd_resume(struct mmc_host *host)
 {
 	int err = 0;
 
@@ -1121,6 +1133,21 @@ out:
 }
 
 /*
+ * Callback for resume
+ */
+static int mmc_sd_resume(struct mmc_host *host)
+{
+	int err;
+
+	err = _mmc_sd_resume(host);
+	pm_runtime_set_active(&host->card->dev);
+	pm_runtime_mark_last_busy(&host->card->dev);
+	pm_runtime_enable(&host->card->dev);
+
+	return err;
+}
+
+/*
  * Callback for runtime_suspend.
  */
 static int mmc_sd_runtime_suspend(struct mmc_host *host)
@@ -1130,7 +1157,7 @@ static int mmc_sd_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	err = mmc_sd_suspend(host);
+	err = _mmc_sd_suspend(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive suspend\n",
 			mmc_hostname(host), err);
@@ -1148,7 +1175,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
-	err = mmc_sd_resume(host);
+	err = _mmc_sd_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
 			mmc_hostname(host), err);
-- 
1.7.9.5

