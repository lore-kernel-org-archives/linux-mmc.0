From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] mmc: fix race condition between dma and omap_hsmmc callback
Date: Tue, 13 Apr 2010 12:47:05 +0300
Message-ID: <4BC43D99.6030809@nokia.com>
References: <618f0c911003240600m1a38935av68f31a232ed8b8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45603 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0DMJre (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Apr 2010 05:47:34 -0400
In-Reply-To: <618f0c911003240600m1a38935av68f31a232ed8b8ad@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>

Venkatraman S wrote:
> This patch addresses the possible race condition between the dma
> callback and hsmmc callback.

Can you explain the problem in more detail?  If the final DMA interrupt
comes before TC then all should be well.  If it comes after, then we need
to be sure that the DMA has finished - particularly in the "read" case.
Neither the existing code nor this patch seems to address that issue.

Also, how can we be sure the final DMA interrupt doesn't race with the
start of the next request?

> All the 'post data transfer' cleanup activities are now done in the
> MMC TC handler.
> The schedule_timeout in omap_hsmmc_start_dma_transfer is hence not
> needed (which, incidentally,
> was also throwing a "schedule while atomic" warning when executed).
> Tested on OMAP4430 SDP.
> 
> CC: Adrian Hunter <adrian.hunter@nokia.com>
> CC: Madhusudhan C <madhu.cr@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   40 ++++++++++++++++------------------------
>  1 files changed, 16 insertions(+), 24 deletions(-)
> 
> The previous discussion about this patch is here
> https://patchwork.kernel.org/patch/82907/
> As requested, this is now posted as a separate patch instead of
> clubbing with another feature.
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 83f0aff..9a70b36 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1046,8 +1046,18 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
> 
>  	if (end_cmd || ((status & CC) && host->cmd))
>  		omap_hsmmc_cmd_done(host, host->cmd);
> -	if ((end_trans || (status & TC)) && host->mrq)
> +	if ((end_trans || (status & TC)) && host->mrq) {
> +		if (host->dma_ch != -1) {
> +			omap_free_dma(host->dma_ch);
> +			host->dma_ch = -1;
> +			/*
> +			 * Callback run in interrupt context.
> +			 * mutex_unlock will throw a kernel warning if used.
> +			 */
> +			up(&host->sem);
> +		}
>  		omap_hsmmc_xfer_done(host, data);
> +	}
> 
>  	spin_unlock(&host->irq_lock);
> 
> @@ -1267,13 +1277,6 @@ static void omap_hsmmc_dma_cb(int lch, u16
> ch_status, void *data)
>  		return;
>  	}
> 
> -	omap_free_dma(host->dma_ch);
> -	host->dma_ch = -1;
> -	/*
> -	 * DMA Callback: run in interrupt context.
> -	 * mutex_unlock will throw a kernel warning if used.
> -	 */
> -	up(&host->sem);
>  }
> 
>  /*
> @@ -1282,7 +1285,7 @@ static void omap_hsmmc_dma_cb(int lch, u16
> ch_status, void *data)
>  static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
>  					struct mmc_request *req)
>  {
> -	int dma_ch = 0, ret = 0, err = 1, i;
> +	int dma_ch = 0, ret = 0, i;
>  	struct mmc_data *data = req->data;
> 
>  	/* Sanity check: all the SG entries must be aligned by block size. */
> @@ -1300,22 +1303,11 @@ static int
> omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
>  		return -EINVAL;
> 
>  	/*
> -	 * If for some reason the DMA transfer is still active,
> -	 * we wait for timeout period and free the dma
> +	 * Can't process the request if the previous
> +	 * request is still active
>  	 */
> -	if (host->dma_ch != -1) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -		schedule_timeout(100);
> -		if (down_trylock(&host->sem)) {
> -			omap_free_dma(host->dma_ch);
> -			host->dma_ch = -1;
> -			up(&host->sem);
> -			return err;
> -		}
> -	} else {
> -		if (down_trylock(&host->sem))
> -			return err;
> -	}
> +	if (down_trylock(&host->sem))
> +			return -EBUSY;
> 
>  	ret = omap_request_dma(omap_hsmmc_get_dma_sync_dev(host, data),
>  			       "MMC/SD", omap_hsmmc_dma_cb, host, &dma_ch);

