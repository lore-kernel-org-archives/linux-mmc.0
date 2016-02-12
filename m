From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/7] ARM: OMAP2+: Fix omap_device for module reload on PM
 runtime forbid
Date: Fri, 12 Feb 2016 13:54:21 +0100
Message-ID: <CAPDyKFoJHw73xi0GE8YqtHcAjArrUkisXLTnF_kypSjAAtG0Eg@mail.gmail.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
	<1455145370-20301-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36860 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcBLMyW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2016 07:54:22 -0500
Received: by mail-yk0-f169.google.com with SMTP id z7so33472514yka.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2016 04:54:22 -0800 (PST)
In-Reply-To: <1455145370-20301-8-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-serial@vger.kernel.org, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>

On 11 February 2016 at 00:02, Tony Lindgren <tony@atomide.com> wrote:
> If a driver PM runtime is disabled via sysfs, and the module is
> unloaded, PM runtime can't do anything to disable the device. Let's
> let the interconnect disable the device on BUS_NOTIFY_UNBOUND_DRIVER.
>
> Otherwise omap_device will produce and error on the following module
> reload. This can be easily tested with something like:
>
> # modprobe omap_hsmmc
> # echo on > /sys/devices/platform/68000000.ocp/4809c000.mmc/power/control
> # rmmod omap_hsmmc
> # modprobe omap_hsmmc
>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  arch/arm/mach-omap2/omap_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index ebd8369..f7ff3b9 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -191,12 +191,22 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct omap_device *od;
> +       int err;
>
>         switch (event) {
>         case BUS_NOTIFY_DEL_DEVICE:
>                 if (pdev->archdata.od)
>                         omap_device_delete(pdev->archdata.od);
>                 break;
> +       case BUS_NOTIFY_UNBOUND_DRIVER:
> +               od = to_omap_device(pdev);
> +               if (od && (od->_state == OMAP_DEVICE_STATE_ENABLED)) {
> +                       dev_info(dev, "enabled after unload, idling\n");
> +                       err = omap_device_idle(pdev);
> +                       if (err)
> +                               dev_err(dev, "failed to idle\n");
> +               }
> +               break;
>         case BUS_NOTIFY_ADD_DEVICE:
>                 if (pdev->dev.of_node)
>                         omap_device_build_from_dt(pdev);
> --
> 2.7.0
>
