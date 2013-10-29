From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 08/12] mmc: sh_mobile_sdhi: Convert to clk_prepare/unprepare
Date: Tue, 29 Oct 2013 09:09:37 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1310290907520.8404@axis700.grange>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1383000569-8916-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 28 Oct 2013, Laurent Pinchart wrote:

> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> clk_disable_unprepare() to get ready for the migration to the common
> clock framework.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index f344659..ed1718a 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -54,7 +54,7 @@ static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int
>  	struct mmc_host *mmc = platform_get_drvdata(pdev);
>  	struct tmio_mmc_host *host = mmc_priv(mmc);
>  	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
> -	int ret = clk_enable(priv->clk);
> +	int ret = clk_prepare_enable(priv->clk);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -67,7 +67,7 @@ static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
>  	struct mmc_host *mmc = platform_get_drvdata(pdev);
>  	struct tmio_mmc_host *host = mmc_priv(mmc);
>  	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
> -	clk_disable(priv->clk);
> +	clk_disable_unprepare(priv->clk);
>  }
>  
>  static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
> -- 
> 1.8.1.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
