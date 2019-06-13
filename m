From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v6 1/5] iommu: add an exported function to get minimum
	page size for a domain
Date: Thu, 13 Jun 2019 19:20:11 +0900
Message-ID: <1560421215-10750-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

This patch adds an exported function to get minimum page size for
a domain. This patch also modifies similar codes on the iommu.c.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/iommu.c | 18 +++++++++++++++---
 include/linux/iommu.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2a90638..7ed16af 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -280,6 +280,18 @@ iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
 	return ret;
 }
 
+/**
+ * iommu_get_minimum_page_size - get minimum page size for a domain
+ * @domain: the domain
+ *
+ * Allow iommu driver to get a minimum page size for a domain.
+ */
+unsigned long iommu_get_minimum_page_size(struct iommu_domain *domain)
+{
+	return 1UL << __ffs(domain->pgsize_bitmap);
+}
+EXPORT_SYMBOL_GPL(iommu_get_minimum_page_size);
+
 int iommu_get_group_resv_regions(struct iommu_group *group,
 				 struct list_head *head)
 {
@@ -558,7 +570,7 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 
 	BUG_ON(!domain->pgsize_bitmap);
 
-	pg_size = 1UL << __ffs(domain->pgsize_bitmap);
+	pg_size = iommu_get_minimum_page_size(domain);
 	INIT_LIST_HEAD(&mappings);
 
 	iommu_get_resv_regions(dev, &mappings);
@@ -1595,7 +1607,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		return -EINVAL;
 
 	/* find out the minimum page size supported */
-	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	min_pagesz = iommu_get_minimum_page_size(domain);
 
 	/*
 	 * both the virtual address and the physical one, as well as
@@ -1655,7 +1667,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 		return 0;
 
 	/* find out the minimum page size supported */
-	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	min_pagesz = iommu_get_minimum_page_size(domain);
 
 	/*
 	 * The virtual address, as well as the size of the mapping, must be
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 91af22a..7e53b43 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -366,6 +366,7 @@ extern int iommu_request_dma_domain_for_dev(struct device *dev);
 extern struct iommu_resv_region *
 iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
 			enum iommu_resv_type type);
+extern unsigned long iommu_get_minimum_page_size(struct iommu_domain *domain);
 extern int iommu_get_group_resv_regions(struct iommu_group *group,
 					struct list_head *head);
 
-- 
2.7.4
