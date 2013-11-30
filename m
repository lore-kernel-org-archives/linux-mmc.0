From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on device
 id
Date: Fri, 29 Nov 2013 18:38:52 -0600
Message-ID: <5299339C.2040102@ti.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com> <1384396537-3486-3-git-send-email-tony@atomide.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51650 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898Ab3K3AjT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Nov 2013 19:39:19 -0500
In-Reply-To: <1384396537-3486-3-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 11/13/2013 08:35 PM, Tony Lindgren wrote:
> We are wrongly relying on device id for the DMA configuration
> which can lead to wrong DMA channel being selected.
> 
> Fix the issue by using the standard resources like we should.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.
> 
> ---
> 
>  drivers/mmc/host/omap.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index b94f38e..ed56868 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -90,17 +90,6 @@
>  #define OMAP_MMC_CMDTYPE_AC	2
>  #define OMAP_MMC_CMDTYPE_ADTC	3
>  
> -#define OMAP_DMA_MMC_TX		21
> -#define OMAP_DMA_MMC_RX		22
> -#define OMAP_DMA_MMC2_TX	54
> -#define OMAP_DMA_MMC2_RX	55
> -
> -#define OMAP24XX_DMA_MMC2_TX	47
> -#define OMAP24XX_DMA_MMC2_RX	48
> -#define OMAP24XX_DMA_MMC1_TX	61
> -#define OMAP24XX_DMA_MMC1_RX	62
> -
> -
>  #define DRIVER_NAME "mmci-omap"
>  
>  /* Specifies how often in millisecs to poll for card status changes
> @@ -1408,19 +1397,20 @@ static int mmc_omap_probe(struct platform_device *pdev)
>  	host->dma_tx_burst = -1;
>  	host->dma_rx_burst = -1;
>  
> -	if (mmc_omap2())
> -		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
> -	else
> -		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
> -	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> +	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> +	if (res)
> +		sig = res->start;
> +	host->dma_tx = dma_request_slave_channel_compat(mask,
> +				omap_dma_filter_fn, &sig, &pdev->dev, "tx");

Minor comment, since we're moving to DT-only for platforms using this driver
(hope I'm right about that), why not just do:
	dma_request_slave_channel_(&pdev->dev, "tx");

IORESOURCE_DMA is not created by OF layer so I guess no need to call
platform_get_resource either.

thanks,

-Joel

