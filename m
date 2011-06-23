From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] mmc: queue: append partition subname to queue thread name
Date: Thu, 23 Jun 2011 13:40:28 +0300
Message-ID: <1308825629-27375-4-git-send-email-adrian.hunter@intel.com>
References: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21043 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759157Ab1FWKlU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2011 06:41:20 -0400
In-Reply-To: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andrei Warkentin <andreiw@motorola.com>

For example, an eMMC with 2 boot partitions will have 3 threads.
The names change from:

   40 ?        00:00:00 mmcqd/0
   41 ?        00:00:00 mmcqd/0
   42 ?        00:00:00 mmcqd/0

to:

   40 ?        00:00:00 mmcqd/0
   41 ?        00:00:00 mmcqd/0boot0
   42 ?        00:00:00 mmcqd/0boot1

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    2 +-
 drivers/mmc/card/queue.c |    8 +++++---
 drivers/mmc/card/queue.h |    3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index d36b7ea..bee2106 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1167,7 +1167,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	INIT_LIST_HEAD(&md->part);
 	md->usage = 1;
 
-	ret = mmc_init_queue(&md->queue, card, &md->lock);
+	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
 	if (ret)
 		goto err_putdisk;
 
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index c07322c..3e2db1c 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -106,10 +106,12 @@ static void mmc_request(struct request_queue *q)
  * @mq: mmc queue
  * @card: mmc card to attach this queue
  * @lock: queue lock
+ * @subname: partition subname
  *
  * Initialise a MMC card request queue.
  */
-int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock)
+int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
+		   spinlock_t *lock, const char *subname)
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
@@ -209,8 +211,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock
 
 	sema_init(&mq->thread_sem, 1);
 
-	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d",
-		host->index);
+	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
+		host->index, subname ? subname : "");
 
 	if (IS_ERR(mq->thread)) {
 		ret = PTR_ERR(mq->thread);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 64e66e0..6223ef8 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -19,7 +19,8 @@ struct mmc_queue {
 	unsigned int		bounce_sg_len;
 };
 
-extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *);
+extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
+			  const char *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
-- 
1.7.4.4

