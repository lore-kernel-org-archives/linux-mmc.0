From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/3] mmc: tmio: Adapt to proper PM configs for exported
 functions
Date: Tue, 5 Nov 2013 23:29:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1311052329270.3700@axis700.grange>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <1383653403-10049-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54755 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab3KEW3o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Nov 2013 17:29:44 -0500
In-Reply-To: <1383653403-10049-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Tue, 5 Nov 2013, Ulf Hansson wrote:

> Since the users of the exported PM functions are now using the modern
> PM ops macros, we can convert to the proper corresponding PM configs.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  drivers/mmc/host/tmio_mmc.h     |    7 +++----
>  drivers/mmc/host/tmio_mmc_pio.c |    7 ++++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 86fd21e..6c5b45a 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -163,16 +163,15 @@ static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
>  }
>  #endif
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  int tmio_mmc_host_suspend(struct device *dev);
>  int tmio_mmc_host_resume(struct device *dev);
> -#else
> -#define tmio_mmc_host_suspend NULL
> -#define tmio_mmc_host_resume NULL
>  #endif
>  
> +#ifdef CONFIG_PM_RUNTIME
>  int tmio_mmc_host_runtime_suspend(struct device *dev);
>  int tmio_mmc_host_runtime_resume(struct device *dev);
> +#endif
>  
>  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
>  {
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index f3b2d8c..472e803 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1140,7 +1140,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>  }
>  EXPORT_SYMBOL(tmio_mmc_host_remove);
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  int tmio_mmc_host_suspend(struct device *dev)
>  {
>  	struct mmc_host *mmc = dev_get_drvdata(dev);
> @@ -1163,9 +1163,9 @@ int tmio_mmc_host_resume(struct device *dev)
>  	return 0;
>  }
>  EXPORT_SYMBOL(tmio_mmc_host_resume);
> +#endif
>  
> -#endif	/* CONFIG_PM */
> -
> +#ifdef CONFIG_PM_RUNTIME
>  int tmio_mmc_host_runtime_suspend(struct device *dev)
>  {
>  	return 0;
> @@ -1182,5 +1182,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
> +#endif
>  
>  MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
