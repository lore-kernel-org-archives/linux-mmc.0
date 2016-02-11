From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RESEND] mmc:host:Fix error handling for calls to the
 function shdci_runtime_pm_get in the file sdhci.c
Date: Thu, 11 Feb 2016 10:06:04 +0200
Message-ID: <56BC40EC.60301@intel.com>
References: <1455114866-27601-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50737 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbcBKIJf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Feb 2016 03:09:35 -0500
In-Reply-To: <1455114866-27601-1-git-send-email-xerofoify@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>, ulf.hansson@linaro.org
Cc: ludovic.desroches@atmel.com, ivan.ivanov@linaro.org, sbranden@broadcom.com, haibo.chen@freescale.com, jszhang@marvell.com, marex@denx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/02/16 16:34, Nicholas Krause wrote:
> This fixes error handling for various function calls to
> the function shdci_runtime_pm_get in the file sdhci.c
> to check if this function call returns a error and if
> this function returns a error depending on if the caller
> function is void return either immediately a blank return
> statement or a the returned error code to the caller if the

pm_runtime_resume() returns 1 if the device's runtime PM status was already
'active', and -EACCES means that 'power.disable_depth' is different from 0
(i.e. runtime pm not enabled), so this does not look coded correctly for
those cases.

Why do you need to check the return value?

> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1dbe932..c31a0d6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1342,7 +1342,8 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  	host = mmc_priv(mmc);
>  
> -	sdhci_runtime_pm_get(host);
> +	if (sdhci_runtime_pm_get(host))
> +		return;
>  
>  	/* Firstly check card presence */
>  	present = sdhci_do_get_cd(host);
> @@ -1589,7 +1590,8 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  
> -	sdhci_runtime_pm_get(host);
> +	if (sdhci_runtime_pm_get(host))
> +		return;
>  	sdhci_do_set_ios(host, ios);
>  	sdhci_runtime_pm_put(host);
>  }
> @@ -1619,7 +1621,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	int ret;
>  
> -	sdhci_runtime_pm_get(host);
> +	ret = sdhci_runtime_pm_get(host);
> +	if (ret)
> +		return ret;
>  	ret = sdhci_do_get_cd(host);
>  	sdhci_runtime_pm_put(host);
>  	return ret;
> @@ -1680,7 +1684,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	int ret;
>  
> -	sdhci_runtime_pm_get(host);
> +	ret = sdhci_runtime_pm_get(host);
> +	if (ret)
> +		return ret;
>  	ret = sdhci_do_get_ro(host);
>  	sdhci_runtime_pm_put(host);
>  	return ret;
> @@ -1705,7 +1711,8 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
>  
> -	sdhci_runtime_pm_get(host);
> +	if (sdhci_runtime_pm_get(host))
> +		return;
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  	if (enable)
> @@ -1818,7 +1825,9 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  
>  	if (host->version < SDHCI_SPEC_300)
>  		return 0;
> -	sdhci_runtime_pm_get(host);
> +	err = sdhci_runtime_pm_get(host);
> +	if (err)
> +		return err;
>  	err = sdhci_do_start_signal_voltage_switch(host, ios);
>  	sdhci_runtime_pm_put(host);
>  	return err;
> @@ -1828,8 +1837,11 @@ static int sdhci_card_busy(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	u32 present_state;
> +	int err;
>  
> -	sdhci_runtime_pm_get(host);
> +	err = sdhci_runtime_pm_get(host);
> +	if (err)
> +		return err;
>  	/* Check whether DAT[3:0] is 0000 */
>  	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
>  	sdhci_runtime_pm_put(host);
> @@ -1859,7 +1871,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	unsigned int tuning_count = 0;
>  	bool hs400_tuning;
>  
> -	sdhci_runtime_pm_get(host);
> +	err = sdhci_runtime_pm_get(host);
> +	if (err)
> +		return err;
> +
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
> 

