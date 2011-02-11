From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Fri, 11 Feb 2011 21:04:23 +0100
Message-ID: <201102112104.23643.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <201102111651.35530.arnd@arndb.de> <20110212005506.GE9289@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56566 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756989Ab1BKUE3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2011 15:04:29 -0500
In-Reply-To: <20110212005506.GE9289@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>, s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, u.kleine-koenig@pengutronix.de

On Saturday 12 February 2011 01:55:07 Shawn Guo wrote:
> On Fri, Feb 11, 2011 at 04:51:35PM +0100, Arnd Bergmann wrote:
> > I have not looked much at other dmaengine drivers, but I'd be
> > surprised if they require the device driver to be written
> > for a specific implementation. If that was the case, you would
> > not even need a dmaengine API but could just as well write
> > to the DMA controller registers from the device driver directly.
> > 
> We need a specific implementation, but it's not so specific that we
> have to access dma controller directly.  Even it is, we still need
> an API/interface, as there are so many client devices need to do the
> same thing, right? ;)

I looked at all mmc drivers that use the dmaengine API: 
atmel-mci.c does the same as what you propose here, while sh_mmcif.c
and tmio_mmc.c more or less do what I'm suggesting you do instead.

Looking at sh_mmcif:

      host->chan_tx = dma_request_channel(mask, sh_mmcif_filter,
                                          &pdata->dma->chan_priv_tx);


This is the only place where dma engine specific data is used
in the driver, and chan_priv_tx is part of the platform data, so the
mmc driver can simply pass it down as a void pointer without knowing
the type. The platform data as defined in the machine file ties
both the dma controller and the mmc device together, but neither
of the two drivers needs to know anything about the implementation
of the other.

> So it should be something like the following?
> 
>         spin_lock(&host->lock);
> 
>         stat = readl(host->base + HW_SSP_CTRL1);
>         writel(stat & MXS_MMC_IRQ_BITS,
>                 host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
> 
>         [...]
> 
>         if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
>                 mmc_signal_sdio_irq(host->mmc);
> 
>         spin_unlock(&host->lock);
> 

Yes, this looks correct to me now.

	Arnd
