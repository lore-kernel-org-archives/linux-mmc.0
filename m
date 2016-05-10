From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 12/23] mmc: sdhci-esdhc-imx: add esdhc specific suspend
 resume callback
Date: Tue, 10 May 2016 12:35:44 +0300
Message-ID: <5731AB70.30009@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-13-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:19270 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbcEJJjj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2016 05:39:39 -0400
In-Reply-To: <1460741387-23815-13-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> It will be used for platform specific suspend/resume state save/restore
> work for some low power mode like Mega/Fast or LPSR mode.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 03980db..6fef6bc 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1254,6 +1254,16 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  }
>  
>  #ifdef CONFIG_PM
> +static int sdhci_esdhc_suspend(struct device *dev)
> +{
> +	return sdhci_pltfm_suspend(dev);
> +}
> +
> +static int sdhci_esdhc_resume(struct device *dev)
> +{
> +	return sdhci_pltfm_resume(dev);
> +}
> +
>  static int sdhci_esdhc_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> @@ -1289,7 +1299,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>  #endif
>  
>  static const struct dev_pm_ops sdhci_esdhc_pmops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
>  	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
>  				sdhci_esdhc_runtime_resume, NULL)
>  };
> 

