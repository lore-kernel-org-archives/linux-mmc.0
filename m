From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: add vmmc-supply support
Date: Wed, 16 Oct 2013 16:42:07 +0200
Message-ID: <CAPDyKFoegdoRQU0tOp0V=D4Gd=kbrE4i8EJdE668hU7+a=p4sg@mail.gmail.com>
References: <1381933924-32437-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:40390 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab3JPOmI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2013 10:42:08 -0400
Received: by mail-vb0-f41.google.com with SMTP id g17so417046vbg.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Oct 2013 07:42:07 -0700 (PDT)
In-Reply-To: <1381933924-32437-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 16 October 2013 16:32, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Other MMC hosts handle a regulator named vmmc-supply that allows to power the
> MMC card or SDIO device before communicating on the bus.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 69e438e..deffa1f 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/scatterlist.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -2355,6 +2356,7 @@ static int __init atmci_probe(struct platform_device *pdev)
>         struct mci_platform_data        *pdata;
>         struct atmel_mci                *host;
>         struct resource                 *regs;
> +       struct regulator                *reg_vmmc;
>         unsigned int                    nr_slots;
>         int                             irq;
>         int                             ret;
> @@ -2371,6 +2373,16 @@ static int __init atmci_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");

Use "mmc_regulator_get_supply" instead. This will also try to setup
the "ocr_avail" mask, which is likely what you need as well.

Kind regards
Ulf Hansson

> +       if (!IS_ERR(reg_vmmc)) {
> +               ret = regulator_enable(reg_vmmc);
> +               if (ret) {
> +                       dev_err(&pdev->dev,
> +                               "Failed to enable vmmc regulator: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
> --
> 1.8.1.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
