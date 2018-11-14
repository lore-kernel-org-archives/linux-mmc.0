From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 02/16] block: remove deadline __deadline
	manipulation helpers
Date: Wed, 14 Nov 2018 17:02:05 +0100
Message-ID: <20181114160219.28328-3-hch@lst.de>
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

No users left since the removal of the legacy request interface, we can
remove all the magic bit stealing now and make it a normal field.

But use WRITE_ONCE/READ_ONCE on the new deadline field, given that we
don't seem to have any mechanism to guarantee a new value actually
gets seen by other threads.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 block/blk-mq.c         |  4 ++--
 block/blk-timeout.c    |  8 +++++---
 block/blk.h            | 35 -----------------------------------
 include/linux/blkdev.h |  4 +---
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 411be60d0cb6..4c82b4b4fa3e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -325,7 +325,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
-	rq->__deadline = 0;
+	WRITE_ONCE(rq->deadline, 0);
 
 	rq->timeout = 0;
 
@@ -839,7 +839,7 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	if (rq->rq_flags & RQF_TIMED_OUT)
 		return false;
 
-	deadline = blk_rq_deadline(rq);
+	deadline = READ_ONCE(rq->deadline);
 	if (time_after_eq(jiffies, deadline))
 		return true;
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 006cff4390c0..3b0179fbdd6a 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -84,7 +84,7 @@ void blk_abort_request(struct request *req)
 	 * immediately and that scan sees the new timeout value.
 	 * No need for fancy synchronizations.
 	 */
-	blk_rq_set_deadline(req, jiffies);
+	WRITE_ONCE(req->deadline, jiffies);
 	kblockd_schedule_work(&req->q->timeout_work);
 }
 EXPORT_SYMBOL_GPL(blk_abort_request);
@@ -121,14 +121,16 @@ void blk_add_timer(struct request *req)
 		req->timeout = q->rq_timeout;
 
 	req->rq_flags &= ~RQF_TIMED_OUT;
-	blk_rq_set_deadline(req, jiffies + req->timeout);
+
+	expiry = jiffies + req->timeout;
+	WRITE_ONCE(req->deadline, expiry);
 
 	/*
 	 * If the timer isn't already pending or this timeout is earlier
 	 * than an existing one, modify the timer. Round up to next nearest
 	 * second.
 	 */
-	expiry = blk_rq_timeout(round_jiffies_up(blk_rq_deadline(req)));
+	expiry = blk_rq_timeout(round_jiffies_up(expiry));
 
 	if (!timer_pending(&q->timeout) ||
 	    time_before(expiry, q->timeout.expires)) {
diff --git a/block/blk.h b/block/blk.h
index 41b64e6e101b..08a5845b03ba 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -238,26 +238,6 @@ void blk_account_io_start(struct request *req, bool new_io);
 void blk_account_io_completion(struct request *req, unsigned int bytes);
 void blk_account_io_done(struct request *req, u64 now);
 
-/*
- * EH timer and IO completion will both attempt to 'grab' the request, make
- * sure that only one of them succeeds. Steal the bottom bit of the
- * __deadline field for this.
- */
-static inline int blk_mark_rq_complete(struct request *rq)
-{
-	return test_and_set_bit(0, &rq->__deadline);
-}
-
-static inline void blk_clear_rq_complete(struct request *rq)
-{
-	clear_bit(0, &rq->__deadline);
-}
-
-static inline bool blk_rq_is_complete(struct request *rq)
-{
-	return test_bit(0, &rq->__deadline);
-}
-
 /*
  * Internal elevator interface
  */
@@ -322,21 +302,6 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 		q->last_merge = NULL;
 }
 
-/*
- * Steal a bit from this field for legacy IO path atomic IO marking. Note that
- * setting the deadline clears the bottom bit, potentially clearing the
- * completed bit. The user has to be OK with this (current ones are fine).
- */
-static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
-{
-	rq->__deadline = time & ~0x1UL;
-}
-
-static inline unsigned long blk_rq_deadline(struct request *rq)
-{
-	return rq->__deadline & ~0x1UL;
-}
-
 /*
  * Internal io_context interface
  */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c92aafcde0b8..1aa94759d219 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -224,9 +224,7 @@ struct request {
 	refcount_t ref;
 
 	unsigned int timeout;
-
-	/* access through blk_rq_set_deadline, blk_rq_deadline */
-	unsigned long __deadline;
+	unsigned long deadline;
 
 	union {
 		struct __call_single_data csd;
-- 
2.19.1
