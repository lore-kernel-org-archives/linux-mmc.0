From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Thu, 10 Feb 2011 18:17:41 +0100
Message-ID: <201102101817.42099.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <201102042126.52701.arnd@arndb.de> <20110211003533.GA9151@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59744 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199Ab1BJRRs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 12:17:48 -0500
In-Reply-To: <20110211003533.GA9151@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>, s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, u.kleine-koenig@pengutronix.de

On Friday 11 February 2011, Shawn Guo wrote:
> 
> > > +	struct resource			*res;
> > > +	struct resource			*dma_res;
> > > +	struct clk			*clk;
> > 
> > are visible in the parent.
> > 
> It seems this is a generally used approach, seen in mxcmmc and pxamci.

Just because someone else is doing it, it doesn't have to be a good
idea ;-)

But you're right, it seems to be done this way almost everywhere.
Unless Chris has a more definite opinion here, I don't mind if
you follow the same pattern.

If someone decides that it's really a bad idea, we should change
all drivers at once.

> > > +	struct mxs_dma_data		dma_data;
> > 
> > Why do you need host specific DMA structures? Please stick to
> > the generic dma-engine API if possible.
> > 
> I'm sticking to the generic dmaengine api.  The mxs dma hardware
> has separate irq line for every single dma channel, which needs to
> be told by client driver.

I'm not convinced, it still sounds like a layering violation to
have specific information about the DMA controller in the
platform data of a driver using the dma engine API.

Why can't you put the interrupt number into the platform data of
the dma engine device? Your filter function already identifies
the number of the DMA channel.

> > > +static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
> > > +{
> > > +	struct mxs_mmc_host *host = dev_id;
> > > +	u32 stat;
> > > +
> > > +	stat = __raw_readl(host->base + HW_SSP_CTRL1);
> > > +	__mxs_clrl(stat & MXS_MMC_IRQ_BITS, host->base + HW_SSP_CTRL1);
> > > +
> > > +	if (host->cmd && (stat & MXS_MMC_ERR_BITS))
> > > +		host->status = __raw_readl(host->base + HW_SSP_STATUS);
> > > +
> > > +	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> > > +		mmc_signal_sdio_irq(host->mmc);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > 
> > You use spin_lock_irqsave in mxs_mmc_enable_sdio_irq, but don't
> > actually use the spinlock in the interrupt handler. This means
> > that either your interrupt handler is broken because it doesn't
> > lock, or that you don't actually need the _irqsave part.
> > 
> I do not understand this one.  I'm seeing mxcmmc and pxamci use
> spin_lock_irqsave/irqrestore in the similar way.

The difference is that e.g. mxcmci_irq() takes the spinlock that is
used to protect the host->use_sdio flag, serializing the the
code that initializes sdio with the code that uses it.

[Actually, mxcmci_irq() also looks wrong, because it releases the
spinlock before calling mmc_signal_sdio_irq(), so sdio may be
disabled by then, but that is a slightly different bug]

What I meant is that you take care to avoid getting into the
interrupt handler while holding the spinlock, but in the handler,
you don't check if the lock is held. It can't be correct to
serialize just half the cases.

	Arnd
