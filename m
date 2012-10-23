From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: core: Power cycle card on voltage switch fail
Date: Tue, 23 Oct 2012 16:39:42 -0400
Message-ID: <87bofsj52p.fsf@octavius.laptop.org>
References: <1348166542-3247-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59967 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933599Ab2JWUju (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Oct 2012 16:39:50 -0400
In-Reply-To: <1348166542-3247-1-git-send-email-johan.rudholm@stericsson.com>
	(Johan Rudholm's message of "Thu, 20 Sep 2012 20:42:22 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, dsd@laptop.org

Hi Johan,

On Thu, Sep 20 2012, Johan Rudholm wrote:
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> ---
>  drivers/mmc/core/core.c |    2 +-
>  drivers/mmc/core/core.h |    1 +
>  drivers/mmc/core/sd.c   |    8 ++++++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 3779431..671986a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1346,7 +1346,7 @@ static void mmc_poweroff_notify(struct mmc_host *host)
>   * If a host does all the power sequencing itself, ignore the
>   * initial MMC_POWER_UP stage.
>   */
> -static void mmc_power_up(struct mmc_host *host)
> +void mmc_power_up(struct mmc_host *host)
>  {
>  	int bit;
>  
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 3bdafbc..5a5170d 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -45,6 +45,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
>  void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>  void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
>  void mmc_power_off(struct mmc_host *host);
> +void mmc_power_up(struct mmc_host *host);
>  
>  static inline void mmc_delay(unsigned int ms)
>  {
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 74972c2..9a165451 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -720,6 +720,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>  	 * state.  We wait 1ms to give cards time to
>  	 * respond.
>  	 */
> +try_again:
>  	mmc_go_idle(host);
>  
>  	/*
> @@ -748,7 +749,6 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>  	if (max_current > 150)
>  		ocr |= SD_OCR_XPC;
>  
> -try_again:
>  	err = mmc_send_app_op_cond(host, ocr, rocr);
>  	if (err)
>  		return err;
> @@ -761,7 +761,11 @@ try_again:
>  	   ((*rocr & 0x41000000) == 0x41000000)) {
>  		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
>  		if (err) {
> -			ocr &= ~SD_OCR_S18R;
> +			/* Power cycle card */
> +			pr_warning("%s: Signal voltage switch failed, "
> +				"power cycling card\n", mmc_hostname(host));
> +			mmc_power_off(host);
> +			mmc_power_up(host);
>  			goto try_again;
>  		}
>  	}

Hasn't the card already been power-cycled inside mmc_set_signal_voltage's
call to sdhci_do_start_signal_voltage_switch()?

                /*
                 * If we are here, that means the switch to 1.8V signaling
                 * failed. We power cycle the card, and retry initialization
                 * sequence by setting S18R to 0.
                 */
                pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
                pwr &= ~SDHCI_POWER_ON;
                sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);

(If you're going to do it here instead, should we remove this code from
sdhci.c?)

Dan, maybe you could see if this patch (there's a 1/2 patch too) solves
your UHS problem?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
