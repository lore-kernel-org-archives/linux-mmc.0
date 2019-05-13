From: Raul E Rangel <rrangel@chromium.org>
Subject: [stable/4.14.y PATCH 1/3] mmc: block: Simplify cleaning up the queue
Date: Mon, 13 May 2019 11:55:19 -0600
Message-ID: <20190513175521.84955-2-rrangel@chromium.org>
References: <20190513175521.84955-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513175521.84955-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org, Chris Boot <bootc@bootc.net>, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Use blk_cleanup_queue() to shutdown the queue when the driver is removed,
and instead get an extra reference to the queue to prevent the queue being
freed before the final mmc_blk_put().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
commit 41e3efd07d5a02c80f503e29d755aa1bbb4245de upstream.

 drivers/mmc/core/block.c | 17 ++++++++++++-----
 drivers/mmc/core/queue.c |  2 ++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce6dd49fbb98d..203038fb85111 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -161,7 +161,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	md->usage--;
 	if (md->usage == 0) {
 		int devidx = mmc_get_devidx(md->disk);
-		blk_cleanup_queue(md->queue.queue);
+		blk_put_queue(md->queue.queue);
 		ida_simple_remove(&mmc_blk_ida, devidx);
 		put_disk(md->disk);
 		kfree(md);
@@ -2122,6 +2122,17 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	md->queue.blkdata = md;
 
+	/*
+	 * Keep an extra reference to the queue so that we can shutdown the
+	 * queue (i.e. call blk_cleanup_queue()) while there are still
+	 * references to the 'md'. The corresponding blk_put_queue() is in
+	 * mmc_blk_put().
+	 */
+	if (!blk_get_queue(md->queue.queue)) {
+		mmc_cleanup_queue(&md->queue);
+		goto err_putdisk;
+	}
+
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->first_minor = devidx * perdev_minors;
 	md->disk->fops = &mmc_bdops;
@@ -2272,10 +2283,6 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		 * from being accepted.
 		 */
 		card = md->queue.card;
-		spin_lock_irq(md->queue.queue->queue_lock);
-		queue_flag_set(QUEUE_FLAG_BYPASS, md->queue.queue);
-		spin_unlock_irq(md->queue.queue->queue_lock);
-		blk_set_queue_dying(md->queue.queue);
 		mmc_cleanup_queue(&md->queue);
 		if (md->disk->flags & GENHD_FL_UP) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 0a4e77a5ba33f..d99fa4e63033c 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -259,6 +259,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
+	blk_cleanup_queue(q);
+
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
-- 
2.21.0.1020.gf2820cf01a-goog
