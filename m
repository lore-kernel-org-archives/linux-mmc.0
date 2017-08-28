From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 4/4] mmc: sdhci-pltfm: export
 sdhci_pltfm_suspend/resume
Date: Mon, 28 Aug 2017 13:36:31 +0300
Message-ID: <7b5561d0-d0d8-f542-5eee-faab891c5aef@intel.com>
References: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
 <1503461703-16225-5-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503461703-16225-5-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, Hu Ziji <huziji@marvell.com>, Christian Daudt <csd@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 23/08/17 07:15, Masahiro Yamada wrote:
> This will be useful when drivers want to reuse either suspend or
> resume callback instead of whole of sdhci_pltfm_pmops.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci-cadence.c | 20 +-------------------
>  drivers/mmc/host/sdhci-pltfm.c   |  6 ++++--
>  drivers/mmc/host/sdhci-pltfm.h   |  2 ++
>  3 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 3dca3b3c6436..56529c3d389a 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -391,24 +391,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -static int sdhci_cdns_suspend(struct device *dev)
> -{
> -	struct sdhci_host *host = dev_get_drvdata(dev);
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	int ret;
> -
> -	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> -		mmc_retune_needed(host->mmc);
> -
> -	ret = sdhci_suspend_host(host);
> -	if (ret)
> -		return ret;
> -
> -	clk_disable_unprepare(pltfm_host->clk);
> -
> -	return 0;
> -}
> -
>  static int sdhci_cdns_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> @@ -438,7 +420,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  #endif
>  
>  static const struct dev_pm_ops sdhci_cdns_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(sdhci_cdns_suspend, sdhci_cdns_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_cdns_resume)
>  };
>  
>  static const struct of_device_id sdhci_cdns_match[] = {
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 4c0135e184e9..02bea6159d79 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -209,7 +209,7 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
>  EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
>  
>  #ifdef CONFIG_PM_SLEEP
> -static int sdhci_pltfm_suspend(struct device *dev)
> +int sdhci_pltfm_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -226,8 +226,9 @@ static int sdhci_pltfm_suspend(struct device *dev)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_pltfm_suspend);
>  
> -static int sdhci_pltfm_resume(struct device *dev)
> +int sdhci_pltfm_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -243,6 +244,7 @@ static int sdhci_pltfm_resume(struct device *dev)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_pltfm_resume);
>  #endif
>  
>  const struct dev_pm_ops sdhci_pltfm_pmops = {
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 957839d0fe37..1e91fb1c020e 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -109,6 +109,8 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
>  	return host->private;
>  }
>  
> +int sdhci_pltfm_suspend(struct device *dev);
> +int sdhci_pltfm_resume(struct device *dev);
>  extern const struct dev_pm_ops sdhci_pltfm_pmops;
>  
>  #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> 
