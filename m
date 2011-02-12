From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 12 Feb 2011 09:59:22 +0100
Message-ID: <201102120959.22707.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <201102112104.23643.arnd@arndb.de> <20110212140417.GA9821@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59001 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab1BLI71 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 03:59:27 -0500
In-Reply-To: <20110212140417.GA9821@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, u.kleine-koenig@pengutronix.de

On Saturday 12 February 2011 15:04:19 Shawn Guo wrote:
> > and tmio_mmc.c more or less do what I'm suggesting you do instead.
> > 
> > Looking at sh_mmcif:
> > 
> >       host->chan_tx = dma_request_channel(mask, sh_mmcif_filter,
> >                                           &pdata->dma->chan_priv_tx);
> > 
> > 
> > This is the only place where dma engine specific data is used
> > in the driver, and chan_priv_tx is part of the platform data, so the
> > mmc driver can simply pass it down as a void pointer without knowing
> > the type. The platform data as defined in the machine file ties
> > both the dma controller and the mmc device together, but neither
> > of the two drivers needs to know anything about the implementation
> > of the other.
> > 
> Not really.  Though mmc does not need to know anything about dma
> driver, dma knows that mmc driver has to pass .slave_id via
> chan->private.  The snippet below is copied from shdma.
> 
>         struct sh_dmae_slave_config {
>                 unsigned int                    slave_id;
>                 dma_addr_t                      addr;
>                 u32                             chcr;
>                 char                            mid_rid;
>         };
> ---
>         if (chan->private) {
>                 /* The caller is holding dma_list_mutex */
>                 struct sh_dmae_slave *param = chan->private;
>                 clear_bit(param->slave_id, sh_dmae_slave_used);
>         }
> 
> And it only works when slave_id is the first member of
> sh_dmae_slave_config.
>
> For me, it's more natural to define device's dma related things like
> dma channel id and irq as its resources than platform data.  So I
> still maintain the current approach.

I'm not arguing against passing the data as platform data (well, not any
more, but it was never the main objection anyway).

You are right that sh_dmae_slave_config contains all the private data
for the DMA controller, and I have no objection to you doing the
same. However, sh_mmcif.c does not know the defintion of
sh_dmae_slave_config, it just gets it via a void pointer from the
platform data and passes it to the dma_request_channel function via
another void pointer. That function calls into the sh_dmae driver, which
casts it back to struct sh_dmae_slave_config, and that is same that I'm
suggesting you to do.

It should really be a trivial change to move your struct mxs_dma_data
from struct mxs_mmc_host to your platform_data:

struct mxs_mmc_platform_data {
	int wp_gpio;	/* write protect pin */
	void *dma_data;
};

static struct mxs_dma_data mxs_mmc_dma_data = {
	.chan_irq = MMC_DMA_IRQ,
};

static struct mxs_mmc_platform_data mxs_mmc_pdata = {
	.wp_gpio = SOME_CONSTANT,
	.dma_data = &mxs_mmc_dma_data,
}

Now only the platform definition needs to know about both
mxs_mmc_platform_data and mxs_dma_data, while the dma engine driver
and the mmc driver each just need to know about their own data.

Sorry for being too vague in what I asking for before.

	Arnd
