From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v5 1/8] dma-mapping: add a device driver helper for iova
	contiguous
Date: Wed,  5 Jun 2019 20:11:47 +0900
Message-ID: <1559733114-4221-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

This API can set a flag whether a device requires iova contiguous
strictly.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index e85264f..a33d611 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -752,6 +752,7 @@ struct device_dma_parameters {
 	 */
 	unsigned int max_segment_size;
 	unsigned long segment_boundary_mask;
+	bool iova_contiguous;
 };
 
 /**
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6309a72..cdb4e75 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -729,6 +729,22 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+static inline int dma_get_iova_contiguous(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->iova_contiguous;
+	return false;
+}
+
+static inline int dma_set_iova_contiguous(struct device *dev, bool contiguous)
+{
+	if (dev->dma_parms) {
+		dev->dma_parms->iova_contiguous = contiguous;
+		return 0;
+	}
+	return -EIO;
+}
+
 #ifndef dma_max_pfn
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
-- 
2.7.4
