From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7] mmc: omap_hsmmc: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Thu, 11 Feb 2016 11:18:34 +0100
Message-ID: <CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
	<1455145370-20301-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1455145370-20301-2-git-send-email-tony@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-serial@vger.kernel.org, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

On 11 February 2016 at 00:02, Tony Lindgren <tony@atomide.com> wrote:
> Commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
> error and driver unbind") introduced pm_runtime_reinit() that is used
> to reinitialize PM runtime after -EPROBE_DEFER. This allows shutting
> down the device after a failed probe.
>
> However, for drivers using pm_runtime_use_autosuspend() this can cause
> a state where suspend callback is never called after -EPROBE_DEFER.
> On the following device driver probe, hardware state is different from
> the PM runtime state causing omap_device to produce the following
> error:
>
> omap_device_enable() called from invalid state 1
>
> And with omap_device and omap hardware being picky for PM, this will
> block any deeper idle states in hardware.
>
> The solution is to fix the drivers to follow the PM runtime documentation:
>
> 1. For sections of code that needs the device disabled, use
>    pm_runtime_put_sync_suspend() if pm_runtime_set_autosuspend() has
>    been set.
>
> 2. For driver exit code, use pm_runtime_dont_use_autosuspend() before
>    pm_runtime_put_sync() if pm_runtime_use_autosuspend() has been
>    set.
>
> Fixes: 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
> error and driver unbind")
> Cc: linux-mmc@vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>
> Ulf, I'd like to merge this along with other related fixes via the
> ARM SoC tree if no objections, please review and ack if this look OK
> to you.

I have some other omap_hsmmc patches queued for 4.6, so I prefer to
send this via my mmc tree.

I guess that's okay as well!?

>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b6639ea..32bc112 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1247,7 +1247,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
>         int ret;
>
>         /* Disable the clocks */
> -       pm_runtime_put_sync(host->dev);
> +       pm_runtime_put_sync_suspend(host->dev);

This has no effect.

The mmc core holds a runtime PM usage count for the device anyway, so
the clock won't be disabled.
Please remove this change from the patch.

>         if (host->dbclk)
>                 clk_disable_unprepare(host->dbclk);
>
> @@ -2232,6 +2232,7 @@ err_irq:
>                 dma_release_channel(host->tx_chan);
>         if (host->rx_chan)
>                 dma_release_channel(host->rx_chan);
> +       pm_runtime_dont_use_autosuspend(host->dev);
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
>         if (host->dbclk)
> @@ -2253,6 +2254,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>         dma_release_channel(host->tx_chan);
>         dma_release_channel(host->rx_chan);
>
> +       pm_runtime_dont_use_autosuspend(host->dev);
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
>         device_init_wakeup(&pdev->dev, false);
> @@ -2285,7 +2287,7 @@ static int omap_hsmmc_suspend(struct device *dev)
>         if (host->dbclk)
>                 clk_disable_unprepare(host->dbclk);
>
> -       pm_runtime_put_sync(host->dev);
> +       pm_runtime_put_sync_suspend(host->dev);

This has no effect, as the PM core prevents runtime suspend during the
system PM phase.
It does so, by increasing the runtime PM usage count
(pm_runtime_get_noresume()).

Please remove this change from patch.

>         return 0;
>  }
>
> --
> 2.7.0
>

Kind regards
Uffe
