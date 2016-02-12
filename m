From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/7] serial: omap: Fix PM regression with deferred probe
 for pm_runtime_reinit
Date: Fri, 12 Feb 2016 13:52:44 +0100
Message-ID: <CAPDyKFoTWzoCypdEz5etghO+zt51n0wriXCRkGBgP3mM=8JSPA@mail.gmail.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
	<1455145370-20301-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34647 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbcBLMwp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2016 07:52:45 -0500
Received: by mail-yw0-f176.google.com with SMTP id h129so63658228ywb.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2016 04:52:44 -0800 (PST)
In-Reply-To: <1455145370-20301-6-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Tero Kristo <t-kristo@ti.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>

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
> Cc: linux-serial@vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
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
> Greg & Peter, I'd like to merge this along with other related fixes
> via the ARM SoC tree if no objections, please review and ack if
> this look OK to you.
>
> ---
>  drivers/tty/serial/omap-serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index b645f92..5c43f75 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1708,7 +1708,8 @@ static int serial_omap_probe(struct platform_device *pdev)
>         return 0;
>
>  err_add_port:
> -       pm_runtime_put(&pdev->dev);
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       pm_runtime_put_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_qos_remove_request(&up->pm_qos_request);
>         device_init_wakeup(up->dev, false);
> @@ -1721,6 +1722,7 @@ static int serial_omap_remove(struct platform_device *dev)
>  {
>         struct uart_omap_port *up = platform_get_drvdata(dev);
>
> +       pm_runtime_dont_use_autosuspend(up->dev);
>         pm_runtime_put_sync(up->dev);
>         pm_runtime_disable(up->dev);
>         uart_remove_one_port(&serial_omap_reg, &up->port);
> --
> 2.7.0
>
