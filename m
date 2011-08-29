From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 5/5] mmc: block: add eMMC hardware reset support
Date: Mon, 29 Aug 2011 16:42:15 +0300
Message-ID: <1314625335-11638-6-git-send-email-adrian.hunter@intel.com>
References: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63266 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab1H2Nma (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Aug 2011 09:42:30 -0400
In-Reply-To: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

For cards that support hardware reset (just eMMC), try a reset and
retry before returning an I/O error.  However this is not done for
ECC errors and is never done twice for the same operation type
(READ, WRITE, DISCARD, SECURE DISCARD) until that type of operation
again succeeds.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c |  201 ++++++++++++++++++++++++++++++++--------------
 drivers/mmc/core/core.c  |    4 +-
 2 files changed, 144 insertions(+), 61 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e702c61..2a05b24 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -94,6 +94,11 @@ struct mmc_blk_data {
 	unsigned int	read_only;
 	unsigned int	part_type;
 	unsigned int	name_idx;
+	unsigned int	reset_done;
+#define MMC_BLK_READ		BIT(0)
+#define MMC_BLK_WRITE		BIT(1)
+#define MMC_BLK_DISCARD		BIT(2)
+#define MMC_BLK_SECDISCARD	BIT(3)
 
 	/*
 	 * Only set in main mmc_blk_data associated
@@ -109,11 +114,11 @@ static DEFINE_MUTEX(open_lock);
 enum mmc_blk_status {
 	MMC_BLK_SUCCESS = 0,
 	MMC_BLK_PARTIAL,
-	MMC_BLK_RETRY,
-	MMC_BLK_RETRY_SINGLE,
-	MMC_BLK_DATA_ERR,
 	MMC_BLK_CMD_ERR,
+	MMC_BLK_RETRY,
 	MMC_BLK_ABORT,
+	MMC_BLK_DATA_ERR,
+	MMC_BLK_ECC_ERR,
 };
 
 module_param(perdev_minors, int, 0444);
@@ -454,7 +459,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 				 card->ext_csd.part_time);
 		if (ret)
 			return ret;
-}
+	}
 
 	main_md->part_curr = md->part_type;
 	return 0;
@@ -616,7 +621,7 @@ static int mmc_blk_cmd_error(struct request *req, const char *name, int error,
  * Otherwise we don't understand what happened, so abort.
  */
 static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
-	struct mmc_blk_request *brq)
+	struct mmc_blk_request *brq, int *ecc_err)
 {
 	bool prev_cmd_status_valid = true;
 	u32 status, stop_status = 0;
@@ -641,6 +646,12 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	if (err)
 		return ERR_ABORT;
 
+	/* Flag ECC errors */
+	if ((status & R1_CARD_ECC_FAILED) ||
+	    (brq->stop.resp[0] & R1_CARD_ECC_FAILED) ||
+	    (brq->cmd.resp[0] & R1_CARD_ECC_FAILED))
+		*ecc_err = 1;
+
 	/*
 	 * Check the current card state.  If it is in some data transfer
 	 * mode, tell it to stop (and hopefully transition back to TRAN.)
@@ -658,6 +669,8 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 		 */
 		if (err)
 			return ERR_ABORT;
+		if (stop_status & R1_CARD_ECC_FAILED)
+			*ecc_err = 1;
 	}
 
 	/* Check for set block count errors */
@@ -670,6 +683,10 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 		return mmc_blk_cmd_error(req, "r/w cmd", brq->cmd.error,
 				prev_cmd_status_valid, status);
 
+	/* Data errors */
+	if (!brq->stop.error)
+		return ERR_CONTINUE;
+
 	/* Now for stop errors.  These aren't fatal to the transfer. */
 	pr_err("%s: error %d sending stop command, original cmd response %#x, card status %#x\n",
 	       req->rq_disk->disk_name, brq->stop.error,
@@ -686,12 +703,45 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	return ERR_CONTINUE;
 }
 
+static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
+			 int type)
+{
+	int err;
+
+	if (md->reset_done & type)
+		return -EEXIST;
+
+	md->reset_done |= type;
+	err = mmc_hw_reset(host);
+	/* Ensure we switch back to the correct partition */
+	if (err != -EOPNOTSUPP) {
+		struct mmc_blk_data *main_md = mmc_get_drvdata(host->card);
+		int part_err;
+
+		main_md->part_curr = main_md->part_type;
+		part_err = mmc_blk_part_switch(host->card, md);
+		if (part_err) {
+			/*
+			 * We have failed to get back into the correct
+			 * partition, so we need to abort the whole request.
+			 */
+			return -ENODEV;
+		}
+	}
+	return err;
+}
+
+static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
+{
+	md->reset_done &= ~type;
+}
+
 static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	unsigned int from, nr, arg;
-	int err = 0;
+	int err = 0, type = MMC_BLK_DISCARD;
 
 	if (!mmc_can_erase(card)) {
 		err = -EOPNOTSUPP;
@@ -705,7 +755,7 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 		arg = MMC_TRIM_ARG;
 	else
 		arg = MMC_ERASE_ARG;
-
+retry:
 	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 INAND_CMD38_ARG_EXT_CSD,
@@ -718,6 +768,10 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	}
 	err = mmc_erase(card, from, nr, arg);
 out:
+	if (err == -EIO && !mmc_blk_reset(md, card->host, type))
+		goto retry;
+	if (!err)
+		mmc_blk_reset_success(md, type);
 	spin_lock_irq(&md->lock);
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
@@ -731,7 +785,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	unsigned int from, nr, arg;
-	int err = 0;
+	int err = 0, type = MMC_BLK_SECDISCARD;
 
 	if (!mmc_can_secure_erase_trim(card)) {
 		err = -EOPNOTSUPP;
@@ -745,7 +799,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 		arg = MMC_SECURE_TRIM1_ARG;
 	else
 		arg = MMC_SECURE_ERASE_ARG;
-
+retry:
 	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 INAND_CMD38_ARG_EXT_CSD,
@@ -769,6 +823,10 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 		err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
 	}
 out:
+	if (err == -EIO && !mmc_blk_reset(md, card->host, type))
+		goto retry;
+	if (!err)
+		mmc_blk_reset_success(md, type);
 	spin_lock_irq(&md->lock);
 	__blk_end_request(req, err, blk_rq_bytes(req));
 	spin_unlock_irq(&md->lock);
@@ -825,11 +883,11 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 static int mmc_blk_err_check(struct mmc_card *card,
 			     struct mmc_async_req *areq)
 {
-	enum mmc_blk_status ret = MMC_BLK_SUCCESS;
 	struct mmc_queue_req *mq_mrq = container_of(areq, struct mmc_queue_req,
 						    mmc_active);
 	struct mmc_blk_request *brq = &mq_mrq->brq;
 	struct request *req = mq_mrq->req;
+	int ecc_err = 0;
 
 	/*
 	 * sbc.error indicates a problem with the set block count
@@ -841,8 +899,9 @@ static int mmc_blk_err_check(struct mmc_card *card,
 	 * stop.error indicates a problem with the stop command.  Data
 	 * may have been transferred, or may still be transferring.
 	 */
-	if (brq->sbc.error || brq->cmd.error || brq->stop.error) {
-		switch (mmc_blk_cmd_recovery(card, req, brq)) {
+	if (brq->sbc.error || brq->cmd.error || brq->stop.error ||
+	    brq->data.error) {
+		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err)) {
 		case ERR_RETRY:
 			return MMC_BLK_RETRY;
 		case ERR_ABORT:
@@ -894,23 +953,21 @@ static int mmc_blk_err_check(struct mmc_card *card,
 		       brq->cmd.resp[0], brq->stop.resp[0]);
 
 		if (rq_data_dir(req) == READ) {
-			if (brq->data.blocks > 1) {
-				/* Redo read one sector at a time */
-				pr_warning("%s: retrying using single block read\n",
-					   req->rq_disk->disk_name);
-				return MMC_BLK_RETRY_SINGLE;
-			}
+			if (ecc_err)
+				return MMC_BLK_ECC_ERR;
 			return MMC_BLK_DATA_ERR;
 		} else {
 			return MMC_BLK_CMD_ERR;
 		}
 	}
 
-	if (ret == MMC_BLK_SUCCESS &&
-	    blk_rq_bytes(req) != brq->data.bytes_xfered)
-		ret = MMC_BLK_PARTIAL;
+	if (!brq->data.bytes_xfered)
+		return MMC_BLK_RETRY;
 
-	return ret;
+	if (blk_rq_bytes(req) != brq->data.bytes_xfered)
+		return MMC_BLK_PARTIAL;
+
+	return MMC_BLK_SUCCESS;
 }
 
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
@@ -1046,12 +1103,41 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	mmc_queue_bounce_pre(mqrq);
 }
 
+static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
+			   struct mmc_blk_request *brq, struct request *req,
+			   int ret)
+{
+	/*
+	 * If this is an SD card and we're writing, we can first
+	 * mark the known good sectors as ok.
+	 *
+	 * If the card is not SD, we can still ok written sectors
+	 * as reported by the controller (which might be less than
+	 * the real number of written sectors, but never more).
+	 */
+	if (mmc_card_sd(card)) {
+		u32 blocks;
+
+		blocks = mmc_sd_num_wr_blocks(card);
+		if (blocks != (u32)-1) {
+			spin_lock_irq(&md->lock);
+			ret = __blk_end_request(req, 0, blocks << 9);
+			spin_unlock_irq(&md->lock);
+		}
+	} else {
+		spin_lock_irq(&md->lock);
+		ret = __blk_end_request(req, 0, brq->data.bytes_xfered);
+		spin_unlock_irq(&md->lock);
+	}
+	return ret;
+}
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
-	int ret = 1, disable_multi = 0, retry = 0;
+	int ret = 1, disable_multi = 0, retry = 0, type;
 	enum mmc_blk_status status;
 	struct mmc_queue_req *mq_rq;
 	struct request *req;
@@ -1073,6 +1159,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
 		req = mq_rq->req;
+		type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 		mmc_queue_bounce_post(mq_rq);
 
 		switch (status) {
@@ -1081,17 +1168,17 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			/*
 			 * A block was successfully transferred.
 			 */
+			mmc_blk_reset_success(md, type);
 			spin_lock_irq(&md->lock);
 			ret = __blk_end_request(req, 0,
 						brq->data.bytes_xfered);
 			spin_unlock_irq(&md->lock);
+			/*
+			 * If the blk_end_request function returns non-zero even
+			 * though all data has been transferred and no errors
+			 * were returned by the host controller, it's a bug.
+			 */
 			if (status == MMC_BLK_SUCCESS && ret) {
-				/*
-				 * The blk_end_request has returned non zero
-				 * even though all data is transfered and no
-				 * erros returned by host.
-				 * If this happen it's a bug.
-				 */
 				printk(KERN_ERR "%s BUG rq_tot %d d_xfer %d\n",
 				       __func__, blk_rq_bytes(req),
 				       brq->data.bytes_xfered);
@@ -1100,16 +1187,36 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			}
 			break;
 		case MMC_BLK_CMD_ERR:
-			goto cmd_err;
-		case MMC_BLK_RETRY_SINGLE:
-			disable_multi = 1;
-			break;
+			ret = mmc_blk_cmd_err(md, card, brq, req, ret);
+			if (!mmc_blk_reset(md, card->host, type))
+				break;
+			goto cmd_abort;
 		case MMC_BLK_RETRY:
 			if (retry++ < 5)
 				break;
+			/* Fall through */
 		case MMC_BLK_ABORT:
+			if (!mmc_blk_reset(md, card->host, type))
+				break;
 			goto cmd_abort;
-		case MMC_BLK_DATA_ERR:
+		case MMC_BLK_DATA_ERR: {
+			int err;
+
+			err = mmc_blk_reset(md, card->host, type);
+			if (!err)
+				break;
+			if (err == -ENODEV)
+				goto cmd_abort;
+			/* Fall through */
+		}
+		case MMC_BLK_ECC_ERR:
+			if (brq->data.blocks > 1) {
+				/* Redo read one sector at a time */
+				pr_warning("%s: retrying using single block read\n",
+					   req->rq_disk->disk_name);
+				disable_multi = 1;
+				break;
+			}
 			/*
 			 * After an error, we redo I/O one sector at a
 			 * time, so we only reach here after trying to
@@ -1126,7 +1233,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
 		if (ret) {
 			/*
-			 * In case of a none complete request
+			 * In case of a incomplete request
 			 * prepare it again and resend.
 			 */
 			mmc_blk_rw_rq_prep(mq_rq, card, disable_multi, mq);
@@ -1136,30 +1243,6 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
 	return 1;
 
- cmd_err:
- 	/*
- 	 * If this is an SD card and we're writing, we can first
- 	 * mark the known good sectors as ok.
- 	 *
-	 * If the card is not SD, we can still ok written sectors
-	 * as reported by the controller (which might be less than
-	 * the real number of written sectors, but never more).
-	 */
-	if (mmc_card_sd(card)) {
-		u32 blocks;
-
-		blocks = mmc_sd_num_wr_blocks(card);
-		if (blocks != (u32)-1) {
-			spin_lock_irq(&md->lock);
-			ret = __blk_end_request(req, 0, blocks << 9);
-			spin_unlock_irq(&md->lock);
-		}
-	} else {
-		spin_lock_irq(&md->lock);
-		ret = __blk_end_request(req, 0, brq->data.bytes_xfered);
-		spin_unlock_irq(&md->lock);
-	}
-
  cmd_abort:
 	spin_lock_irq(&md->lock);
 	while (ret)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3bdb981..2f6897c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1521,7 +1521,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	if (err) {
 		printk(KERN_ERR "mmc_erase: group start error %d, "
 		       "status %#x\n", err, cmd.resp[0]);
-		err = -EINVAL;
+		err = -EIO;
 		goto out;
 	}
 
@@ -1536,7 +1536,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	if (err) {
 		printk(KERN_ERR "mmc_erase: group end error %d, status %#x\n",
 		       err, cmd.resp[0]);
-		err = -EINVAL;
+		err = -EIO;
 		goto out;
 	}
 
-- 
1.7.6

