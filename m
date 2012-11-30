From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mmcif: remove unneeded clock connection ID
Date: Fri, 30 Nov 2012 18:02:24 +0900
Message-ID: <20121130090224.GG4501@verge.net.au>
References: <Pine.LNX.4.64.1211281006340.1710@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1211281006340.1710@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 28, 2012 at 10:24:27AM +0100, Guennadi Liakhovetski wrote:
> MMCIF only uses one clock, all ARM and SuperH platforms register MMCIF
> clock lookup entries with no connection ID, hence it can be dropped in
> the driver too.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/mmc/host/sh_mmcif.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index d25bc97..358295e 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1310,7 +1310,6 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
>  	struct sh_mmcif_plat_data *pd = pdev->dev.platform_data;
>  	struct resource *res;
>  	void __iomem *reg;
> -	char clk_name[8];
>  
>  	irq[0] = platform_get_irq(pdev, 0);
>  	irq[1] = platform_get_irq(pdev, 1);
> @@ -1360,11 +1359,10 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  	host->power = false;
>  
> -	snprintf(clk_name, sizeof(clk_name), "mmc%d", pdev->id);
> -	host->hclk = clk_get(&pdev->dev, clk_name);
> +	host->hclk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(host->hclk)) {
>  		ret = PTR_ERR(host->hclk);
> -		dev_err(&pdev->dev, "cannot get clock \"%s\": %d\n", clk_name, ret);
> +		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
>  		goto eclkget;
>  	}
>  	ret = sh_mmcif_clk_update(host);
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
