From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: core: Remove unnecessary validations for bus_ops callbacks
Date: Mon, 16 Dec 2013 13:31:48 +0100
Message-ID: <1387197108-24040-2-git-send-email-ulf.hansson@linaro.org>
References: <1387197108-24040-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:40490 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab3LPMb6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 07:31:58 -0500
Received: by mail-bk0-f48.google.com with SMTP id r7so2281947bkg.21
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2013 04:31:57 -0800 (PST)
In-Reply-To: <1387197108-24040-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Due to the removal of the Kconfig option MMC_UNSAFE_RESUME, several
validations of a present bus_ops callback became redundant. Let's
remove these.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c  |   12 ++----------
 drivers/mmc/core/core.c |   13 +++++--------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 64145a3..8246448 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -185,24 +185,16 @@ static int mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_host *host = card->host;
-	int ret = 0;
 
-	if (host->bus_ops->runtime_suspend)
-		ret = host->bus_ops->runtime_suspend(host);
-
-	return ret;
+	return host->bus_ops->runtime_suspend(host);
 }
 
 static int mmc_runtime_resume(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_host *host = card->host;
-	int ret = 0;
 
-	if (host->bus_ops->runtime_resume)
-		ret = host->bus_ops->runtime_resume(host);
-
-	return ret;
+	return host->bus_ops->runtime_resume(host);
 }
 
 static int mmc_runtime_idle(struct device *dev)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 10856ec..22427c6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2231,9 +2231,6 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 {
 	struct mmc_card *card = host->card;
 
-	if (!host->bus_ops->power_restore)
-		return -EOPNOTSUPP;
-
 	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
 		return -EOPNOTSUPP;
 
@@ -2335,7 +2332,7 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 {
 	int ret;
 
-	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
+	if (host->caps & MMC_CAP_NONREMOVABLE)
 		return 0;
 
 	if (!host->card || mmc_card_removed(host->card))
@@ -2418,7 +2415,7 @@ void mmc_rescan(struct work_struct *work)
 	 * if there is a _removable_ card registered, check whether it is
 	 * still present
 	 */
-	if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
+	if (host->bus_ops && !host->bus_dead
 	    && !(host->caps & MMC_CAP_NONREMOVABLE))
 		host->bus_ops->detect(host);
 
@@ -2520,7 +2517,7 @@ int mmc_power_save_host(struct mmc_host *host)
 
 	mmc_bus_get(host);
 
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->power_restore) {
+	if (!host->bus_ops || host->bus_dead) {
 		mmc_bus_put(host);
 		return -EINVAL;
 	}
@@ -2546,7 +2543,7 @@ int mmc_power_restore_host(struct mmc_host *host)
 
 	mmc_bus_get(host);
 
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->power_restore) {
+	if (!host->bus_ops || host->bus_dead) {
 		mmc_bus_put(host);
 		return -EINVAL;
 	}
@@ -2651,7 +2648,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 		/* Validate prerequisites for suspend */
 		if (host->bus_ops->pre_suspend)
 			err = host->bus_ops->pre_suspend(host);
-		if (!err && host->bus_ops->suspend)
+		if (!err)
 			break;
 
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
-- 
1.7.9.5

