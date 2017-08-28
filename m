From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-xenon: add runtime pm support
Date: Mon, 28 Aug 2017 14:49:26 +0300
Message-ID: <c7a8ee1b-2698-1afa-6fc7-fb75694bc6b0@intel.com>
References: <1503613178-26912-1-git-send-email-zjwu@marvell.com>
 <1503613178-26912-2-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:34859 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbdH1L4I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Aug 2017 07:56:08 -0400
In-Reply-To: <1503613178-26912-2-git-send-email-zjwu@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, xswang@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

On 25/08/17 01:19, Zhoujie Wu wrote:
> Enable runtime pm support for xenon controller, which uses 50ms
> auto runtime suspend by default.

This patch seems to break system system.  Does it really make sense to have
2 separate patches?  Maybe consider putting them together.

> 
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 306ffaf..517ff2e 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -18,6 +18,8 @@
>  #include <linux/ktime.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "sdhci-pltfm.h"
>  #include "sdhci-xenon.h"
> @@ -506,13 +508,24 @@ static int xenon_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_clk;
>  
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);

I would expect to see a corresponding pm_runtime_disable() in xenon_remove()
e.g.

	pm_runtime_get_sync(dev);
	pm_runtime_disable(dev);
	pm_runtime_put_noidle(dev);

	sdhci_remove_host(host, 0);

> +	pm_suspend_ignore_children(&pdev->dev, 1);
> +
>  	err = sdhci_add_host(host);
>  	if (err)
>  		goto remove_sdhc;
>  
> +	pm_runtime_put_autosuspend(&pdev->dev);
> +
>  	return 0;
>  
>  remove_sdhc:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
>  	xenon_sdhc_unprepare(host);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
> @@ -577,6 +590,52 @@ static int xenon_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
>  
> +#ifdef CONFIG_PM
> +static int xenon_runtime_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = sdhci_runtime_suspend_host(host);
> +
> +	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +		mmc_retune_needed(host->mmc);
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	/*
> +	 * Need to update the priv->clock here, or when runtime resume
> +	 * back, phy don't aware the clock change and won't adjust phy
> +	 * which will cause cmd err
> +	 */
> +	priv->clock = 0;
> +	return ret;
> +}
> +
> +static int xenon_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	int ret;
> +
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable mainck\n");
> +		return ret;
> +	}
> +
> +	return sdhci_runtime_resume_host(host);
> +}
> +#endif /* CONFIG_PM */
> +
> +static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
> +	SET_RUNTIME_PM_OPS(xenon_runtime_suspend,
> +			   xenon_runtime_resume,
> +			   NULL)
> +};
> +
> +
>  static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  	{ .compatible = "marvell,armada-ap806-sdhci",},
>  	{ .compatible = "marvell,armada-cp110-sdhci",},
> @@ -589,7 +648,7 @@ static int xenon_resume(struct device *dev)
>  	.driver	= {
>  		.name	= "xenon-sdhci",
>  		.of_match_table = sdhci_xenon_dt_ids,
> -		.pm = &xenon_pmops,
> +		.pm = &sdhci_xenon_dev_pm_ops,
>  	},
>  	.probe	= xenon_probe,
>  	.remove	= xenon_remove,
> 

