From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 08:55:07 +0800
Message-ID: <20110212005506.GE9289@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
 <201102101817.42099.arnd@arndb.de>
 <20110211231417.GC9289@S2100-06.ap.freescale.net>
 <201102111651.35530.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:20867 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750Ab1BKQz4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2011 11:55:56 -0500
Received: from mail139-tx2 (localhost.localdomain [127.0.0.1])	by
 mail139-tx2-R.bigfish.com (Postfix) with ESMTP id 6D97A19A8587	for
 <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 16:55:55 +0000 (UTC)
Received: from TX2EHSMHS037.bigfish.com (unknown [10.9.14.249])	by
 mail139-tx2.bigfish.com (Postfix) with ESMTP id 20076278051	for
 <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 16:55:47 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1BGtiH6014960	for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 09:55:44
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1BGthOW001990	for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 10:55:43
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <201102111651.35530.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, u.kleine-koenig@pengutronix.de

On Fri, Feb 11, 2011 at 04:51:35PM +0100, Arnd Bergmann wrote:
> On Saturday 12 February 2011, Shawn Guo wrote:
> > On Thu, Feb 10, 2011 at 06:17:41PM +0100, Arnd Bergmann wrote:
> > > On Friday 11 February 2011, Shawn Guo wrote:
> > > > 
> > > > > > +	struct mxs_dma_data		dma_data;
> > > > > 
> > > > > Why do you need host specific DMA structures? Please stick to
> > > > > the generic dma-engine API if possible.
> > > > > 
> > > > I'm sticking to the generic dmaengine api.  The mxs dma hardware
> > > > has separate irq line for every single dma channel, which needs to
> > > > be told by client driver.
> > > 
> > > I'm not convinced, it still sounds like a layering violation to
> > > have specific information about the DMA controller in the
> > > platform data of a driver using the dma engine API.
> > > 
> > It sounds like something about the dma controller, but it really
> > belongs to dma client device e.g. ssp here.  Every single dma client
> > device has two dma related resources, dma channel and dma irq, which
> > should be defined in client device data.
> 
> That is true for the DMA controller you use, but it doesn't have
> to be that way for all other DMA controllers, right? My point is
> that the MMC driver should not make any assumptions about what
> DMA controller is used, because a future SoC might combine it
> with a different DMA controller, e.g. one that just just a single
> interrupt for all channels.
> 
Your thought is right.  But the fact is, from hw design point of
view, all client peripherals are coupled with mxs dma.  As a real
example, gpmi (mxs nand controller) is one mxs dma client device.
When gpmi is integrated into i.MX50 to replace nfc (original i.mx
nand controller), dma-aphb has to be brought into mx50 together,
though mx50 already gets sdma there.

I tried hard to decouple client driver from mxs dmaengine driver, but
it can not be that thorough. As dma peripheral only trigger error irq,
mxs dma "pio" mode and dma irq need to be handled by client and dma
driver in a coupled way.

> > > Why can't you put the interrupt number into the platform data of
> > > the dma engine device? Your filter function already identifies
> > > the number of the DMA channel.
> > > 
> > We have 16 channels for dma-apbh and dma-apbx respectively.  And each
> > channel has fixed peripheral device and irq.  You think we can define
> > 2 x 16 x (channel number + channel irq) in dma engine driver?  I'm
> > afraid not.  The channel number can be identified in filter function
> > because dmaengine core code and mxs dma hw are indexing the channel
> > in the same way, so that the sw channel id can be used to address hw
> > channel, otherwise we have to pass hw channel id to dma driver just
> > like what we do with irq.
> 
> I don't understand. The sw channel id should be something that is
> defined in an arbitrary way for each machine, and it should be the
> only thing that a driver needs, right?
> 
Yes, the sw channel id can be defined in an arbitrary way by
dmaengine, but in that case dmaegine can not use sw channel id to
access hw channel, because each mxs dma client device gets a specific
hw channel.  Of course, we can give device an arbitrary channel with
a fixed hw channel id attached on, and use hw id to access hw channel.
But in that case, we have one more info in device data to pass besides
irq.


> I have not looked much at other dmaengine drivers, but I'd be
> surprised if they require the device driver to be written
> for a specific implementation. If that was the case, you would
> not even need a dmaengine API but could just as well write
> to the DMA controller registers from the device driver directly.
> 
We need a specific implementation, but it's not so specific that we
have to access dma controller directly.  Even it is, we still need
an API/interface, as there are so many client devices need to do the
same thing, right? ;)

> > > What I meant is that you take care to avoid getting into the
> > > interrupt handler while holding the spinlock, but in the handler,
> > > you don't check if the lock is held. It can't be correct to
> > > serialize just half the cases.
> > > 
> > Thanks for the explanation.  Please help review the fix below to see
> > if I understand the comment correctly.
> > 
> >         if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN)) {
> >                 spin_lock_irqsave(&host->lock, flags);
> >                 mmc_signal_sdio_irq(host->mmc);
> >                 spin_unlock_irqrestore(&host->lock, flags);
> >         }
> 
> This is still wrong for two reasons:
> 
> * You now don't hold the lock while reading the 'stat' variable. The point of the
>   lock is to make sure that sdio doesn't get turned off after reading stat but
>   before signaling the sdio, so you have to hold it across both.
> * In an interrupt controller, you should not disable interrupts again.
>   It's harmless, but slow and confusing to the reader.
> 
Sorry for the dumb.  So it should be something like the following?

        spin_lock(&host->lock);

        stat = readl(host->base + HW_SSP_CTRL1);
        writel(stat & MXS_MMC_IRQ_BITS,
                host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);

	[...]

        if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
                mmc_signal_sdio_irq(host->mmc);

        spin_unlock(&host->lock);

Regards,
Shawn

