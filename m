From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: [PATCH V2] mmc: Kill block requests if card is removed
Date: Tue, 22 Nov 2011 16:26:58 +0530
Message-ID: <1321959418-26864-1-git-send-email-sthumma@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, per.lkml@gmail.com, adrian.hunter@intel.com
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Kill block requests when the host knows that the card is
removed from the slot and is sure that subsequent requests
are bound to fail. Do this silently so that the block
layer doesn't output unnecessary error messages.

This patch implements suggestion from Adrian Hunter,
http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3474

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

---
Changes in v2:
	- Changed the implementation with further comments from Adrian
	- Set the card removed flag in bus notifier callbacks
	- This patch is now dependent on patch from Per Forlin:
	http://thread.gmane.org/gmane.linux.kernel.mmc/11128/focus=11211
---
 drivers/mmc/card/block.c |   33 ++++++++++++++++++++++++++++-----
 drivers/mmc/card/queue.c |    5 +++++
 drivers/mmc/core/bus.c   |   32 +++++++++++++++++++++++++++++++-
 drivers/mmc/core/core.c  |    8 +++++++-
 include/linux/mmc/card.h |    3 +++
 5 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index edc379e..83956fa 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -648,8 +648,15 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	}
 
 	/* We couldn't get a response from the card.  Give up. */
-	if (err)
+	if (err) {
+		/*
+		 * If the card didn't respond to status command,
+		 * it is likely that card is gone. Flag it as removed,
+		 * mmc_detect_change() cleans the rest.
+		 */
+		mmc_card_set_removed(card);
 		return ERR_ABORT;
+	}
 
 	/* Flag ECC errors */
 	if ((status & R1_CARD_ECC_FAILED) ||
@@ -1168,6 +1175,9 @@ static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *card,
                                                   int disable_multi,
                                                   struct mmc_async_req *areq)
 {
+	struct mmc_blk_data *md = mmc_get_drvdata(card);
+	struct request *req = mqrq->req;
+	int ret;
        /*
         * Release host after failure in case the host is needed
         * by someone else. For instance, if the card is removed the
@@ -1175,11 +1185,24 @@ static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *card,
         */
        mmc_release_host(card->host);
        mmc_claim_host(card->host);
-
-       mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
-       return mmc_start_req(card->host, areq, NULL);
+	if (mmc_card_removed(card)) {
+		/*
+		 * End the pending async request without starting
+		 * it when card is removed.
+		 */
+		spin_lock_irq(&md->lock);
+		req->cmd_flags |= REQ_QUIET;
+		do {
+			ret = __blk_end_request(req,
+					-EIO, blk_rq_cur_bytes(req));
+		} while (ret);
+		spin_unlock_irq(&md->lock);
+		return NULL;
+	} else {
+		mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
+		return mmc_start_req(card->host, areq, NULL);
+	}
 }
-
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->data;
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index dcad59c..2517547 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -29,6 +29,8 @@
  */
 static int mmc_prep_request(struct request_queue *q, struct request *req)
 {
+	struct mmc_queue *mq = q->queuedata;
+
 	/*
 	 * We only like normal block requests and discards.
 	 */
@@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 		return BLKPREP_KILL;
 	}
 
+	if (mq && mmc_card_removed(mq->card))
+		return BLKPREP_KILL;
+
 	req->cmd_flags |= REQ_DONTPREP;
 
 	return BLKPREP_OK;
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 5639fdf..ca6e07a 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -102,6 +102,25 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return retval;
 }
 
+static int mmc_bus_notify(struct notifier_block *nb, unsigned long action,
+		void *data)
+{
+	struct mmc_card *card = mmc_dev_to_card((struct device *) data);
+
+	switch (action) {
+	case BUS_NOTIFY_DEL_DEVICE:
+		mmc_card_set_removed(card);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static struct notifier_block mmc_bus_nb = {
+	.notifier_call = mmc_bus_notify,
+};
+
 static int mmc_bus_probe(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
@@ -191,11 +210,22 @@ static struct bus_type mmc_bus_type = {
 
 int mmc_register_bus(void)
 {
-	return bus_register(&mmc_bus_type);
+	int ret;
+
+	ret = bus_register(&mmc_bus_type);
+	if (ret)
+		goto out;
+
+	ret = bus_register_notifier(&mmc_bus_type, &mmc_bus_nb);
+	if (ret)
+		bus_unregister(&mmc_bus_type);
+out:
+	return ret;
 }
 
 void mmc_unregister_bus(void)
 {
+	bus_unregister_notifier(&mmc_bus_type, &mmc_bus_nb);
 	bus_unregister(&mmc_bus_type);
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 271efea..a2ce729 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -259,7 +259,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		wait_for_completion(&mrq->completion);
 
 		cmd = mrq->cmd;
-		if (!cmd->error || !cmd->retries)
+		if (!cmd->error || !cmd->retries ||
+				mmc_card_removed(host->card))
 			break;
 
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
@@ -374,6 +375,11 @@ EXPORT_SYMBOL(mmc_start_req);
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	if (mmc_card_removed(host->card)) {
+		mrq->cmd->error = -ENOMEDIUM;
+		return;
+	}
+
 	__mmc_start_req(host, mrq);
 	mmc_wait_for_req_done(host, mrq);
 }
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 534974c..9319329 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -209,6 +209,7 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
+#define MMC_STATE_CARD_REMOVED	(1<<7)		/* card removed from the slot */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -363,6 +364,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
+#define mmc_card_removed(c)	(c && ((c)->state & MMC_STATE_CARD_REMOVED))
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
@@ -372,6 +374,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
+#define mmc_card_set_removed(c) (c ? (c)->state |= MMC_STATE_CARD_REMOVED : 0)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
