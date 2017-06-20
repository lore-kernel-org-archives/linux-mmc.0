From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-at91: set clocks and presets after
 resume from deepest PM
Date: Tue, 20 Jun 2017 10:39:36 +0300
Message-ID: <6acdfd61-afb8-e0cf-b8d3-b2e81bd71569@intel.com>
References: <20170616072929.3266-1-quentin.schulz@free-electrons.com>
 <20170616072929.3266-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51784 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbdFTHpp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Jun 2017 03:45:45 -0400
In-Reply-To: <20170616072929.3266-2-quentin.schulz@free-electrons.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, ludovic.desroches@microchip.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com

On 16/06/17 10:29, Quentin Schulz wrote:
> This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
> SoC's SDHCI controller.
> 
> When resuming from deepest state, it is required to restore preset
> registers as the registers are lost since VDD core has been shut down
> when entering deepest state on the SAMA5D2. The clocks need to be
> reconfigured as well.
> 
> The other registers and init process are taken care of by the SDHCI
> core.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mmc/host/sdhci-of-at91.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index fb8c6011f13d..300513fc1068 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -207,6 +207,37 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  }
>  
>  #ifdef CONFIG_PM

Should be CONFIG_PM_SLEEP for suspend / resume callbacks.

> +static int sdhci_at91_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = sdhci_suspend_host(host);
> +
> +	if (host->runtime_suspended)
> +		return ret;

Suspending while runtime suspended seems like a bad idea.  Have you
considered just adding sdhci_at91_set_clks_presets() to
sdhci_at91_runtime_resume()?

> +
> +	clk_disable_unprepare(priv->gck);
> +	clk_disable_unprepare(priv->hclock);
> +	clk_disable_unprepare(priv->mainck);
> +
> +	return ret;
> +}
> +
> +static int sdhci_at91_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = sdhci_at91_set_clks_presets(dev);
> +	if (ret)
> +		return ret;
> +
> +	return sdhci_resume_host(host);
> +}
> +
>  static int sdhci_at91_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> @@ -256,8 +287,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>  #endif /* CONFIG_PM */
>  
>  static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_at91_suspend, sdhci_at91_resume)
>  	SET_RUNTIME_PM_OPS(sdhci_at91_runtime_suspend,
>  			   sdhci_at91_runtime_resume,
>  			   NULL)
> 

