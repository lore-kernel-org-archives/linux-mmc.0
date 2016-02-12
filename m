From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7] mmc: omap_hsmmc: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Fri, 12 Feb 2016 13:59:07 +0100
Message-ID: <CAPDyKFpwGcCW_Vwz07cgh8LxGmxu9=GVch0MVJEpNJ19zoLZ7g@mail.gmail.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
	<1455145370-20301-2-git-send-email-tony@atomide.com>
	<CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
	<20160211150240.GR19432@atomide.com>
	<CAPDyKFo4Jyjwyvr3P5VHfDhQ87K9mnR01N-NtKz-yx2ycnfOLg@mail.gmail.com>
	<20160211172632.GT19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160211172632.GT19432@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-serial@vger.kernel.org, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

On 11 February 2016 at 18:26, Tony Lindgren <tony@atomide.com> wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [160211 07:14]:
>> On 11 February 2016 at 16:02, Tony Lindgren <tony@atomide.com> wrote:
>> > * Ulf Hansson <ulf.hansson@linaro.org> [160211 02:19]:
>> >> On 11 February 2016 at 00:02, Tony Lindgren <tony@atomide.com> wrote:
>> >> >
>> >> > Ulf, I'd like to merge this along with other related fixes via the
>> >> > ARM SoC tree if no objections, please review and ack if this look OK
>> >> > to you.
>> >>
>> >> I have some other omap_hsmmc patches queued for 4.6, so I prefer to
>> >> send this via my mmc tree.
>> >>
>> >> I guess that's okay as well!?
>> >
>> > Naturally yes, please go ahead thanks!
>>
>> Okay!
>>
>> BTW, did you notice my other comments to the patch?
>>
>> I can fix them before applying, unless you want to send a v2?
>
> Oh sorry, no I missed the rest of your comments again, I really
> need to recalibrate my reading habits obviously if I keep
> missing comments on regular basis..
>
> You comments make sense to me. Below is the patch with only
> minimal changes. Seems to work just fine and hit off mode for
> suspend too.
>
> Regards,
>
> Tony
>
> 8< -------------------
> From eb3c93421f01fb6198f76127262a92b527dd214c Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 9 Feb 2016 09:31:10 -0800
> Subject: [PATCH] mmc: omap_hsmmc: Fix PM regression with deferred probe for
>  pm_runtime_reinit
>
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
>
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
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

Thanks, applied for fixes!

Kind regards
Uffe
