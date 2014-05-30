From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH 3/3] mmc: tmio: care about DMA tx/rx addr offset
Date: Fri, 30 May 2014 11:56:23 +0100
Message-ID: <20140530105623.GE6241@trinity.fluff.org>
References: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com>
 <87lhtjpn0o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lhtjpn0o.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, May 30, 2014 at 03:40:56AM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Basically, SD_BUF0 Tx/Rx addresses are same
> in normal TMIO controller,
> but, it is different on Renesas R-Car SDHI controller
> if it uses DMAC
> (Rx address needs to add 0x2000 to Tx address)
> 
> This patch adds new .dma_rx_offset and cares it
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    3 +++
>  drivers/mmc/host/tmio_mmc_dma.c   |    2 +-
>  include/linux/mfd/tmio.h          |    1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index b3baa83..91c6399 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -39,6 +39,7 @@ struct sh_mobile_sdhi_of_data {
>  	unsigned long tmio_flags;
>  	unsigned long capabilities;
>  	unsigned long capabilities2;
> +	dma_addr_t dma_rx_offset;
>  };
>  
>  static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
> @@ -56,6 +57,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
>  	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>  	.capabilities2	= MMC_CAP2_NO_2BLKS_READ,
> +	.dma_rx_offset	= 0x2000,
>  };
>  
>  static const struct of_device_id sh_mobile_sdhi_of_match[] = {
> @@ -228,6 +230,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  		mmc_data->flags |= of_data->tmio_flags;
>  		mmc_data->capabilities |= of_data->capabilities;
>  		mmc_data->capabilities2 |= of_data->capabilities2;
> +		dma_priv->dma_rx_offset = of_data->dma_rx_offset;
>  	}
>  
>  	/* SD control register space size is 0x100, 0x200 for bus_shift=1 */
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index 03e7b28..1925170 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -311,7 +311,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
>  		if (pdata->dma->chan_priv_rx)
>  			cfg.slave_id = pdata->dma->slave_id_rx;
>  		cfg.direction = DMA_DEV_TO_MEM;
> -		cfg.src_addr = cfg.dst_addr;
> +		cfg.src_addr = cfg.dst_addr + pdata->dma->dma_rx_offset;
>  		cfg.dst_addr = 0;
>  		ret = dmaengine_slave_config(host->chan_rx, &cfg);
>  		if (ret < 0)

Ok, this is a useful fix. We did it by adding an option to specify
the DMA address in the DT.

Acked-by: Ben Dooks <ben-linux@fluff.org>


-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

