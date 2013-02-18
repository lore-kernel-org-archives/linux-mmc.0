From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v4 13/13] mmc: tmio: add barriers to IO operations
Date: Mon, 18 Feb 2013 18:20:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302181808510.4526@axis700.grange>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
 <201302181505.58118.arnd@arndb.de> <Pine.LNX.4.64.1302181614070.4526@axis700.grange>
 <201302181634.02751.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64874 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab3BRRUe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 12:20:34 -0500
In-Reply-To: <201302181634.02751.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Mon, 18 Feb 2013, Arnd Bergmann wrote:

> On Monday 18 February 2013, Guennadi Liakhovetski wrote:
> > > Also, should the barrier not be after the MMIO read, rather than before it?
> > > Typically the barrier should ensure that any read from memory after an
> > > MMIO read reflects the memory contents after any DMA is complete that
> > > the MMIO read has already claimed to be done.
> > 
> > Errors, that I've been observing were happening with no DMA, in pure PIO 
> > mode.
> > 
> > Unfortunately, I don't have a good explanation, why the barriers have to 
> > be there, where I put them. At some point during my testing, I had 
> > printk()s in the code and SDIO worked. Then the classical - remove 
> > printk()s - stops working. Delays didn't halp, but barriers did. The 
> > motivation to put a write barrier before a (repeated) read was to wait for 
> > completion of any write operations before starting a read. And indeed, 
> > normal write operations, like writew() / iowrite16() have a write barrier 
> > before the write. So, isn't it possible, that the last write hasn't 
> > completed yet, while we begin with reading? But reads / writes should, 
> > probably, anyway be serialised on the bus...
> 
> What kind of bus is this?

Sorry, I'm not sure how best to describe it, and I don't have sufficient 
information myself. In any case on a block-diagram of sh73a0 SDHI devices 
aren't directly connected to a common super-highway bus, instead they are 
on a bus-splitter. One more thing I forgot to mention - this error has 
been observed on SMP.

> All buses I have looked at do serialize reads
> and writes to the same address at the minimum, and all sane buses
> serialize them when they happen to the same device, but it's harder
> to do when you need to serialize e.g. a read with a previous write
> to another device or another bus connected to the same device.
> 
> Let me try to say what I understand from reading the code: These
> accessors are only used on one function, and there is no DMA
> involved here. The function does (simplified):
> 
> void tmio_mmc_pio_irq(struct page *, void __iomem *io, size_t count, bool read)
> {
> 	void *virt;
> 
> 	/* called from interrupt handler, but let's disable interrupts some more ;) */
> 	local_irq_disable();
> 
> 	/* if highmem, map the page */
> 	virt = kmap_atomic(page);
> 	if (read) {
> 		wmb();
> 		readsw(io, virt, count);
> 	} else {
> 		writesw(io, virt, count);
> 		rmb();
> 	}
> 
> 	kunmap_atomic(virt);
> }
> 
> I don't think there is any other I/O involved, so the barriers are probably
> needed to synchronize with whoever is accessing the page on the other
> side of the kmap/kunmap. Did the bug happen on highmem?

No, don't think highmem was involved.

> The barriers here should probably be outside of the I/O accessors
> and in the tmio_mmc_pio_irq() function, but I still can't explain
> why they are needed here.
> 
> > It's also possible, that these errors are related to runtime 
> > power-management, which would involve IO to other SoC peripherals. But 
> > they all should also contain barriers, so, this doesn't explain it 
> > immediately either.
> 
> Maybe the runtime-pm code uses __raw_writel or writel_relaxed where it
> should be using writel?

I checked clock code under drivers/sh/clk, I don't see any relevant 
__raw_* operations there. One I do see, however, GIC code does use 
*_relaxed() accessors, but under raw spinlocks... Do those provide 
sufficient barriers?

Thanks
Guennadi

> Or maybe there some effect with disabling the caches and not flushing
> them properly in advance here?
> 
> In any case, I would expect a much more specific changeset text for a
> patch like this.
> 
> 	Arnd
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
