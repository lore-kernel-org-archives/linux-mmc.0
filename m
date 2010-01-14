From: <gregkh@suse.de>
Subject: patch mmc_block-fix-queue-cleanup.patch added to 2.6.32-stable tree
Date: Thu, 14 Jan 2010 07:32:28 -0800
Message-ID: <12634831483502@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:43754 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757238Ab0ANPdl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Jan 2010 10:33:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@nokia.com, akpm@linux-foundation.org, gregkh@suse.de, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: mmc_block: fix queue cleanup

to the 2.6.32-stable tree.  Its filename is

    mmc_block-fix-queue-cleanup.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From 5fa83ce284a4b7cd9dcfadd01500b0ed4ab9b740 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 8 Jan 2010 14:43:00 -0800
Subject: mmc_block: fix queue cleanup

From: Adrian Hunter <adrian.hunter@nokia.com>

commit 5fa83ce284a4b7cd9dcfadd01500b0ed4ab9b740 upstream.

The main bug was that 'blk_cleanup_queue()' was called while the block
device could still be in use, for example, because the card was removed
while files were still open.

In addition, to be sure that 'mmc_request()' will get called for all new
requests (so it can error them out), the queue is emptied during cleanup.
This is done after the worker thread is stopped to avoid racing with it.

Finally, it is not a device error for this to be happening, so quiet the
(sometimes very many) error messages.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/card/block.c |    2 ++
 drivers/mmc/card/queue.c |   18 +++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -91,6 +91,8 @@ static void mmc_blk_put(struct mmc_blk_d
 		if (!devmaj)
 			devidx = md->disk->first_minor >> MMC_SHIFT;
 
+		blk_cleanup_queue(md->queue.queue);
+
 		__clear_bit(devidx, dev_use);
 
 		put_disk(md->disk);
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -90,9 +90,10 @@ static void mmc_request(struct request_q
 	struct request *req;
 
 	if (!mq) {
-		printk(KERN_ERR "MMC: killing requests for dead queue\n");
-		while ((req = blk_fetch_request(q)) != NULL)
+		while ((req = blk_fetch_request(q)) != NULL) {
+			req->cmd_flags |= REQ_QUIET;
 			__blk_end_request_all(req, -EIO);
+		}
 		return;
 	}
 
@@ -223,17 +224,18 @@ void mmc_cleanup_queue(struct mmc_queue 
 	struct request_queue *q = mq->queue;
 	unsigned long flags;
 
-	/* Mark that we should start throwing out stragglers */
-	spin_lock_irqsave(q->queue_lock, flags);
-	q->queuedata = NULL;
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
 	/* Make sure the queue isn't suspended, as that will deadlock */
 	mmc_queue_resume(mq);
 
 	/* Then terminate our worker thread */
 	kthread_stop(mq->thread);
 
+	/* Empty the queue */
+	spin_lock_irqsave(q->queue_lock, flags);
+	q->queuedata = NULL;
+	blk_start_queue(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
  	if (mq->bounce_sg)
  		kfree(mq->bounce_sg);
  	mq->bounce_sg = NULL;
@@ -245,8 +247,6 @@ void mmc_cleanup_queue(struct mmc_queue 
 		kfree(mq->bounce_buf);
 	mq->bounce_buf = NULL;
 
-	blk_cleanup_queue(mq->queue);
-
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);


Patches currently in stable-queue which might be from adrian.hunter@nokia.com are

queue-2.6.32/mmc_block-add-dev_t-initialization-check.patch
queue-2.6.32/mmc_block-fix-probe-error-cleanup-bug.patch
queue-2.6.32/mmc_block-fix-queue-cleanup.patch
