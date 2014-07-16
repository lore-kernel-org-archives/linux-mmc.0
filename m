From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 05/11] mmc: tmio: Fix DMA source address
Date: Wed, 16 Jul 2014 11:41:38 +0200
Message-ID: <3064066.cLMrQSJucc@avalon>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1405464321-4723-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <87r41mkrpl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:57089 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbaGPJlf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jul 2014 05:41:35 -0400
In-Reply-To: <87r41mkrpl.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

Hi Morimoto-san,

Thank you for the review.

On Tuesday 15 July 2014 18:39:04 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > DMA reads from the data buffer register must be offset by 0x2000
> > according to the hardware documentation.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/mmc/host/tmio_mmc_dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/tmio_mmc_dma.c
> > b/drivers/mmc/host/tmio_mmc_dma.c index eb8f1d5..4da7be1 100644
> > --- a/drivers/mmc/host/tmio_mmc_dma.c
> > +++ b/drivers/mmc/host/tmio_mmc_dma.c
> > @@ -312,7 +312,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host,
> > struct tmio_mmc_data *pdat> 
> >  		if (pdata->dma->chan_priv_rx)
> >  		
> >  			cfg.slave_id = pdata->dma->slave_id_rx;
> >  		
> >  		cfg.direction = DMA_DEV_TO_MEM;
> > 
> > -		cfg.src_addr = cfg.dst_addr;
> > +		cfg.src_addr = cfg.dst_addr + 0x2000;
> > 
> >  		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> >  		cfg.dst_addr = 0;
> >  		ret = dmaengine_slave_config(host->chan_rx, &cfg);
> 
> Unfortunately, this patch breaks compatibility.
> This "+ 0x2000" is required only from Renesas R-Car.
> I alreay sent this fixup patch before (not accepted yet, and I will re-send
> v2 patch soon)
> 
> https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg26776.html

I've applied your patch locally, thank you. You can add my Acked-by line to 
v2. When do you plan to push it to mainline ?

-- 
Regards,

Laurent Pinchart

