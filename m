From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 01/15] mmc: sdhci: using common
 mmc_regulator_set_vqmmc()
Date: Thu, 21 Jul 2016 10:06:43 +0300
Message-ID: <57907483.3030207@intel.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <1468309584-3591-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56811 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcGUHLD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jul 2016 03:11:03 -0400
In-Reply-To: <1468309584-3591-2-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 12/07/16 10:46, Dong Aisheng wrote:
> Switch to use the more robust common mmc_regulator_set_vqmmc()
> function in MMC core which set the target voltage as close as
> possible to target voltage.
> 
> We did not re-factor the whole sdhci_start_signal_voltage_switch()
> cause we want to keep the original signal switch order between host
> and card to avoid potential break.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>


Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ee8bfa77116..7894652b9929 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1835,8 +1835,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>  
>  		if (!IS_ERR(mmc->supply.vqmmc)) {
> -			ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
> -						    3600000);
> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
>  			if (ret) {
>  				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>  					mmc_hostname(mmc));
> @@ -1859,8 +1858,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		if (!(host->flags & SDHCI_SIGNALING_180))
>  			return -EINVAL;
>  		if (!IS_ERR(mmc->supply.vqmmc)) {
> -			ret = regulator_set_voltage(mmc->supply.vqmmc,
> -					1700000, 1950000);
> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
>  			if (ret) {
>  				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>  					mmc_hostname(mmc));
> @@ -1892,8 +1890,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  		if (!(host->flags & SDHCI_SIGNALING_120))
>  			return -EINVAL;
>  		if (!IS_ERR(mmc->supply.vqmmc)) {
> -			ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
> -						    1300000);
> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
>  			if (ret) {
>  				pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
>  					mmc_hostname(mmc));
> 

