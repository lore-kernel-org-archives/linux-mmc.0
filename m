From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 05/11] mmc: core: Clarify sdio_irq_pending flag for
 MMC_CAP2_SDIO_IRQ_NOTHREAD
Date: Wed, 4 Sep 2019 17:34:51 -0700
Message-ID: <20190905003451.GI70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-6-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-6-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:01PM +0200, Ulf Hansson wrote:
> In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
> avoid reading the SDIO_CCCR_INTx register and instead immediately call the
> SDIO func's >irq_handler() callback.
> 
> To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
> let's set the flag from inside sdio_signal_irq(), rather from
> sdio_run_irqs(). Moreover, let's also reset the flag when the SDIO IRQ have
> been properly processed.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index f75043266984..0962a4357d54 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>  {
>  	struct mmc_card *card = host->card;
>  	int i, ret, count;
> +	bool sdio_irq_pending = host->sdio_irq_pending;
>  	unsigned char pending;
>  	struct sdio_func *func;
>  
> @@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>  	if (mmc_card_suspended(card))
>  		return 0;
>  
> +	/* Clear the flag to indicate that we have processed the IRQ. */
> +	host->sdio_irq_pending = false;
> +

It's not entirely true that we have processed the IRQ,
the sdio_get_pending_irqs() below could fail and we'd return. However
I guess if it comes to that we are in a pretty bad shape already and
the value of the flag doesn't really matter.

>  	/*
>  	 * Optimization, if there is only 1 function interrupt registered
>  	 * and we know an IRQ was signaled then call irq handler directly.
>  	 * Otherwise do the full probe.
>  	 */
>  	func = card->sdio_single_irq;
> -	if (func && host->sdio_irq_pending) {
> +	if (func && sdio_irq_pending) {
>  		func->irq_handler(func);
>  		return 1;
>  	}
> @@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
>  {
>  	mmc_claim_host(host);
>  	if (host->sdio_irqs) {
> -		host->sdio_irq_pending = true;
>  		process_sdio_pending_irqs(host);
>  		if (host->ops->ack_sdio_irq)
>  			host->ops->ack_sdio_irq(host);
> @@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
>  
>  void sdio_signal_irq(struct mmc_host *host)
>  {
> +	host->sdio_irq_pending = true;
>  	queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
>  }
>  EXPORT_SYMBOL_GPL(sdio_signal_irq);
> @@ -173,7 +177,6 @@ static int sdio_irq_thread(void *_host)
>  		if (ret)
>  			break;
>  		ret = process_sdio_pending_irqs(host);
> -		host->sdio_irq_pending = false;
>  		mmc_release_host(host);
>  
>  		/*

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
