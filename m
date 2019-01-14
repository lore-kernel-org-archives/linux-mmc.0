From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/11] dma-mapping: remove dma_max_pfn
Date: Mon, 14 Jan 2019 10:58:04 +0100
Message-ID: <20190114095804.27978-12-hch@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

These days the DMA mapping code must bounce buffer for any not supported
address, and if they driver needs to optimize for natively supported
ranged it should use dma_get_required_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h | 7 -------
 include/linux/dma-mapping.h        | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 31d3b96f0f4b..496b36b9a7ff 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -89,13 +89,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 }
 #endif
 
-/* The ARM override for dma_max_pfn() */
-static inline unsigned long dma_max_pfn(struct device *dev)
-{
-	return dma_to_pfn(dev, *dev->dma_mask);
-}
-#define dma_max_pfn(dev) dma_max_pfn(dev)
-
 #define arch_setup_dma_ops arch_setup_dma_ops
 extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			       const struct iommu_ops *iommu, bool coherent);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f6ded992c183..c6dbc287e466 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -710,13 +710,6 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
-#ifndef dma_max_pfn
-static inline unsigned long dma_max_pfn(struct device *dev)
-{
-	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
-}
-#endif
-
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
-- 
2.20.1
