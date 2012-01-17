From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: change mmc_delay() to use usleep_range()
Date: Tue, 17 Jan 2012 09:29:11 +0200
Message-ID: <4F152347.1060703@intel.com>
References: <1326696200-514-1-git-send-email-dmitry.antipov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326696200-514-1-git-send-email-dmitry.antipov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Antipov <dmitry.antipov@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, patches@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 16/01/12 08:43, Dmitry Antipov wrote:
> Use the usleep_range() to simplify mmc_delay() and give some more
> accuracy to it - but with an exception of mmc_card_sleepawake():
> for the hosts with very small (<100us) sleep/awake timeout, it's
> value is rounded up to 100us so usleep_range() always makes sense.
> ---
>  drivers/mmc/core/core.h    |    8 ++------
>  drivers/mmc/core/mmc_ops.c |    9 ++++++---
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 3bdafbc..fbd2cba 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -48,12 +48,8 @@ void mmc_power_off(struct mmc_host *host);
>  
>  static inline void mmc_delay(unsigned int ms)
>  {
> -	if (ms < 1000 / HZ) {
> -		cond_resched();
> -		mdelay(ms);
> -	} else {
> -		msleep(ms);
> -	}
> +	unsigned long us = ms * USEC_PER_MSEC;
> +	usleep_range(us, us + 1000);
>  }
>  
>  void mmc_rescan(struct work_struct *work);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 4d41fa9..457443a 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -82,9 +82,12 @@ int mmc_card_sleepawake(struct mmc_host *host, int sleep)
>  	 * SEND_STATUS command to poll the status because that command (and most
>  	 * others) is invalid while the card sleeps.
>  	 */
> -	if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
> -		mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
> -
> +	if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY)) {
> +		/* JEDEC MMCA 4.41 specifies the timeout value is in 200ns..838.86ms
> +		   range, which is rounded it up to 100us here. */
> +		unsigned long us = DIV_ROUND_UP(card->ext_csd.sa_timeout, 1000);

The divisor has changed from 10000 to 1000 but the change is from ms to us,
so it ought to be 3 zeros different - unless it is a bug fix (which should
be a separate patch)?


> +		usleep_range(us, us + 100);
> +	}
>  	if (!sleep)
>  		err = mmc_select_card(card);
>  
