From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 09/18] mmc: meson-gx: change interrupt name
Date: Wed, 15 Feb 2017 09:18:49 -0800
Message-ID: <m2inob9xty.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <cbe84305-803a-5431-9246-0b30d6f135b0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34609 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdBORSv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 12:18:51 -0500
Received: by mail-pf0-f169.google.com with SMTP id e4so32858249pfg.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 09:18:51 -0800 (PST)
In-Reply-To: <cbe84305-803a-5431-9246-0b30d6f135b0@gmail.com> (Heiner
        Kallweit's message of "Tue, 14 Feb 2017 21:06:39 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> So far the driver name is used for the interrupt. Therefore in
> /proc/interrupts we can't tell which interrupt belongs to which
> SD_EMMC port.
> So let's use the device name instead (what is the OF node name).
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index a67c811e..1a76c925 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -757,9 +757,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
>  	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
>  
> -	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
> -					meson_mmc_irq, meson_mmc_irq_thread,
> -					IRQF_SHARED, DRIVER_NAME, host);
> +	ret = devm_request_threaded_irq(&pdev->dev, host->irq, meson_mmc_irq,
> +					meson_mmc_irq_thread, IRQF_SHARED,
> +					dev_name(&pdev->dev), host);
>  	if (ret)
>  		goto free_host;
