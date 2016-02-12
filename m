From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 6/7] ARM: OMAP2+: Improve omap_device error for driver writers
Date: Thu, 11 Feb 2016 17:13:23 -0800
Message-ID: <7hfuwy6898.fsf@baylibre.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
	<1455145370-20301-7-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33348 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbcBLBNZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 20:13:25 -0500
Received: by mail-pa0-f54.google.com with SMTP id fl4so25839664pad.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2016 17:13:25 -0800 (PST)
In-Reply-To: <1455145370-20301-7-git-send-email-tony@atomide.com> (Tony
	Lindgren's message of "Wed, 10 Feb 2016 15:02:49 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Stern <stern@rowland.harvard.edu>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>

Tony Lindgren <tony@atomide.com> writes:

> Drivers using pm_runtime_use_autosuspend() may not get disabled after
> -EPROBE_DEFER. On the following device driver probe, hardware state
> is different from the PM runtime state causing omap_device to produce
> the following error:
>
> omap_device_enable() called from invalid state 1
>
> And with omap_device and omap hardware being picky for PM, this will
> block any deeper idle states in hardware.
>
> Let's add a proper error message so driver writers can easily fix
> their drivers for PM.
>
> In general, the solution is to fix the drivers to follow the PM
> runtime documentation:
>
> 1. For sections of code that needs the device disabled, use
>    pm_runtime_put_sync_suspend() if pm_runtime_set_autosuspend() has
>    been set.
>
> 2. For driver exit code, use pm_runtime_dont_use_autosuspend() before
>    pm_runtime_put_sync() if pm_runtime_use_autosuspend() has been
>    set.
>
> Let's not return with 0 from _od_runtime_resume() as that will
> eventually lead into new drivers with broken PM runtime that will
> block deeper idle states on omaps.
>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  arch/arm/mach-omap2/omap_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 0437537..ebd8369 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -602,8 +602,10 @@ static int _od_runtime_resume(struct device *dev)
>  	int ret;
>  
>  	ret = omap_device_enable(pdev);
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "use pm_runtime_put_sync_suspend() in driver?\n");
>  		return ret;
> +	}
>  
>  	return pm_generic_runtime_resume(dev);
>  }
