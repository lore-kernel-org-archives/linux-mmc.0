From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v2 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Thu,  7 Jun 2012 15:46:58 +0530
Message-ID: <1339064218-31925-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>
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

This change is not meant for improving MMC throughput; it's basically
about becoming fair to other threads/interrupts in the system. By holding
spin lock and interrupts disabled for longer duration, we won't allow
other threads/interrupts to run at all.
Actually slight performance degradation at file system level can be expected
as we are not holding the spin lock during blk_update_bidi_request() which
means our mmcqd thread may get preempted for other high priority thread or
any interrupt in the system.

These are performance numbers (100MB file write) with eMMC running in DDR
mode:

Without this patch:
	Name of the Test   Value   Unit
	LMDD Read Test     53.79   MBPS
	LMDD Write Test    18.86   MBPS
	IOZONE  Read Test  51.65   MBPS
	IOZONE  Write Test 24.36   MBPS

With this patch:
	Name of the Test    Value  Unit
	LMDD Read Test      52.94  MBPS
	LMDD Write Test     16.70  MBPS
	IOZONE  Read Test   52.08  MBPS
	IOZONE  Write Test  23.29  MBPS

Read numbers are fine. Write numbers are bit down (especially LMDD write),
may be because write requests normally have large transfer size and
which means there are chances that while mmcq is executing
blk_update_bidi_request(), it may get interrupted by interrupts or
other high priority thread.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/card/block.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index dd2d374..7e3f453 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -862,9 +862,7 @@ out:
 		goto retry;
 	if (!err)
 		mmc_blk_reset_success(md, type);
-	spin_lock_irq(&md->lock);
-	__blk_end_request(req, err, blk_rq_bytes(req));
-	spin_unlock_irq(&md->lock);
+	blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
 }
@@ -946,9 +944,7 @@ out_retry:
 	if (!err)
 		mmc_blk_reset_success(md, type);
 out:
-	spin_lock_irq(&md->lock);
-	__blk_end_request(req, err, blk_rq_bytes(req));
-	spin_unlock_irq(&md->lock);
+	blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
 }
@@ -963,9 +959,7 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	if (ret)
 		ret = -EIO;
 
-	spin_lock_irq(&md->lock);
-	__blk_end_request_all(req, ret);
-	spin_unlock_irq(&md->lock);
+	blk_end_request_all(req, ret);
 
 	return ret ? 0 : 1;
 }
@@ -1264,14 +1258,10 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 
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
@@ -1323,10 +1313,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
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
@@ -1376,10 +1364,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
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
@@ -1400,12 +1386,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
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
@@ -1429,9 +1413,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
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
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
