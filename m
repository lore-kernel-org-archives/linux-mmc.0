From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer
 forever.
Date: Mon, 10 Sep 2012 09:47:54 +0200
Message-ID: <20120910074753.GX18243@pengutronix.de>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51318 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab2IJHr5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Sep 2012 03:47:57 -0400
Content-Disposition: inline
In-Reply-To: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, cjb@laptop.org, fabio.estevam@freescale.com, gcembed@gmail.com

On Fri, Sep 07, 2012 at 12:43:37PM +0200, Javier Martin wrote:
> The problem can be easily reproduced using a script that loops
> copying a file in an SD card to another place in the same SD card
> and its related to read transfers. This only happens with DMA enabled.
> 
> This is related to the fact that, when reading, an MMC irq signals
> the fact that all data from the SD card has been copied to the
> internal buffers. However, it doesn't signal whether the DMA transfer
> that is in charge of moving data from these internal buffers to RAM
> has finished or not. Thus, calling dmaengine_terminate_all() in the
> MMC irq routine can cancel an ongoing DMA transfer leaving some data
> in the internal buffers that produces an accumulative effect which,
> in the end, blocks a read data transfer forever.
> 
> The following patch watches DMA irq for reading and MMC irqs for
> writing transfers. The 'dangerous' usage of dmaengine_terminate_all()
> is removed and a timeout of 10 seconds is added so that the MMC won't
> block forever anymore.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
> Changes since v1:
>  - Use DMA callbacks for reading and MMC irqs for writing instead
>  of monitoring both irqs for each transfer.
>  - Increase timeout to 10 seconds to give enough time to slow cards.
> 

Looks good now, thanks.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
>  drivers/mmc/host/mxcmmc.c |   76 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 70 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 28ed52d..fc42a2e 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -44,6 +44,7 @@
>  #include <mach/hardware.h>
>  
>  #define DRIVER_NAME "mxc-mmc"
> +#define MXCMCI_TIMEOUT_MS 10000
>  
>  #define MMC_REG_STR_STP_CLK		0x00
>  #define MMC_REG_STATUS			0x04
> @@ -150,6 +151,8 @@ struct mxcmci_host {
>  	int			dmareq;
>  	struct dma_slave_config dma_slave_config;
>  	struct imx_dma_data	dma_data;
> +
> +	struct timer_list	watchdog;
>  };
>  
>  static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
> @@ -271,9 +274,32 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>  	dmaengine_submit(host->desc);
>  	dma_async_issue_pending(host->dma);
>  
> +	mod_timer(&host->watchdog, jiffies + msecs_to_jiffies(MXCMCI_TIMEOUT_MS));
> +
>  	return 0;
>  }
>  
> +static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat);
> +static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat);
> +
> +static void mxcmci_dma_callback(void *data)
> +{
> +	struct mxcmci_host *host = data;
> +	u32 stat;
> +
> +	del_timer(&host->watchdog);
> +
> +	stat = readl(host->base + MMC_REG_STATUS);
> +	writel(stat & ~STATUS_DATA_TRANS_DONE, host->base + MMC_REG_STATUS);
> +
> +	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
> +
> +	if (stat & STATUS_READ_OP_DONE)
> +		writel(STATUS_READ_OP_DONE, host->base + MMC_REG_STATUS);
> +
> +	mxcmci_data_done(host, stat);
> +}
> +
>  static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
>  		unsigned int cmdat)
>  {
> @@ -305,8 +331,14 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
>  
>  	int_cntr = INT_END_CMD_RES_EN;
>  
> -	if (mxcmci_use_dma(host))
> -		int_cntr |= INT_READ_OP_EN | INT_WRITE_OP_DONE_EN;
> +	if (mxcmci_use_dma(host)) {
> +		if (host->dma_dir == DMA_FROM_DEVICE) {
> +			host->desc->callback = mxcmci_dma_callback;
> +			host->desc->callback_param = host;
> +		} else {
> +			int_cntr |= INT_WRITE_OP_DONE_EN;
> +		}
> +	}
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  	if (host->use_sdio)
> @@ -345,11 +377,9 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
>  	struct mmc_data *data = host->data;
>  	int data_error;
>  
> -	if (mxcmci_use_dma(host)) {
> -		dmaengine_terminate_all(host->dma);
> +	if (mxcmci_use_dma(host))
>  		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
>  				host->dma_dir);
> -	}
>  
>  	if (stat & STATUS_ERR_MASK) {
>  		dev_dbg(mmc_dev(host->mmc), "request failed. status: 0x%08x\n",
> @@ -624,8 +654,10 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
>  		mxcmci_cmd_done(host, stat);
>  
>  	if (mxcmci_use_dma(host) &&
> -		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE)))
> +		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE))) {
> +		del_timer(&host->watchdog);
>  		mxcmci_data_done(host, stat);
> +	}
>  
>  	if (host->default_irq_mask &&
>  		  (stat & (STATUS_CARD_INSERTION | STATUS_CARD_REMOVAL)))
> @@ -836,6 +868,34 @@ static bool filter(struct dma_chan *chan, void *param)
>  	return true;
>  }
>  
> +static void mxcmci_watchdog(unsigned long data)
> +{
> +	struct mmc_host *mmc = (struct mmc_host *)data;
> +	struct mxcmci_host *host = mmc_priv(mmc);
> +	struct mmc_request *req = host->req;
> +	unsigned int stat = readl(host->base + MMC_REG_STATUS);
> +
> +	if (host->dma_dir == DMA_FROM_DEVICE) {
> +		dmaengine_terminate_all(host->dma);
> +		dev_err(mmc_dev(host->mmc),
> +			"%s: read time out (status = 0x%08x)\n",
> +			__func__, stat);
> +	} else {
> +		dev_err(mmc_dev(host->mmc),
> +			"%s: write time out (status = 0x%08x)\n",
> +			__func__, stat);
> +		mxcmci_softreset(host);
> +	}
> +
> +	/* Mark transfer as erroneus and inform the upper layers */
> +
> +	host->data->error = -ETIMEDOUT;
> +	host->req = NULL;
> +	host->cmd = NULL;
> +	host->data = NULL;
> +	mmc_request_done(host->mmc, req);
> +}
> +
>  static const struct mmc_host_ops mxcmci_ops = {
>  	.request		= mxcmci_request,
>  	.set_ios		= mxcmci_set_ios,
> @@ -968,6 +1028,10 @@ static int mxcmci_probe(struct platform_device *pdev)
>  
>  	mmc_add_host(mmc);
>  
> +	init_timer(&host->watchdog);
> +	host->watchdog.function = &mxcmci_watchdog;
> +	host->watchdog.data = (unsigned long)mmc;
> +
>  	return 0;
>  
>  out_free_irq:
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
