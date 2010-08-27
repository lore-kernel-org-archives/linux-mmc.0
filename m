From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc
	callback
Date: Fri, 27 Aug 2010 20:37:27 +0100
Message-ID: <20100827193727.GF23079@void.printf.net>
References: <618f0c911003100611q42e7f23cuc3c8d3f116ca7eb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37398 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab0H0Th3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:37:29 -0400
Content-Disposition: inline
In-Reply-To: <618f0c911003100611q42e7f23cuc3c8d3f116ca7eb3@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>

Hi,

Looks like the discussion on this patch stopped: do we think there's a
race worth fixing here?

On Wed, Mar 10, 2010 at 07:41:38PM +0530, Venkatraman S wrote:
> See previous post http://patchwork.kernel.org/patch/82907/
> Rebased to 2.6.34-rc1 and fixed comment alignment.
> 
> CC: Adrian Hunter <adrian.hunter@nokia.com>
> CC: Madhusudhan C <madhu.cr@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
>  1 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 83f0aff..ea2a082 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1046,8 +1046,18 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
> 
>  	if (end_cmd || ((status & CC) && host->cmd))
>  		omap_hsmmc_cmd_done(host, host->cmd);
> -	if ((end_trans || (status & TC)) && host->mrq)
> +	if ((end_trans || (status & TC)) && host->mrq) {
>  		omap_hsmmc_xfer_done(host, data);
> +		if (host->dma_ch != -1) {
> +			omap_free_dma(host->dma_ch);
> +			host->dma_ch = -1;
> +			/*
> +			 * Callback: run in interrupt context.
> +			 * mutex_unlock will throw a kernel warning if used.
> +			 */
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

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
