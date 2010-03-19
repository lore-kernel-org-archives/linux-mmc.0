From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 09:17:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003190908330.31128@xanadu.home>
References: <alpine.LFD.2.00.1003170946250.31128@xanadu.home>
 <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
 <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
 <20100318092352.GD8267@n2100.arm.linux.org.uk>
 <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
 <20100318112453.GA19544@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1003180904440.31128@xanadu.home>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
 <20100318141930.GF19544@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
 <20100319015523.GD14108@shareable.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:64555 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab0CSNRU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 09:17:20 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZJ00H7968VSB10@VL-MR-MR001.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 19 Mar 2010 09:17:19 -0400 (EDT)
In-reply-to: <20100319015523.GD14108@shareable.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "V, Hemanth" <hemanthv@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "pierre@ossman.eu" <pierre@ossman.eu>, saeed bishara <saeed.bishara@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 19 Mar 2010, Jamie Lokier wrote:

> Nicolas Pitre wrote:
> > Data read from a DMA based block device is corrupted in memory and 
> > causing all sorts of misbehavior such as segmentation faults in user 
> > space, or EXT2 complaining about broken filesystem metadata.
> 
> I doubt it is related, but just in case: I've seen similar on a
> no-doubt completely unrelated ARM9 system on now-ancient kernels:
> occasional ext3 metadata corruption.
> 
> In my case it was due to a bug in the chip's IDE driver, which did:
[...]

Driver bugs would tend to be visible with or without highmem in play.

And in this case, the same SATA driver is used on two different system, 
one being ARMv5 with absolutely no issues with highmem, and the other 
being ARMv6 with highmem problems.  So that pretty much rules out IDE 
driver bugs.

Furthermore the same highmem issues were reported to occur on an OMAP 
system with the filesystem on a MMC card i.e. different CPU manufacturer 
with a different block device driver.

So the issue really seems to be about ARMv5 (works) vs ARMv6 (doesn't 
work), which makes some sense given the huge difference between both 
cache models.


Nicolas
