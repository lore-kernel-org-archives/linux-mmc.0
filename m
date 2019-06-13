From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead of a
	workaround
Date: Thu, 13 Jun 2019 19:20:14 +0900
Message-ID: <1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Since the commit 133d624b1cee ("dma: Introduce dma_max_mapping_size()")
provides a helper function to get the max mapping size, we can use
the function instead of the workaround code for swiotlb.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/mmc/host/tmio_mmc_core.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 130b91c..85bd6aa6 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -26,6 +26,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -1189,19 +1190,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	mmc->max_blk_size = TMIO_MAX_BLK_SIZE;
 	mmc->max_blk_count = pdata->max_blk_count ? :
 		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
-	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	/*
-	 * Since swiotlb has memory size limitation, this will calculate
-	 * the maximum size locally (because we don't have any APIs for it now)
-	 * and check the current max_req_size. And then, this will update
-	 * the max_req_size if needed as a workaround.
-	 */
-	if (swiotlb_max_segment()) {
-		unsigned int max_size = (1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
-
-		if (mmc->max_req_size > max_size)
-			mmc->max_req_size = max_size;
-	}
+	mmc->max_req_size = min_t(unsigned int,
+				  mmc->max_blk_size * mmc->max_blk_count,
+				  dma_max_mapping_size(&pdev->dev));
 	mmc->max_seg_size = mmc->max_req_size;
 
 	if (mmc_can_gpio_ro(mmc))
-- 
2.7.4
