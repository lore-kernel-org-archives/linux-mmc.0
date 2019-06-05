From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Date: Wed,  5 Jun 2019 20:11:49 +0900
Message-ID: <1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This patch adds a new capable IOMMU_CAP_MERGING to check whether
the IOVA would be contiguous strictly if a device requires and
the IOMMU driver has the capable.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++++++--
 include/linux/iommu.h     |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 034caae..ecf1a04 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -847,11 +847,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
-	int i;
+	int i, ret;
+	bool iova_contiguous = false;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
+	if (dma_get_iova_contiguous(dev) &&
+	    iommu_capable(dev->bus, IOMMU_CAP_MERGING))
+		iova_contiguous = true;
+
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
@@ -867,6 +872,13 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		sg_dma_len(s) = s_length;
 		s->offset -= s_iova_off;
 		s_length = iova_align(iovad, s_length + s_iova_off);
+		/*
+		 * Check whether the IOVA would be contiguous strictly if
+		 * a device requires and the IOMMU driver has the capable.
+		 */
+		if (iova_contiguous && i > 0 &&
+		    (s_iova_off || s->length != s_length))
+			return 0;
 		s->length = s_length;
 
 		/*
@@ -902,8 +914,18 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (iommu_map_sg(domain, iova, sg, nents, prot) < iova_len)
 		goto out_free_iova;
 
-	return __finalise_sg(dev, sg, nents, iova);
+	ret = __finalise_sg(dev, sg, nents, iova);
+	/*
+	 * Check whether the sg entry is single if a device requires and
+	 * the IOMMU driver has the capable.
+	 */
+	if (iova_contiguous && ret != 1)
+		goto out_unmap_sg;
+
+	return ret;
 
+out_unmap_sg:
+	iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
 out_free_iova:
 	iommu_dma_free_iova(cookie, iova, iova_len);
 out_restore_sg:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 91af22a..f971dd3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -104,6 +104,7 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_MERGING,		/* IOMMU supports segments merging */
 };
 
 /*
-- 
2.7.4
