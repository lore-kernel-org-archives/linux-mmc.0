From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/3] mmc: sh-mmcif: add DMA SG synchronisation
Date: Tue, 4 Feb 2014 09:57:53 +0900
Message-ID: <20140204005752.GD24787@verge.net.au>
References: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
 <Pine.LNX.4.64.1401311249070.3234@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1401311249070.3234@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 31, 2014 at 12:54:29PM +0100, Guennadi Liakhovetski wrote:
> According to the DMA API data has to be synchronised before starting
> a DMA transfer to device and after completing a DMA transfer from device.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/mmc/host/sh_mmcif.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index d032b08..902780c 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -345,6 +345,8 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
>  			 DMA_TO_DEVICE);
>  	if (ret > 0) {
>  		host->dma_active = true;
> +		dma_sync_sg_for_device(chan->device->dev, sg, data->sg_len,
> +				       DMA_TO_DEVICE);
>  		desc = dmaengine_prep_slave_sg(chan, sg, ret,
>  			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	}
> @@ -1118,14 +1120,14 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
>  	time = wait_for_completion_interruptible_timeout(&host->dma_complete,
>  							 host->timeout);
>  
> -	if (data->flags & MMC_DATA_READ)
> -		dma_unmap_sg(host->chan_rx->device->dev,
> -			     data->sg, data->sg_len,
> -			     DMA_FROM_DEVICE);
> -	else
> -		dma_unmap_sg(host->chan_tx->device->dev,
> -			     data->sg, data->sg_len,
> -			     DMA_TO_DEVICE);
> +	if (data->flags & MMC_DATA_READ) {
> +		struct device *dev = host->chan_rx->device->dev;
> +		dma_unmap_sg(dev, data->sg, data->sg_len, DMA_FROM_DEVICE);
> +		dma_sync_sg_for_cpu(dev, data->sg, data->sg_len, DMA_FROM_DEVICE);
> +	} else {
> +		struct device *dev = host->chan_tx->device->dev;
> +		dma_unmap_sg(dev, data->sg, data->sg_len, DMA_TO_DEVICE);
> +	}
>  
>  	if (host->sd_error) {
>  		dev_err(host->mmc->parent,
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
