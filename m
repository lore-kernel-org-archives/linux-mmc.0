From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/2] mmc: core: Add sdio_trigger_replug() API
Date: Mon, 22 Jul 2019 12:35:55 -0700
Message-ID: <20190722193555.GX250418@google.com>
References: <20190716164209.62320-1-dianders@chromium.org>
 <20190716164209.62320-2-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190716164209.62320-2-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ganapathi Bhat <gbhat@marvell.com>, linux-wireless@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Nishant Sarmukadam <nishants@marvell.com>, netdev@vger.kernel.org, Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org, davem@davemloft.net, Xinming Hu <huxinming820@gmail.com>, Jiong Wu <lohengrin1024@gmail.com>, Ritesh Harjani <riteshh@codeaurora.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 16, 2019 at 09:42:08AM -0700, Douglas Anderson wrote:
> When using Marvell WiFi SDIO cards, it is not uncommon for Linux WiFi
> driver to fully lose the communication channel to the firmware running
> on the card.  Presumably the firmware on the card has a bug or two in
> it and occasionally crashes.
> 
> The Marvell WiFi driver attempts to recover from this problem.
> Specifically the driver has the function mwifiex_sdio_card_reset()
> which is called when communcation problems are found.  That function
> attempts to reset the state of things by utilizing the mmc_hw_reset()
> function.
> 
> The current solution is a bit complex because the Marvell WiFi driver
> needs to manually deinit and reinit the WiFi driver around the reset
> call.  This means it's going through a bunch of code paths that aren't
> normally tested.  However, complexity isn't our only problem.  The
> other (bigger) problem is that Marvell WiFi cards are often combo
> WiFi/Bluetooth cards and Bluetooth runs on a second SDIO func.  While
> the WiFi driver knows that it should re-init its own state around the
> mmc_hw_reset() call there is no good way to inform the Bluetooth
> driver.  That means that in Linux today when you reset the Marvell
> WiFi driver you lose all Bluetooth communication.  Doh!
> 
> One way to fix the above problems is to leverage a more standard way
> to reset the Marvell WiFi card where we go through the same code paths
> as card unplug and the card plug.  In this patch we introduce a new
> API call for doing just that: sdio_trigger_replug().  This API call
> will trigger an unplug of the SDIO card followed by a plug of the
> card.  As part of this the card will be nicely reset.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/mmc/core/core.c       | 28 ++++++++++++++++++++++++++--
>  drivers/mmc/core/sdio_io.c    | 20 ++++++++++++++++++++
>  include/linux/mmc/host.h      | 15 ++++++++++++++-
>  include/linux/mmc/sdio_func.h |  2 ++
>  4 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9020cb2490f7..48a7d23aed26 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2164,6 +2164,12 @@ int mmc_sw_reset(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_sw_reset);
>  
> +void mmc_trigger_replug(struct mmc_host *host)
> +{
> +	host->trigger_replug_state = MMC_REPLUG_STATE_UNPLUG;
> +	_mmc_detect_change(host, 0, false);
> +}
> +
>  static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>  {
>  	host->f_init = freq;
> @@ -2217,6 +2223,11 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>  	if (!host->card || mmc_card_removed(host->card))
>  		return 1;
>  
> +	if (host->trigger_replug_state == MMC_REPLUG_STATE_UNPLUG) {
> +		mmc_card_set_removed(host->card);
> +		return 1;
> +	}
> +
>  	ret = host->bus_ops->alive(host);
>  
>  	/*
> @@ -2329,8 +2340,21 @@ void mmc_rescan(struct work_struct *work)
>  	mmc_bus_put(host);
>  
>  	mmc_claim_host(host);
> -	if (mmc_card_is_removable(host) && host->ops->get_cd &&
> -			host->ops->get_cd(host) == 0) {
> +
> +	/*
> +	 * Move through the state machine if we're triggering an unplug
> +	 * followed by a re-plug.
> +	 */
> +	if (host->trigger_replug_state == MMC_REPLUG_STATE_UNPLUG) {
> +		host->trigger_replug_state = MMC_REPLUG_STATE_PLUG;
> +		_mmc_detect_change(host, 0, false);
> +	} else if (host->trigger_replug_state == MMC_REPLUG_STATE_PLUG) {
> +		host->trigger_replug_state = MMC_REPLUG_STATE_NONE;
> +	}
> +
> +	if (host->trigger_replug_state == MMC_REPLUG_STATE_PLUG ||
> +	    (mmc_card_is_removable(host) && host->ops->get_cd &&
> +			host->ops->get_cd(host) == 0)) {

at first I was concerned there could be race conditions with the
different invocations of mmc_rescan(), but IIUC all calls are through
the host->detect work, so only one instance should be running at any
time.

>  		mmc_power_off(host);
>  		mmc_release_host(host);
>  		goto out;
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 2ba00acf64e6..1c5c2a3ebe5e 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -811,3 +811,23 @@ void sdio_retune_release(struct sdio_func *func)
>  	mmc_retune_release(func->card->host);
>  }
>  EXPORT_SYMBOL_GPL(sdio_retune_release);
> +
> +/**
> + *	sdio_trigger_replug - trigger an "unplug" + "plug" of the card
> + *	@func: SDIO function attached to host
> + *
> + *	When you call this function we will schedule events that will
> + *	make it look like the card contining the given SDIO func was

nit: containing

> + *	unplugged and then re-plugged-in.  This is as close as possible
> + *	to a full reset of the card that can be achieved.
> + *
> + *	NOTE: routnine will temporarily make the card look as if it is

nit: routine

Other than the typos this looks sane to me, I don't claim to have a
deep understanding of the MMC codebase though.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
