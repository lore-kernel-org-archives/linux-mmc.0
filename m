From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RESEND PATCH v4 3/3] mmc: sdhci-of-arasan: add runtime pm
 support
Date: Thu, 22 Oct 2015 11:44:26 +0200
Message-ID: <5628AFFA.5040206@xilinx.com>
References: <1445504810-5642-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445504810-5642-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 10/22/2015 11:06 AM, Shawn Lin wrote:
> This patch add runtime_suspend and runtime_resume for
> sdhci-of-arasan. Currently we also power-off phy at
> runtime_suspend for power-saving.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Serise-changes: 4
> - remove ifdef for PM callback statement
> - fix missing pm_runtime_set_active
> - remove pm_runtime_dont_use_autosuspend from remove hook
> - add pm_runtime_force_suspend|resume for PM callback to
>   deal with suspend invoked from rpm
> - remove wrappers of phy ops
> 
> ---
> 
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 85 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 4f30716..fb1915c 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -30,6 +30,8 @@
>  #define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
>  #define CLK_CTRL_TIMEOUT_MIN_EXP	13
>  
> +#define ARASAN_RPM_DELAY_MS		50
> +
>  /**
>   * struct sdhci_arasan_data
>   * @clk_ahb:	Pointer to the AHB clock
> @@ -71,6 +73,46 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
>  			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>  
> +#ifdef CONFIG_PM
> +static int sdhci_arasan_runtime_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
> +	int ret;
> +
> +	ret = sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_ERR(sdhci_arasan->phy))
> +		phy_power_off(sdhci_arasan->phy);
> +
> +	clk_disable(sdhci_arasan->clk_ahb);
> +	clk_disable(pltfm_host->clk);
> +
> +	return 0;
> +}
> +
> +static int sdhci_arasan_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
> +
> +	clk_enable(pltfm_host->clk);
> +	clk_enable(sdhci_arasan->clk_ahb);
> +
> +	if (!IS_ERR(sdhci_arasan->phy))
> +		phy_power_on(sdhci_arasan->phy);
> +
> +	return sdhci_runtime_resume_host(host);
> +}
> +#else
> +#define sdhci_arasan_runtime_suspend NULL
> +#define sdhci_arasan_runtime_resume NULL

Remove these 3 lines - they are not needed.

> +#endif
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -87,6 +129,12 @@ static int sdhci_arasan_suspend(struct device *dev)
>  	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>  	int ret;
>  
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		dev_err(dev, "problem force suspending\n");
> +		return ret;
> +	}
> +
>  	ret = sdhci_suspend_host(host);
>  	if (ret)
>  		return ret;
> @@ -140,18 +188,39 @@ static int sdhci_arasan_resume(struct device *dev)
>  		}
>  	}
>  
> -	return sdhci_resume_host(host);
> +	ret = sdhci_resume_host(host);
> +	if (ret)
> +		goto err_resume_host;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret) {
> +		dev_err(dev, "problem force resuming\n");
> +		goto err_force_resume;
> +	}
> +
> +	return 0;
>  
> +err_force_resume:
> +	sdhci_suspend_host(host);
> +err_resume_host:
> +	if (!IS_ERR(sdhci_arasan->phy))
> +		phy_power_off(sdhci_arasan->phy);
>  err_phy_power:
>  	clk_disable(pltfm_host->clk);
>  err_clk_en:
>  	clk_disable(sdhci_arasan->clk_ahb);
>  	return ret;
>  }
> +#else
> +#define sdhci_arasan_suspend NULL
> +#define sdhci_arasan_resume NULL

Remove these 3 lines - they are not needed.

Thanks,
Michal
