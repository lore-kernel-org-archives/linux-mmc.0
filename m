From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
Date: Tue, 21 Jun 2011 08:53:19 +0100
Message-ID: <20110621075319.GN26089@n2100.arm.linux.org.uk>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44303 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1FUHxd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 03:53:33 -0400
Content-Disposition: inline
In-Reply-To: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

On Sun, Jun 19, 2011 at 11:17:26PM +0200, Per Forlin wrote:
> How significant is the cache maintenance over head?

Per,

Can you measure how much difference this has before and after your
patch set please?  This moves the dsb() out of the individual cache
maintanence functions, such that we will only perform one dsb() per
dma_*_sg call rather than one per SG entry.

Thanks.

 arch/arm/include/asm/dma-mapping.h |   11 +++++++++++
 arch/arm/mm/cache-fa.S             |    6 ------
 arch/arm/mm/cache-v4wb.S           |    2 --
 arch/arm/mm/cache-v6.S             |    6 ------
 arch/arm/mm/cache-v7.S             |    3 ---
 arch/arm/mm/dma-mapping.c          |    8 ++++++++
 6 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 4fff837..853eba5 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -115,6 +115,11 @@ static inline void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 		___dma_page_dev_to_cpu(page, off, size, dir);
 }
 
+static inline void __dma_sync(void)
+{
+	dsb();
+}
+
 /*
  * Return whether the given device DMA address mask can be supported
  * properly.  For example, if your device can only drive the low 24-bits
@@ -378,6 +383,7 @@ static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
 	BUG_ON(!valid_dma_direction(dir));
 
 	addr = __dma_map_single(dev, cpu_addr, size, dir);
+	__dma_sync();
 	debug_dma_map_page(dev, virt_to_page(cpu_addr),
 			(unsigned long)cpu_addr & ~PAGE_MASK, size,
 			dir, addr, true);
@@ -407,6 +413,7 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 	BUG_ON(!valid_dma_direction(dir));
 
 	addr = __dma_map_page(dev, page, offset, size, dir);
+	__dma_sync();
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
 
 	return addr;
@@ -431,6 +438,7 @@ static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 {
 	debug_dma_unmap_page(dev, handle, size, dir, true);
 	__dma_unmap_single(dev, handle, size, dir);
+	__dma_sync();
 }
 
 /**
@@ -452,6 +460,7 @@ static inline void dma_unmap_page(struct device *dev, dma_addr_t handle,
 {
 	debug_dma_unmap_page(dev, handle, size, dir, false);
 	__dma_unmap_page(dev, handle, size, dir);
+	__dma_sync();
 }
 
 /**
@@ -484,6 +493,7 @@ static inline void dma_sync_single_range_for_cpu(struct device *dev,
 		return;
 
 	__dma_single_dev_to_cpu(dma_to_virt(dev, handle) + offset, size, dir);
+	__dma_sync();
 }
 
 static inline void dma_sync_single_range_for_device(struct device *dev,
@@ -498,6 +508,7 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 		return;
 
 	__dma_single_cpu_to_dev(dma_to_virt(dev, handle) + offset, size, dir);
+	__dma_sync();
 }
 
 static inline void dma_sync_single_for_cpu(struct device *dev,
diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 1fa6f71..6eeb734 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -179,8 +179,6 @@ fa_dma_inv_range:
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
@@ -197,8 +195,6 @@ fa_dma_clean_range:
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mov	r0, #0	
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
@@ -212,8 +208,6 @@ ENTRY(fa_dma_flush_range)
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mov	r0, #0	
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index f40c696..523c0cb 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -194,7 +194,6 @@ v4wb_dma_inv_range:
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
@@ -211,7 +210,6 @@ v4wb_dma_clean_range:
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 73b4a8b..7a842dd 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -239,8 +239,6 @@ v6_dma_inv_range:
 	strlo	r2, [r0]			@ write for ownership
 #endif
 	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
@@ -262,8 +260,6 @@ v6_dma_clean_range:
 	add	r0, r0, #D_CACHE_LINE_SIZE
 	cmp	r0, r1
 	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
@@ -290,8 +286,6 @@ ENTRY(v6_dma_flush_range)
 	strlob	r2, [r0]			@ write for ownership
 #endif
 	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index d32f02b..18dcef6 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -257,7 +257,6 @@ v7_dma_inv_range:
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
 	mov	pc, lr
 ENDPROC(v7_dma_inv_range)
 
@@ -275,7 +274,6 @@ v7_dma_clean_range:
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
 	mov	pc, lr
 ENDPROC(v7_dma_clean_range)
 
@@ -293,7 +291,6 @@ ENTRY(v7_dma_flush_range)
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
 	mov	pc, lr
 ENDPROC(v7_dma_flush_range)
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 82a093c..042b056 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -97,6 +97,7 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
 	memset(ptr, 0, size);
 	dmac_flush_range(ptr, ptr + size);
 	outer_flush_range(__pa(ptr), __pa(ptr) + size);
+	__dma_sync();
 
 	return page;
 }
@@ -572,6 +573,7 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		if (dma_mapping_error(dev, s->dma_address))
 			goto bad_mapping;
 	}
+	__dma_sync();
 	debug_dma_map_sg(dev, sg, nents, nents, dir);
 	return nents;
 
@@ -602,6 +604,8 @@ void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 	for_each_sg(sg, s, nents, i)
 		__dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
+
+	__dma_sync();
 }
 EXPORT_SYMBOL(dma_unmap_sg);
 
@@ -627,6 +631,8 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 				      s->length, dir);
 	}
 
+	__dma_sync();
+
 	debug_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 }
 EXPORT_SYMBOL(dma_sync_sg_for_cpu);
@@ -653,6 +659,8 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 				      s->length, dir);
 	}
 
+	__dma_sync();
+
 	debug_dma_sync_sg_for_device(dev, sg, nents, dir);
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);

