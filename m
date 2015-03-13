From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add a timeout for sending CMD11
Date: Fri, 13 Mar 2015 20:19:39 +0900
Message-ID: <5502C7CB.3010504@samsung.com>
References: <1425943101-11976-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59090 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbbCMLTm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 07:19:42 -0400
In-reply-to: <1425943101-11976-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Andrew Bresticker <abrestic@chromium.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, linux-rockchip@lists.infradead.org, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, javier.martinez@collabora.co.uk, linux-arm-kernel@lists.infradead.org, Alexandru Stan <amstan@chromium.org>

Hi Doug.

This patch is a right process. Just i wonder something.

On 03/10/2015 08:18 AM, Doug Anderson wrote:
> In the Designware databook's description of the "Voltage Switch Normal
> Scenario" it instructs us to set a timer and fail the voltage change
> if we don't see the voltage change interrupt within 2ms.  Let's
> implement that.  Without implementing this I have often been able to
> reproduce a hang while trying to send CMD11 on an rk3288-based board
> while constantly ejecting and inserting UHS cards.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c  | 26 ++++++++++++++++++++++++++
>  include/linux/mmc/dw_mmc.h |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 47dfd0e..d259662 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1020,6 +1020,15 @@ static void __dw_mci_start_request(struct dw_mci *host,
>  
>  	dw_mci_start_command(host, cmd, cmdflags);
>  
> +	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
> +		/*
> +		 * Databook says to fail after 2ms w/ no response; give an
> +		 * extra jiffy just in case we're about to roll over.
> +		 */
> +		mod_timer(&host->cmd11_timer,
> +			  jiffies + msecs_to_jiffies(2) + 1);

What's "plus one"?

> +	}
> +
>  	if (mrq->stop)
>  		host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
>  	else
> @@ -2158,6 +2167,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  		/* Check volt switch first, since it can look like an error */
>  		if ((host->state == STATE_SENDING_CMD11) &&
>  		    (pending & SDMMC_INT_VOLT_SWITCH)) {
> +			del_timer(&host->cmd11_timer);
> +
>  			mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
>  			pending &= ~SDMMC_INT_VOLT_SWITCH;
>  			dw_mci_cmd_interrupt(host, pending);
> @@ -2571,6 +2582,18 @@ ciu_out:
>  	return ret;
>  }
>  
> +static void dw_mci_cmd11_timer(unsigned long arg)
> +{
> +	struct dw_mci *host = (struct dw_mci *)arg;
> +
> +	if (host->state != STATE_SENDING_CMD11)
> +		dev_info(host->dev, "Unexpected CMD11 timeout\n");

If Unexpected CMD11 timeout, can it do  just" return"?
Well, I think Unexpected CMD11 timeout is an rare case.

Best Regards,
Jaehoon Chung

> +
> +	host->cmd_status = SDMMC_INT_RTO;
> +	set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
> +	tasklet_schedule(&host->tasklet);
> +}
> +
>  #ifdef CONFIG_OF
>  static struct dw_mci_of_quirks {
>  	char *quirk;
> @@ -2745,6 +2768,9 @@ int dw_mci_probe(struct dw_mci *host)
>  		}
>  	}
>  
> +	setup_timer(&host->cmd11_timer,
> +		    dw_mci_cmd11_timer, (unsigned long)host);
> +
>  	host->quirks = host->pdata->quirks;
>  
>  	spin_lock_init(&host->lock);
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 471fb31..9efc567 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -202,6 +202,8 @@ struct dw_mci {
>  	int			irq;
>  
>  	int			sdio_id0;
> +
> +	struct timer_list       cmd11_timer;
>  };
>  
>  /* DMA ops for Internal/External DMAC interface */
> 

