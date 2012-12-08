From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH 3/3] mmc: core: Fixup signal voltage switch
Date: Sat, 08 Dec 2012 11:39:13 +0530
Message-ID: <50C2D989.5060901@codeaurora.org>
References: <1354897176-15307-1-git-send-email-johan.rudholm@stericsson.com> <1354897176-15307-4-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:20575 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757891Ab2LHGJU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Dec 2012 01:09:20 -0500
In-Reply-To: <1354897176-15307-4-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@marvell.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>

On 12/7/2012 9:49 PM, Johan Rudholm wrote:
> When switching SD and SDIO cards from 3.3V to 1.8V signal levels, the
> clock should be gated for 5 ms during the step. After enabling the
> clock, the host should wait for at least 1 ms before checking for
> failure. Failure by the card to switch is indicated by dat[0:3] being
> pulled low. The host should check for this condition and power-cycle
> the card if failure is indicated.
>
> Add a retry mechanism for the SDIO case.
>
> If the voltage switch fails repeatedly, give up and continue the
> initialization using the original voltage.
>
> This patch places a couple of requirements on the host driver:
>
>   1) mmc_set_ios with ios.clock = 0 must gate the clock
>   2) mmc_power_off must actually cut the power to the card
>
> if these requirements are not fulfilled, the 1.8V signal voltage switch
> may not be successful.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> ---
>   drivers/mmc/core/core.c |   35 +++++++++++++++++++++++++++++++++++
>   drivers/mmc/core/sd.c   |   26 +++++++++++++++++++++-----
>   drivers/mmc/core/sdio.c |   25 +++++++++++++++++++++++--
>   3 files changed, 79 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 285f064..c9a7a8a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1246,8 +1246,43 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
>   	host->ios.signal_voltage = signal_voltage;
>   
>   	if (host->ops->start_signal_voltage_switch) {
> +		u32 clock;
> +
>   		mmc_host_clk_hold(host);
> +		/*
> +		 * During a signal voltage level switch, the clock must be gated
> +		 * for a certain period of time according to the SD spec
> +		 */
> +		if (cmd11) {
> +			clock = host->ios.clock;
> +			host->ios.clock = 0;
> +			mmc_set_ios(host);
> +		}
> +
>   		err = host->ops->start_signal_voltage_switch(host, &host->ios);

Shouldn't you fix all the existing host drivers who have already 
implemented start_signal_voltage_switch host ops? If you don't change 
them as part of this patch then
i afraid UHS functionality would be broken on those platforms. Also, 
it's not just changing the start_signal_voltage_switch hot op 
implementation, you may also need to add card_busy() host op 
implementation for those drivers.

> +
> +		if (err && cmd11) {
> +			host->ios.clock = clock;
> +			mmc_set_ios(host);
> +		} else if (cmd11) {
> +			/* Keep clock gated for at least 5 ms */
> +			mmc_delay(5);
> +			host->ios.clock = clock;
> +			mmc_set_ios(host);
> +
> +			/* Wait for at least 1 ms according to spec */
> +			mmc_delay(1);
> +
> +			/*
> +			 * Failure to switch is indicated by the card holding
> +			 * dat[0:3] low
> +			 */
> +			if (!host->ops->card_busy)
> +				pr_warning("%s: cannot verify signal voltage switch\n",
> +					mmc_hostname(host));
> +			else if (host->ops->card_busy(host))
> +				err = -EAGAIN;
> +		}
>   		mmc_host_clk_release(host);
>   	}
>   
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 74972c2..eb299bc 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -713,6 +713,14 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>   {
>   	int err;
>   	u32 max_current;
> +	int retries = 10;
> +
> +try_again:
> +	if (!retries) {
> +		ocr &= ~SD_OCR_S18R;
> +		pr_warning("%s: Skipping voltage switch\n",
> +			mmc_hostname(host));
> +	}
>   
>   	/*
>   	 * Since we're changing the OCR value, we seem to
> @@ -734,9 +742,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>   
>   	/*
>   	 * If the host supports one of UHS-I modes, request the card
> -	 * to switch to 1.8V signaling level.
> +	 * to switch to 1.8V signaling level. If the card has failed
> +	 * repeatedly to switch however, skip this.
>   	 */
> -	if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
> +	if (retries && host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
>   	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50))
>   		ocr |= SD_OCR_S18R;
>   
> @@ -748,7 +757,6 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>   	if (max_current > 150)
>   		ocr |= SD_OCR_XPC;
>   
> -try_again:
>   	err = mmc_send_app_op_cond(host, ocr, rocr);
>   	if (err)
>   		return err;
> @@ -760,8 +768,16 @@ try_again:
>   	if (!mmc_host_is_spi(host) && rocr &&
>   	   ((*rocr & 0x41000000) == 0x41000000)) {
>   		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
> -		if (err) {
> -			ocr &= ~SD_OCR_S18R;
> +		if (err == -EAGAIN) {
> +			/* Power cycle card */
> +			pr_debug("%s: Signal voltage switch failed, "
> +				"power cycling card (retries = %d)\n",
> +				mmc_hostname(host), retries);
> +			mmc_power_cycle(host);
> +			retries--;
> +			goto try_again;
> +		} else if (err) {
> +			retries = 0;
>   			goto try_again;
>   		}
>   	}
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 2273ce6..573ab06 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -583,10 +583,19 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>   {
>   	struct mmc_card *card;
>   	int err;
> +	int retries = 10;
>   
>   	BUG_ON(!host);
>   	WARN_ON(!host->claimed);
>   
> +try_again:
> +	if (!retries) {
> +		pr_warning("%s: Skipping voltage switch\n",
> +				mmc_hostname(host));
> +		ocr &= ~R4_18V_PRESENT;
> +		host->ocr &= ~R4_18V_PRESENT;
> +	}
> +
>   	/*
>   	 * Inform the card of the voltage
>   	 */
> @@ -645,14 +654,26 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>   	 * systems that claim 1.8v signalling in fact do not support
>   	 * it.
>   	 */
> -	if ((ocr & R4_18V_PRESENT) &&
> +	if (!powered_resume && (ocr & R4_18V_PRESENT) &&
>   		(host->caps &
>   			(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
>   			 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
>   			 MMC_CAP_UHS_DDR50))) {
>   		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
>   				true);
> -		if (err) {
> +		if (err == -EAGAIN) {
> +			/* Power cycle card */
> +			pr_debug("%s: Signal voltage switch failed, "
> +				"power cycling card (retries = %d)\n",
> +				mmc_hostname(host), retries);
> +			mmc_power_cycle(host);
> +			sdio_reset(host);
> +			mmc_go_idle(host);
> +			mmc_send_if_cond(host, host->ocr_avail);
> +			mmc_remove_card(card);
> +			retries--;
> +			goto try_again;
> +		} else if (err) {
>   			ocr &= ~R4_18V_PRESENT;
>   			host->ocr &= ~R4_18V_PRESENT;
>   		}

