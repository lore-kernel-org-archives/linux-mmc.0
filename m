From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v7 5/5] mmc: queue: Use bigger segments if DMA MAP layer
	can merge the segments
Date: Thu, 20 Jun 2019 17:50:10 +0900
Message-ID: <1561020610-953-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

When the max_segs of a mmc host is smaller than 512, the mmc
subsystem tries to use 512 segments if DMA MAP layer can merge
the segments, and then the mmc subsystem exposes such information
to the block layer by using blk_queue_can_use_dma_map_merging().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/mmc/core/queue.c | 35 ++++++++++++++++++++++++++++++++---
 include/linux/mmc/host.h |  1 +
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 92900a0..ab0ecc6 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -24,6 +24,8 @@
 #include "card.h"
 #include "host.h"
 
+#define MMC_DMA_MAP_MERGE_SEGMENTS	512
+
 static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
 {
 	/* Allow only 1 DCMD at a time */
@@ -196,6 +198,12 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
 }
 
+static unsigned int mmc_get_max_segments(struct mmc_host *host)
+{
+	return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
+					 host->max_segs;
+}
+
 /**
  * mmc_init_request() - initialize the MMC-specific per-request data
  * @q: the request queue
@@ -209,7 +217,7 @@ static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 
-	mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
+	mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), gfp);
 	if (!mq_rq->sg)
 		return -ENOMEM;
 
@@ -368,13 +376,23 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	blk_queue_bounce_limit(mq->queue, limit);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
-	blk_queue_max_segments(mq->queue, host->max_segs);
+	if (host->can_dma_map_merge)
+		WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
+							mmc_dev(host)),
+		     "merging was advertised but not possible");
+	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
 
 	if (mmc_card_mmc(card))
 		block_size = card->ext_csd.data_sector_size;
 
 	blk_queue_logical_block_size(mq->queue, block_size);
-	blk_queue_max_segment_size(mq->queue,
+	/*
+	 * After blk_queue_can_use_dma_map_merging() was called with succeed,
+	 * since it calls blk_queue_virt_boundary(), the mmc should not call
+	 * both blk_queue_max_segment_size().
+	 */
+	if (host->can_dma_map_merge)
+		blk_queue_max_segment_size(mq->queue,
 			round_down(host->max_seg_size, block_size));
 
 	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
@@ -424,6 +442,17 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
 	mq->tag_set.driver_data = mq;
 
+	/*
+	 * Since blk_mq_alloc_tag_set() calls .init_request() of mmc_mq_ops,
+	 * the host->can_dma_map_merge should be set before to get max_segs
+	 * from mmc_get_max_segments().
+	 */
+	if (host->max_segs < MMC_DMA_MAP_MERGE_SEGMENTS &&
+	    dma_get_merge_boundary(mmc_dev(host)))
+		host->can_dma_map_merge = 1;
+	else
+		host->can_dma_map_merge = 0;
+
 	ret = blk_mq_alloc_tag_set(&mq->tag_set);
 	if (ret)
 		return ret;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 43d0f0c..10c3719 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -398,6 +398,7 @@ struct mmc_host {
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		use_blk_mq:1;	/* use blk-mq */
+	unsigned int		can_dma_map_merge:1; /* merging can be used */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.7.4
