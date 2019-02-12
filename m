From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/14] scatterlist: add sg_kmap_atomic / sg_kunmap_atomic
 helpers
Date: Tue, 12 Feb 2019 08:25:15 +0100
Message-ID: <20190212072528.13167-2-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This avoids bug prone open coding of the sg offset handling and
also helps to document the limitations of mapping scatterlist
entries.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/scatterlist.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b96f0d0b5b8f..524cd8448a48 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCATTERLIST_H
 #define _LINUX_SCATTERLIST_H
 
+#include <linux/highmem.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/bug.h>
@@ -239,6 +240,31 @@ static inline void *sg_virt(struct scatterlist *sg)
 	return page_address(sg_page(sg)) + sg->offset;
 }
 
+/**
+ * sg_kmap_atomic - map a S/G list entry to a kernel address
+ * @sg:		scatterlist entry
+ *
+ * Return a kernel address for scatterlist entry by kmapping it.  Note that
+ * this function must only be called on scatterlist entries that do not span
+ * multiple pages.
+ */
+static inline void *sg_kmap_atomic(struct scatterlist *sg)
+{
+	if (WARN_ON_ONCE(sg->offset + sg->length > PAGE_SIZE))
+		return NULL;
+	return kmap_atomic(sg_page(sg)) + sg->offset;
+}
+
+/**
+ * sg_kunmap_atomic - unmap a S/G list entry to a kernel address
+ * @sg:		scatterlist entry
+ * @ptr:	address returned from sg_kmap_atomic
+ */
+static inline void sg_kunmap_atomic(struct scatterlist *sg, void *ptr)
+{
+	kunmap_atomic(ptr - sg->offset);
+}
+
 /**
  * sg_init_marker - Initialize markers in sg table
  * @sgl:	   The SG table
-- 
2.20.1
