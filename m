From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 16:14:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003191600580.31128@xanadu.home>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
 <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
 <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
 <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
 <20100318092352.GD8267@n2100.arm.linux.org.uk>
 <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
 <20100318112453.GA19544@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1003180904440.31128@xanadu.home>
 <1269009677.31227.10.camel@e102109-lin.cambridge.arm.com>
 <20100319144647.GG21280@n2100.arm.linux.org.uk>
 <1269010320.31227.13.camel@e102109-lin.cambridge.arm.com>
 <alpine.LFD.2.00.1003191347230.31128@xanadu.home>
 <alpine.LFD.2.00.1003191359440.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:9521 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0CSUOR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 16:14:17 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZJ00G2JPJSMAX0@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 19 Mar 2010 16:14:16 -0400 (EDT)
In-reply-to: <alpine.LFD.2.00.1003191359440.31128@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

On Fri, 19 Mar 2010, Nicolas Pitre wrote:

> A highmem page can have 2 states: virtually mapped in the pkmap area, or 
> not mapped at all.  When it is mapped then page_address() returns a 
> valid virtual address for it.  In that case the cache for that mapping 
> can be valid, even dirty.  So the DMA API will perform cache handling 
> before/after the DMA operation.
> 
> However, before the page is unmapped, the VIVT cache has to be flushed 
> for that page.  This is why the DMA code currently doesn't bother doing 
> any L1 cache handling when a highmem page is not mapped -- the cache 
> just can't refer to such a page.
> 
> But on ARMv6 this is different.  The L1 cache is VIPT and it therefore 
> doesn't have to be flushed as often as a VIVT cache.  Still, as far as I 
> know, the highmem code currently always flush any page to be unmapped.  
> But somewhere somehow an unmapped highmem page becomes subject to DMA 
> and apparently can still be L1 cached.  But the DMA code doesn't flush 
> its cache due to the page not being mapped and then problems occur.

And here's a patch to test that hypothesis.  With this patch, all the 
issues with highmem on my ARMv6 system are gone.

Note this is suboptimal.  I still have to open my ARM ARM and see if we 
can do cache maintenance on the L1 cache using physical addresses to 
avoid the IRQ disable, PTE setup and TLB flush altogether.

Also, with this, a couple cache flushes elsewhere could be removed from 
the highmem code for VIPT caches.  But some of them are tricky and 
require more thoughts.

Oh and yes usage of KM_L2_CACHE in this IRQ disabled context is safe.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0da7ecc..79771b0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -22,8 +22,14 @@
 #include <asm/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/system.h>
+#include <asm/kmap_types.h>
+#include <asm/fixmap.h>
+#include <asm/pgtable.h>
 #include <asm/sizes.h>
 
+#include "mm.h"
+
 /* Sanity check size */
 #if (CONSISTENT_DMA_SIZE % SZ_2M)
 #error "CONSISTENT_DMA_SIZE must be multiple of 2MiB"
@@ -464,6 +470,18 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 				vaddr += offset;
 				op(vaddr, len, dir);
 				kunmap_high(page);
+			} else if (cache_is_vipt_nonaliasing()) {
+				unsigned long va, idx, pte, flags;
+				unsigned long pa = page_to_phys(page);
+				idx = KM_L2_CACHE + KM_TYPE_NR * smp_processor_id();
+				va = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+				pte = pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL);
+				local_irq_save(flags);
+				set_pte_ext(TOP_PTE(va), pte, 0);
+				local_flush_tlb_kernel_page(va);
+				vaddr = (void*)va + offset;
+				op(vaddr, len, dir);
+				local_irq_restore(flags);
 			}
 		} else {
 			vaddr = page_address(page) + offset;
