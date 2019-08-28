From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v10 3/4] block: add a helper function to merge the segments
Date: Wed, 28 Aug 2019 21:35:42 +0900
Message-ID: <1566995743-5614-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1566995743-5614-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1566995743-5614-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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

This patch adds a helper function whether a queue can merge
the segments by the DMA MAP layer (e.g. via IOMMU).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
---
 block/blk-settings.c   | 23 +++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2c18312..c3632fc 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -12,6 +12,7 @@
 #include <linux/lcm.h>
 #include <linux/jiffies.h>
 #include <linux/gfp.h>
+#include <linux/dma-mapping.h>
 
 #include "blk.h"
 #include "blk-wbt.h"
@@ -832,6 +833,28 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
+/**
+ * blk_queue_can_use_dma_map_merging - configure queue for merging segments.
+ * @q:		the request queue for the device
+ * @dev:	the device pointer for dma
+ *
+ * Tell the block layer about merging the segments by dma map of @q.
+ */
+bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
+				       struct device *dev)
+{
+	unsigned long boundary = dma_get_merge_boundary(dev);
+
+	if (!boundary)
+		return false;
+
+	/* No need to update max_segment_size. see blk_queue_virt_boundary() */
+	blk_queue_virt_boundary(q, boundary);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
+
 static int __init blk_settings_init(void)
 {
 	blk_max_low_pfn = max_low_pfn - 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ac7901..d62d6e2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1086,6 +1086,8 @@ extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
+extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
+					      struct device *dev);
 
 /*
  * Number of physical segments as sent to the device.
-- 
2.7.4
