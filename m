From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2 2/7] mmc: sh_mmcif: Convert to PM macros when defining
 dev_pm_ops
Date: Wed, 30 Oct 2013 23:18:16 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1310302313270.25391@axis700.grange>
References: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
 <1382450846-17144-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56546 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab3J3WSU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 18:18:20 -0400
In-Reply-To: <1382450846-17144-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Ulf

On Tue, 22 Oct 2013, Ulf Hansson wrote:

> Use SET_SYSTEM_SLEEP_PM_OPS to simplify code.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/sh_mmcif.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 6bffebe..32bc412 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1538,7 +1538,7 @@ static int sh_mmcif_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int sh_mmcif_suspend(struct device *dev)
>  {
>  	struct sh_mmcif_host *host = dev_get_drvdata(dev);
> @@ -1552,10 +1552,7 @@ static int sh_mmcif_resume(struct device *dev)
>  {
>  	return 0;
>  }
> -#else
> -#define sh_mmcif_suspend	NULL
> -#define sh_mmcif_resume		NULL
> -#endif	/* CONFIG_PM */
> +#endif
>  
>  static const struct of_device_id mmcif_of_match[] = {
>  	{ .compatible = "renesas,sh-mmcif" },
> @@ -1564,8 +1561,7 @@ static const struct of_device_id mmcif_of_match[] = {
>  MODULE_DEVICE_TABLE(of, mmcif_of_match);
>  
>  static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
> -	.suspend = sh_mmcif_suspend,
> -	.resume = sh_mmcif_resume,
> +	SET_SYSTEM_SLEEP_PM_OPS(sh_mmcif_suspend, sh_mmcif_resume)
>  };

You could then even use SIMPLE_DEV_PM_OPS().

Thanks
Guennadi

>  
>  static struct platform_driver sh_mmcif_driver = {
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
