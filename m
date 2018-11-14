From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 05/16] block: remove queue_lockdep_assert_held
Date: Wed, 14 Nov 2018 17:02:08 +0100
Message-ID: <20181114160219.28328-6-hch@lst.de>
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

The only remaining user unconditionally drops and reacquires the lock,
which means we really don't need any additional (conditional) annotation.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 block/blk-throttle.c |  1 -
 block/blk.h          | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8e6f3c9821c2..a665b0950369 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2353,7 +2353,6 @@ void blk_throtl_drain(struct request_queue *q)
 	struct bio *bio;
 	int rw;
 
-	queue_lockdep_assert_held(q);
 	rcu_read_lock();
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index f2ddc71e93da..027a0ccc175e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -35,19 +35,6 @@ extern struct kmem_cache *blk_requestq_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
-/*
- * @q->queue_lock is set while a queue is being initialized. Since we know
- * that no other threads access the queue object before @q->queue_lock has
- * been set, it is safe to manipulate queue flags without holding the
- * queue_lock if @q->queue_lock == NULL. See also blk_alloc_queue_node() and
- * blk_init_allocated_queue().
- */
-static inline void queue_lockdep_assert_held(struct request_queue *q)
-{
-	if (q->queue_lock)
-		lockdep_assert_held(q->queue_lock);
-}
-
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 {
-- 
2.19.1
