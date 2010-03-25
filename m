From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
Date: Thu, 25 Mar 2010 17:02:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:62586 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899Ab0CYVDA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Mar 2010 17:03:00 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZU006GMVS6Y720@VL-MR-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 25 Mar 2010 17:02:32 -0400 (EDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org


The VIVT cache of a highmem page is always flushed before the page
is unmapped.  This cache flush is explicit through flush_cache_kmaps()
in flush_all_zero_pkmaps(), or through __cpuc_flush_dcache_area() in
kunmap_atomic().  There is also an implicit flush of those highmem pages
that were part of a process that just terminated making those pages free
as the whole VIVT cache has to be flushed on every task switch. Hence
unmapped highmem pages need no cache maintenance in that case.

However unmapped pages may still be cached with a VIPT cache because the
cache is tagged with physical addresses.  There is no need for a whole
cache flush during task switching for that reason, and despite the
explicit cache flushes in flush_all_zero_pkmaps() and kunmap_atomic(),
some highmem pages that were mapped in user space end up still cached
even when they become unmapped.

So, we do have to perform cache maintenance on those unmapped highmem
pages in the context of DMA when using a VIPT cache.  Unfortunately,
it is not possible to perform that cache maintenance using physical
addresses as all the L1 cache maintenance coprocessor functions accept
virtual addresses only.  Therefore we have no choice but to set up a
temporary virtual mapping for that purpose.

And of course the explicit cache flushing when unmapping a highmem page
on a system with a VIPT cache now can go, which should increase
performance.

While at it, because the code in __flush_dcache_page() has to be modified
anyway, let's also make sure the mapped highmem pages are pinned with
kmap_high_get() for the duration of the cache maintenance operation.
Because kunmap() does unmap highmem pages lazily, it was reported by
Gary King <GKing@nvidia.com> that those pages ended up being unmapped
during cache maintenance on SMP causing segmentation faults.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
---
 arch/arm/include/asm/highmem.h    |   15 +++++-
 arch/arm/include/asm/kmap_types.h |    1 +
 arch/arm/mm/copypage-v6.c         |    9 +---
 arch/arm/mm/dma-mapping.c         |    5 ++
 arch/arm/mm/flush.c               |   25 +++++----
 arch/arm/mm/highmem.c             |   87 ++++++++++++++++++++++++++++++-
 6 files changed, 122 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index 7f36d00..feb988a 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -11,7 +11,11 @@
 
 #define kmap_prot		PAGE_KERNEL
 
-#define flush_cache_kmaps()	flush_cache_all()
+#define flush_cache_kmaps() \
+	do { \
+		if (cache_is_vivt()) \
+			flush_cache_all(); \
+	} while (0)
 
 extern pte_t *pkmap_page_table;
 
@@ -21,11 +25,20 @@ extern void *kmap_high(struct page *page);
 extern void *kmap_high_get(struct page *page);
 extern void kunmap_high(struct page *page);
 
+extern void *kmap_high_l1_vipt(struct page *page, pte_t *saved_pte);
+extern void kunmap_high_l1_vipt(struct page *page, pte_t saved_pte);
+
+/*
+ * The following functions are already defined by <linux/highmem.h>
+ * when CONFIG_HIGHMEM is not set.
+ */
+#ifdef CONFIG_HIGHMEM
 extern void *kmap(struct page *page);
 extern void kunmap(struct page *page);
 extern void *kmap_atomic(struct page *page, enum km_type type);
 extern void kunmap_atomic(void *kvaddr, enum km_type type);
 extern void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
 extern struct page *kmap_atomic_to_page(const void *ptr);
+#endif
 
 #endif
diff --git a/arch/arm/include/asm/kmap_types.h b/arch/arm/include/asm/kmap_types.h
index c019949..c4b2ea3 100644
--- a/arch/arm/include/asm/kmap_types.h
+++ b/arch/arm/include/asm/kmap_types.h
@@ -18,6 +18,7 @@ enum km_type {
 	KM_IRQ1,
 	KM_SOFTIRQ0,
 	KM_SOFTIRQ1,
+	KM_L1_CACHE,
 	KM_L2_CACHE,
 	KM_TYPE_NR
 };
diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index 8bca4de..f55fa10 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -41,14 +41,7 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
 	kfrom = kmap_atomic(from, KM_USER0);
 	kto = kmap_atomic(to, KM_USER1);
 	copy_page(kto, kfrom);
-#ifdef CONFIG_HIGHMEM
-	/*
-	 * kmap_atomic() doesn't set the page virtual address, and
-	 * kunmap_atomic() takes care of cache flushing already.
-	 */
-	if (page_address(to) != NULL)
-#endif
-		__cpuc_flush_dcache_area(kto, PAGE_SIZE);
+	__cpuc_flush_dcache_area(kto, PAGE_SIZE);
 	kunmap_atomic(kto, KM_USER1);
 	kunmap_atomic(kfrom, KM_USER0);
 }
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0da7ecc..e955dc4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -464,6 +464,11 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 				vaddr += offset;
 				op(vaddr, len, dir);
 				kunmap_high(page);
+			} else if (cache_is_vipt()) {
+				pte_t saved_pte;
+				vaddr = kmap_high_l1_vipt(page, &saved_pte);
+				op(vaddr + offset, len, dir);
+				kunmap_high_l1_vipt(page, saved_pte);
 			}
 		} else {
 			vaddr = page_address(page) + offset;
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index e34f095..c6844cb 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -13,6 +13,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
+#include <asm/highmem.h>
 #include <asm/smp_plat.h>
 #include <asm/system.h>
 #include <asm/tlbflush.h>
@@ -152,21 +153,25 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 
 void __flush_dcache_page(struct address_space *mapping, struct page *page)
 {
-	void *addr = page_address(page);
-
 	/*
 	 * Writeback any data associated with the kernel mapping of this
 	 * page.  This ensures that data in the physical page is mutually
 	 * coherent with the kernels mapping.
 	 */
-#ifdef CONFIG_HIGHMEM
-	/*
-	 * kmap_atomic() doesn't set the page virtual address, and
-	 * kunmap_atomic() takes care of cache flushing already.
-	 */
-	if (addr)
-#endif
-		__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+	if (!PageHighMem(page)) {
+		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+	} else {
+		void *addr = kmap_high_get(page);
+		if (addr) {
+			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+			kunmap_high(page);
+		} else if (cache_is_vipt()) {
+			pte_t saved_pte;
+			addr = kmap_high_l1_vipt(page, &saved_pte);
+			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+			kunmap_high_l1_vipt(page, saved_pte);
+		}
+	}
 
 	/*
 	 * If this is a page cache page, and we have an aliasing VIPT cache,
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 2be1ec7..77b030f 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -79,7 +79,8 @@ void kunmap_atomic(void *kvaddr, enum km_type type)
 	unsigned int idx = type + KM_TYPE_NR * smp_processor_id();
 
 	if (kvaddr >= (void *)FIXADDR_START) {
-		__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
+		if (cache_is_vivt())
+			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
 #ifdef CONFIG_DEBUG_HIGHMEM
 		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
 		set_pte_ext(TOP_PTE(vaddr), __pte(0), 0);
@@ -124,3 +125,87 @@ struct page *kmap_atomic_to_page(const void *ptr)
 	pte = TOP_PTE(vaddr);
 	return pte_page(*pte);
 }
+
+#ifdef CONFIG_CPU_CACHE_VIPT
+
+#include <linux/percpu.h>
+
+/*
+ * The VIVT cache of a highmem page is always flushed before the page
+ * is unmapped. Hence unmapped highmem pages need no cache maintenance
+ * in that case.
+ *
+ * However unmapped pages may still be cached with a VIPT cache, and
+ * it is not possible to perform cache maintenance on them using physical
+ * addresses unfortunately.  So we have no choice but to set up a temporary
+ * virtual mapping for that purpose.
+ *
+ * Yet this VIPT cache maintenance may be triggered from DMA support
+ * functions which are possibly called from interrupt context. As we don't
+ * want to keep interrupt disabled all the time when such maintenance is
+ * taking place, we therefore allow for some reentrancy by preserving and
+ * restoring the previous fixmap entry before the interrupted context is
+ * resumed.  If the reentrancy depth is 0 then there is no need to restore
+ * the previous fixmap, and leaving the current one in place allow it to
+ * be reused the next time without a TLB flush (common with DMA).
+ */
+
+static DEFINE_PER_CPU(int, kmap_high_l1_vipt_depth);
+
+void *kmap_high_l1_vipt(struct page *page, pte_t *saved_pte)
+{
+	unsigned int idx, cpu = smp_processor_id();
+	int *depth = &per_cpu(kmap_high_l1_vipt_depth, cpu);
+	unsigned long vaddr, flags;
+	pte_t pte, *ptep;
+
+	idx = KM_L1_CACHE + KM_TYPE_NR * cpu;
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	ptep = TOP_PTE(vaddr);
+	pte = mk_pte(page, kmap_prot);
+
+	if (!in_interrupt())
+		preempt_disable();
+
+	raw_local_irq_save(flags);
+	(*depth)++;
+	if (pte_val(*ptep) == pte_val(pte)) {
+		*saved_pte = pte;
+	} else {
+		*saved_pte = *ptep;
+		set_pte_ext(ptep, pte, 0);
+		local_flush_tlb_kernel_page(vaddr);
+	}
+	raw_local_irq_restore(flags);
+
+	return (void *)vaddr;
+}
+
+void kunmap_high_l1_vipt(struct page *page, pte_t saved_pte)
+{
+	unsigned int idx, cpu = smp_processor_id();
+	int *depth = &per_cpu(kmap_high_l1_vipt_depth, cpu);
+	unsigned long vaddr, flags;
+	pte_t pte, *ptep;
+
+	idx = KM_L1_CACHE + KM_TYPE_NR * cpu;
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	ptep = TOP_PTE(vaddr);
+	pte = mk_pte(page, kmap_prot);
+
+	BUG_ON(pte_val(*ptep) != pte_val(pte));
+	BUG_ON(*depth <= 0);
+
+	raw_local_irq_save(flags);
+	(*depth)--;
+	if (*depth != 0 && pte_val(pte) != pte_val(saved_pte)) {
+		set_pte_ext(ptep, saved_pte, 0);
+		local_flush_tlb_kernel_page(vaddr);
+	}
+	raw_local_irq_restore(flags);
+
+	if (!in_interrupt())
+		preempt_enable();
+}
+
+#endif  /* CONFIG_CPU_CACHE_VIPT */


Nicolas
