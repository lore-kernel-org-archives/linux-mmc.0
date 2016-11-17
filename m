From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCHv3 5/9] mmc: dw_mmc: call the dw_mci_prep_stop_abort() by
 default
Date: Thu, 17 Nov 2016 15:51:06 +0800
Message-ID: <c939c91c-6e00-72ea-62f9-94ea6320a753@rock-chips.com>
References: <20161117074041.8641-1-jh80.chung@samsung.com>
 <20161117074041.8641-6-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:39287 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbcKQHvS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 02:51:18 -0500
In-Reply-To: <20161117074041.8641-6-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, adrian.hunter@intel.com

ÔÚ 2016/11/17 15:40, Jaehoon Chung Ð´µÀ:
> stop_cmdr should be set to values relevant to stop command.
> It migth be assigned to values whatever there is mrq->stop or not.
> Then it doesn't need to use dw_mci_prepare_command().
> It's enough to use the prep_stop_abort for preparing stop command.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>  drivers/mmc/host/dw_mmc.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f592280..f01b5ce 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -385,7 +385,7 @@ static void dw_mci_start_command(struct dw_mci *host,
>
>  static inline void send_stop_abort(struct dw_mci *host, struct mmc_data *data)
>  {
> -	struct mmc_command *stop = data->stop ? data->stop : &host->stop_abort;
> +	struct mmc_command *stop = &host->stop_abort;
>
>  	dw_mci_start_command(host, stop, host->stop_cmdr);
>  }
> @@ -1277,10 +1277,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>  		spin_unlock_irqrestore(&host->irq_lock, irqflags);
>  	}
>
> -	if (mrq->stop)
> -		host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
> -	else
> -		host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
> +	host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
>  }
>
>  static void dw_mci_start_request(struct dw_mci *host,
> @@ -1890,8 +1887,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>  			if (test_and_clear_bit(EVENT_DATA_ERROR,
>  					       &host->pending_events)) {
>  				dw_mci_stop_dma(host);
> -				if (data->stop ||
> -				    !(host->data_status & (SDMMC_INT_DRTO |
> +				if (!(host->data_status & (SDMMC_INT_DRTO |
>  							   SDMMC_INT_EBE)))
>  					send_stop_abort(host, data);
>  				state = STATE_DATA_ERROR;
> @@ -1927,8 +1923,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>  			if (test_and_clear_bit(EVENT_DATA_ERROR,
>  					       &host->pending_events)) {
>  				dw_mci_stop_dma(host);
> -				if (data->stop ||
> -				    !(host->data_status & (SDMMC_INT_DRTO |
> +				if (!(host->data_status & (SDMMC_INT_DRTO |
>  							   SDMMC_INT_EBE)))
>  					send_stop_abort(host, data);
>  				state = STATE_DATA_ERROR;
> @@ -2004,7 +1999,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>  			host->cmd = NULL;
>  			host->data = NULL;
>
> -			if (mrq->stop)
> +			if (!mrq->sbc && mrq->stop)
>  				dw_mci_command_complete(host, mrq->stop);
>  			else
>  				host->cmd_status = 0;
>


-- 
Best Regards
Shawn Lin

