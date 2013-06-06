From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] MMC: tmio: fix unbalanced power-on calls with
 clock-gating enabled
Date: Thu, 6 Jun 2013 09:34:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1306060934340.32566@axis700.grange>
References: <Pine.LNX.4.64.1304230916270.1422@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1304230916270.1422@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

On Tue, 23 Apr 2013, Guennadi Liakhovetski wrote:

> With MMC clock gating enabled the MMC core currently calls MMC host driver's
> .set_ios() method with .power_mode == MMC_POWER_ON and the clock value set
> either to 0 or to the target rate. The tmio MMC driver then wrongly
> translates the latter calls to card slot power-on requests, even when the
> slot already was on. This patch fixes the driver to avoid needlessly
> incrementing power-supplying regulator's use count.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Can we get this one into 3.10?

Thanks
Guennadi

> ---
> 
> v2: Also make runtime PM handling safer and more resistant to possible 
> MMC core changes. V1 worked fine too, but theoretically if the core 
> decided to issue a sequence like
> 
> 	.set_ios(ios->power_mode == MMC_POWER_ON, ios->clock != 0);
> 	.set_ios(ios->power_mode == MMC_POWER_ON, ios->clock == 0);
> 	.set_ios(ios->power_mode == MMC_POWER_OFF, ios->clock == 0);
> 
> we would end up calling pm_runtime_put() twice in a row, which is wrong. 
> V2 only toggles the controller runtime PM status only when entering or 
> leaving the TMIO_MMC_ON_RUN state.
> 
>  drivers/mmc/host/tmio_mmc.h     |   20 ++++++++++++++++++--
>  drivers/mmc/host/tmio_mmc_pio.c |   27 +++++++++++++++++----------
>  2 files changed, 35 insertions(+), 12 deletions(-)
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
> + * 1. card slot powered off, controller stopped. This is used, when either there
> + *    is no card in the slot, or the card really has to be powered down.
> + * 2. card slot powered on, controller stopped. This is used, when a card is in
> + *    the slot, but no activity is currently taking place. This is a power-
> + *    saving mode with card-state preserved. This state can be entered, e.g.
> + *    when MMC clock-gating is used.
> + * 3. card slot powered on, controller running. This is the actual active state.
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
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index f508ecb..1d5ef64 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -859,32 +859,39 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	 * is kept positive, so no suspending actually takes place.
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
> -		if (host->power) {
> -			struct tmio_mmc_data *pdata = host->pdata;
> -			if (ios->power_mode == MMC_POWER_OFF)
> +		struct tmio_mmc_data *pdata = host->pdata;
> +		unsigned int old_power = host->power;
> +
> +		if (old_power != TMIO_MMC_OFF_STOP) {
> +			if (ios->power_mode == MMC_POWER_OFF) {
>  				tmio_mmc_power_off(host);
> +				host->power = TMIO_MMC_OFF_STOP;
> +			} else {
> +				host->power = TMIO_MMC_ON_STOP;
> +			}
> +		}
> +
> +		if (old_power == TMIO_MMC_ON_RUN) {
>  			tmio_mmc_clk_stop(host);
> -			host->power = false;
>  			pm_runtime_put(dev);
>  			if (pdata->clk_disable)
>  				pdata->clk_disable(host->pdev);
>  		}
>  	}
>  
> -	if (host->power) {
> +	if (host->power != TMIO_MMC_OFF_STOP) {
>  		switch (ios->bus_width) {
>  		case MMC_BUS_WIDTH_1:
>  			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
> @@ -1025,7 +1032,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
>  				  mmc->caps & MMC_CAP_NONREMOVABLE ||
>  				  mmc->slot.cd_irq >= 0);
>  
> -	_host->power = false;
> +	_host->power = TMIO_MMC_OFF_STOP;
>  	pm_runtime_enable(&pdev->dev);
>  	ret = pm_runtime_resume(&pdev->dev);
>  	if (ret < 0)
> -- 
> 1.7.2.5
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
