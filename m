From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] MMC: tmio: fix unbalanced power-on calls with clock-gating enabled
Date: Tue, 23 Apr 2013 01:24:04 +0200
Message-ID: <3707076.C3cH4Fjh9W@avalon>
References: <Pine.LNX.4.64.1304221611100.23906@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1304221611100.23906@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

Thanks for the patch.

On Monday 22 April 2013 16:14:40 Guennadi Liakhovetski wrote:
> With MMC clock gating enabled the MMC core currently calls MMC host driver's
> .set_ios() method with .power_mode == MMC_POWER_ON and the clock value set
> either to 0 or to the target rate. The tmio MMC driver then wrongly
> translates the latter calls to card slot power-on requests, even when the
> slot already was on. This patch fixes the driver to avoid needlessly
> incrementing power-supplying regulator's use count.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>
> ---
>  drivers/mmc/host/tmio_mmc.h     |   20 ++++++++++++++++++--
>  drivers/mmc/host/tmio_mmc_pio.c |   16 +++++++++-------
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index d857f5c..3cc589a 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -40,6 +40,22 @@
> 
>  struct tmio_mmc_data;
> 
> +/*
> + * We differentiate between the following 3 power states:
> + * 1. card slot powered off, controller stopped. This is used, when either
> + *    there is no card in the slot, or the card really has to be powered
> + *    down.
> + * 2. card slot powered on, controller stopped. This is used, when a card
> + *    is in the slot, but no activity is currently taking place. This is a
> + *    power-saving mode with card-state preserved. This state can be
> + *    entered, e.g. when MMC clock-gating is used.
> + * 3. card slot powered on, controller running. This is the actual active
> + *    state.
> + */
> +enum tmio_mmc_power {
> +	TMIO_MMC_OFF_STOP,	/* card power off, controller stopped */
> +	TMIO_MMC_ON_STOP,	/* card power on, controller stopped */
> +	TMIO_MMC_ON_RUN,	/* card power on, controller running */
> +};
> +
>  struct tmio_mmc_host {
>  	void __iomem *ctl;
>  	unsigned long bus_shift;
> @@ -48,8 +64,8 @@ struct tmio_mmc_host {
>  	struct mmc_data         *data;
>  	struct mmc_host         *mmc;
> 
> -	/* Controller power state */
> -	bool			power;
> +	/* Controller and card power state */
> +	enum tmio_mmc_power	power;
> 
>  	/* Callbacks for clock / power control */
>  	void (*set_pwr)(struct platform_device *host, int state);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c
> b/drivers/mmc/host/tmio_mmc_pio.c index f508ecb..d442eab 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -859,25 +859,27 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc,
> struct mmc_ios *ios) * is kept positive, so no suspending actually takes
> place.
>  	 */
>  	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
> -		if (!host->power) {
> +		if (host->power != TMIO_MMC_ON_RUN) {
>  			tmio_mmc_clk_update(mmc);
>  			pm_runtime_get_sync(dev);
>  		}
>  		tmio_mmc_set_clock(host, ios->clock);
> -		if (!host->power) {
> +		if (host->power == TMIO_MMC_OFF_STOP)
>  			/* power up SD card and the bus */
>  			tmio_mmc_power_on(host, ios->vdd);
> -			host->power = true;
> -		}
> +		host->power = TMIO_MMC_ON_RUN;
>  		/* start bus clock */
>  		tmio_mmc_clk_start(host);
>  	} else if (ios->power_mode != MMC_POWER_UP) {
>  		if (host->power) {

Maybe host->power != TMIO_MMC_OFF_STOP ?

Otherwise the patch looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  			struct tmio_mmc_data *pdata = host->pdata;
> -			if (ios->power_mode == MMC_POWER_OFF)
> +			if (ios->power_mode == MMC_POWER_OFF) {
>  				tmio_mmc_power_off(host);
> +				host->power = TMIO_MMC_OFF_STOP;
> +			} else {
> +				host->power = TMIO_MMC_ON_STOP;
> +			}
>  			tmio_mmc_clk_stop(host);
> -			host->power = false;
>  			pm_runtime_put(dev);
>  			if (pdata->clk_disable)
>  				pdata->clk_disable(host->pdev);
> @@ -1025,7 +1027,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
>  				  mmc->caps & MMC_CAP_NONREMOVABLE ||
>  				  mmc->slot.cd_irq >= 0);
> 
> -	_host->power = false;
> +	_host->power = TMIO_MMC_OFF_STOP;
>  	pm_runtime_enable(&pdev->dev);
>  	ret = pm_runtime_resume(&pdev->dev);
>  	if (ret < 0)
-- 
Regards,

Laurent Pinchart

