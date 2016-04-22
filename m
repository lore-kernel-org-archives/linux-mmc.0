From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 04/23] mmc: sdhci: re-factor sdhci_start_signal_voltage()
Date: Fri, 22 Apr 2016 14:43:26 +0300
Message-ID: <571A0E5E.4090904@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-5-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42512 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbcDVLrP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2016 07:47:15 -0400
In-Reply-To: <1460741387-23815-5-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> Handle host and regulator signal voltage switch separately.
> Move host signal voltage switch code into a separated function
> sdhci_do_signal_voltage_switch() first, the following patches will
> remove the regulator voltage switch code and use the common
> mmc_regulator_set_vqmmc() instead.

You have changed the order that things are done.  There is no way to know
what that will break, so let's not do that.  What about just changing
regulator_set_voltage() to mmc_regulator_set_vqmmc()?

> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 97 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 57 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 839aa4c..7f63f5d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1657,19 +1657,10 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> -static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> -					     struct mmc_ios *ios)
> +static int sdhci_do_signal_voltage_switch(struct sdhci_host *host,
> +					  struct mmc_ios *ios)
>  {
> -	struct sdhci_host *host = mmc_priv(mmc);
>  	u16 ctrl;
> -	int ret;
> -
> -	/*
> -	 * Signal Voltage Switching is only applicable for Host Controllers
> -	 * v3.00 and above.
> -	 */
> -	if (host->version < SDHCI_SPEC_300)
> -		return 0;
>  
>  	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  
> @@ -1679,15 +1670,6 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		ctrl &= ~SDHCI_CTRL_VDD_180;
>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>  
> -		if (!IS_ERR(mmc->supply.vqmmc)) {
> -			ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
> -						    3600000);
> -			if (ret) {
> -				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
> -					mmc_hostname(mmc));
> -				return -EIO;
> -			}
> -		}
>  		/* Wait for 5ms */
>  		usleep_range(5000, 5500);
>  
> @@ -1697,20 +1679,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  			return 0;
>  
>  		pr_warn("%s: 3.3V regulator output did not became stable\n",
> -			mmc_hostname(mmc));
> +			mmc_hostname(host->mmc));
>  
>  		return -EAGAIN;
>  	case MMC_SIGNAL_VOLTAGE_180:
> -		if (!IS_ERR(mmc->supply.vqmmc)) {
> -			ret = regulator_set_voltage(mmc->supply.vqmmc,
> -					1700000, 1950000);
> -			if (ret) {
> -				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
> -					mmc_hostname(mmc));
> -				return -EIO;
> -			}
> -		}
> -
>  		/*
>  		 * Enable 1.8V Signal Enable in the Host Control2
>  		 * register
> @@ -1728,18 +1700,63 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  			return 0;
>  
>  		pr_warn("%s: 1.8V regulator output did not became stable\n",
> -			mmc_hostname(mmc));
> +			mmc_hostname(host->mmc));
>  
>  		return -EAGAIN;
> +	default:
> +		/* No signal voltage switch required */
> +		return 0;
> +	}
> +}
> +
> +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> +					     struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret;
> +
> +	/*
> +	 * Signal Voltage Switching is only applicable for Host Controllers
> +	 * v3.00 and above.
> +	 */
> +	if (host->version < SDHCI_SPEC_300)
> +		return 0;
> +
> +	ret = sdhci_do_signal_voltage_switch(host, ios);
> +	if (ret)
> +		return ret;
> +
> +	if (IS_ERR(mmc->supply.vqmmc))
> +		return 0;
> +
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
> +					    3600000);
> +		if (ret) {
> +			pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
> +				mmc_hostname(mmc));
> +			return -EIO;
> +		}
> +
> +		return 0;
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		ret = regulator_set_voltage(mmc->supply.vqmmc,
> +				1700000, 1950000);
> +		if (ret) {
> +			pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
> +				mmc_hostname(mmc));
> +			return -EIO;
> +		}
> +
> +		return 0;
>  	case MMC_SIGNAL_VOLTAGE_120:
> -		if (!IS_ERR(mmc->supply.vqmmc)) {
> -			ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
> -						    1300000);
> -			if (ret) {
> -				pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
> -					mmc_hostname(mmc));
> -				return -EIO;
> -			}
> +		ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
> +					    1300000);
> +		if (ret) {
> +			pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
> +				mmc_hostname(mmc));
> +			return -EIO;
>  		}
>  		return 0;
>  	default:
> 

