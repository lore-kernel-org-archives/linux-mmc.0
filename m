From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v8 09/12] mmc: block: move error code in issue_rw_rq to a
	separate function.
Date: Tue, 28 Jun 2011 10:11:54 +0200
Message-ID: <1309248717-14606-10-git-send-email-per.forlin@linaro.org>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1309248717-14606-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nickolay
List-Id: linux-mmc@vger.kernel.org

Break out code without functional changes. This simplifies the code and
makes way for handle two parallel request.

Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/card/block.c |  220 +++++++++++++++++++++++++++-------------------
 1 files changed, 131 insertions(+), 89 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a0a76f4..7ed2c68 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -106,6 +106,16 @@ struct mmc_blk_data {
 
 static DEFINE_MUTEX(open_lock);
 
+enum mmc_blk_status {
+	MMC_BLK_SUCCESS = 0,
+	MMC_BLK_PARTIAL,
+	MMC_BLK_RETRY,
+	MMC_BLK_RETRY_SINGLE,
+	MMC_BLK_DATA_ERR,
+	MMC_BLK_CMD_ERR,
+	MMC_BLK_ABORT,
+};
+
 module_param(perdev_minors, int, 0444);
 MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
@@ -812,6 +822,95 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
 
+int mmc_blk_err_check(struct mmc_blk_request *brq,
+		      struct request *req,
+		      struct mmc_card *card,
+		      struct mmc_blk_data *md)
+{
+	int ret = MMC_BLK_SUCCESS;
+
+	/*
+	 * sbc.error indicates a problem with the set block count
+	 * command.  No data will have been transferred.
+	 *
+	 * cmd.error indicates a problem with the r/w command.  No
+	 * data will have been transferred.
+	 *
+	 * stop.error indicates a problem with the stop command.  Data
+	 * may have been transferred, or may still be transferring.
+	 */
+	if (brq->sbc.error || brq->cmd.error || brq->stop.error) {
+		switch (mmc_blk_cmd_recovery(card, req, brq)) {
+		case ERR_RETRY:
+			return MMC_BLK_RETRY;
+		case ERR_ABORT:
+			return MMC_BLK_ABORT;
+		case ERR_CONTINUE:
+			break;
+		}
+	}
+
+	/*
+	 * Check for errors relating to the execution of the
+	 * initial command - such as address errors.  No data
+	 * has been transferred.
+	 */
+	if (brq->cmd.resp[0] & CMD_ERRORS) {
+		pr_err("%s: r/w command failed, status = %#x\n",
+		       req->rq_disk->disk_name, brq->cmd.resp[0]);
+		return MMC_BLK_ABORT;
+	}
+
+	/*
+	 * Everything else is either success, or a data error of some
+	 * kind.  If it was a write, we may have transitioned to
+	 * program mode, which we have to wait for it to complete.
+	 */
+	if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
+		u32 status;
+		do {
+			int err = get_card_status(card, &status, 5);
+			if (err) {
+				printk(KERN_ERR "%s: error %d requesting status\n",
+				       req->rq_disk->disk_name, err);
+				return MMC_BLK_CMD_ERR;
+			}
+			/*
+			 * Some cards mishandle the status bits,
+			 * so make sure to check both the busy
+			 * indication and the card state.
+			 */
+		} while (!(status & R1_READY_FOR_DATA) ||
+			 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
+	}
+
+	if (brq->data.error) {
+		pr_err("%s: error %d transferring data, sector %u, nr %u, cmd response %#x, card status %#x\n",
+		       req->rq_disk->disk_name, brq->data.error,
+		       (unsigned)blk_rq_pos(req),
+		       (unsigned)blk_rq_sectors(req),
+		       brq->cmd.resp[0], brq->stop.resp[0]);
+
+		if (rq_data_dir(req) == READ) {
+			if (brq->data.blocks > 1) {
+				/* Redo read one sector at a time */
+				pr_warning("%s: retrying using single block read\n",
+					   req->rq_disk->disk_name);
+				return MMC_BLK_RETRY_SINGLE;
+			}
+			return MMC_BLK_DATA_ERR;
+		} else {
+			return MMC_BLK_CMD_ERR;
+		}
+	}
+
+	if (ret == MMC_BLK_SUCCESS &&
+	    blk_rq_bytes(req) != brq->data.bytes_xfered)
+		ret = MMC_BLK_PARTIAL;
+
+	return ret;
+}
+
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
@@ -948,6 +1047,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
 	int ret = 1, disable_multi = 0, retry = 0;
+	enum mmc_blk_status status;
 
 	do {
 		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, disable_multi, mq);
@@ -955,99 +1055,41 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 
 		mmc_queue_bounce_post(mq->mqrq_cur);
 
-		/*
-		 * sbc.error indicates a problem with the set block count
-		 * command.  No data will have been transferred.
-		 *
-		 * cmd.error indicates a problem with the r/w command.  No
-		 * data will have been transferred.
-		 *
-		 * stop.error indicates a problem with the stop command.  Data
-		 * may have been transferred, or may still be transferring.
-		 */
-		if (brq->sbc.error || brq->cmd.error || brq->stop.error) {
-			switch (mmc_blk_cmd_recovery(card, req, brq)) {
-			case ERR_RETRY:
-				if (retry++ < 5)
-					continue;
-			case ERR_ABORT:
-				goto cmd_abort;
-			case ERR_CONTINUE:
+		status = mmc_blk_err_check(brq, req, card, md);
+		switch (status) {
+		case MMC_BLK_SUCCESS:
+		case MMC_BLK_PARTIAL:
+			/*
+			 * A block was successfully transferred.
+			 */
+			spin_lock_irq(&md->lock);
+			ret = __blk_end_request(req, 0,
+						brq->data.bytes_xfered);
+			spin_unlock_irq(&md->lock);
+			break;
+		case MMC_BLK_CMD_ERR:
+			goto cmd_err;
+		case MMC_BLK_RETRY_SINGLE:
+			disable_multi = 1;
+			break;
+		case MMC_BLK_RETRY:
+			if (retry++ < 5)
 				break;
-			}
-		}
-
-		/*
-		 * Check for errors relating to the execution of the
-		 * initial command - such as address errors.  No data
-		 * has been transferred.
-		 */
-		if (brq->cmd.resp[0] & CMD_ERRORS) {
-			pr_err("%s: r/w command failed, status = %#x\n",
-				req->rq_disk->disk_name, brq->cmd.resp[0]);
+		case MMC_BLK_ABORT:
 			goto cmd_abort;
+		case MMC_BLK_DATA_ERR:
+			/*
+			 * After an error, we redo I/O one sector at a
+			 * time, so we only reach here after trying to
+			 * read a single sector.
+			 */
+			spin_lock_irq(&md->lock);
+			ret = __blk_end_request(req, -EIO,
+						brq->data.blksz);
+			spin_unlock_irq(&md->lock);
+			break;
 		}
 
-		/*
-		 * Everything else is either success, or a data error of some
-		 * kind.  If it was a write, we may have transitioned to
-		 * program mode, which we have to wait for it to complete.
-		 */
-		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
-			u32 status;
-			do {
-				int err = get_card_status(card, &status, 5);
-				if (err) {
-					printk(KERN_ERR "%s: error %d requesting status\n",
-					       req->rq_disk->disk_name, err);
-					goto cmd_err;
-				}
-				/*
-				 * Some cards mishandle the status bits,
-				 * so make sure to check both the busy
-				 * indication and the card state.
-				 */
-			} while (!(status & R1_READY_FOR_DATA) ||
-				 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
-		}
-
-		if (brq->data.error) {
-			pr_err("%s: error %d transferring data, sector %u, nr %u, cmd response %#x, card status %#x\n",
-				req->rq_disk->disk_name, brq->data.error,
-				(unsigned)blk_rq_pos(req),
-				(unsigned)blk_rq_sectors(req),
-				brq->cmd.resp[0], brq->stop.resp[0]);
-
-			if (rq_data_dir(req) == READ) {
-				if (brq->data.blocks > 1) {
-					/* Redo read one sector at a time */
-					pr_warning("%s: retrying using single block read\n",
-						req->rq_disk->disk_name);
-					disable_multi = 1;
-					continue;
-				}
-
-				/*
-				 * After an error, we redo I/O one sector at a
-				 * time, so we only reach here after trying to
-				 * read a single sector.
-				 */
-				spin_lock_irq(&md->lock);
-				ret = __blk_end_request(req, -EIO,
-							brq->data.blksz);
-				spin_unlock_irq(&md->lock);
-				continue;
-			} else {
-				goto cmd_err;
-			}
-		}
-
-		/*
-		 * A block was successfully transferred.
-		 */
-		spin_lock_irq(&md->lock);
-		ret = __blk_end_request(req, 0, brq->data.bytes_xfered);
-		spin_unlock_irq(&md->lock);
 	} while (ret);
 
 	return 1;
-- 
1.7.4.1
