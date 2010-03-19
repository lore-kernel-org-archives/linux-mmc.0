From: Jamie Lokier <jamie@shareable.org>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 01:55:23 +0000
Message-ID: <20100319015523.GD14108@shareable.org>
References: <alpine.LFD.2.00.1003170946250.31128@xanadu.home> <043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946> <alpine.LFD.2.00.1003171050160.31128@xanadu.home> <20100318092352.GD8267@n2100.arm.linux.org.uk> <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com> <20100318112453.GA19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003180904440.31128@xanadu.home> <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com> <20100318141930.GF19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:35244 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab0CSBz3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2010 21:55:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "V, Hemanth" <hemanthv@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "pierre@ossman.eu" <pierre@ossman.eu>, saeed bishara <saeed.bishara@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Nicolas Pitre wrote:
> Data read from a DMA based block device is corrupted in memory and 
> causing all sorts of misbehavior such as segmentation faults in user 
> space, or EXT2 complaining about broken filesystem metadata.

I doubt it is related, but just in case: I've seen similar on a
no-doubt completely unrelated ARM9 system on now-ancient kernels:
occasional ext3 metadata corruption.

In my case it was due to a bug in the chip's IDE driver, which did:

   1. Setup DMA address register.
   2. Appropriate cache flushes.
   3. Write to remaining DMA registers to start DMA.

It turned out step 1 causes the DMA controller to begin reading from
that address into an internal 128-byte FIFO, before officially
starting DMA.  Moving step 2 before step 1 fixed that.

-- Jamie
