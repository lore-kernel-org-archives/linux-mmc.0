From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 8 Sep 2016 11:02:37 +0300
Message-ID: <a0e314de-3590-399c-27c7-ddd6461dee42@intel.com>
References: <20160901142335.2396-1-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160901142335.2396-1-pramod.gurav@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 01/09/16 17:23, Pramod Gurav wrote:
> Provides runtime PM callbacks to enable and disable clock resources
> when idle. Also support system PM callbacks to be called during system
> suspend and resume.
> 
> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>

Can we get some Tested/Reviewed/Acked-by from people using this driver?

> ---
> Changes in v3:
> - Added CONFIG_PM around runtime pm function.
> - Replaced msm suspend/resume with generic function directly
> - Use SET_SYSTEM_SLEEP_PM_OPS instead of late version
> 
> Changes in v2:
> - Moved pm_rutime enabling before adding host
> - Handled pm_rutime in remove
> - Changed runtime handling with reference from sdhci-of-at91.c
> 
>  drivers/mmc/host/sdhci-msm.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ef44a2a..0ef4f29 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_device.h>
>  #include <linux/delay.h>
>  #include <linux/mmc/mmc.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  
>  #include "sdhci-pltfm.h"
> @@ -658,12 +659,26 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +
>  	ret = sdhci_add_host(host);
>  	if (ret)
> -		goto clk_disable;
> +		goto pm_runtime_disable;
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	return 0;
>  
> +pm_runtime_disable:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
>  clk_disable:
>  	clk_disable_unprepare(msm_host->clk);
>  pclk_disable:
> @@ -685,6 +700,11 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>  		    0xffffffff);
>  
>  	sdhci_remove_host(host, dead);
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
>  	clk_disable_unprepare(msm_host->clk);
>  	clk_disable_unprepare(msm_host->pclk);
>  	if (!IS_ERR(msm_host->bus_clk))
> @@ -693,12 +713,61 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int sdhci_msm_runtime_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(msm_host->clk);
> +	clk_disable_unprepare(msm_host->pclk);
> +
> +	return 0;
> +}
> +
> +static int sdhci_msm_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = clk_prepare_enable(msm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "clk_enable failed: %d\n", ret);
> +		return ret;
> +	}
> +	ret = clk_prepare_enable(msm_host->pclk);
> +	if (ret) {
> +		dev_err(dev, "clk_enable failed: %d\n", ret);
> +		clk_disable_unprepare(msm_host->clk);
> +		return ret;
> +	}
> +
> +	return sdhci_runtime_resume_host(host);
> +}
> +#endif
> +
> +static const struct dev_pm_ops sdhci_msm_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +					pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume,
> +				NULL)
> +};
> +
>  static struct platform_driver sdhci_msm_driver = {
>  	.probe = sdhci_msm_probe,
>  	.remove = sdhci_msm_remove,
>  	.driver = {
>  		   .name = "sdhci_msm",
>  		   .of_match_table = sdhci_msm_dt_match,
> +		   .pm = &sdhci_msm_pm_ops,
>  	},
>  };
>  
> 
