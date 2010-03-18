From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 19:00:06 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1003180904440.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33272 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab0CRNa2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 09:30:28 -0400
In-Reply-To: <alpine.LFD.2.00.1003180904440.31128@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "V, Hemanth" <hemanthv@ti.com>, saeed bishara <saeed.bishara@gmail.com>, "pierre@ossman.eu" <pierre@ossman.eu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-=
kernel-
> bounces@lists.infradead.org] On Behalf Of Nicolas Pitre
> Sent: Thursday, March 18, 2010 6:50 PM
> To: Russell King - ARM Linux
> Cc: linux-mmc@vger.kernel.org; V, Hemanth; saeed bishara; pierre@ossm=
an.eu; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: Highmem issues with MMC filesystem
>=20
> On Thu, 18 Mar 2010, Russell King - ARM Linux wrote:
>=20
> > On Thu, Mar 18, 2010 at 01:15:58PM +0200, saeed bishara wrote:
> > > >> The only conclusion I came to so far is that ARMv5 where highm=
em works
> > > >> just fine in all cases has VIVT cache whereas ARMv6 has VIPT c=
ache.
> > > >> And the problem with VIPT caches occurs when direct DMA is inv=
olved,
> > > >> otherwise there is no problem if PIO or NFS is used. =A0Sprink=
ling some
> > > >> flush_cache_all() in a few places makes things work, but this =
is not a
> > > >> satisfactory solution.
> > > >
> > > > This sounds like the problem we had with the DMA API. =A0Since =
that's now
> > > > fixed, there shouldn't be a problem with the latest (-rc) kerne=
ls, or
> > > > a kernel with my old streaming DMA patches applied.
> > > The failure happens also on 2.6.34.rc1,  as Nico said, it looks l=
ike
> > > that buffers that are subject to DMA remain dirty, as I understan=
d it,
> > > for vipt nonaliasing cpu's, the kernel doesn't clean user space c=
ache
> > > lines. if I force kmap_atomic/kunmap_atomic to highmem pages that=
 are
> > > not mapped by the kernel (kmap_high_get returns null), then the i=
ssue
> > > disappears.
> >
> > In no case does the kernel ever clean user space cache lines for DM=
A;
> > that's not the responsibility of the DMA API.
>=20
> Let's forget about user space.  Even some kernel space memory is
> affected too.
>=20
> The issue as I see it is that highmem pages being DMA'd to may be cac=
hed
> even when they're unmapped on VIPT machines.  And the DMA code perfor=
ms
> L1 cache maintenance only on pages which are virtually mapped.
>=20
> Contrary to VIVT caches which have to be flushed all the time, VIPT
> caches may avoid cache flushing in some cases, which may lead to some
> highmem pages not being mapped but still cached somehow.  But so far =
I
> just can't find how that could happen.
>=20
> The only way a highmem page can be unmapped is through kunmap_atomic(=
)
> where an explicit __cpuc_flush_dcache_area() is performed, or through
> flush_all_zero_pkmaps() where flush_cache_kmaps() translates into
> flush_cache_all().
>=20
> So something allows for some highmem pages to escape cache flushing w=
hen
> unmapped.  But I can't find it.
>=20
Or could it be that there is appropriate cacheflush happening but data =
gets
stuck in CPU writebuffers instead of reaching to main memory. In this c=
ase
too DMA won't see the contents and a barrier (dsb) is necessary to ensu=
re
that write buffer is drained before DMA takes over the buffer.

Regards,
Santosh
