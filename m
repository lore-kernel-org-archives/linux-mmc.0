From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 15:24:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003181517340.31128@xanadu.home>
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
 <20100318175120.GA7081@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:46419 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0CRTYx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 15:24:53 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZH00LKSSLGU9O0@VL-MH-MR003.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 18 Mar 2010 15:24:52 -0400 (EDT)
In-reply-to: <20100318175120.GA7081@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "V, Hemanth" <hemanthv@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "pierre@ossman.eu" <pierre@ossman.eu>, saeed bishara <saeed.bishara@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 18 Mar 2010, Russell King - ARM Linux wrote:

> On Thu, Mar 18, 2010 at 12:17:50PM -0400, Nicolas Pitre wrote:
> > On Thu, 18 Mar 2010, Russell King - ARM Linux wrote:
> > > What exactly is the problem that we're discussing?  Is it that the data
> > > on the block device is becoming corrupted, or is the data being read off
> > > the block device corrupted?
> > 
> > Data read from a DMA based block device is corrupted in memory and 
> > causing all sorts of misbehavior such as segmentation faults in user 
> > space, or EXT2 complaining about broken filesystem metadata.
> 
> Isn't ext2 metadata read into lowmem pages?

Possible.  I've not looked at it closely enough to know for sure.

> The ext2 bitmap code sources its backing store from the old fs buffercache
> code, which can only use lowmem - so the ext2 bitmaps are in lowmem (see
> set_bh_page).  The superblock comes from the buffercache (grep for sb_bread)
> as well, so that's lowmem, and it looks to me like inode reading also
> comes via the buffercache.
> 
> It seems that all ext2 metadata is in lowmem, so I don't get the highmem
> interaction causing ext2 fs metadata corruption.

Well, some EXT2 errors appear randomly through the kernel console output 
and get mixed with all the avalenge of user space processes crashing due 
to strange errors or simply segfaulting during a boot.  Luckily when 
that happens the user space wasn't even able to remount the root fs 
read-write, so performing a fsck after a reboot (without highmem pages) 
reveals a sane and clean filesystem.


Nicolas
