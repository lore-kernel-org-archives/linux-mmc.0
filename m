From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] mmc: Don't force card to active state when entering suspend/shutdown
Date: Fri, 11 Oct 2013 14:28:15 +0200
Message-ID: <1381494498-16699-2-git-send-email-ulf.hansson@linaro.org>
References: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:37484 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab3JKM2k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Oct 2013 08:28:40 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so3376129lab.30
        for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2013 05:28:39 -0700 (PDT)
In-Reply-To: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Colin Cross <ccross@android.com>, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

By adding a card state that records if it is suspended or resumed, we
can accept asyncronus suspend/resume requests for the mmc and sd
bus_ops.

MMC_CAP_AGGRESSIVE_PM, will at request inactivity through the runtime
bus_ops callbacks, execute a suspend of the the card. In the state were
this has been done, we can receive a suspend request for the mmc bus,
which for sd and mmc forced the card to active state by a
pm_runtime_get_sync. In other words, the card was resumed and then
immediately suspended again, completely unnecessary.

Since the suspend/resume bus_ops callbacks for sd and mmc are now
capable of handling asynchronous requests, we no longer need to force
the card to active state before executing suspend. Evidently preventing
the above sequence for MMC_CAP_AGGRESSIVE_PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c |    2 --
 drivers/mmc/core/mmc.c   |   45 ++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/core/sd.c    |   21 +++++++++++++++++----
 include/linux/mmc/card.h |    4 ++++
 4 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1a3163f..29d5d98 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2448,7 +2448,6 @@ static int _mmc_blk_suspend(struct mmc_card *card)
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
-		pm_runtime_get_sync(&card->dev);
 		mmc_queue_suspend(&md->queue);
 		list_for_each_entry(part_md, &md->part, part) {
 			mmc_queue_suspend(&part_md->queue);
@@ -2483,7 +2482,6 @@ static int mmc_blk_resume(struct mmc_card *card)
 		list_for_each_entry(part_md, &md->part, part) {
 			mmc_queue_resume(&part_md->queue);
 		}
-		pm_runtime_put(&card->dev);
 	}
 	return 0;
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6d02012..f7722d2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1477,6 +1477,9 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 
 	mmc_claim_host(host);
 
+	if (mmc_card_suspended(host->card))
+		goto out;
+
 	if (mmc_card_doing_bkops(host->card)) {
 		err = mmc_stop_bkops(host->card);
 		if (err)
@@ -1496,8 +1499,10 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		err = mmc_deselect_cards(host);
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 
-	if (!err)
+	if (!err) {
 		mmc_power_off(host);
+		mmc_card_set_suspended(host->card);
+	}
 out:
 	mmc_release_host(host);
 	return err;
@@ -1512,14 +1517,6 @@ static int mmc_suspend(struct mmc_host *host)
 }
 
 /*
- * Shutdown callback
- */
-static int mmc_shutdown(struct mmc_host *host)
-{
-	return _mmc_suspend(host, false);
-}
-
-/*
  * Resume callback from host.
  *
  * This function tries to determine if the same card is still present
@@ -1527,20 +1524,46 @@ static int mmc_shutdown(struct mmc_host *host)
  */
 static int mmc_resume(struct mmc_host *host)
 {
-	int err;
+	int err = 0;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
+
+	if (!mmc_card_suspended(host->card))
+		goto out;
+
 	mmc_power_up(host);
 	mmc_select_voltage(host, host->ocr);
 	err = mmc_init_card(host, host->ocr, host->card);
-	mmc_release_host(host);
+	mmc_card_clr_suspended(host->card);
 
+out:
+	mmc_release_host(host);
 	return err;
 }
 
+/*
+ * Shutdown callback
+ */
+static int mmc_shutdown(struct mmc_host *host)
+{
+	int err = 0;
+
+	/*
+	 * In a specific case for poweroff notify, we need to resume the card
+	 * before we can shutdown it properly.
+	 */
+	if (mmc_can_poweroff_notify(host->card) &&
+		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
+		err = mmc_resume(host);
+
+	if (!err)
+		err = _mmc_suspend(host, false);
+
+	return err;
+}
 
 /*
  * Callback for runtime_suspend.
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5e8823d..ef302f3 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1075,13 +1075,20 @@ static int mmc_sd_suspend(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
+
+	if (mmc_card_suspended(host->card))
+		goto out;
+
 	if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
 	host->card->state &= ~MMC_STATE_HIGHSPEED;
-	if (!err)
+	if (!err) {
 		mmc_power_off(host);
-	mmc_release_host(host);
+		mmc_card_set_suspended(host->card);
+	}
 
+out:
+	mmc_release_host(host);
 	return err;
 }
 
@@ -1093,17 +1100,23 @@ static int mmc_sd_suspend(struct mmc_host *host)
  */
 static int mmc_sd_resume(struct mmc_host *host)
 {
-	int err;
+	int err = 0;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
+
+	if (!mmc_card_suspended(host->card))
+		goto out;
+
 	mmc_power_up(host);
 	mmc_select_voltage(host, host->ocr);
 	err = mmc_sd_init_card(host, host->ocr, host->card);
-	mmc_release_host(host);
+	mmc_card_clr_suspended(host->card);
 
+out:
+	mmc_release_host(host);
 	return err;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f42cdbd..111a199 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -257,6 +257,7 @@ struct mmc_card {
 #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
 #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
 #define MMC_STATE_DOING_BKOPS	(1<<10)		/* card is doing BKOPS */
+#define MMC_STATE_SUSPENDED	(1<<11)		/* card is suspended */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -423,6 +424,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
+#define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -435,6 +437,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
 #define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
+#define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
+#define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
 
 /*
  * Quirk add/remove for MMC products.
-- 
1.7.9.5

