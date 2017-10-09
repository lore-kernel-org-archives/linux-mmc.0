From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 3/3] mmc: dw_mmc: Add locking to the CTO timer
Date: Mon, 9 Oct 2017 15:41:21 +0800
Message-ID: <fa1eff8e-0fbe-caa5-6311-168e3b4c55b7@rock-chips.com>
References: <20170927205631.31559-1-dianders@chromium.org>
 <20170927205631.31559-4-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:43639 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdJIHlf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Oct 2017 03:41:35 -0400
In-Reply-To: <20170927205631.31559-4-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, briannorris@chromium.org, amstan@chromium.org, xzy.xu@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Doug,

On 2017/9/28 4:56, Douglas Anderson wrote:
> This attempts to instill a bit of paranoia to the code dealing with
> the CTO timer.  It's believed that this will make the CTO timer more
> robust in the case that we're having very long interrupt latencies.
> 

I have already got reports about the similar problem that on one of
the Rockchip platforms, some IP cyclicity idle the bus too long,
so that cto timer fires but actually it shouldn't.

> Note that I originally thought that perhaps this patch was being
> overly paranoid and wasn't really needed, but then while I was running
> mmc_test on an rk3399 board I saw one instance of the message:
>    dwmmc_rockchip fe320000.dwmmc: Unexpected interrupt latency
> 

The intention of introducing CTO and DRTO timers is simply to break the
dead loop due to the bug of controller itself but it seems the timer
should take more factors into consideration. So it's more complicated
than expected, expecially we should also fix the drto case like what
this patch does...

How about combining the cto and drto timer and re-new a catch-all
timer like what SDHCI did?


> I had debug prints in the CTO timer code and I found that it was
> running CMD 13 at the time.
> 
> ...so even though this patch seems like it might be overly paranoid,
> maybe it really isn't?
> 
> Presumably the bad interrupt latency experienced was due to the fact
> that I had serial console enabled as serial console is typically where
> I place blame when I see absurdly large interrupt latencies.  In this
> particular case there was an (unrelated) printout to the serial
> console just before I saw the "Unexpected interrupt latency" printout.
>  > ...and actually, I managed to even reproduce the problems by running
> "iw mlan0 scan > /dev/null" while mmc_test was running.  That not only
> does a bunch of PCIe traffic but it also (on my system) outputs some
> SELinux log spam.
> 
> Fixes: 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken command transfer over scheme")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/mmc/host/dw_mmc.c | 92 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 82 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 16516c528a88..6ecfe35094dd 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -403,6 +403,7 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
>   	unsigned int cto_clks;
>   	unsigned int cto_div;
>   	unsigned int cto_ms;
> +	unsigned long irqflags;
>   
>   	cto_clks = mci_readl(host, TMOUT) & 0xff;
>   	cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
> @@ -413,8 +414,24 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
>   	/* add a bit spare time */
>   	cto_ms += 10;
>   
> -	mod_timer(&host->cto_timer,
> -		  jiffies + msecs_to_jiffies(cto_ms) + 1);
> +	/*
> +	 * The durations we're working with are fairly short so we have to be
> +	 * extra careful about synchronization here.  Specifically in hardware a
> +	 * command timeout is _at most_ 5.1 ms, so that means we expect an
> +	 * interrupt (either command done or timeout) to come rather quickly
> +	 * after the mci_writel.  ...but just in case we have a long interrupt
> +	 * latency let's add a bit of paranoia.
> +	 *
> +	 * In general we'll assume that at least an interrupt will be asserted
> +	 * in hardware by the time the cto_timer runs.  ...and if it hasn't
> +	 * been asserted in hardware by that time then we'll assume it'll never
> +	 * come.
> +	 */
> +	spin_lock_irqsave(&host->irq_lock, irqflags);
> +	if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
> +		mod_timer(&host->cto_timer,
> +			jiffies + msecs_to_jiffies(cto_ms) + 1);
> +	spin_unlock_irqrestore(&host->irq_lock, irqflags);
>   }
>   
>   static void dw_mci_start_command(struct dw_mci *host,
> @@ -429,11 +446,11 @@ static void dw_mci_start_command(struct dw_mci *host,
>   	wmb(); /* drain writebuffer */
>   	dw_mci_wait_while_busy(host, cmd_flags);
>   
> +	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
> +
>   	/* response expected command only */
>   	if (cmd_flags & SDMMC_CMD_RESP_EXP)
>   		dw_mci_set_cto(host);
> -
> -	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
>   }
>   
>   static inline void send_stop_abort(struct dw_mci *host, struct mmc_data *data)
> @@ -1930,6 +1947,24 @@ static void dw_mci_set_drto(struct dw_mci *host)
>   	mod_timer(&host->dto_timer, jiffies + msecs_to_jiffies(drto_ms));
>   }
>   
> +static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
> +{
> +	if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
> +		return false;
> +
> +	/*
> +	 * Really be certain that the timer has stopped.  This is a bit of
> +	 * paranoia and could only really happen if we had really bad
> +	 * interrupt latency and the interrupt routine and timeout were
> +	 * running concurrently so that the del_timer() in the interrupt
> +	 * handler couldn't run.
> +	 */
> +	WARN_ON(del_timer_sync(&host->cto_timer));
> +	clear_bit(EVENT_CMD_COMPLETE, &host->pending_events);
> +
> +	return true;
> +}
> +
>   static void dw_mci_tasklet_func(unsigned long priv)
>   {
>   	struct dw_mci *host = (struct dw_mci *)priv;
> @@ -1956,8 +1991,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>   
>   		case STATE_SENDING_CMD11:
>   		case STATE_SENDING_CMD:
> -			if (!test_and_clear_bit(EVENT_CMD_COMPLETE,
> -						&host->pending_events))
> +			if (!dw_mci_clear_pending_cmd_complete(host))
>   				break;
>   
>   			cmd = host->cmd;
> @@ -2126,8 +2160,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>   			/* fall through */
>   
>   		case STATE_SENDING_STOP:
> -			if (!test_and_clear_bit(EVENT_CMD_COMPLETE,
> -						&host->pending_events))
> +			if (!dw_mci_clear_pending_cmd_complete(host))
>   				break;
>   
>   			/* CMD error in data command */
> @@ -2600,6 +2633,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>   	struct dw_mci *host = dev_id;
>   	u32 pending;
>   	struct dw_mci_slot *slot = host->slot;
> +	unsigned long irqflags;
> +	int i;
>   
>   	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
>   
> @@ -2607,8 +2642,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>   		/* Check volt switch first, since it can look like an error */
>   		if ((host->state == STATE_SENDING_CMD11) &&
>   		    (pending & SDMMC_INT_VOLT_SWITCH)) {
> -			unsigned long irqflags;
> -
>   			mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
>   			pending &= ~SDMMC_INT_VOLT_SWITCH;
>   
> @@ -2624,11 +2657,15 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>   		}
>   
>   		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
> +			spin_lock_irqsave(&host->irq_lock, irqflags);
> +
>   			del_timer(&host->cto_timer);
>   			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
>   			host->cmd_status = pending;
>   			smp_wmb(); /* drain writebuffer */
>   			set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
> +
> +			spin_unlock_irqrestore(&host->irq_lock, irqflags);
>   		}
>   
>   		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
> @@ -2668,8 +2705,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>   		}
>   
>   		if (pending & SDMMC_INT_CMD_DONE) {
> +			spin_lock_irqsave(&host->irq_lock, irqflags);
> +
>   			mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
>   			dw_mci_cmd_interrupt(host, pending);
> +
> +			spin_unlock_irqrestore(&host->irq_lock, irqflags);
>   		}
>   
>   		if (pending & SDMMC_INT_CD) {
> @@ -2943,7 +2984,35 @@ static void dw_mci_cmd11_timer(unsigned long arg)
>   static void dw_mci_cto_timer(unsigned long arg)
>   {
>   	struct dw_mci *host = (struct dw_mci *)arg;
> +	unsigned long irqflags;
> +	u32 pending;
>   
> +	spin_lock_irqsave(&host->irq_lock, irqflags);
> +
> +	/*
> +	 * If somehow we have very bad interrupt latency it's remotely possible
> +	 * that the timer could fire while the interrupt is still pending or
> +	 * while the interrupt is midway through running.  Let's be paranoid
> +	 * and detect those two cases.  Note that this is paranoia is somewhat
> +	 * justified because in this function we don't actually cancel the
> +	 * pending command in the controller--we just assume it will never come.
> +	 */
> +	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
> +	if (pending & (DW_MCI_CMD_ERROR_FLAGS | SDMMC_INT_CMD_DONE)) {
> +		/* The interrupt should fire; no need to act but we can warn */
> +		dev_warn(host->dev, "Unexpected interrupt latency\n");
> +		goto exit;
> +	}
> +	if (test_bit(EVENT_CMD_COMPLETE, &host->pending_events)) {
> +		/* Presumably interrupt handler couldn't delete the timer */
> +		dev_warn(host->dev, "CTO timeout when already completed\n");
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Continued paranoia to make sure we're in the state we expect.
> +	 * This paranoia isn't really justified but it seems good to be safe.
> +	 */
>   	switch (host->state) {
>   	case STATE_SENDING_CMD11:
>   	case STATE_SENDING_CMD:
> @@ -2962,6 +3031,9 @@ static void dw_mci_cto_timer(unsigned long arg)
>   			 host->state);
>   		break;
>   	}
> +
> +exit:
> +	spin_unlock_irqrestore(&host->irq_lock, irqflags);
>   }
>   
>   static void dw_mci_dto_timer(unsigned long arg)
> 

