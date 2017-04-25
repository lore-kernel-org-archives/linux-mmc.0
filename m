From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: arasan: adapt to runtime pm
Date: Tue, 25 Apr 2017 13:17:58 +0300
Message-ID: <77e3c31a-69df-a71e-47d8-da0e3924c4aa@intel.com>
References: <1492667088-20866-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50149 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1176297AbdDYKXn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Apr 2017 06:23:43 -0400
In-Reply-To: <1492667088-20866-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com

On 20/04/17 08:44, Shubhrajyoti Datta wrote:
> Currently the clock are enabled at probe and released at driver
> removal. This moves to enable before mmc read/ write and disables
> after it.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 50 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 1cfd7f9..812e75a 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include "sdhci-pltfm.h"
>  #include <linux/of.h>
> @@ -373,10 +374,44 @@ static int sdhci_arasan_resume(struct device *dev)
>  
>  	return sdhci_resume_host(host);
>  }
> +

Runtime PM is under CONFIG_PM not CONFIG_PM_SLEEP

> +static int sdhci_arasan_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = sdhci_runtime_suspend_host(host);

Other drivers now have:

	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
		mmc_retune_needed(host->mmc);

If you don't need re-tuning, maybe add a comment so we know.

> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	clk_disable_unprepare(sdhci_arasan->clk_ahb);
> +
> +	return ret;
> +}
> +
> +static int sdhci_arasan_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +
> +	clk_prepare_enable(pltfm_host->clk);
> +	clk_prepare_enable(sdhci_arasan->clk_ahb);
> +
> +	return sdhci_runtime_resume_host(host);
> +}
>  #endif /* ! CONFIG_PM_SLEEP */
>  
> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
> -			 sdhci_arasan_resume);
> +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend,
> +				sdhci_arasan_resume)
> +	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> +			   sdhci_arasan_runtime_resume,
> +			   NULL)
> +};
>  
>  static const struct of_device_id sdhci_arasan_of_match[] = {
>  	/* SoC-specific compatible strings w/ soc_ctl_map */
> @@ -637,6 +672,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto clk_dis_ahb;
>  	}
>  
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +
>  	sdhci_get_of_property(pdev);
>  
>  	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
> @@ -687,6 +728,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_add_host;
>  
> +	pm_runtime_put(&pdev->dev);
>  	return 0;
>  
>  err_add_host:
> @@ -695,6 +737,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  unreg_clk:
>  	sdhci_arasan_unregister_sdclk(&pdev->dev);
>  clk_disable_all:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
>  	clk_disable_unprepare(clk_xin);
>  clk_dis_ahb:
>  	clk_disable_unprepare(sdhci_arasan->clk_ahb);
> @@ -723,6 +768,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(clk_ahb);
>  
> +	pm_runtime_disable(&pdev->dev);
>  	return ret;
>  }
>  
> 

