From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v7 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
Date: Thu, 20 Jun 2019 17:50:07 +0900
Message-ID: <1561020610-953-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

This patch adds a new dma_map_ops of get_merge_boundary() to
expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 205d694..9950cb5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1091,6 +1091,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return ret;
 }
 
+static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+
+	if (domain->type != IOMMU_DOMAIN_DMA)
+		return 0;	/* can't merge */
+
+	return (1 << __ffs(domain->pgsize_bitmap)) - 1;
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
@@ -1106,6 +1116,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
 	.map_resource		= iommu_dma_map_resource,
 	.unmap_resource		= iommu_dma_unmap_resource,
+	.get_merge_boundary	= iommu_dma_get_merge_boundary,
 };
 
 /*
-- 
2.7.4
