From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: core: Do not pre-claim host in suspend
Date: Thu, 19 Apr 2012 11:55:25 +0200
Message-ID: <1334829325-3464-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:37383 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753058Ab2DSJzv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Apr 2012 05:55:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Daniel Drake <dsd@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Since SDIO drivers may want to do some SDIO operations
in their suspend callback functions, we must not keep
the host claimed when calling them.

Daniel Drake reported that libertas_sdio encountered
a deadlock in it's suspend function.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/core/core.c |   55 +++++++++++++++++-----------------------------
 1 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e541efb..ba821fe 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2238,6 +2238,7 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
 			mmc_card_is_removable(host))
 		return err;
 
+	mmc_claim_host(host);
 	if (card && mmc_card_mmc(card) &&
 			(card->ext_csd.cache_size > 0)) {
 		enable = !!enable;
@@ -2255,6 +2256,7 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
 				card->ext_csd.cache_ctrl = enable;
 		}
 	}
+	mmc_release_host(host);
 
 	return err;
 }
@@ -2272,49 +2274,32 @@ int mmc_suspend_host(struct mmc_host *host)
 
 	cancel_delayed_work(&host->detect);
 	mmc_flush_scheduled_work();
-	if (mmc_try_claim_host(host)) {
-		err = mmc_cache_ctrl(host, 0);
-		mmc_release_host(host);
-	} else {
-		err = -EBUSY;
-	}
 
+	err = mmc_cache_ctrl(host, 0);
 	if (err)
 		goto out;
 
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
 
-		/*
-		 * A long response time is not acceptable for device drivers
-		 * when doing suspend. Prevent mmc_claim_host in the suspend
-		 * sequence, to potentially wait "forever" by trying to
-		 * pre-claim the host.
-		 */
-		if (mmc_try_claim_host(host)) {
-			if (host->bus_ops->suspend) {
-				err = host->bus_ops->suspend(host);
-			}
-			mmc_release_host(host);
+		if (host->bus_ops->suspend)
+			err = host->bus_ops->suspend(host);
 
-			if (err == -ENOSYS || !host->bus_ops->resume) {
-				/*
-				 * We simply "remove" the card in this case.
-				 * It will be redetected on resume.  (Calling
-				 * bus_ops->remove() with a claimed host can
-				 * deadlock.)
-				 */
-				if (host->bus_ops->remove)
-					host->bus_ops->remove(host);
-				mmc_claim_host(host);
-				mmc_detach_bus(host);
-				mmc_power_off(host);
-				mmc_release_host(host);
-				host->pm_flags = 0;
-				err = 0;
-			}
-		} else {
-			err = -EBUSY;
+		if (err == -ENOSYS || !host->bus_ops->resume) {
+			/*
+			 * We simply "remove" the card in this case.
+			 * It will be redetected on resume.  (Calling
+			 * bus_ops->remove() with a claimed host can
+			 * deadlock.)
+			 */
+			if (host->bus_ops->remove)
+				host->bus_ops->remove(host);
+			mmc_claim_host(host);
+			mmc_detach_bus(host);
+			mmc_power_off(host);
+			mmc_release_host(host);
+			host->pm_flags = 0;
+			err = 0;
 		}
 	}
 	mmc_bus_put(host);
-- 
1.7.9

