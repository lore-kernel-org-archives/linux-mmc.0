From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Fri, 11 Feb 2011 16:51:35 +0100
Message-ID: <201102111651.35530.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <201102101817.42099.arnd@arndb.de> <20110211231417.GC9289@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53348 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab1BKPvl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2011 10:51:41 -0500
In-Reply-To: <20110211231417.GC9289@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, u.kleine-koenig@pengutronix.de

On Saturday 12 February 2011, Shawn Guo wrote:
> On Thu, Feb 10, 2011 at 06:17:41PM +0100, Arnd Bergmann wrote:
> > On Friday 11 February 2011, Shawn Guo wrote:
> > > 
> > > > > +	struct mxs_dma_data		dma_data;
> > > > 
> > > > Why do you need host specific DMA structures? Please stick to
> > > > the generic dma-engine API if possible.
> > > > 
> > > I'm sticking to the generic dmaengine api.  The mxs dma hardware
> > > has separate irq line for every single dma channel, which needs to
> > > be told by client driver.
> > 
> > I'm not convinced, it still sounds like a layering violation to
> > have specific information about the DMA controller in the
> > platform data of a driver using the dma engine API.
> > 
> It sounds like something about the dma controller, but it really
> belongs to dma client device e.g. ssp here.  Every single dma client
> device has two dma related resources, dma channel and dma irq, which
> should be defined in client device data.

That is true for the DMA controller you use, but it doesn't have
to be that way for all other DMA controllers, right? My point is
that the MMC driver should not make any assumptions about what
DMA controller is used, because a future SoC might combine it
with a different DMA controller, e.g. one that just just a single
interrupt for all channels.

> > Why can't you put the interrupt number into the platform data of
> > the dma engine device? Your filter function already identifies
> > the number of the DMA channel.
> > 
> We have 16 channels for dma-apbh and dma-apbx respectively.  And each
> channel has fixed peripheral device and irq.  You think we can define
> 2 x 16 x (channel number + channel irq) in dma engine driver?  I'm
> afraid not.  The channel number can be identified in filter function
> because dmaengine core code and mxs dma hw are indexing the channel
> in the same way, so that the sw channel id can be used to address hw
> channel, otherwise we have to pass hw channel id to dma driver just
> like what we do with irq.

I don't understand. The sw channel id should be something that is
defined in an arbitrary way for each machine, and it should be the
only thing that a driver needs, right?

I have not looked much at other dmaengine drivers, but I'd be
surprised if they require the device driver to be written
for a specific implementation. If that was the case, you would
not even need a dmaengine API but could just as well write
to the DMA controller registers from the device driver directly.

> > What I meant is that you take care to avoid getting into the
> > interrupt handler while holding the spinlock, but in the handler,
> > you don't check if the lock is held. It can't be correct to
> > serialize just half the cases.
> > 
> Thanks for the explanation.  Please help review the fix below to see
> if I understand the comment correctly.
> 
>         if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN)) {
>                 spin_lock_irqsave(&host->lock, flags);
>                 mmc_signal_sdio_irq(host->mmc);
>                 spin_unlock_irqrestore(&host->lock, flags);
>         }

This is still wrong for two reasons:

* You now don't hold the lock while reading the 'stat' variable. The point of the
  lock is to make sure that sdio doesn't get turned off after reading stat but
  before signaling the sdio, so you have to hold it across both.
* In an interrupt controller, you should not disable interrupts again.
  It's harmless, but slow and confusing to the reader.

	Arnd
