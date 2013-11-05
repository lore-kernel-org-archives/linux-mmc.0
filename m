From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/3] mmc: sh_mobile_sdhi: Use modern PM macros to define
 pm callbacks
Date: Tue, 5 Nov 2013 23:29:20 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1311052328490.3700@axis700.grange>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <1383653403-10049-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57446 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab3KEW31 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Nov 2013 17:29:27 -0500
In-Reply-To: <1383653403-10049-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Tue, 5 Nov 2013, Ulf Hansson wrote:

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 87ed3fb..2227a9f 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -297,10 +297,10 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
>  }
>  
>  static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
> -	.suspend = tmio_mmc_host_suspend,
> -	.resume = tmio_mmc_host_resume,
> -	.runtime_suspend = tmio_mmc_host_runtime_suspend,
> -	.runtime_resume = tmio_mmc_host_runtime_resume,
> +	SET_SYSTEM_SLEEP_PM_OPS(tmio_mmc_host_suspend, tmio_mmc_host_resume)
> +	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
> +			tmio_mmc_host_runtime_resume,
> +			NULL)
>  };
>  
>  static struct platform_driver sh_mobile_sdhi_driver = {
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
