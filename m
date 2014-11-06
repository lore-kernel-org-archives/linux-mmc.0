From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: adopt pinctrl support
Date: Thu, 6 Nov 2014 10:41:26 +0100
Message-ID: <CAPDyKFo_snpdU5EjW7-rAXSwqBt0mi9-oEYuNpONRAr_aKdiPw@mail.gmail.com>
References: <1415263973-15012-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:59186 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaKFJl1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Nov 2014 04:41:27 -0500
Received: by mail-qc0-f169.google.com with SMTP id i17so451821qcy.28
        for <linux-mmc@vger.kernel.org>; Thu, 06 Nov 2014 01:41:26 -0800 (PST)
In-Reply-To: <1415263973-15012-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Chris Ball <chris@printf.net>, Kevin Hilman <khilman@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 6 November 2014 09:52, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> Amend the atmel mci pin controller to optionally take a pin control
> handle and set the state of the pins to:
> - "default" on boot, resume and before performing an transfer.
> - "sleep" on suspend().
>
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  drivers/mmc/host/atmel-mci.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 4df1599..eb4bfbc 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -39,6 +39,7 @@
>  #include <linux/atmel_pdc.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/io.h>
> @@ -2385,6 +2386,8 @@ static int __init atmci_probe(struct platform_device *pdev)
>         int                             irq;
>         int                             ret, i;
>
> +       pinctrl_pm_select_default_state(&pdev->dev);

Not needed, it's already taken care of from driver core.

> +
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!regs)
>                 return -ENXIO;
> @@ -2568,6 +2571,8 @@ static int atmci_runtime_suspend(struct device *dev)
>
>         clk_disable_unprepare(host->mck);
>
> +       pinctrl_pm_select_sleep_state(dev);
> +
>         return 0;
>  }
>
> @@ -2575,6 +2580,8 @@ static int atmci_runtime_resume(struct device *dev)
>  {
>         struct atmel_mci *host = dev_get_drvdata(dev);
>
> +       pinctrl_pm_select_default_state(dev);
> +
>         return clk_prepare_enable(host->mck);
>  }
>  #endif
> --
> 1.7.9.5
>

Kind regards
Uffe
