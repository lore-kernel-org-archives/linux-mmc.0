From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 1/7] blk-mq: Export blk_mq_hctx_has_pending() function
Date: Mon, 22 Jul 2019 21:09:36 +0800
Message-ID: <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Some SD/MMC host controllers can support packed command or packed request,
that means we can package several requests to host controller at one time
to improve performence. And this patch set will introduce MMC packed function
to support this feature by following patches.

To support MMC packed function, the MMC layer need to know if there are
requests are pending now in hardware queue to help to combine requests
as much as possible. If we know there are requests pending in hardware
queue, then we should not package requests to host controller immediately,
instead we should collect more requests into MMC packed queue to be packed
to host controller with packed condition.

Thus export this function for MMC packed function.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 block/blk-mq.c         |    3 ++-
 include/linux/blk-mq.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec6..5bd4ef9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
  */
-static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
 	return !list_empty_careful(&hctx->dispatch) ||
 		sbitmap_any_bit_set(&hctx->ctx_map) ||
 			blk_mq_sched_has_work(hctx);
 }
+EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);
 
 /*
  * Mark this ctx as having pending work in this hardware queue
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3fa1fa5..15a2b7b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -334,6 +334,7 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
 
 /*
  * Driver command data is immediately after the request. So subtract request
-- 
1.7.9.5
