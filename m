From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-msm: avoid unused function warning
Date: Tue, 11 Dec 2018 09:33:49 +0200
Message-ID: <875b5f29-c486-5f49-653e-13cc94b4c16f@intel.com>
References: <20181210204546.2384299-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210204546.2384299-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vijay Viswanath <vviswana@codeaurora.org>, Evan Green <evgreen@chromium.org>, Sayali Lokhande <sayalil@codeaurora.org>, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, "weiyongjun (A)" <weiyongjun1@huawei.com>, Loic Poulain <loic.poulain@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 10/12/18 10:45 PM, Arnd Bergmann wrote:
> The newly added sdhci_msm_restore_sdr_dll_config() function is only
> called if CONFIG_PM is enabled:
> 
> drivers/mmc/host/sdhci-msm.c:1050:12: error: 'sdhci_msm_restore_sdr_dll_config' defined but not used [-Werror=unused-function]
> 
> Better remove the incorrect #ifdef altogether and just use __maybe_unused,
> which is harder to get wrong.
> 
> Fixes: ec3349733550 ("mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5497a71abe07..d6c9ebd8d263 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1997,8 +1997,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -static int sdhci_msm_runtime_suspend(struct device *dev)
> +static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -2010,7 +2009,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int sdhci_msm_runtime_resume(struct device *dev)
> +static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -2030,7 +2029,6 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> 
