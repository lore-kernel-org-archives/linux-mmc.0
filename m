From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 3/3] mmc_block: fix queue cleanup
Date: Fri, 18 Dec 2009 14:15:48 +0200
Message-ID: <20091218121548.4351.24938.sendpatchset@ahunter-work.research.nokia.com>
References: <20091218121527.4351.14601.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38271 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZLRMQw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2009 07:16:52 -0500
In-Reply-To: <20091218121527.4351.14601.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

>From 010e6bcca45e7a0bcd9e8b27b39330cb375a7eda Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 14 Nov 2009 10:44:03 +0200
Subject: [PATCH] mmc_block: fix queue cleanup

The main bug was that 'blk_cleanup_queue()' was called while
the block device could still be in use, for example, because
the card was removed while files were still open.

In addition, to be sure that 'mmc_request()' will get called
for all new requests (so it can error them out), the queue is
emptied during cleanup.  This is done after the worker thread
is stopped to avoid racing with it.

Finally, it is not a device error for this to be happening, so
quiet the (sometimes very many) error messages.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/block.c |    2 ++
 drivers/mmc/card/queue.c |   18 +++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index ee87911..1f552c6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -91,6 +91,8 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 		if (!devmaj)
 			devidx = md->disk->first_minor >> MMC_SHIFT;
 
+		blk_cleanup_queue(md->queue.queue);
+
 		__clear_bit(devidx, dev_use);
 
 		put_disk(md->disk);
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 49e5823..c5a7a85 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -90,9 +90,10 @@ static void mmc_request(struct request_queue *q)
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
 
@@ -223,17 +224,18 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
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
@@ -245,8 +247,6 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 		kfree(mq->bounce_buf);
 	mq->bounce_buf = NULL;
 
-	blk_cleanup_queue(mq->queue);
-
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
-- 
1.6.0.4

