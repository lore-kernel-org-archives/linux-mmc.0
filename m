From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Wed, 17 Mar 2010 10:58:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
 <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
 <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:20849 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab0CQO6t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Mar 2010 10:58:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZF004IMLM0VQE0@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 17 Mar 2010 10:58:49 -0400 (EDT)
In-reply-to: <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, pierre@ossman.eu

On Wed, 17 Mar 2010, Hemanth V wrote:

> 
> ----- Original Message ----- From: "Nicolas Pitre" <nico@fluxnic.net>
> To: "Hemanth V" <hemanthv@ti.com>
> Cc: <linux-mmc@vger.kernel.org>; <pierre@ossman.eu>
> Sent: Wednesday, March 17, 2010 7:19 PM
> Subject: Re: Highmem issues with MMC filesystem
> 
> 
> > On Wed, 17 Mar 2010, Hemanth V wrote:
> > 
> > > Hi All,
> > > 
> > > We are trying to enable highmem support for OMAP based boards, while doing
> > > so
> > > we are
> > > unable to boot poky UI if the filesystem is in a MMC card.
> > > 
> > > The poky UI comes up fine if the filesystem is in NAND or NFS,
> > > while with MMC it gives errors like segmentation faults/syntax error while
> > > there are none.
> > > Seems like read from MMC is getting corrupted.
> > 
> > Yes, this is a known issue with highmem on ARM architectures v6 and
> > later, related to some cache mishandling.  This is not a MMC issue as
> > the problem occurs when booting from SATA too. The problem is still
> > investigated.
> > 
> 
> Nicolas, Russel are there any more details available which might help
> in investigating this further.

The only conclusion I came to so far is that ARMv5 where highmem works 
just fine in all cases has VIVT cache whereas ARMv6 has VIPT cache.  
And the problem with VIPT caches occurs when direct DMA is involved, 
otherwise there is no problem if PIO or NFS is used.  Sprinkling some 
flush_cache_all() in a few places makes things work, but this is not a 
satisfactory solution.


Nicolas
