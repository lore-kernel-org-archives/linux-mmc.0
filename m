From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] mmc/sdio: utilize runtime PM to speed up SDIO card's
 resume process
Date: Mon, 18 Apr 2016 11:59:03 +0800
Message-ID: <57145B87.1070708@linux.intel.com>
References: <570DEA5D.8070708@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32020 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbcDRD7I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 17 Apr 2016 23:59:08 -0400
In-Reply-To: <570DEA5D.8070708@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andreas Fenkart <afenkart@gmail.com>, kishon@ti.com, shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Any comments are welcome.


Thanks,
Zhonghui

On 4/13/2016 2:42 PM, Fu, Zhonghui wrote:
> Leave some work of SDIO card's resume process into it's runtime resume
> process to shorten system resume latency.
>
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  drivers/mmc/core/sdio.c  |   21 ++++++++++-----------
>  include/linux/mmc/host.h |    9 ++++++---
>  2 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index bd44ba8..fe5d3c5 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -902,6 +902,10 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>  
>  	if (!mmc_card_keep_power(host)) {
>  		mmc_power_off(host);
> +		if (host->caps & MMC_CAP_POWER_OFF_CARD) {
> +			pm_runtime_disable(&host->card->dev);
> +			pm_runtime_set_suspended(&host->card->dev);
> +		}
>  	} else if (host->retune_period) {
>  		mmc_retune_timer_stop(host);
>  		mmc_retune_needed(host);
> @@ -924,18 +928,16 @@ static int mmc_sdio_resume(struct mmc_host *host)
>  
>  	/* Restore power if needed */
>  	if (!mmc_card_keep_power(host)) {
> -		mmc_power_up(host, host->card->ocr);
>  		/*
> -		 * Tell runtime PM core we just powered up the card,
> -		 * since it still believes the card is powered off.
>  		 * Note that currently runtime PM is only enabled
>  		 * for SDIO cards that are MMC_CAP_POWER_OFF_CARD
>  		 */
>  		if (host->caps & MMC_CAP_POWER_OFF_CARD) {
> -			pm_runtime_disable(&host->card->dev);
> -			pm_runtime_set_active(&host->card->dev);
>  			pm_runtime_enable(&host->card->dev);
> +			goto out;
>  		}
> +
> +		mmc_power_up(host, host->card->ocr);
>  	}
>  
>  	/* No need to reinitialize powered-resumed nonremovable cards */
> @@ -953,13 +955,10 @@ static int mmc_sdio_resume(struct mmc_host *host)
>  		err = sdio_enable_4bit_bus(host->card);
>  	}
>  
> -	if (!err && host->sdio_irqs) {
> -		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
> -			wake_up_process(host->sdio_irq_thread);
> -		else if (host->caps & MMC_CAP_SDIO_IRQ)
> -			host->ops->enable_sdio_irq(host, 1);
> -	}
> +	if (!err && host->sdio_irqs)
> +		mmc_signal_sdio_irq(host);
>  
> +out:
>  	mmc_release_host(host);
>  
>  	host->pm_flags &= ~MMC_PM_KEEP_POWER;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 8dd4d29..8faaa5b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -400,10 +400,13 @@ void mmc_request_done(struct mmc_host *, struct mmc_request *);
>  
>  static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>  {
> -	host->ops->enable_sdio_irq(host, 0);
> -	host->sdio_irq_pending = true;
> -	if (host->sdio_irq_thread)
> +	if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
> +		host->ops->enable_sdio_irq(host, 0);
> +		host->sdio_irq_pending = true;
>  		wake_up_process(host->sdio_irq_thread);
> +	} else if (host->caps & MMC_CAP_SDIO_IRQ) {
> +		host->ops->enable_sdio_irq(host, 1);
> +	}
>  }
>  
>  void sdio_run_irqs(struct mmc_host *host);
> -- 1.7.1
>

