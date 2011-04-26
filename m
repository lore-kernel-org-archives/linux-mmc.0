From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] mmc: sd: When resuming, try a little harder to init the card
Date: Tue, 26 Apr 2011 15:39:56 +0200
Message-ID: <201104261539.56244.arnd@arndb.de>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org> <1303520502-32171-6-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58917 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab1DZNkJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 09:40:09 -0400
In-Reply-To: <1303520502-32171-6-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: linux-mmc@vger.kernel.org, San Mehat <san@android.com>, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>

On Saturday 23 April 2011, John Stultz wrote:
> From: San Mehat <san@android.com>
> 
> CC: Chris Ball <cjb@laptop.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Dima Zavin <dima@android.com>
> Signed-off-by: San Mehat <san@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/mmc/core/sd.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c0f14cb..7b6cab2 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -734,12 +734,31 @@ static int mmc_sd_suspend(struct mmc_host *host)
>  static int mmc_sd_resume(struct mmc_host *host)
>  {
>  	int err;
> +#ifdef CONFIG_MMC_PARANOID_SD_INIT
> +	int retries;
> +#endif
>  
>  	BUG_ON(!host);
>  	BUG_ON(!host->card);
>  
>  	mmc_claim_host(host);
> +#ifdef CONFIG_MMC_PARANOID_SD_INIT
> +	retries = 5;
> +	while (retries) {
> +		err = mmc_sd_init_card(host, host->ocr, host->card);
> +
> +		if (err) {
> +			printk(KERN_ERR "%s: Re-init card rc = %d (retries = %d)\n",
> +			       mmc_hostname(host), err, retries);
> +			mdelay(5);
> +			retries--;
> +			continue;
> +		}
> +		break;
> +	}
> +#else
>  	err = mmc_sd_init_card(host, host->ocr, host->card);
> +#endif
>  	mmc_release_host(host);
>  

Again, the configuration option should not be there. Either it is needed for
some hardware or not.

The mdelay(5) is not ok, we must never spin in a kernel thread for that long.
Substituting it for msleep(5) solves that, but could still be considered
inappropriate during the boot process by some people -- a 25 ms delay for
each mmc host may be noticeable when people wait for the boot to complete.

It needs at least an explanation about why the delay is used here.

	Arnd
