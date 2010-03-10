From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc callback
Date: Wed, 10 Mar 2010 10:47:29 -0600
Message-ID: <006401cac071$5f4c3df0$544ff780@am.dhcp.ti.com>
References: <618f0c911003010325q201fbcedr776da21c709ac421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756284Ab0CJQri (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Mar 2010 11:47:38 -0500
In-Reply-To: <618f0c911003010325q201fbcedr776da21c709ac421@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Venkatraman S
> Sent: Monday, March 01, 2010 5:26 AM
> To: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-omap@vger.kernel.org
> Subject: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc
> callback
> 
> It is observed that sometimes the MMC Transfer Complete (TC) is not
> received when DMA completion callback is processed (or takes too long
> to process)
> This patch moves the releasing of DMA channel from dma callback to the
> mmc transfer complete handler.
> This is observed consistently when descriptor loading is used (see the
> rest of the series)
> 
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
>  1 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 83f0aff..06337f6 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1046,8 +1046,18 @@ static irqreturn_t omap_hsmmc_irq(int irq, void
> *dev_id)
> 
>  	if (end_cmd || ((status & CC) && host->cmd))
>  		omap_hsmmc_cmd_done(host, host->cmd);
> -	if ((end_trans || (status & TC)) && host->mrq)
> +	if ((end_trans || (status & TC)) && host->mrq) {
>  		omap_hsmmc_xfer_done(host, data);
> +		if (host->dma_ch != -1) {
> +			omap_free_dma(host->dma_ch);
> +			host->dma_ch = -1;

Why is this necessary? The core is notified of xfer complete only when TC is
received which is good enough.

> +		/*
> +		 * Callback: run in interrupt context.
> +		 * mutex_unlock will throw a kernel warning if used.
> +		 */
> +			up(&host->sem);
> +		}
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
> --
> 1.6.3.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

