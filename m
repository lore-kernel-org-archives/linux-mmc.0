From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] mmc: mmci: augment driver to handle gpio descriptors
Date: Wed, 27 Aug 2014 13:34:28 +0200
Message-ID: <CAPDyKFrM5f_tuwhtCzzx+We5WnfkgJFxYo5v4hrWQM1GYXTGOw@mail.gmail.com>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
	<1409137253-25189-4-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:57038 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbaH0Lea (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Aug 2014 07:34:30 -0400
Received: by mail-la0-f52.google.com with SMTP id b17so79150lan.39
        for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2014 04:34:28 -0700 (PDT)
In-Reply-To: <1409137253-25189-4-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@arm.linux.org.uk>

On 27 August 2014 13:00, Linus Walleij <linus.walleij@linaro.org> wrote:
> Currently the MMCI driver will only handle GPIO descriptors
> implicitly through the device tree probe glue in mmc_of_init(),
> but devices instatiated other ways such as through board files
> and passing descriptors using the GPIO descriptor table will
> not be able to exploit descriptors.
>
> Augment the driver to look for a GPIO descriptor if device
> tree is not used for the device, and if that doesn't work,
> fall back to platform data GPIO assignment using the old
> API. The end goal is to get rid of the platform data integer
> GPIO assingments from the kernel.
>
> This enable the MMCI-embedding platforms to be converted to
> GPIO descritor tables.
>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/mmci.c | 53 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e4d470704150..37a6542f056c 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1658,16 +1658,49 @@ static int mmci_probe(struct amba_device *dev,
>         writel(0, host->base + MMCIMASK1);
>         writel(0xfff, host->base + MMCICLEAR);
>
> -       /* If DT, cd/wp gpios must be supplied through it. */
> -       if (!np && gpio_is_valid(plat->gpio_cd)) {
> -               ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
> -               if (ret)
> -                       goto clk_disable;
> -       }
> -       if (!np && gpio_is_valid(plat->gpio_wp)) {
> -               ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
> -               if (ret)
> -                       goto clk_disable;
> +       /*
> +        * If:
> +        * - not using DT but using a descriptor table, or
> +        * - using a table of descriptors ALONGSIDE DT, or
> +        * look up these descriptors named "cd" and "wp" right here, fail
> +        * silently of these do not exist and proceed to try platform data
> +        */
> +       if (!np) {
> +               ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> +               if (!ret)
> +                       dev_info(mmc_dev(mmc), "got CD GPIO (table)\n");
> +               else {
> +                       if (ret == -EPROBE_DEFER)
> +                               goto clk_disable;
> +                       else if (gpio_is_valid(plat->gpio_cd)) {
> +                               ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
> +                               if (ret)
> +                                       goto clk_disable;
> +                               else
> +                                       dev_info(mmc_dev(mmc), "got CD GPIO (pdata)\n");
> +                       } else {
> +                               dev_dbg(mmc_dev(mmc),
> +                                       "no CD GPIO in DT, table or pdata\n");
> +                       }
> +               }
> +
> +               ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0);
> +               if (!ret)
> +                       dev_info(mmc_dev(mmc), "got WP GPIO (table)\n");
> +               else {
> +                       if (ret == -EPROBE_DEFER)
> +                               goto clk_disable;
> +                       else if (gpio_is_valid(plat->gpio_wp)) {
> +                               ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
> +                               if (ret)
> +                                       goto clk_disable;
> +                               else
> +                                       dev_info(mmc_dev(mmc), "got WP GPIO (pdata)\n");
> +                       } else {
> +                               dev_dbg(mmc_dev(mmc),
> +                                       "no WP GPIO in DT, table or pdata\n");
> +                       }

Just a nitpick; and unless it's important to you, could you remove all
the dev_info|dbg - we didn't need them before, why now?

Kind regards
Uffe

> +               }
>         }
>
>         ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
> --
> 1.9.3
>
