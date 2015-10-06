From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] mmc: omap: Fix module autoload for OF platform driver
Date: Tue, 6 Oct 2015 01:09:36 -0700
Message-ID: <20151006080935.GK23801@atomide.com>
References: <20150917215025.GA8079@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150917215025.GA8079@goodgumbo.baconseed.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Luis de Bethencourt <luis@debethencourt.com> [150917 14:54]:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Looks OK to me, this would be mostly for n8x0:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/mmc/host/omap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index b763b11..b9958a1 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1490,6 +1490,7 @@ static const struct of_device_id mmc_omap_match[] = {
>  	{ .compatible = "ti,omap2420-mmc", },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, mmc_omap_match);
>  #endif
>  
>  static struct platform_driver mmc_omap_driver = {
> -- 
> 2.4.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
