From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not define
Date: Tue, 20 Jul 2010 10:09:13 +0300
Message-ID: <4C454B99.7090705@nokia.com>
References: <1279607878-2405-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1279607878-2405-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

Sukumar Ghorai wrote:
>     Issue if power_saving option passed from board file and CONFIG_PM not define.
>     This is because hosts refer to wrong operation table and that try to power save.

power_saving is not related to power management.  It should work with or without
CONFIG_PM.  What problem are you seeing?

> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Madhusudhan Chikkature <madhu.cr@ti.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Tested on omap3, omap4430 ES2.0
> 
>  drivers/mmc/host/omap_hsmmc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b032828..f84eed0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2015,9 +2015,11 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, host);
>  	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
>  
> +#ifdef CONFIG_PM
>  	if (mmc_slot(host).power_saving)
>  		mmc->ops	= &omap_hsmmc_ps_ops;
>  	else
> +#endif
>  		mmc->ops	= &omap_hsmmc_ops;
>  
>  	/*
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

