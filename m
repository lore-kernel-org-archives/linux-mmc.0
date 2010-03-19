From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 13:47:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003191347230.31128@xanadu.home>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:61979 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0CSRsQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 13:48:16 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZJ00LZMIRZ9R60@VL-MO-MR003.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 19 Mar 2010 13:48:00 -0400 (EDT)
In-reply-to: <1269010320.31227.13.camel@e102109-lin.cambridge.arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

On Fri, 19 Mar 2010, Catalin Marinas wrote:

> > On Fri, Mar 19, 2010 at 02:41:17PM +0000, Catalin Marinas wrote:
> > > On Thu, 2010-03-18 at 13:20 +0000, Nicolas Pitre wrote:
> > > > The only way a highmem page can be unmapped is through kunmap_atomic()
> > > > where an explicit __cpuc_flush_dcache_area() is performed, or through
> > > > flush_all_zero_pkmaps() where flush_cache_kmaps() translates into
> > > > flush_cache_all().
> > >
> > > The thing that I couldn't fully understand with the kunmap_atomic()
> > > function is that there is a path (when kvaddr < FIXADDR_START) where no
> > > cache flushing occurs. Can this not happen?
> > 
> > kunmap interfaces are not for cache flushing; the cache flushing is
> > only there to ensure consistency when unmapping a mapping on VIVT CPUs.
> 
> I agree, but then why don't we conditionally call
> __cpuc_flush_dcache_area() in kunmap_atomic() so that we avoid this
> flush on non-aliasing VIPT?

We should indeed.


Nicolas
