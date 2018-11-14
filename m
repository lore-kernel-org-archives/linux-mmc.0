From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 10/16] blk-cgroup: move locking into
	blkg_destroy_all
Date: Wed, 14 Nov 2018 17:02:13 +0100
Message-ID: <20181114160219.28328-11-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 block/blk-cgroup.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 717ab38a6c67..3ba23b9bfeb9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -349,8 +349,7 @@ static void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
 
-	lockdep_assert_held(q->queue_lock);
-
+	spin_lock_irq(q->queue_lock);
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
@@ -360,6 +359,7 @@ static void blkg_destroy_all(struct request_queue *q)
 	}
 
 	q->root_blkg = NULL;
+	spin_unlock_irq(q->queue_lock);
 }
 
 /*
@@ -1182,9 +1182,7 @@ int blkcg_init_queue(struct request_queue *q)
 	return 0;
 
 err_destroy_all:
-	spin_lock_irq(q->queue_lock);
 	blkg_destroy_all(q);
-	spin_unlock_irq(q->queue_lock);
 	return ret;
 err_unlock:
 	spin_unlock_irq(q->queue_lock);
@@ -1222,10 +1220,7 @@ void blkcg_drain_queue(struct request_queue *q)
  */
 void blkcg_exit_queue(struct request_queue *q)
 {
-	spin_lock_irq(q->queue_lock);
 	blkg_destroy_all(q);
-	spin_unlock_irq(q->queue_lock);
-
 	blk_throtl_exit(q);
 }
 
-- 
2.19.1
