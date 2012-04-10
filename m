From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Tue, 10 Apr 2012 23:56:52 +0530
Message-ID: <1334082412-2821-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, cjb@laptop.org, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

For completing any block request, MMC block driver is calling:
	spin_lock_irq(queue)
	__blk_end_request()
	spin_unlock_irq(queue)

But if we analyze the sources of latency in kernel using ftrace,
__blk_end_request() function at times may take up to 6.5ms with
spinlock held and irq disabled.

__blk_end_request() calls couple of functions and ftrace output
shows that blk_update_bidi_request() function is almost taking 6ms.
There are 2 function to end the current request: ___blk_end_request()
and blk_end_request(). Both these functions do same thing except
that blk_end_request() function doesn't take up the spinlock
while calling the blk_update_bidi_request().

This patch replaces all __blk_end_request() calls with
blk_end_request() and __blk_end_request_all() calls with
blk_end_request_all().

Testing done: 20 process concurrent read/write on sd card
and eMMC. Ran this test for almost a day on multicore system
and no errors observed.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/card/block.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index b180965..437471a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -861,9 +861,7 @@ out:
 		goto retry;
 	if (!err)
 		mmc_blk_reset_success(md, type);
-	spin_lock_irq(&md->lock);
-	__blk_end_request(req, err, blk_rq_bytes(req));
-	spin_unlock_irq(&md->lock);
+	blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
 }
@@ -923,9 +921,7 @@ out:
 		goto retry;
 	if (!err)
 		mmc_blk_reset_success(md, type);
-	spin_lock_irq(&md->lock);
-	__blk_end_request(req, err, blk_rq_bytes(req));
-	spin_unlock_irq(&md->lock);
+	blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
 }
@@ -940,9 +936,7 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	if (ret)
 		ret = -EIO;
 
-	spin_lock_irq(&md->lock);
-	__blk_end_request_all(req, ret);
-	spin_unlock_irq(&md->lock);
+	blk_end_request_all(req, ret);
 
 	return ret ? 0 : 1;
 }
@@ -1241,14 +1235,10 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 
 		blocks = mmc_sd_num_wr_blocks(card);
 		if (blocks != (u32)-1) {
-			spin_lock_irq(&md->lock);
-			ret = __blk_end_request(req, 0, blocks << 9);
-			spin_unlock_irq(&md->lock);
+			ret = blk_end_request(req, 0, blocks << 9);
 		}
 	} else {
-		spin_lock_irq(&md->lock);
-		ret = __blk_end_request(req, 0, brq->data.bytes_xfered);
-		spin_unlock_irq(&md->lock);
+		ret = blk_end_request(req, 0, brq->data.bytes_xfered);
 	}
 	return ret;
 }
@@ -1290,10 +1280,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 * A block was successfully transferred.
 			 */
 			mmc_blk_reset_success(md, type);
-			spin_lock_irq(&md->lock);
-			ret = __blk_end_request(req, 0,
+			ret = blk_end_request(req, 0,
 						brq->data.bytes_xfered);
-			spin_unlock_irq(&md->lock);
 			/*
 			 * If the blk_end_request function returns non-zero even
 			 * though all data has been transferred and no errors
@@ -1343,10 +1331,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 * time, so we only reach here after trying to
 			 * read a single sector.
 			 */
-			spin_lock_irq(&md->lock);
-			ret = __blk_end_request(req, -EIO,
+			ret = blk_end_request(req, -EIO,
 						brq->data.blksz);
-			spin_unlock_irq(&md->lock);
 			if (!ret)
 				goto start_new_req;
 			break;
@@ -1367,12 +1353,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	return 1;
 
  cmd_abort:
-	spin_lock_irq(&md->lock);
 	if (mmc_card_removed(card))
 		req->cmd_flags |= REQ_QUIET;
 	while (ret)
-		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
-	spin_unlock_irq(&md->lock);
+		ret = blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
 
  start_new_req:
 	if (rqc) {
@@ -1396,9 +1380,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		if (req) {
-			spin_lock_irq(&md->lock);
-			__blk_end_request_all(req, -EIO);
-			spin_unlock_irq(&md->lock);
+			blk_end_request_all(req, -EIO);
 		}
 		ret = 0;
 		goto out;
-- 
1.7.1.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
