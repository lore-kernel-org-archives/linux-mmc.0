From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 7/8] mmc: sdhci: Remove redundant runtime PM calls
Date: Fri, 1 Apr 2016 10:46:01 +0300
Message-ID: <56FE2739.2030100@intel.com>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
 <1459236673-5639-7-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49023 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbcDAHtm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Apr 2016 03:49:42 -0400
In-Reply-To: <1459236673-5639-7-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 29/03/16 10:31, Ulf Hansson wrote:
> Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
> devices"), made some calls to the runtime PM API from the driver
> redundant. Especially those which deals with runtime PM reference
> counting, so let's remove them.
> 
> Moreover as SDHCI have its own wrapper functions for runtime PM these
> becomes superfluous, so let's remove them as well.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks good, but I have one comment below.

> ---
>  drivers/mmc/host/sdhci.c | 56 ++++++------------------------------------------
>  1 file changed, 7 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8670f16..4bb9bfd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -56,19 +56,9 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>  static int sdhci_do_get_cd(struct sdhci_host *host);
>  
>  #ifdef CONFIG_PM
> -static int sdhci_runtime_pm_get(struct sdhci_host *host);
> -static int sdhci_runtime_pm_put(struct sdhci_host *host);
>  static void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
>  static void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
>  #else
> -static inline int sdhci_runtime_pm_get(struct sdhci_host *host)
> -{
> -	return 0;
> -}
> -static inline int sdhci_runtime_pm_put(struct sdhci_host *host)
> -{
> -	return 0;
> -}
>  static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
>  {
>  }
> @@ -1298,8 +1288,6 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  	host = mmc_priv(mmc);
>  
> -	sdhci_runtime_pm_get(host);
> -
>  	/* Firstly check card presence */
>  	present = mmc->ops->get_cd(mmc);
>  
> @@ -1546,9 +1534,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  
> -	sdhci_runtime_pm_get(host);
>  	sdhci_do_set_ios(host, ios);
> -	sdhci_runtime_pm_put(host);
>  }
>  
>  static int sdhci_do_get_cd(struct sdhci_host *host)
> @@ -1580,12 +1566,8 @@ static int sdhci_do_get_cd(struct sdhci_host *host)
>  static int sdhci_get_cd(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	int ret;
>  
> -	sdhci_runtime_pm_get(host);
> -	ret = sdhci_do_get_cd(host);
> -	sdhci_runtime_pm_put(host);
> -	return ret;
> +	return sdhci_do_get_cd(host);
>  }
>  
>  static int sdhci_check_ro(struct sdhci_host *host)
> @@ -1641,12 +1623,8 @@ static void sdhci_hw_reset(struct mmc_host *mmc)
>  static int sdhci_get_ro(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	int ret;
>  
> -	sdhci_runtime_pm_get(host);
> -	ret = sdhci_do_get_ro(host);
> -	sdhci_runtime_pm_put(host);
> -	return ret;
> +	return sdhci_do_get_ro(host);
>  }
>  
>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
> @@ -1668,7 +1646,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
>  
> -	sdhci_runtime_pm_get(host);
> +	pm_runtime_get_sync(mmc_dev(mmc));

Why can't this be moved into the core as well?  At the least, there should
be a comment here and explanation in the commit message.

>  
>  	spin_lock_irqsave(&host->lock, flags);
>  	if (enable)
> @@ -1679,7 +1657,8 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	sdhci_enable_sdio_irq_nolock(host, enable);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	sdhci_runtime_pm_put(host);
> +	pm_runtime_mark_last_busy(mmc_dev(mmc));
> +	pm_runtime_put_autosuspend(mmc_dev(mmc));
>  }
>  
>  static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
> @@ -1777,14 +1756,11 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  	struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	int err;
>  
>  	if (host->version < SDHCI_SPEC_300)
>  		return 0;
> -	sdhci_runtime_pm_get(host);
> -	err = sdhci_do_start_signal_voltage_switch(host, ios);
> -	sdhci_runtime_pm_put(host);
> -	return err;
> +
> +	return sdhci_do_start_signal_voltage_switch(host, ios);
>  }
>  
>  static int sdhci_card_busy(struct mmc_host *mmc)
> @@ -1792,10 +1768,8 @@ static int sdhci_card_busy(struct mmc_host *mmc)
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	u32 present_state;
>  
> -	sdhci_runtime_pm_get(host);
>  	/* Check whether DAT[3:0] is 0000 */
>  	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -	sdhci_runtime_pm_put(host);
>  
>  	return !(present_state & SDHCI_DATA_LVL_MASK);
>  }
> @@ -1822,7 +1796,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	unsigned int tuning_count = 0;
>  	bool hs400_tuning;
>  
> -	sdhci_runtime_pm_get(host);
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
> @@ -1870,7 +1843,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	if (host->ops->platform_execute_tuning) {
>  		spin_unlock_irqrestore(&host->lock, flags);
>  		err = host->ops->platform_execute_tuning(host, opcode);
> -		sdhci_runtime_pm_put(host);
>  		return err;
>  	}
>  
> @@ -2002,8 +1974,6 @@ out:
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  out_unlock:
>  	spin_unlock_irqrestore(&host->lock, flags);
> -	sdhci_runtime_pm_put(host);
> -
>  	return err;
>  }
>  
> @@ -2201,7 +2171,6 @@ static void sdhci_tasklet_finish(unsigned long param)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	mmc_request_done(host->mmc, mrq);
> -	sdhci_runtime_pm_put(host);
>  }
>  
>  static void sdhci_timeout_timer(unsigned long data)
> @@ -2682,17 +2651,6 @@ int sdhci_resume_host(struct sdhci_host *host)
>  
>  EXPORT_SYMBOL_GPL(sdhci_resume_host);
>  
> -static int sdhci_runtime_pm_get(struct sdhci_host *host)
> -{
> -	return pm_runtime_get_sync(host->mmc->parent);
> -}
> -
> -static int sdhci_runtime_pm_put(struct sdhci_host *host)
> -{
> -	pm_runtime_mark_last_busy(host->mmc->parent);
> -	return pm_runtime_put_autosuspend(host->mmc->parent);
> -}
> -
>  static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
>  {
>  	if (host->bus_on)
> 

