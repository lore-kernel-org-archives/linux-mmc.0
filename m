From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 14:52:00 +0000
Message-ID: <1269010320.31227.13.camel@e102109-lin.cambridge.arm.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:65222 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139Ab0CSOwX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 10:52:23 -0400
In-Reply-To: <20100319144647.GG21280@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, Hemanth V <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

> On Fri, Mar 19, 2010 at 02:41:17PM +0000, Catalin Marinas wrote:
> > On Thu, 2010-03-18 at 13:20 +0000, Nicolas Pitre wrote:
> > > The only way a highmem page can be unmapped is through kunmap_atomic()
> > > where an explicit __cpuc_flush_dcache_area() is performed, or through
> > > flush_all_zero_pkmaps() where flush_cache_kmaps() translates into
> > > flush_cache_all().
> >
> > The thing that I couldn't fully understand with the kunmap_atomic()
> > function is that there is a path (when kvaddr < FIXADDR_START) where no
> > cache flushing occurs. Can this not happen?
> 
> kunmap interfaces are not for cache flushing; the cache flushing is
> only there to ensure consistency when unmapping a mapping on VIVT CPUs.

I agree, but then why don't we conditionally call
__cpuc_flush_dcache_area() in kunmap_atomic() so that we avoid this
flush on non-aliasing VIPT?

-- 
Catalin

