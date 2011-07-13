From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: maximize power saving
Date: Thu, 14 Jul 2011 01:23:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107140116150.30737@axis700.grange>
References: <Pine.LNX.4.64.1105261524120.9307@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105261524120.9307@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

This patch has survived multiple runtime PM versions on sh-mobile without 
changes, so, it should be good for the mainline. Please, queue for 3.1. We 
might, however, eventually decide, that we don't want to be so aggressive 
with our power savings;-) and want to add a flag to allow platforms to 
sacrifice power and maximise performance. This would be an incremental 
patch then.

Thanks
Guennadi

On Thu, 26 May 2011, Guennadi Liakhovetski wrote:

> This patch uses runtime PM to allow the system to power down the MMC
> controller, when the MMC closk is switched off.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Patches have been submitted earlier for SDHCI to accomplish something 
> similar, but they have complicated dependencies upon other different 
> subsystems, especially on PCI. MMCIF is easier - it only exists in 
> different SoCs, so, this change should also be easier to review, verify 
> and test.
> 
>  drivers/mmc/host/sh_mmcif.c |   27 ++++++++++++++++++---------
>  1 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 14f8edb..557886b 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -175,6 +175,7 @@ struct sh_mmcif_host {
>  	enum mmcif_state state;
>  	spinlock_t lock;
>  	bool power;
> +	bool card_present;
>  
>  	/* DMA support */
>  	struct dma_chan		*chan_rx;
> @@ -877,23 +878,23 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	if (ios->power_mode == MMC_POWER_UP) {
> -		if (p->set_pwr)
> -			p->set_pwr(host->pd, ios->power_mode);
> -		if (!host->power) {
> +		if (!host->card_present) {
>  			/* See if we also get DMA */
>  			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
> -			pm_runtime_get_sync(&host->pd->dev);
> -			host->power = true;
> +			host->card_present = true;
>  		}
>  	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
>  		/* clock stop */
>  		sh_mmcif_clock_control(host, 0);
>  		if (ios->power_mode == MMC_POWER_OFF) {
> -			if (host->power) {
> -				pm_runtime_put(&host->pd->dev);
> +			if (host->card_present) {
>  				sh_mmcif_release_dma(host);
> -				host->power = false;
> +				host->card_present = false;
>  			}
> +		}
> +		if (host->power) {
> +			pm_runtime_put(&host->pd->dev);
> +			host->power = false;
>  			if (p->down_pwr)
>  				p->down_pwr(host->pd);
>  		}
> @@ -901,8 +902,16 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		return;
>  	}
>  
> -	if (ios->clock)
> +	if (ios->clock) {
> +		if (!host->power) {
> +			if (p->set_pwr)
> +				p->set_pwr(host->pd, ios->power_mode);
> +			pm_runtime_get_sync(&host->pd->dev);
> +			host->power = true;
> +			sh_mmcif_sync_reset(host);
> +		}
>  		sh_mmcif_clock_control(host, ios->clock);
> +	}
>  
>  	host->bus_width = ios->bus_width;
>  	host->state = STATE_IDLE;
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
