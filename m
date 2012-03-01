From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: core: Fixup suspend/resume issues for UHS-I cards
Date: Thu, 1 Mar 2012 10:57:44 -0800
Message-ID: <5355820F-F5FC-4E52-9A96-AD4A84833028@marvell.com>
References: <1330604285-9275-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:53368 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756198Ab2CATAM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Mar 2012 14:00:12 -0500
In-Reply-To: <1330604285-9275-1-git-send-email-ulf.hansson@stericsson.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>


acked-by: Philip Rakity <prakity@marvell.com>

On Mar 1, 2012, at 4:18 AM, Ulf Hansson wrote:

> Even if cards supports 1.8V I/O voltage those should anyway be
> initialized at 3.3V I/O according to (e)MMC, SD and SDIO specs.
> Some eMMC and embedded SDIO devices are able to be initialized
> at 1.8V as well, but it is better to be safe.
> 
> Do note that initialization in this context means that the card
> has been completely powered off, otherwise the card will remain
> at the last I/O voltage level that were negotitiated.
> 
> Due to the above being taken care of the suspend/resume issues
> for UHS-I SD-cards has been fixed.
> 
> Change-Id: Ia906f69d44b5be8374b0b536881190f67757b03e
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
> drivers/mmc/core/core.c |    3 +++
> drivers/mmc/core/mmc.c  |    3 +++
> drivers/mmc/core/sd.c   |    8 +++-----
> drivers/mmc/core/sdio.c |    9 +++++++++
> 4 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b317f0..faa0af1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2074,6 +2074,9 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
> 	 */
> 	mmc_hw_reset_for_init(host);
> 
> +	/* Initialization should be done at 3.3 V I/O voltage. */
> +	mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
> +
> 	/*
> 	 * sdio_reset sends CMD52 to reset card.  Since we do not know
> 	 * if the card is being re-initialized, just send it.  CMD52
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6b13776..6defddd 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -830,6 +830,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> 	if (!mmc_host_is_spi(host))
> 		mmc_set_bus_mode(host, MMC_BUSMODE_OPENDRAIN);
> 
> +	/* Initialization should be done at 3.3 V I/O voltage. */
> +	mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
> +
> 	/*
> 	 * Since we're changing the OCR value, we seem to
> 	 * need to tell some cards to go back to the idle
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 5017f93..c272c686 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -911,6 +911,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
> 	BUG_ON(!host);
> 	WARN_ON(!host->claimed);
> 
> +	/* The initialization should be done at 3.3 V I/O voltage. */
> +	mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
> +
> 	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
> 	if (err)
> 		return err;
> @@ -1156,11 +1159,6 @@ int mmc_attach_sd(struct mmc_host *host)
> 	BUG_ON(!host);
> 	WARN_ON(!host->claimed);
> 
> -	/* Make sure we are at 3.3V signalling voltage */
> -	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, false);
> -	if (err)
> -		return err;
> -
> 	/* Disable preset value enable if already set since last time */
> 	if (host->ops->enable_preset_value) {
> 		mmc_host_clk_hold(host);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 12cde6e..dac2e23 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -585,6 +585,10 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
> 	 * Inform the card of the voltage
> 	 */
> 	if (!powered_resume) {
> +
> +		/* The initialization should be done at 3.3 V I/O voltage. */
> +		mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
> +
> 		err = mmc_send_io_op_cond(host, host->ocr, &ocr);
> 		if (err)
> 			goto err;
> @@ -996,6 +1000,11 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
> 	 * With these steps taken, mmc_select_voltage() is also required to
> 	 * restore the correct voltage setting of the card.
> 	 */
> +
> +	if (!mmc_card_keep_power(host))
> +		/* The initialization should be done at 3.3 V I/O voltage. */
> +		mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
> +
> 	sdio_reset(host);
> 	mmc_go_idle(host);
> 	mmc_send_if_cond(host, host->ocr_avail);
> -- 
> 1.7.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

