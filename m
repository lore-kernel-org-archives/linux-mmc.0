From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 16:46:54 +0000
Message-ID: <1269017214.31227.117.camel@e102109-lin.cambridge.arm.com>
References: <20100319145417.GH21280@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:48556 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750716Ab0CSQr2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 12:47:28 -0400
In-Reply-To: <20100319145417.GH21280@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

On Fri, 2010-03-19 at 14:54 +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 19, 2010 at 02:52:00PM +0000, Catalin Marinas wrote:
> > > On Fri, Mar 19, 2010 at 02:41:17PM +0000, Catalin Marinas wrote:
> > > > On Thu, 2010-03-18 at 13:20 +0000, Nicolas Pitre wrote:
> > > > > The only way a highmem page can be unmapped is through kunmap_atomic()
> > > > > where an explicit __cpuc_flush_dcache_area() is performed, or through
> > > > > flush_all_zero_pkmaps() where flush_cache_kmaps() translates into
> > > > > flush_cache_all().
> > > >
> > > > The thing that I couldn't fully understand with the kunmap_atomic()
> > > > function is that there is a path (when kvaddr < FIXADDR_START) where no
> > > > cache flushing occurs. Can this not happen?
> > >
> > > kunmap interfaces are not for cache flushing; the cache flushing is
> > > only there to ensure consistency when unmapping a mapping on VIVT CPUs.
> >
> > I agree, but then why don't we conditionally call
> > __cpuc_flush_dcache_area() in kunmap_atomic() so that we avoid this
> > flush on non-aliasing VIPT?
> 
> Probably because highmem was written at the time for VIVT CPUs.  I'm sure
> Nicolas will accept patches to improve performance of highmem for VIPT.

See below for the VIPT case. But my initial question still remains for
VIVT caches - are all the cases covered?


ARM: Do not flush the cache in kunmap_atomic if non-aliasing VIPT

From: Catalin Marinas <catalin.marinas@arm.com>

If the cache is non-aliasing VIPT, there is no need to flush the D-cache
during kunmap_atomic().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mm/highmem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 2be1ec7..51c01a9 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -79,7 +79,8 @@ void kunmap_atomic(void *kvaddr, enum km_type type)
 	unsigned int idx = type + KM_TYPE_NR * smp_processor_id();
 
 	if (kvaddr >= (void *)FIXADDR_START) {
-		__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
+		if (!cache_is_vipt_nonaliasing())
+			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
 #ifdef CONFIG_DEBUG_HIGHMEM
 		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
 		set_pte_ext(TOP_PTE(vaddr), __pte(0), 0);


-- 
Catalin

