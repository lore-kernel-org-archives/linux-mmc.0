From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: sh_mmcif: add SET_BLOCK_COUNT support
Date: Thu, 13 Jun 2013 10:33:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1306131024260.31976@axis700.grange>
References: <51B97CDB.7010207@renesas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <51B97CDB.7010207@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Shimoda-san

Thank you for your patch.

On Thu, 13 Jun 2013, Shimoda, Yoshihiro wrote:

> This patch adds SET_BLOCK_COUNT(CMD23) support to sh_mmcif driver.
> If we add MMC_CAP_CMD23 to ".caps" of sh_mmcif_plat_data, the mmc
> core driver will use CMD23. Then, the sh_mmcif driver can use
> Reliable Write feature.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on the latest mmc-next branch of mmc.git.
> 
>  drivers/mmc/host/sh_mmcif.c |   83 +++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 8ef5efa..14d4c81 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -244,6 +244,7 @@ struct sh_mmcif_host {
>  	bool power;
>  	bool card_present;
>  	struct mutex thread_lock;
> +	struct completion sbc_complete;
> 
>  	/* DMA support */
>  	struct dma_chan		*chan_rx;
> @@ -802,7 +803,11 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
>  		tmp |= CMD_SET_DWEN;
>  	/* CMLTE/CMD12EN */
>  	if (opc == MMC_READ_MULTIPLE_BLOCK || opc == MMC_WRITE_MULTIPLE_BLOCK) {
> -		tmp |= CMD_SET_CMLTE | CMD_SET_CMD12EN;
> +		/* If SBC, we don't use CMD12(STOP) */
> +		if (mrq->sbc)
> +			tmp |= CMD_SET_CMLTE;
> +		else
> +			tmp |= CMD_SET_CMLTE | CMD_SET_CMD12EN;
>  		sh_mmcif_bitset(host, MMCIF_CE_BLOCK_SET,
>  				data->blocks << 16);
>  	}
> @@ -903,6 +908,43 @@ static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
>  	host->wait_for = MMCIF_WAIT_FOR_STOP;
>  }
> 
> +static bool sh_mmcif_send_sbc(struct sh_mmcif_host *host,
> +			      struct mmc_request *mrq)
> +{
> +	struct mmc_request req_orig = *mrq;
> +	long time;
> +
> +	/* Switch the commands around */
> +	mrq->cmd = mrq->sbc;
> +	mrq->sbc = NULL;
> +	mrq->data = NULL;
> +	mrq->stop = NULL;
> +
> +	/* Send SBC Cmd */
> +	sh_mmcif_start_cmd(host, mrq);
> +
> +	/* Normal completion time is less than 1us */
> +	time = wait_for_completion_interruptible_timeout(&host->sbc_complete,
> +							 host->timeout);

I'm afraid this doesn't look like a correct approach to me. In commit 
f985da1 "mmc: sh_mmcif: process requests asynchronously" I converted the 
driver to not wait inside its .request() method. This your patch makes a 
part of the .request() processing synchronous again by adding a wait to 
it. Besides you're very much special casing the processing of the SBC 
command. I think, it would be better to process it asynchronously too, 
implementing it as a sequence of two requests, similar to how sdhci.c does 
it (see sdhci_request() nearer the end the "if (mrq->sbc...) handling and 
sdhci_finish_command() below the "Finished CMD23, now send actual 
command" comment). Would that be possible to convert this patch to execute 
similarly and to avoid special-casing as much as possible? Just check for 
an SBC in .request(), if there is one send it instead of the proper 
request. Then in completion check, whether it's the SBC that has just 
completed, and if so, now send the actual request.

Thanks
Guennadi

> +
> +	/* Restore */
> +	mrq->cmd = req_orig.cmd;
> +	mrq->sbc = req_orig.sbc;
> +	mrq->data = req_orig.data;
> +	mrq->stop = req_orig.stop;
> +
> +	if (mrq->sbc->error || host->sd_error || time <= 0) {
> +		dev_dbg(&host->pd->dev, "%s(): failed!\n", __func__);
> +		host->state = STATE_IDLE;
> +		if (!time)
> +			mrq->sbc->error = -ETIMEDOUT;
> +		mmc_request_done(host->mmc, mrq);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct sh_mmcif_host *host = mmc_priv(mmc);
> @@ -938,6 +980,11 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
> 
>  	host->mrq = mrq;
> 
> +	if (mrq->sbc) {
> +		if (sh_mmcif_send_sbc(host, mrq))
> +			return;
> +	}
> +
>  	sh_mmcif_start_cmd(host, mrq);
>  }
> 
> @@ -1074,6 +1121,9 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
> 
>  	sh_mmcif_get_response(host, cmd);
> 
> +	if (cmd->opcode == MMC_SET_BLOCK_COUNT)
> +		complete(&host->sbc_complete);
> +
>  	if (!data)
>  		return false;
> 
> @@ -1212,13 +1262,35 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>  		return IRQ_HANDLED;
>  	}
> 
> +	if (mrq->sbc && (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) &&
> +			(host->wait_for != MMCIF_WAIT_FOR_WRITE_END)) {
> +		/* Wait for end of data phase */
> +		host->wait_for = MMCIF_WAIT_FOR_WRITE_END;
> +		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
> +		schedule_delayed_work(&host->timeout_work, host->timeout);
> +		mutex_unlock(&host->thread_lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (mrq->sbc && (mrq->cmd->opcode == MMC_READ_MULTIPLE_BLOCK) &&
> +			(host->wait_for != MMCIF_WAIT_FOR_READ_END)) {
> +		/* Wait for end of data phase */
> +		host->wait_for = MMCIF_WAIT_FOR_READ_END;
> +		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
> +		schedule_delayed_work(&host->timeout_work, host->timeout);
> +		mutex_unlock(&host->thread_lock);
> +		return IRQ_HANDLED;
> +	}
> +
>  	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
>  		struct mmc_data *data = mrq->data;
>  		if (!mrq->cmd->error && data && !data->error)
>  			data->bytes_xfered =
>  				data->blocks * data->blksz;
> 
> -		if (mrq->stop && !mrq->cmd->error && (!data || !data->error)) {
> +		/* If SBC, we don't use CMD12(STOP) */
> +		if (mrq->stop && !mrq->cmd->error && (!data || !data->error) &&
> +		    !mrq->sbc) {
>  			sh_mmcif_stop_cmd(host, mrq);
>  			if (!mrq->stop->error) {
>  				schedule_delayed_work(&host->timeout_work, host->timeout);
> @@ -1228,6 +1300,12 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>  		}
>  	}
> 
> +	if ((mrq->cmd->opcode == MMC_SET_BLOCK_COUNT) && !mrq->cmd->error) {
> +		schedule_delayed_work(&host->timeout_work, host->timeout);
> +		mutex_unlock(&host->thread_lock);
> +		return IRQ_HANDLED;
> +	}
> +
>  	host->wait_for = MMCIF_WAIT_FOR_REQUEST;
>  	host->state = STATE_IDLE;
>  	host->mrq = NULL;
> @@ -1379,6 +1457,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>  	host->pd = pdev;
> 
>  	spin_lock_init(&host->lock);
> +	init_completion(&host->sbc_complete);
> 
>  	mmc->ops = &sh_mmcif_ops;
>  	sh_mmcif_init_ocr(host);
> -- 
> 1.7.1
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
