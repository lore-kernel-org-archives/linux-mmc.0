From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/4] mmc: meson-gx: use per port interrupt names
Date: Fri, 24 Mar 2017 15:53:09 -0700
Message-ID: <m260iyffsa.fsf@baylibre.com>
References: <f6960395-370e-16b0-1a2a-2a1fce720d45@gmail.com>
        <e4b6d120-d48d-0a00-0348-ff044f268fc7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34828 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbdCXWyO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 18:54:14 -0400
Received: by mail-pg0-f54.google.com with SMTP id t143so1839300pgb.2
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 15:53:11 -0700 (PDT)
In-Reply-To: <e4b6d120-d48d-0a00-0348-ff044f268fc7@gmail.com> (Heiner
        Kallweit's message of "Fri, 24 Mar 2017 23:08:09 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> So far the driver name is used as interrupt description, therefore in
> /proc/interrupts it's not possible to tell which interrupt belongs to
> which port. Change this by switching to NULL what causes the default
> (device name) to be used. In our case that's the DT node name.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index cf2ccc67..b0a9317b 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -740,7 +740,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
>  					meson_mmc_irq_thread, IRQF_SHARED,
> -					DRIVER_NAME, host);
> +					NULL, host);
>  	if (ret)
>  		goto err_div_clk;
