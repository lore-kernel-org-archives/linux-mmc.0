From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 01/16] block: remove QUEUE_FLAG_BYPASS and
	->bypass
Date: Wed, 14 Nov 2018 17:02:04 +0100
Message-ID: <20181114160219.28328-2-hch@lst.de>
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

Unused since the removal of the legacy request code.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 block/blk-cgroup.c         | 15 ---------------
 block/blk-core.c           | 21 ---------------------
 block/blk-mq-debugfs.c     |  1 -
 block/blk-throttle.c       |  3 ---
 include/linux/blk-cgroup.h |  6 +-----
 include/linux/blkdev.h     |  3 ---
 6 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6c65791bc3fe..a95cddb39f1c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -270,13 +270,6 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	lockdep_assert_held(q->queue_lock);
 
-	/*
-	 * This could be the first entry point of blkcg implementation and
-	 * we shouldn't allow anything to go through for a bypassing queue.
-	 */
-	if (unlikely(blk_queue_bypass(q)))
-		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
-
 	blkg = __blkg_lookup(blkcg, q, true);
 	if (blkg)
 		return blkg;
@@ -741,14 +734,6 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
 
 	if (!blkcg_policy_enabled(q, pol))
 		return ERR_PTR(-EOPNOTSUPP);
-
-	/*
-	 * This could be the first entry point of blkcg implementation and
-	 * we shouldn't allow anything to go through for a bypassing queue.
-	 */
-	if (unlikely(blk_queue_bypass(q)))
-		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
-
 	return __blkg_lookup(blkcg, q, true /* update_hint */);
 }
 
diff --git a/block/blk-core.c b/block/blk-core.c
index fdc0ad2686c4..1c9b6975cf0a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -370,18 +370,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	blk_set_queue_dying(q);
 	spin_lock_irq(lock);
 
-	/*
-	 * A dying queue is permanently in bypass mode till released.  Note
-	 * that, unlike blk_queue_bypass_start(), we aren't performing
-	 * synchronize_rcu() after entering bypass mode to avoid the delay
-	 * as some drivers create and destroy a lot of queues while
-	 * probing.  This is still safe because blk_release_queue() will be
-	 * called only after the queue refcnt drops to zero and nothing,
-	 * RCU or not, would be traversing the queue by then.
-	 */
-	q->bypass_depth++;
-	queue_flag_set(QUEUE_FLAG_BYPASS, q);
-
 	queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
 	queue_flag_set(QUEUE_FLAG_DYING, q);
@@ -589,15 +577,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 
 	q->queue_lock = lock ? : &q->__queue_lock;
 
-	/*
-	 * A queue starts its life with bypass turned on to avoid
-	 * unnecessary bypass on/off overhead and nasty surprises during
-	 * init.  The initial bypass will be finished when the queue is
-	 * registered by blk_register_queue().
-	 */
-	q->bypass_depth = 1;
-	queue_flag_set_unlocked(QUEUE_FLAG_BYPASS, q);
-
 	init_waitqueue_head(&q->mq_freeze_wq);
 
 	/*
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f021f4817b80..a32bb79d6c95 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -114,7 +114,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
-	QUEUE_FLAG_NAME(BYPASS),
 	QUEUE_FLAG_NAME(BIDI),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index db1a3a2ae006..8e6f3c9821c2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2145,9 +2145,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	throtl_update_latency_buckets(td);
 
-	if (unlikely(blk_queue_bypass(q)))
-		goto out_unlock;
-
 	blk_throtl_assoc_bio(tg, bio);
 	blk_throtl_update_idletime(tg);
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 1b299e025e83..2c68efc603bd 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -325,16 +325,12 @@ static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
  * @q: request_queue of interest
  *
  * Lookup blkg for the @blkcg - @q pair.  This function should be called
- * under RCU read lock and is guaranteed to return %NULL if @q is bypassing
- * - see blk_queue_bypass_start() for details.
+ * under RCU read loc.
  */
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 					   struct request_queue *q)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	if (unlikely(blk_queue_bypass(q)))
-		return NULL;
 	return __blkg_lookup(blkcg, q, false);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e67ad2dd025e..c92aafcde0b8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -551,7 +551,6 @@ struct request_queue {
 
 	struct mutex		sysfs_lock;
 
-	int			bypass_depth;
 	atomic_t		mq_freeze_depth;
 
 #if defined(CONFIG_BLK_DEV_BSG)
@@ -589,7 +588,6 @@ struct request_queue {
 
 #define QUEUE_FLAG_STOPPED	1	/* queue is stopped */
 #define QUEUE_FLAG_DYING	2	/* queue being torn down */
-#define QUEUE_FLAG_BYPASS	3	/* act as dumb FIFO queue */
 #define QUEUE_FLAG_BIDI		4	/* queue supports bidi requests */
 #define QUEUE_FLAG_NOMERGES     5	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	6	/* complete on same CPU-group */
@@ -633,7 +631,6 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_dead(q)	test_bit(QUEUE_FLAG_DEAD, &(q)->queue_flags)
-#define blk_queue_bypass(q)	test_bit(QUEUE_FLAG_BYPASS, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
 #define blk_queue_noxmerges(q)	\
-- 
2.19.1
