From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 17:51:21 +0000
Message-ID: <20100318175120.GA7081@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003170946250.31128@xanadu.home> <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003171050160.31128@xanadu.home> <20100318092352.GD8267@n2100.arm.linux.org.uk> <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com> <20100318112453.GA19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003180904440.31128@xanadu.home> <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com> <20100318141930.GF19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54918 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0CRRvj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 13:51:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "V, Hemanth" <hemanthv@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "pierre@ossman.eu" <pierre@ossman.eu>, saeed bishara <saeed.bishara@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 18, 2010 at 12:17:50PM -0400, Nicolas Pitre wrote:
> On Thu, 18 Mar 2010, Russell King - ARM Linux wrote:
> > What exactly is the problem that we're discussing?  Is it that the data
> > on the block device is becoming corrupted, or is the data being read off
> > the block device corrupted?
> 
> Data read from a DMA based block device is corrupted in memory and 
> causing all sorts of misbehavior such as segmentation faults in user 
> space, or EXT2 complaining about broken filesystem metadata.

Isn't ext2 metadata read into lowmem pages?

The ext2 bitmap code sources its backing store from the old fs buffercache
code, which can only use lowmem - so the ext2 bitmaps are in lowmem (see
set_bh_page).  The superblock comes from the buffercache (grep for sb_bread)
as well, so that's lowmem, and it looks to me like inode reading also
comes via the buffercache.

It seems that all ext2 metadata is in lowmem, so I don't get the highmem
interaction causing ext2 fs metadata corruption.
