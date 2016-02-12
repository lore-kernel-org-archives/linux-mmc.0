From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Fri, 12 Feb 2016 13:51:18 +0100
Message-ID: <CAPDyKFpatP1Kq4Dkw=m0eurP=7AJVRH2GjOHx0Cj56gYLOjVDQ@mail.gmail.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
	<1455145370-20301-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33222 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcBLMvS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2016 07:51:18 -0500
Received: by mail-yw0-f170.google.com with SMTP id u200so63567008ywf.0
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2016 04:51:18 -0800 (PST)
In-Reply-To: <1455145370-20301-4-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>

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
> Cc: linux-spi@vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Mark, I'd like to merge this along with other related fixes via
> the ARM SoC tree if no objections, please review and ack if this
> look OK to you.
>
>
> ---
>  drivers/spi/spi-omap2-mcspi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 7273820..0caa3c8 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1490,6 +1490,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>         return status;
>
>  disable_pm:
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       pm_runtime_put_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>  free_master:
>         spi_master_put(master);
> @@ -1501,6 +1503,7 @@ static int omap2_mcspi_remove(struct platform_device *pdev)
>         struct spi_master *master = platform_get_drvdata(pdev);
>         struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
>
> +       pm_runtime_dont_use_autosuspend(mcspi->dev);
>         pm_runtime_put_sync(mcspi->dev);
>         pm_runtime_disable(&pdev->dev);
>
> --
> 2.7.0
>
