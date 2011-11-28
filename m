From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3] mmc: allow upper layers to determine immediately if a card has been removed
Date: Mon, 28 Nov 2011 15:02:15 +0200
Message-ID: <1322485335-17922-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: Chris Ball <cjb@laptop.org>, per.lkml@gmail.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Add a function mmc_detect_card_removed() which upper layers
can use to determine immediately if a card has been removed.
This function should be called after an I/O request fails so
that all queued I/O requests can be errored out immediately
instead of waiting for the card device to be removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  |   51 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/core.h  |    3 ++
 drivers/mmc/core/mmc.c   |   12 ++++++++++-
 drivers/mmc/core/sd.c    |   12 ++++++++++-
 drivers/mmc/core/sdio.c  |   11 +++++++++-
 include/linux/mmc/card.h |    3 ++
 include/linux/mmc/core.h |    2 +
 include/linux/mmc/host.h |    1 +
 8 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 271efea..3dacc98 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -140,7 +140,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 			cmd->retries = 0;
 	}
 
-	if (err && cmd->retries) {
+	if (err && cmd->retries && !mmc_card_removed(host->card)) {
 		/*
 		 * Request starter must handle retries - see
 		 * mmc_wait_for_req_done().
@@ -247,6 +247,11 @@ static void __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	init_completion(&mrq->completion);
 	mrq->done = mmc_wait_done;
+	if (mmc_card_removed(host->card)) {
+		mrq->cmd->error = -ENOMEDIUM;
+		complete(&mrq->completion);
+		return;
+	}
 	mmc_start_request(host, mrq);
 }
 
@@ -259,7 +264,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		wait_for_completion(&mrq->completion);
 
 		cmd = mrq->cmd;
-		if (!cmd->error || !cmd->retries)
+		if (!cmd->error || !cmd->retries ||
+		    mmc_card_removed(host->card))
 			break;
 
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
@@ -1456,7 +1462,7 @@ void mmc_detect_change(struct mmc_host *host, unsigned long delay)
 	WARN_ON(host->removed);
 	spin_unlock_irqrestore(&host->lock, flags);
 #endif
-
+	host->detect_change = 1;
 	mmc_schedule_delayed_work(&host->detect, delay);
 }
 
@@ -2049,6 +2055,43 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	return -EIO;
 }
 
+int _mmc_detect_card_removed(struct mmc_host *host)
+{
+	int ret;
+
+	if (!(host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
+		return 0;
+
+	if (!host->card || mmc_card_removed(host->card))
+		return 1;
+
+	ret = host->bus_ops->alive(host);
+	if (ret) {
+		mmc_card_set_removed(host->card);
+		pr_info("%s: card removed\n", mmc_hostname(host));
+	}
+
+	return ret;
+}
+
+int mmc_detect_card_removed(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+
+	WARN_ON(!host->claimed);
+	/*
+	 * The card will be considered unchanged unless we have been asked to
+	 * detect a change or host requires polling to provide card detection.
+	 */
+	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
+		return mmc_card_removed(card);
+
+	host->detect_change = 0;
+
+	return _mmc_detect_card_removed(host);
+}
+EXPORT_SYMBOL(mmc_detect_card_removed);
+
 void mmc_rescan(struct work_struct *work)
 {
 	static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
@@ -2069,6 +2112,8 @@ void mmc_rescan(struct work_struct *work)
 	    && !(host->caps & MMC_CAP_NONREMOVABLE))
 		host->bus_ops->detect(host);
 
+	host->detect_change = 0;
+
 	/*
 	 * Let mmc_bus_put() free the bus/bus_ops if we've found that
 	 * the card is no longer present.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 14664f1..3400924 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -24,6 +24,7 @@ struct mmc_bus_ops {
 	int (*resume)(struct mmc_host *);
 	int (*power_save)(struct mmc_host *);
 	int (*power_restore)(struct mmc_host *);
+	int (*alive)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
@@ -59,6 +60,8 @@ void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
 
+int _mmc_detect_card_removed(struct mmc_host *host);
+
 int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a1223bd..e8b6b5d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1104,6 +1104,14 @@ static void mmc_remove(struct mmc_host *host)
 }
 
 /*
+ * Card detection - card is alive.
+ */
+static int mmc_alive(struct mmc_host *host)
+{
+	return mmc_send_status(host->card, NULL);
+}
+
+/*
  * Card detection callback from host.
  */
 static void mmc_detect(struct mmc_host *host)
@@ -1118,7 +1126,7 @@ static void mmc_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	err = _mmc_detect_card_removed(host);
 
 	mmc_release_host(host);
 
@@ -1223,6 +1231,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.suspend = NULL,
 	.resume = NULL,
 	.power_restore = mmc_power_restore,
+	.alive = mmc_alive,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -1233,6 +1242,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
 	.power_restore = mmc_power_restore,
+	.alive = mmc_alive,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1d5a3bd..bfdf708 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1018,6 +1018,14 @@ static void mmc_sd_remove(struct mmc_host *host)
 }
 
 /*
+ * Card detection - card is alive.
+ */
+static int mmc_sd_alive(struct mmc_host *host)
+{
+	return mmc_send_status(host->card, NULL);
+}
+
+/*
  * Card detection callback from host.
  */
 static void mmc_sd_detect(struct mmc_host *host)
@@ -1032,7 +1040,7 @@ static void mmc_sd_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	err = _mmc_detect_card_removed(host);
 
 	mmc_release_host(host);
 
@@ -1101,6 +1109,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.suspend = NULL,
 	.resume = NULL,
 	.power_restore = mmc_sd_power_restore,
+	.alive = mmc_sd_alive,
 };
 
 static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
@@ -1109,6 +1118,7 @@ static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
 	.power_restore = mmc_sd_power_restore,
+	.alive = mmc_sd_alive,
 };
 
 static void mmc_sd_attach_bus_ops(struct mmc_host *host)
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8c04f7f..b77f770 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -820,6 +820,14 @@ static void mmc_sdio_remove(struct mmc_host *host)
 }
 
 /*
+ * Card detection - card is alive.
+ */
+static int mmc_sdio_alive(struct mmc_host *host)
+{
+	return mmc_select_card(host->card);
+}
+
+/*
  * Card detection callback from host.
  */
 static void mmc_sdio_detect(struct mmc_host *host)
@@ -841,7 +849,7 @@ static void mmc_sdio_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_select_card(host->card);
+	err = _mmc_detect_card_removed(host);
 
 	mmc_release_host(host);
 
@@ -1019,6 +1027,7 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
 	.suspend = mmc_sdio_suspend,
 	.resume = mmc_sdio_resume,
 	.power_restore = mmc_sdio_power_restore,
+	.alive = mmc_sdio_alive,
 };
 
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 534974c..6402d92 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -209,6 +209,7 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
+#define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -370,6 +371,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_uhs(c)		((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_sd_card_uhs(c)	((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
+#define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -379,6 +381,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
+#define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 
 /*
  * Quirk add/remove for MMC products.
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 174a844..87a976c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -180,6 +180,8 @@ extern int mmc_try_claim_host(struct mmc_host *host);
 
 extern int mmc_flush_cache(struct mmc_card *);
 
+extern int mmc_detect_card_removed(struct mmc_host *host);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 706f722..9a03d03 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -299,6 +299,7 @@ struct mmc_host {
 	int			claim_cnt;	/* "claim" nesting count */
 
 	struct delayed_work	detect;
+	int			detect_change;	/* card detect flag */
 
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
 	unsigned int		bus_refs;	/* reference counter */
-- 
1.7.6.4
