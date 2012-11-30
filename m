From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: fix clock frequency printing
Date: Fri, 30 Nov 2012 18:02:39 +0900
Message-ID: <20121130090238.GH4501@verge.net.au>
References: <Pine.LNX.4.64.1211281023310.1710@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1211281023310.1710@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 28, 2012 at 10:24:13AM +0100, Guennadi Liakhovetski wrote:
> During its probing the SDHI driver prints out the clock frequency, but
> does it wrongly, always reporting 0Hz. Use the MMC host frequency value
> to fix this issue.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 22ac8e7..d6ff853 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -248,7 +248,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
>  		 mmc_hostname(host->mmc), (unsigned long)
>  		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
> -		 mmc_data->hclk / 1000000);
> +		 host->mmc->f_max / 1000000);
>  
>  	return ret;
>  
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
