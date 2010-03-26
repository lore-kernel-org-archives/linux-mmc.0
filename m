From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: fix highmem with VIPT cache and DMA
Date: Fri, 26 Mar 2010 23:09:39 +0000
Message-ID: <20100326230939.GF29179@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home> <1269610458.807.49.camel@e102109-lin.cambridge.arm.com> <alpine.LFD.2.00.1003261144020.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46955 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab0CZXJ4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Mar 2010 19:09:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003261144020.694@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Hemanth V <hemanthv@ti.com>, linux-mmc@vger.kernel.org, pierre@ossman.eu, saeed bishara <saeed.bishara@gmail.com>, linux-arm-kernel@lists.infradead.org

On Fri, Mar 26, 2010 at 11:51:58AM -0400, Nicolas Pitre wrote:
> On Fri, 26 Mar 2010, Catalin Marinas wrote:
> 
> > On Thu, 2010-03-25 at 21:02 +0000, Nicolas Pitre wrote:
> > > --- a/arch/arm/include/asm/highmem.h
> > > +++ b/arch/arm/include/asm/highmem.h
> > > @@ -11,7 +11,11 @@
> > > 
> > >  #define kmap_prot              PAGE_KERNEL
> > > 
> > > -#define flush_cache_kmaps()    flush_cache_all()
> > > +#define flush_cache_kmaps() \
> > > +       do { \
> > > +               if (cache_is_vivt()) \
> > > +                       flush_cache_all(); \
> > > +       } while (0)
> > 
> > Do the aliasing VIPT caches need flushing as well?
> 
> No idea.  Highmem is not supported with aliasing VIPT at the moment 
> anyway -- see commit 3f973e2216.  I don't have hardware with aliasing 
> VIPT cache either.

I don't think we'll ever support aliasing VIPT caches with highmem -
it'd quadruple the amount of kmap space that's required for things like
KM_USER*.
