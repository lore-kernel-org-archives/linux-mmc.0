From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 11:24:54 +0000
Message-ID: <20100318112453.GA19544@n2100.arm.linux.org.uk>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003170946250.31128@xanadu.home> <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003171050160.31128@xanadu.home> <20100318092352.GD8267@n2100.arm.linux.org.uk> <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33151 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab0CRLZN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 07:25:13 -0400
Content-Disposition: inline
In-Reply-To: <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Hemanth V <hemanthv@ti.com>, linux-mmc@vger.kernel.org, pierre@ossman.eu, linux-arm-kernel@lists.infradead.org

On Thu, Mar 18, 2010 at 01:15:58PM +0200, saeed bishara wrote:
> >> The only conclusion I came to so far is that ARMv5 where highmem w=
orks
> >> just fine in all cases has VIVT cache whereas ARMv6 has VIPT cache=
=2E
> >> And the problem with VIPT caches occurs when direct DMA is involve=
d,
> >> otherwise there is no problem if PIO or NFS is used. =A0Sprinkling=
 some
> >> flush_cache_all() in a few places makes things work, but this is n=
ot a
> >> satisfactory solution.
> >
> > This sounds like the problem we had with the DMA API. =A0Since that=
's now
> > fixed, there shouldn't be a problem with the latest (-rc) kernels, =
or
> > a kernel with my old streaming DMA patches applied.
> The failure happens also on 2.6.34.rc1,  as Nico said, it looks like
> that buffers that are subject to DMA remain dirty, as I understand it=
,
> for vipt nonaliasing cpu's, the kernel doesn't clean user space cache
> lines. if I force kmap_atomic/kunmap_atomic to highmem pages that are
> not mapped by the kernel (kmap_high_get returns null), then the issue
> disappears.

In no case does the kernel ever clean user space cache lines for DMA;
that's not the responsibility of the DMA API.
