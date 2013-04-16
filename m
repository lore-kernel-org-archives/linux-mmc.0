From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V3 1/4] mmc: core: Stop bkops for eMMC only from mmc suspend
Date: Tue, 16 Apr 2013 12:00:34 +0200
Message-ID: <1366106437-18004-2-git-send-email-ulf.hansson@stericsson.com>
References: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:57160 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935469Ab3DPKBZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Apr 2013 06:01:25 -0400
In-Reply-To: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

From: Ulf Hansson <ulf.hansson@linaro.org>

Move mmc suspend specific operations to be executed from the .suspend
callback in the mmc bus_ops. This simplifies the mmc_suspend_host
function which is supposed to handle nothing but common suspend tasks.

Since eMMC can be considered non-removable there are no need to check
for ongoing bkops at PM_SUSPEND_PREPARE notification so remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maya Erez <merez@codeaurora.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Liu <kliu5@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/core.c |   22 +---------------------
 drivers/mmc/core/mmc.c  |    6 ++++++
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ad7decc..f001097 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2631,14 +2631,8 @@ int mmc_suspend_host(struct mmc_host *host)
 
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
-		if (host->bus_ops->suspend) {
-			if (mmc_card_doing_bkops(host->card)) {
-				err = mmc_stop_bkops(host->card);
-				if (err)
-					goto out;
-			}
+		if (host->bus_ops->suspend)
 			err = host->bus_ops->suspend(host);
-		}
 
 		if (err == -ENOSYS || !host->bus_ops->resume) {
 			/*
@@ -2662,10 +2656,8 @@ int mmc_suspend_host(struct mmc_host *host)
 	if (!err && !mmc_card_keep_power(host))
 		mmc_power_off(host);
 
-out:
 	return err;
 }
-
 EXPORT_SYMBOL(mmc_suspend_host);
 
 /**
@@ -2720,22 +2712,10 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 	struct mmc_host *host = container_of(
 		notify_block, struct mmc_host, pm_notify);
 	unsigned long flags;
-	int err = 0;
 
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
-		if (host->card && mmc_card_mmc(host->card) &&
-		    mmc_card_doing_bkops(host->card)) {
-			err = mmc_stop_bkops(host->card);
-			if (err) {
-				pr_err("%s: didn't stop bkops\n",
-					mmc_hostname(host));
-				return err;
-			}
-			mmc_card_clr_doing_bkops(host->card);
-		}
-
 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 1;
 		spin_unlock_irqrestore(&host->lock, flags);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d584f7c..66a530e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1411,6 +1411,12 @@ static int mmc_suspend(struct mmc_host *host)
 
 	mmc_claim_host(host);
 
+	if (mmc_card_doing_bkops(host->card)) {
+		err = mmc_stop_bkops(host->card);
+		if (err)
+			goto out;
+	}
+
 	err = mmc_cache_ctrl(host, 0);
 	if (err)
 		goto out;
-- 
1.7.10

