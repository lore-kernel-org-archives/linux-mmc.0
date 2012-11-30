From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: remove unneeded clock connection ID
Date: Fri, 30 Nov 2012 17:59:04 +0900
Message-ID: <20121130085903.GF4501@verge.net.au>
References: <Pine.LNX.4.64.1211281016550.1710@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1211281016550.1710@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 28, 2012 at 10:24:21AM +0100, Guennadi Liakhovetski wrote:
> SDHI only uses one clock, all ARM and SuperH platform register SDHI clock
> lookup entries with no connection ID, hence it can be dropped in the
> driver too.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 0bdc146..22ac8e7 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -123,7 +123,6 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	struct tmio_mmc_data *mmc_data;
>  	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
>  	struct tmio_mmc_host *host;
> -	char clk_name[8];
>  	int irq, ret, i = 0;
>  	bool multiplexed_isr = true;
>  
> @@ -144,11 +143,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
> -	priv->clk = clk_get(&pdev->dev, clk_name);
> +	priv->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(priv->clk)) {
> -		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
>  		ret = PTR_ERR(priv->clk);
> +		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
>  		goto eclkget;
>  	}
>  
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
