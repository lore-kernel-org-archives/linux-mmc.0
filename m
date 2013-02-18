From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 13/13] mmc: tmio: add barriers to IO operations
Date: Mon, 18 Feb 2013 16:34:02 +0000
Message-ID: <201302181634.02751.arnd@arndb.de>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de> <201302181505.58118.arnd@arndb.de> <Pine.LNX.4.64.1302181614070.4526@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1302181614070.4526@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Monday 18 February 2013, Guennadi Liakhovetski wrote:
> > Also, should the barrier not be after the MMIO read, rather than before it?
> > Typically the barrier should ensure that any read from memory after an
> > MMIO read reflects the memory contents after any DMA is complete that
> > the MMIO read has already claimed to be done.
> 
> Errors, that I've been observing were happening with no DMA, in pure PIO 
> mode.
> 
> Unfortunately, I don't have a good explanation, why the barriers have to 
> be there, where I put them. At some point during my testing, I had 
> printk()s in the code and SDIO worked. Then the classical - remove 
> printk()s - stops working. Delays didn't halp, but barriers did. The 
> motivation to put a write barrier before a (repeated) read was to wait for 
> completion of any write operations before starting a read. And indeed, 
> normal write operations, like writew() / iowrite16() have a write barrier 
> before the write. So, isn't it possible, that the last write hasn't 
> completed yet, while we begin with reading? But reads / writes should, 
> probably, anyway be serialised on the bus...

What kind of bus is this? All buses I have looked at do serialize reads
and writes to the same address at the minimum, and all sane buses
serialize them when they happen to the same device, but it's harder
to do when you need to serialize e.g. a read with a previous write
to another device or another bus connected to the same device.

Let me try to say what I understand from reading the code: These
accessors are only used on one function, and there is no DMA
involved here. The function does (simplified):

void tmio_mmc_pio_irq(struct page *, void __iomem *io, size_t count, bool read)
{
	void *virt;

	/* called from interrupt handler, but let's disable interrupts some more ;) */
	local_irq_disable();

	/* if highmem, map the page */
	virt = kmap_atomic(page);
	if (read) {
		wmb();
		readsw(io, virt, count);
	} else {
		writesw(io, virt, count);
		rmb();
	}

	kunmap_atomic(virt);
}

I don't think there is any other I/O involved, so the barriers are probably
needed to synchronize with whoever is accessing the page on the other
side of the kmap/kunmap. Did the bug happen on highmem?

The barriers here should probably be outside of the I/O accessors
and in the tmio_mmc_pio_irq() function, but I still can't explain
why they are needed here.

> It's also possible, that these errors are related to runtime 
> power-management, which would involve IO to other SoC peripherals. But 
> they all should also contain barriers, so, this doesn't explain it 
> immediately either.

Maybe the runtime-pm code uses __raw_writel or writel_relaxed where it
should be using writel?

Or maybe there some effect with disabling the caches and not flushing
them properly in advance here?

In any case, I would expect a much more specific changeset text for a
patch like this.

	Arnd
