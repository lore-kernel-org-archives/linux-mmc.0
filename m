From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: core: Force a "detect" to handle non-properly removed cards
Date: Tue, 3 Jan 2012 11:33:18 +0100
Message-ID: <1325586798-16276-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:50564 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751477Ab2ACKeR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2012 05:34:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Removing a card "slowly" can trigger a GPIO irq to be raised far
before the card is actually removed. This means the scheduled
detect work will not find out that the card were removed and thus
the card and the block device will not be unregistered.

Let the mmc_detect_card_removed function trigger a new detect
work immediately when it discovers that a card has been removed.
This will solve the described issue above. Moreover we make sure
the detect work is executed as soon as possible, since there is
no reason for waiting for a "delayed" detect to happen.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/core/core.c  |   24 +++++++++++++-----------
 include/linux/mmc/host.h |    1 -
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4770807..7bc02f4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1462,7 +1462,6 @@ void mmc_detect_change(struct mmc_host *host, unsigned long delay)
 	WARN_ON(host->removed);
 	spin_unlock_irqrestore(&host->lock, flags);
 #endif
-	host->detect_change = 1;
 	mmc_schedule_delayed_work(&host->detect, delay);
 }
 
@@ -2077,18 +2076,23 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 int mmc_detect_card_removed(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
+	int ret = 1;
 
 	WARN_ON(!host->claimed);
-	/*
-	 * The card will be considered unchanged unless we have been asked to
-	 * detect a change or host requires polling to provide card detection.
-	 */
-	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
-		return mmc_card_removed(card);
 
-	host->detect_change = 0;
+	if (card && !mmc_card_removed(card)) {
+		if (_mmc_detect_card_removed(host)) {
+			/*
+			 * Make sure a detect work is always executed and also
+			 * do it as soon as possible.
+			 */
+			cancel_delayed_work(&host->detect);
+			mmc_detect_change(host, 0);
+		}
+		ret = mmc_card_removed(card);
+	}
 
-	return _mmc_detect_card_removed(host);
+	return ret;
 }
 EXPORT_SYMBOL(mmc_detect_card_removed);
 
@@ -2112,8 +2116,6 @@ void mmc_rescan(struct work_struct *work)
 	    && !(host->caps & MMC_CAP_NONREMOVABLE))
 		host->bus_ops->detect(host);
 
-	host->detect_change = 0;
-
 	/*
 	 * Let mmc_bus_put() free the bus/bus_ops if we've found that
 	 * the card is no longer present.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 031d865..09fa5e6 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -305,7 +305,6 @@ struct mmc_host {
 	int			claim_cnt;	/* "claim" nesting count */
 
 	struct delayed_work	detect;
-	int			detect_change;	/* card detect flag */
 	struct mmc_hotplug	hotplug;
 
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
-- 
1.7.5.4

