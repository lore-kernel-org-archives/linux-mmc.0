From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 07/11] mmc: sdhci-esdhc-imx: Assign system PM ops within
 #ifdef CONFIG_PM_SLEEP
Date: Fri, 29 Jul 2016 16:38:02 +0800
Message-ID: <20160729083802.GA21177@shlinux2>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
 <1469619127-29283-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32872 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcG2Iql (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2016 04:46:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id i6so5125429pfe.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jul 2016 01:46:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1469619127-29283-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dong Aisheng <aisheng.dong@nxp.com>

On Wed, Jul 27, 2016 at 01:32:03PM +0200, Ulf Hansson wrote:
> The system PM callbacks isn't used unless CONFIG_PM_SLEEP is set, thus it
> triggers a compiler warning about unused functions. Avoid this by changing
> from CONFIG_PM to CONFIG_PM_SLEEP.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b70d0b3b5b29 ("mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback")
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>


Thanks for the clean up.
I'm okay with the either way as you discussed with Arnd.

So
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2bb326b..f5768a6 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1293,7 +1293,7 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int sdhci_esdhc_suspend(struct device *dev)
>  {
>  	return sdhci_pltfm_suspend(dev);
> @@ -1308,7 +1308,9 @@ static int sdhci_esdhc_resume(struct device *dev)
>  
>  	return sdhci_pltfm_resume(dev);
>  }
> +#endif
>  
> +#ifdef CONFIG_PM
>  static int sdhci_esdhc_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
