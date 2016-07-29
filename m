From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 08/11] mmc: sdhci-esdhc-imx: Use common
 sdhci_suspend|resume_host()
Date: Fri, 29 Jul 2016 16:39:08 +0800
Message-ID: <20160729083908.GB21177@shlinux2>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
 <1469619127-29283-9-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33081 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcG2Iro (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2016 04:47:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id i6so5126880pfe.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jul 2016 01:47:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1469619127-29283-9-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>

On Wed, Jul 27, 2016 at 01:32:04PM +0200, Ulf Hansson wrote:
> To prepare to make the sdhci_pltfm_suspend|resume() static functions, move
> sdhci-esdhc-imx over to use the sdhci_suspend|resume_host().
> 

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f5768a6..99e0b33 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1296,7 +1296,9 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int sdhci_esdhc_suspend(struct device *dev)
>  {
> -	return sdhci_pltfm_suspend(dev);
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +	return sdhci_suspend_host(host);
>  }
>  
>  static int sdhci_esdhc_resume(struct device *dev)
> @@ -1306,7 +1308,7 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	/* re-initialize hw state in case it's lost in low power mode */
>  	sdhci_esdhc_imx_hwinit(host);
>  
> -	return sdhci_pltfm_resume(dev);
> +	return sdhci_resume_host(host);
>  }
>  #endif
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
