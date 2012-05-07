From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 07/10] mmc: mxs-mmc: copy wp_gpio in struct mxs_mmc_host
Date: Tue, 8 May 2012 01:53:44 +0200
Message-ID: <201205080153.44313.marex@denx.de>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org> <1336401793-13753-8-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56974 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953Ab2EGX6g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 19:58:36 -0400
In-Reply-To: <1336401793-13753-8-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>

Dear Shawn Guo,

> It has wp_gpio copied in struct mxs_mmc_host from platform_data,

Copy wp_gpio into struct ...

> so that the use of platform_data can be limited in probe function,
> which will ease the device tree probe.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Otherwise
Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/mmc/host/mxs-mmc.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index e905721..66f792a 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -160,21 +160,17 @@ struct mxs_mmc_host {
>  	unsigned char			bus_width;
>  	spinlock_t			lock;
>  	int				sdio_irq_en;
> +	int				wp_gpio;
>  };
> 
>  static int mxs_mmc_get_ro(struct mmc_host *mmc)
>  {
>  	struct mxs_mmc_host *host = mmc_priv(mmc);
> -	struct mxs_mmc_platform_data *pdata =
> -		mmc_dev(host->mmc)->platform_data;
> 
> -	if (!pdata)
> -		return -EFAULT;
> -
> -	if (!gpio_is_valid(pdata->wp_gpio))
> +	if (!gpio_is_valid(host->wp_gpio))
>  		return -EINVAL;
> 
> -	return gpio_get_value(pdata->wp_gpio);
> +	return gpio_get_value(host->wp_gpio);
>  }
> 
>  static int mxs_mmc_get_cd(struct mmc_host *mmc)
> @@ -758,6 +754,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
>  		if (pdata->flags & SLOTF_4_BIT_CAPABLE)
>  			mmc->caps |= MMC_CAP_4_BIT_DATA;
> +		host->wp_gpio = pdata->wp_gpio;
>  	}
> 
>  	mmc->f_min = 400000;

Best regards,
Marek Vasut
