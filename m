From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] mmc: sh_mmcif: add support for Device Tree DMA bindings
Date: Tue, 2 Jul 2013 15:52:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307021548100.1965@axis700.grange>
References: <Pine.LNX.4.64.1306241434200.19735@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1306241434200.19735@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

What's the plan about this patch? Do you think you'd be able to push it 
for 3.11 or rather 3.12?

Thanks
Guennadi

On Mon, 24 Jun 2013, Guennadi Liakhovetski wrote:

> To use DMA in the Device Tree case the driver has to be modified
> to use suitable API to obtain DMA channels.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> v2: use an "else if"
> 
>  drivers/mmc/host/sh_mmcif.c |   26 ++++++++++++++++----------
>  1 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index ba76a53..4fff404 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -386,25 +386,29 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
>  
>  	host->dma_active = false;
>  
> -	if (!pdata)
> -		return;
> -
> -	if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
> +	if (pdata) {
> +		if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
> +			return;
> +	} else if (!host->pd->dev.of_node) {
>  		return;
> +	}
>  
>  	/* We can only either use DMA for both Tx and Rx or not use it at all */
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	host->chan_tx = dma_request_channel(mask, shdma_chan_filter,
> -					    (void *)pdata->slave_id_tx);
> +	host->chan_tx = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> +				pdata ? (void *)pdata->slave_id_tx : NULL,
> +				&host->pd->dev, "tx");
>  	dev_dbg(&host->pd->dev, "%s: TX: got channel %p\n", __func__,
>  		host->chan_tx);
>  
>  	if (!host->chan_tx)
>  		return;
>  
> -	cfg.slave_id = pdata->slave_id_tx;
> +	/* In the OF case the driver will get the slave ID from the DT */
> +	if (pdata)
> +		cfg.slave_id = pdata->slave_id_tx;
>  	cfg.direction = DMA_MEM_TO_DEV;
>  	cfg.dst_addr = res->start + MMCIF_CE_DATA;
>  	cfg.src_addr = 0;
> @@ -412,15 +416,17 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
>  	if (ret < 0)
>  		goto ecfgtx;
>  
> -	host->chan_rx = dma_request_channel(mask, shdma_chan_filter,
> -					    (void *)pdata->slave_id_rx);
> +	host->chan_rx = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> +				pdata ? (void *)pdata->slave_id_rx : NULL,
> +				&host->pd->dev, "rx");
>  	dev_dbg(&host->pd->dev, "%s: RX: got channel %p\n", __func__,
>  		host->chan_rx);
>  
>  	if (!host->chan_rx)
>  		goto erqrx;
>  
> -	cfg.slave_id = pdata->slave_id_rx;
> +	if (pdata)
> +		cfg.slave_id = pdata->slave_id_rx;
>  	cfg.direction = DMA_DEV_TO_MEM;
>  	cfg.dst_addr = 0;
>  	cfg.src_addr = res->start + MMCIF_CE_DATA;
> -- 
> 1.7.2.5
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
