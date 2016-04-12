From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: Move sdhci_runtime_pm_bus_off|on() to avoid
 pre-definition
Date: Tue, 12 Apr 2016 14:24:52 +0300
Message-ID: <570CDB04.8070305@intel.com>
References: <1460381561-12511-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8040 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307AbcDLL2g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2016 07:28:36 -0400
In-Reply-To: <1460381561-12511-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 11/04/16 16:32, Ulf Hansson wrote:
> There are no need to have two versions of sdhci_runtime_pm_bus_off|on(),
> depending on whether CONFIG_PM is set or unset. Thus it's easy to move the
> implementation of these functions a bit earlier to avoid the unnecessary
> pre-definition of them, so let's do that.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci.c | 44 ++++++++++++++++----------------------------
>  1 file changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8e74e75..c6dbe65 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -55,18 +55,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>  static int sdhci_do_get_cd(struct sdhci_host *host);
>  
> -#ifdef CONFIG_PM
> -static void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
> -static void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
> -#else
> -static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> -{
> -}
> -static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> -{
> -}
> -#endif
> -
>  static void sdhci_dumpregs(struct sdhci_host *host)
>  {
>  	pr_debug(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
> @@ -161,6 +149,22 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
>  	sdhci_set_card_detection(host, false);
>  }
>  
> +static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> +{
> +	if (host->bus_on)
> +		return;
> +	host->bus_on = true;
> +	pm_runtime_get_noresume(host->mmc->parent);
> +}
> +
> +static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> +{
> +	if (!host->bus_on)
> +		return;
> +	host->bus_on = false;
> +	pm_runtime_put_noidle(host->mmc->parent);
> +}
> +
>  void sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	unsigned long timeout;
> @@ -2667,22 +2671,6 @@ int sdhci_resume_host(struct sdhci_host *host)
>  
>  EXPORT_SYMBOL_GPL(sdhci_resume_host);
>  
> -static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> -{
> -	if (host->bus_on)
> -		return;
> -	host->bus_on = true;
> -	pm_runtime_get_noresume(host->mmc->parent);
> -}
> -
> -static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> -{
> -	if (!host->bus_on)
> -		return;
> -	host->bus_on = false;
> -	pm_runtime_put_noidle(host->mmc->parent);
> -}
> -
>  int sdhci_runtime_suspend_host(struct sdhci_host *host)
>  {
>  	unsigned long flags;
> 

