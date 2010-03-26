From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] ARM: fix highmem with VIPT cache and DMA
Date: Fri, 26 Mar 2010 11:51:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003261144020.694@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
 <1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:40634 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0CZPwA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Mar 2010 11:52:00 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZW00DXCC2M9W40@VL-MO-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 26 Mar 2010 11:51:59 -0400 (EDT)
In-reply-to: <1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

On Fri, 26 Mar 2010, Catalin Marinas wrote:

> On Thu, 2010-03-25 at 21:02 +0000, Nicolas Pitre wrote:
> > --- a/arch/arm/include/asm/highmem.h
> > +++ b/arch/arm/include/asm/highmem.h
> > @@ -11,7 +11,11 @@
> > 
> >  #define kmap_prot              PAGE_KERNEL
> > 
> > -#define flush_cache_kmaps()    flush_cache_all()
> > +#define flush_cache_kmaps() \
> > +       do { \
> > +               if (cache_is_vivt()) \
> > +                       flush_cache_all(); \
> > +       } while (0)
> 
> Do the aliasing VIPT caches need flushing as well?

No idea.  Highmem is not supported with aliasing VIPT at the moment 
anyway -- see commit 3f973e2216.  I don't have hardware with aliasing 
VIPT cache either.


Nicolas
