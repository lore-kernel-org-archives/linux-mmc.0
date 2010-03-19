From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 14:56:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003191451460.31128@xanadu.home>
References: <alpine.LFD.2.00.1003191348231.31128@xanadu.home>
 <1269023212.22473.5.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:33357 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab0CSS43 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 14:56:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZJ007KJLY4HU30@VL-MO-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 19 Mar 2010 14:56:28 -0400 (EDT)
In-reply-to: <1269023212.22473.5.camel@e102109-lin.cambridge.arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jamie Lokier <jamie@shareable.org>, "V, Hemanth" <hemanthv@ti.com>, linux-mmc@vger.kernel.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, pierre@ossman.eu, saeed bishara <saeed.bishara@gmail.com>, linux-arm-kernel@lists.infradead.org

On Fri, 19 Mar 2010, Catalin Marinas wrote:

> On Fri, 2010-03-19 at 17:59 +0000, Nicolas Pitre wrote:
> > On Fri, 19 Mar 2010, Russell King - ARM Linux wrote:
> > 
> > > On Fri, Mar 19, 2010 at 09:17:19AM -0400, Nicolas Pitre wrote:
> > > > And in this case, the same SATA driver is used on two different system,
> > > > one being ARMv5 with absolutely no issues with highmem, and the other
> > > > being ARMv6 with highmem problems.  So that pretty much rules out IDE
> > > > driver bugs.
> > >
> > > No it doesn't - there's more changes between ARMv5 and ARMv6 than just
> > > the cache model.  There's weak memory ordering effects too.
> > 
> > Sure.  But at the moment we have:
> > 
> >  - ARMv5 without highmem -> works
> > 
> >  - ARMv5 with highmem -> works
> > 
> >  - ARMv6 without highmem -> works
> > 
> >  - ARMv6 with highmem -> fails
> > 
> > In all four cases the SATA driver, the hard disk and the filesystem on
> > it are identical.  In the two ARMv5 cases the system and the kernel are
> > identical.  Ditto for the two ARMv6 cases.
> 
> Which ARMv6 processor is this?

Marvell 88AP510 aka Dove.  But the same issue was reported on OMAP.

> Is the SATA driver using DMA (I think I read this in the thread but it
> started as MMC issues and got confused)?

Any block device using DMA is affected.  Drivers using PIO are not, 
neither is NFS.  And again, using the _same_ kernel with mem=512m so to 
be sure highmem doesn't kick in exhibits no issue even with DMA.


Nicolas
