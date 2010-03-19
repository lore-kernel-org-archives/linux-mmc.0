From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Highmem issues with MMC filesystem
Date: Fri, 19 Mar 2010 14:45:32 +0000
Message-ID: <20100319144532.GF21280@n2100.arm.linux.org.uk>
References: <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com> <20100318112453.GA19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003180904440.31128@xanadu.home> <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com> <20100318141930.GF19544@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1003181205020.31128@xanadu.home> <20100319015523.GD14108@shareable.org> <alpine.LFD.2.00.1003190908330.31128@xanadu.home> <5080.10.24.255.18.1269008921.squirrel@dbdmail.itg.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C4947FE3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35327 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab0CSOp6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 10:45:58 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4947FE3@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "V, Hemanth" <hemanthv@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Jamie Lokier <jamie@shareable.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "pierre@ossman.eu" <pierre@ossman.eu>, saeed bishara <saeed.bishara@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 19, 2010 at 08:06:12PM +0530, Shilimkar, Santosh wrote:
> Since the cache_flush is helping and we are talking about DMA_FROM_DEVICE
> case, Russells recent DMA mapping series does have fix for this.
> 
> Do you have Russell's DMA mapping series integrated in your kernel you are
> trying ? It's already in the 2.6.34-rc1

I wonder whether we can get _one_ email from each person who has
encountered the problem giving full details of what kernels they're
running and the problem is that they've experienced.

At the moment, that information is spread throughout this thread,
with some clues from one person and others from another person -
there's no way to tie this all together, and I certainly can't follow
it.

So, let's end this thread here (I'm going to start ignoring it), and
start a new one with some *proper* and *full* bug reports from *each*
person with a problem.
