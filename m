From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 5/5] mmc: dw_mmc: Cleanup the DTO timer like the CTO
 one
Date: Tue, 17 Oct 2017 09:17:30 +0800
Message-ID: <48ad69fd-b85a-d9c6-308f-dea72caa70b5@rock-chips.com>
References: <20171012201118.23570-1-dianders@chromium.org>
 <20171012201118.23570-6-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:48923 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbdJQBRm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Oct 2017 21:17:42 -0400
In-Reply-To: <20171012201118.23570-6-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, amstan@chromium.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, linux-samsung-soc@vger.kernel.org, kernel@esmil.dk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Doug

On 2017/10/13 4:11, Douglas Anderson wrote:
> The recent CTO timer introduced in commit 03de19212ea3 ("mmc: dw_mmc:
> introduce timer for broken command transfer over scheme") was causing
> observable problems due to race conditions.  Previous patches have
> fixed those race conditions.
> 
> It can be observed that these same race conditions ought to be
> theoretically possible with the DTO timer too though they are
> massively less likely to happen because the data timeout is always set
> to 0xffffff right now.  That means even at a 200 MHz card clock we
> were arming the DTO timer for 94 ms:
>    >>> (0xffffff * 1000. / 200000000) + 10
>    93.886075
> 
> We always also were setting the DTO timer _after_ starting the
> transfer, unlike how the old code was seting the CTO timer.
> 
> In any case, even though the DTO timer is much less likely to have
> races, it still makes sense to add code to handle it _just in case_.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Cleanup the DTO timer new for v2
> 
>   drivers/mmc/host/dw_mmc.c | 54 ++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6bc87b1385a9..bc0808615431 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1950,7 +1950,11 @@ static void dw_mci_set_drto(struct dw_mci *host)
>   	/* add a bit spare time */
>   	drto_ms += 10;
>   
> -	mod_timer(&host->dto_timer, jiffies + msecs_to_jiffies(drto_ms));
> +	spin_lock_irqsave(&host->irq_lock, irqflags);
> +	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
> +		mod_timer(&host->dto_timer,
> +			  jiffies + msecs_to_jiffies(drto_ms));
> +	spin_unlock_irqrestore(&host->irq_lock, irqflags);
>   }
>   
>   static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
> @@ -1971,6 +1975,18 @@ static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
>   	return true;
>   }
>   
> +static bool dw_mci_clear_pending_data_complete(struct dw_mci *host)
> +{
> +	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
> +		return false;
> +
> +	/* Extra paranoia just like dw_mci_clear_pending_cmd_complete() */
> +	WARN_ON(del_timer_sync(&host->dto_timer));
> +	clear_bit(EVENT_DATA_COMPLETE, &host->pending_events);
> +
> +	return true;
> +}
> +
>   static void dw_mci_tasklet_func(unsigned long priv)
>   {
>   	struct dw_mci *host = (struct dw_mci *)priv;
> @@ -2112,8 +2128,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>   			/* fall through */
>   
>   		case STATE_DATA_BUSY:
> -			if (!test_and_clear_bit(EVENT_DATA_COMPLETE,
> -						&host->pending_events)) {
> +			if (!dw_mci_clear_pending_data_complete(host)) {
>   				/*
>   				 * If data error interrupt comes but data over
>   				 * interrupt doesn't come within the given time.
> @@ -2683,6 +2698,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>   		}
>   
>   		if (pending & SDMMC_INT_DATA_OVER) {
> +			spin_lock_irqsave(&host->irq_lock, irqflags);
> +
>   			del_timer(&host->dto_timer);
>   
>   			mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
> @@ -2695,6 +2712,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>   			}
>   			set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
>   			tasklet_schedule(&host->tasklet);
> +
> +			spin_unlock_irqrestore(&host->irq_lock, irqflags);
>   		}
>   
>   		if (pending & SDMMC_INT_RXDR) {
> @@ -3044,7 +3063,31 @@ static void dw_mci_cto_timer(unsigned long arg)
>   static void dw_mci_dto_timer(unsigned long arg)
>   {
>   	struct dw_mci *host = (struct dw_mci *)arg;
> +	unsigned long irqflags;
> +	u32 pending;
> +
> +	spin_lock_irqsave(&host->irq_lock, irqflags);
>   
> +	/*
> +	 * The DTO timer is much longer than the CTO timer, so it's even less
> +	 * likely that we'll these cases, but it pays to be paranoid.
> +	 */
> +	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
> +	if (pending & SDMMC_INT_DATA_OVER) {
> +		/* The interrupt should fire; no need to act but we can warn */
> +		dev_warn(host->dev, "Unexpected data interrupt latency\n");
> +		goto exit;

I was checking a problem like this:

(1) Start a CTO timer
(2) Start a command
(3) Got CMD_DONE interrupt and cancel the CTO timer
(4) Start a DRTO timer
(5) Start external dma to get the data from fifo
(6) The system bus/DRAM port is idle for a very long time for no
matter what happen.
(7) DRTO timer fires but DTO was set as the card have already
sent all data to the fifo.
(8) Now you patch bails out earlier  and notify the mmc core that this
data transfer was finished successfully.
(9) mmc core propgate the successful state to block layer and maybe
a critical reader in file system will use the data right now but it
falls into trouble due to the incomplete data.


The problem comes from step 6 and setep 7. Quote some bit from dwmmc
databook, V270a, section 7.1,

"While using the external DMA interface for reading from a card, the DTO
interrupt occurs only after all the data is flushed to memory by the DMA
Interface unit. A Busy Clear Interrupt is asserted after the DTO."

So the DTO isn't reliable or perfectly good in practice for that case
that the delay is in external DMA side. That is hard to reproduced but
it was the reason for me to come up with the immature idea of adding
a longer enough and catch-all timer. Or we only set a longer enough
timeout value for CTO and DRTO timer and we could blindly believe the
hardware falls into troube for HW reason and seems that makes the change
simpler. Looking forward to your opinion. :)





> +	}
> +	if (test_bit(EVENT_DATA_COMPLETE, &host->pending_events)) {
> +		/* Presumably interrupt handler couldn't delete the timer */
> +		dev_warn(host->dev, "DTO timeout when already completed\n");
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Continued paranoia to make sure we're in the state we expect.
> +	 * This paranoia isn't really justified but it seems good to be safe.
> +	 */
>   	switch (host->state) {
>   	case STATE_SENDING_DATA:
>   	case STATE_DATA_BUSY:
> @@ -3059,8 +3102,13 @@ static void dw_mci_dto_timer(unsigned long arg)
>   		tasklet_schedule(&host->tasklet);
>   		break;
>   	default:
> +		dev_warn(host->dev, "Unexpected data timeout, state %d\n",
> +			 host->state);
>   		break;
>   	}
> +
> +exit:
> +	spin_unlock_irqrestore(&host->irq_lock, irqflags);
>   }
>   
>   #ifdef CONFIG_OF
> 

