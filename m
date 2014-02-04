From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] mmc: tmio-mmc: add DMA SG synchronisation
Date: Tue, 4 Feb 2014 09:57:41 +0900
Message-ID: <20140204005741.GC24787@verge.net.au>
References: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
 <Pine.LNX.4.64.1401311248320.3234@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1401311248320.3234@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 31, 2014 at 12:54:19PM +0100, Guennadi Liakhovetski wrote:
> According to the DMA API data has to be synchronised before starting
> a DMA transfer to device and after completing a DMA transfer from device.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/mmc/host/tmio_mmc_dma.c |   21 ++++++++++++---------
>  1 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index 65edb4a..a997b94 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -168,9 +168,12 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
>  	}
>  
>  	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
> -	if (ret > 0)
> +	if (ret > 0) {
> +		dma_sync_sg_for_device(chan->device->dev, sg, host->sg_len,
> +				       DMA_TO_DEVICE);
>  		desc = dmaengine_prep_slave_sg(chan, sg, ret,
>  			DMA_MEM_TO_DEV, DMA_CTRL_ACK);
> +	}
>  
>  	if (desc) {
>  		cookie = dmaengine_submit(desc);
> @@ -247,14 +250,14 @@ static void tmio_mmc_tasklet_fn(unsigned long arg)
>  	if (!host->data)
>  		goto out;
>  
> -	if (host->data->flags & MMC_DATA_READ)
> -		dma_unmap_sg(host->chan_rx->device->dev,
> -			     host->sg_ptr, host->sg_len,
> -			     DMA_FROM_DEVICE);
> -	else
> -		dma_unmap_sg(host->chan_tx->device->dev,
> -			     host->sg_ptr, host->sg_len,
> -			     DMA_TO_DEVICE);
> +	if (host->data->flags & MMC_DATA_READ) {
> +		struct device *dev = host->chan_rx->device->dev;
> +		dma_unmap_sg(dev, host->sg_ptr, host->sg_len, DMA_FROM_DEVICE);
> +		dma_sync_sg_for_cpu(dev, host->sg_ptr, host->sg_len, DMA_FROM_DEVICE);
> +	} else {
> +		struct device *dev = host->chan_tx->device->dev;
> +		dma_unmap_sg(dev, host->sg_ptr, host->sg_len, DMA_TO_DEVICE);
> +	}
>  
>  	tmio_mmc_do_data_irq(host);
>  out:
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
