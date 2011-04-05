From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: do not switch to 1-bit mode if not required
Date: Tue, 05 Apr 2011 11:25:32 -0400
Message-ID: <m3bp0k67pv.fsf@pullcord.laptop.org>
References: <1302014601-8089-1-git-send-email-ohad@wizery.com>
	<1302014601-8089-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53113 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723Ab1DEPUF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Apr 2011 11:20:05 -0400
In-Reply-To: <1302014601-8089-2-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Tue, 5 Apr 2011 17:43:21 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 05 2011, Ohad Ben-Cohen wrote:
> 6b5eda36 followed SDIO spec part E1 section 8, which states that
> in case SDIO interrupts are being used to wake up a suspended host,
> then it is required to switch to 1-bit mode before stopping the clock.
>
> Before switching to 1-bit mode (or back to 4-bit mode on resume),
> make sure that SDIO interrupts are really being used to wake the host.
>
> This is helpful for devices which have an external irq line (e.g.
> wl1271), and do not use SDIO interrupts to wake up the host.
>
> In this case, switching to 1-bit mode (and back to 4-bit mode on resume)
> is not necessary.
>
> Reported-by: Eliad Peller <eliad@wizery.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/mmc/core/sdio.c  |    4 ++--
>  include/linux/mmc/host.h |    4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 0f7d436..4221670 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -625,7 +625,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>  		}
>  	}
>  
> -	if (!err && mmc_card_keep_power(host)) {
> +	if (!err && mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
>  		mmc_claim_host(host);
>  		sdio_disable_wide(host->card);
>  		mmc_release_host(host);
> @@ -648,7 +648,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
>  	if (mmc_card_is_removable(host) || !mmc_card_keep_power(host))
>  		err = mmc_sdio_init_card(host, host->ocr, host->card,
>  					mmc_card_keep_power(host));
> -	else if (mmc_card_keep_power(host)) {
> +	else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
>  		/* We may have switched to 1-bit mode during suspend */
>  		err = sdio_enable_4bit_bus(host->card);
>  		if (err > 0) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index cccb5cf..4f705eb 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -326,5 +326,9 @@ static inline int mmc_card_keep_power(struct mmc_host *host)
>  	return host->pm_flags & MMC_PM_KEEP_POWER;
>  }
>  
> +static inline int mmc_card_wake_sdio_irq(struct mmc_host *host)
> +{
> +	return host->pm_flags & MMC_PM_WAKE_SDIO_IRQ;
> +}
>  #endif

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
