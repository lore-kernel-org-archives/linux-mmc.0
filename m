From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
	initialization
Date: Mon, 23 Apr 2012 15:14:15 +0100
Message-ID: <20120423141415.GA24299@n2100.arm.linux.org.uk>
References: <20120418210142.GR21106@atomide.com> <20120418211606.GU25053@n2100.arm.linux.org.uk> <20120418213642.GV25053@n2100.arm.linux.org.uk> <20120419013914.GV21106@atomide.com> <20120419174332.GY25053@n2100.arm.linux.org.uk> <20120419180741.GX21106@atomide.com> <20120420151034.GA24205@n2100.arm.linux.org.uk> <20120420152623.GA21106@atomide.com> <20120420153743.GB24205@n2100.arm.linux.org.uk> <20120420164957.GC21106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120420164957.GC21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 20, 2012 at 09:50:00AM -0700, Tony Lindgren wrote:
> Then something like this is still needed on top of your original mmc driver
> patch for omap2420:
> 
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1617,11 +1617,14 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
>  	host->dma_tx_burst = -1;
>  	host->dma_rx_burst = -1;
>  
> -	sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
> +	if (cpu_is_omap24xx())
> +		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX :  OMAP24XX_DMA_MMC2_TX;
> +	else
> +		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
>  	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
>  #if 0
>  	if (!host->dma_tx) {
> -		def_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
> +		dev_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
>  			sig);
>  		goto err_dma;
>  	}
> @@ -1632,7 +1635,10 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
>  #endif
>  #endif
>  #ifdef USE_DMA_ENGINE
> -	sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
> +	if (cpu_is_omap24xx())
> +		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX :  OMAP24XX_DMA_MMC2_RX;
> +	else
> +		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
>  	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
>  #if 0
>  	if (!host->dma_rx) {

Is there any chance this DMA signal information could be moved into
platform resources, like omap_hsmmc has done?  I could then get rid
of the plat/dma.h dependence from this driver.
