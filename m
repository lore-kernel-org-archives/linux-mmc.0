From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 13/13] mmc: tmio: add barriers to IO operations
Date: Mon, 18 Feb 2013 22:11:46 +0000
Message-ID: <201302182211.46697.arnd@arndb.de>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de> <201302181634.02751.arnd@arndb.de> <Pine.LNX.4.64.1302181808510.4526@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1302181808510.4526@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Monday 18 February 2013, Guennadi Liakhovetski wrote:
> On Mon, 18 Feb 2013, Arnd Bergmann wrote:
> 
> Sorry, I'm not sure how best to describe it, and I don't have sufficient 
> information myself. In any case on a block-diagram of sh73a0 SDHI devices 
> aren't directly connected to a common super-highway bus, instead they are 
> on a bus-splitter. One more thing I forgot to mention - this error has 
> been observed on SMP.

Ah, I guess that explains it. If you have one CPU filling the buffer
and another CPU reading it, you need an smp_wmb/wmp_rmb pair.

That case can easily happen with tmio interrupt handler in PIO
mode.

> I checked clock code under drivers/sh/clk, I don't see any relevant 
> __raw_* operations there. One I do see, however, GIC code does use 
> *_relaxed() accessors, but under raw spinlocks... Do those provide 
> sufficient barriers?

A spinlock by definition contains an SMP barrier, which seems to be
what is missing here. I don't know if that is enough here, because
the spinlock only needs barriers to protect against other users
behind the same spinlock.

In architecture independent code, any smp_wmb() on the writer side
must be paired with an smp_rmb on the reader. You probably have the
sufficient barriers on the side that initiates the I/O because
that uses a dmb() in the MMIO instructions, but that is only
by accident and not portable.

Also, in the uniprocessor case, you have more barriers than you
need, which limits the performance. The best solution for
both performance and readability would be to use readw_relaxed()
and writew_relaxed() and manually add the barriers you actually
need, i.e. two smp_rmb()/smp_wmb() in the PIO case, and a
wmb() before you start a real DMA to the device and an rmb()
after a DMA from the device is complete.

	Arnd
