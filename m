From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 09/16] blk-cgroup: consolidate error handling in
	blkcg_init_queue
Date: Wed, 14 Nov 2018 17:02:12 +0100
Message-ID: <20181114160219.28328-10-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
In-Reply-To: <20181114160219.28328-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
List-Help: <mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=subscribe>
Sender: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
Errors-To: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
To: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Cc: linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Use a goto label to merge two identical pieces of error handling code.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 block/blk-cgroup.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3296c0b7353a..717ab38a6c67 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1173,21 +1173,19 @@ int blkcg_init_queue(struct request_queue *q)
 		radix_tree_preload_end();
 
 	ret = blk_iolatency_init(q);
-	if (ret) {
-		spin_lock_irq(q->queue_lock);
-		blkg_destroy_all(q);
-		spin_unlock_irq(q->queue_lock);
-		return ret;
-	}
+	if (ret)
+		goto err_destroy_all;
 
 	ret = blk_throtl_init(q);
-	if (ret) {
-		spin_lock_irq(q->queue_lock);
-		blkg_destroy_all(q);
-		spin_unlock_irq(q->queue_lock);
-	}
-	return ret;
+	if (ret)
+		goto err_destroy_all;
+	return 0;
 
+err_destroy_all:
+	spin_lock_irq(q->queue_lock);
+	blkg_destroy_all(q);
+	spin_unlock_irq(q->queue_lock);
+	return ret;
 err_unlock:
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
-- 
2.19.1
