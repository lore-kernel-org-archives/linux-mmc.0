From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 14:27:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003191359440.31128@xanadu.home>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:34568 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0CSS1k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 14:27:40 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZJ00JTKKLOI6O0@VL-MO-MR005.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 19 Mar 2010 14:27:24 -0400 (EDT)
In-reply-to: <alpine.LFD.2.00.1003191347230.31128@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

On Fri, 19 Mar 2010, Nicolas Pitre wrote:

> On Fri, 19 Mar 2010, Catalin Marinas wrote:
> 
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
> We should indeed.

Wait...  This is actually going to make the issue even worse.

Not that this isn't a good idea, but here's how the system works at the 
moment with highmem.

A highmem page can have 2 states: virtually mapped in the pkmap area, or 
not mapped at all.  When it is mapped then page_address() returns a 
valid virtual address for it.  In that case the cache for that mapping 
can be valid, even dirty.  So the DMA API will perform cache handling 
before/after the DMA operation.

However, before the page is unmapped, the VIVT cache has to be flushed 
for that page.  This is why the DMA code currently doesn't bother doing 
any L1 cache handling when a highmem page is not mapped -- the cache 
just can't refer to such a page.

But on ARMv6 this is different.  The L1 cache is VIPT and it therefore 
doesn't have to be flushed as often as a VIVT cache.  Still, as far as I 
know, the highmem code currently always flush any page to be unmapped.  
But somewhere somehow an unmapped highmem page becomes subject to DMA 
and apparently can still be L1 cached.  But the DMA code doesn't flush 
its cache due to the page not being mapped and then problems occur.

Two solutions:

1) We find the remaining places where highmem pages may get unmapped and 
   make sure the cache for them is always flushed at that point.  This 
   is most likely when some highmem pages are removed from a user space 
   process or the like.

2) We stop flushing the cache for highmem pages when they get unmapped 
   on VIPT systems. This includes kunmap_atomic() and flush_cache_kmaps().
   However that means that we need a way to flush the cache for unmapped
   highmem pages, preferably using physical addresses since by vertue of 
   not being mapped they don't have any kernel virtual address attached 
   to them (is that possible?).


Nicolas
