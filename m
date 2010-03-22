From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Mon, 22 Mar 2010 08:50:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003220847380.31128@xanadu.home>
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
	<alpine.LFD.2.00.1003191600580.31128@xanadu.home>
	<13544.10.24.255.18.1269248733.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <13544.10.24.255.18.1269248733.squirrel@dbdmail.itg.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hemanth V <hemanthv@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, pierre@ossman.eu, saeed bishara <saeed.bishara@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 22 Mar 2010, Hemanth V wrote:

> > On Fri, 19 Mar 2010, Nicolas Pitre wrote:
> >
> >> A highmem page can have 2 states: virtually mapped in the pkmap area, or
> >> not mapped at all.  When it is mapped then page_address() returns a
> >> valid virtual address for it.  In that case the cache for that mapping
> >> can be valid, even dirty.  So the DMA API will perform cache handling
> >> before/after the DMA operation.
> >>
> >> However, before the page is unmapped, the VIVT cache has to be flushed
> >> for that page.  This is why the DMA code currently doesn't bother doing
> >> any L1 cache handling when a highmem page is not mapped -- the cache
> >> just can't refer to such a page.
> >>
> >> But on ARMv6 this is different.  The L1 cache is VIPT and it therefore
> >> doesn't have to be flushed as often as a VIVT cache.  Still, as far as I
> >> know, the highmem code currently always flush any page to be unmapped.
> >> But somewhere somehow an unmapped highmem page becomes subject to DMA
> >> and apparently can still be L1 cached.  But the DMA code doesn't flush
> >> its cache due to the page not being mapped and then problems occur.
> >
> > And here's a patch to test that hypothesis.  With this patch, all the
> > issues with highmem on my ARMv6 system are gone.
> >
> 
> Modified version of this patch also solves the problem for 2.6.32-rc7
> on ARM v7.

OK thanks for testing.  I'll work on a proper patch now.


Nicolas
