From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 3/4 v2] mmc: host: switch OF parser to use gpio descriptors
Date: Tue, 30 Sep 2014 13:30:44 +0200
Message-ID: <CABxcv==ipqvs+XpuWMVjmLPTHArBa2Kqk2Zcxn5du5+oXK3RyQ@mail.gmail.com>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
	<1409137253-25189-3-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33899 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaI3Lap (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Sep 2014 07:30:45 -0400
Received: by mail-oi0-f47.google.com with SMTP id g201so5820336oib.34
        for <linux-mmc@vger.kernel.org>; Tue, 30 Sep 2014 04:30:45 -0700 (PDT)
In-Reply-To: <1409137253-25189-3-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux GPIO List <linux-gpio@vger.kernel.org>

Hello Linus,

On Wed, Aug 27, 2014 at 1:00 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This switches the central MMC OF parser to use gpio descriptors
> instead of grabbing GPIOs explicitly from the device tree.
> This strips out an unecessary use of the integer-based GPIO
> API that we want to get rid of, cuts down on code as the
> gpio descriptor code will handle active low flags.
>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>

Card detection is failing in some boards because this patch changes
some semantics. I tried to come up with a fix but I didn't find an
obvious way to do it (more on that below).

>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 95cceae96944..6f7ed9c50346 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -310,9 +310,7 @@ int mmc_of_parse(struct mmc_host *host)
>  {
>         struct device_node *np;
>         u32 bus_width;
> -       bool explicit_inv_wp, gpio_inv_wp = false;
> -       enum of_gpio_flags flags;
> -       int len, ret, gpio;
> +       int len, ret;
>
>         if (!host->parent || !host->parent->of_node)
>                 return 0;
> @@ -360,60 +358,40 @@ int mmc_of_parse(struct mmc_host *host)
>         if (of_find_property(np, "non-removable", &len)) {
>                 host->caps |= MMC_CAP_NONREMOVABLE;
>         } else {
> -               bool explicit_inv_cd, gpio_inv_cd = false;
> -
> -               explicit_inv_cd = of_property_read_bool(np, "cd-inverted");
> +               if (of_property_read_bool(np, "cd-inverted"))
> +                       host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>

The card-detect signal active high flag is set if the "cd-inverted"
property is found but in the original code MMC_CAP2_CD_ACTIVE_HIGH was
set only if "cd-inverted" was true and the card detect GPIO flag was
OF_GPIO_ACTIVE_HIGH.

>                 if (of_find_property(np, "broken-cd", &len))
>                         host->caps |= MMC_CAP_NEEDS_POLL;
>
> -               gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
> -               if (gpio == -EPROBE_DEFER)
> -                       return gpio;
> -               if (gpio_is_valid(gpio)) {
> -                       if (!(flags & OF_GPIO_ACTIVE_LOW))
> -                               gpio_inv_cd = true;
> -
> -                       ret = mmc_gpio_request_cd(host, gpio, 0);
> -                       if (ret < 0) {
> -                               dev_err(host->parent,
> -                                       "Failed to request CD GPIO #%d: %d!\n",
> -                                       gpio, ret);
> +               ret = mmc_gpiod_request_cd(host, "cd", 0, false, 0);

Now false is passed as the override_active_level bool parameter but
mmc_gpio_request_cd() sets ctx->override_cd_active_level = true. Which
means that after this patch, mmc_gpio_get_cd() does not take into
account if host->caps2 has MMC_CAP2_CD_ACTIVE_HIGH set.

> +               if (ret) {
> +                       if (ret == -EPROBE_DEFER)
>                                 return ret;
> -                       } else {
> -                               dev_info(host->parent, "Got CD GPIO #%d.\n",
> -                                        gpio);
> +                       if (ret != -ENOENT) {
> +                               dev_err(host->parent,
> +                                       "Failed to request CD GPIO: %d\n",
> +                                       ret);
>                         }
> -               }
> -
> -               if (explicit_inv_cd ^ gpio_inv_cd)
> -                       host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> +               } else
> +                       dev_info(host->parent, "Got CD GPIO\n");
>         }
>
>         /* Parse Write Protection */
> -       explicit_inv_wp = of_property_read_bool(np, "wp-inverted");
> -
> -       gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
> -       if (gpio == -EPROBE_DEFER) {
> -               ret = -EPROBE_DEFER;
> -               goto out;
> -       }
> -       if (gpio_is_valid(gpio)) {
> -               if (!(flags & OF_GPIO_ACTIVE_LOW))
> -                       gpio_inv_wp = true;
> +       if (of_property_read_bool(np, "wp-inverted"))
> +               host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>
> -               ret = mmc_gpio_request_ro(host, gpio);
> -               if (ret < 0) {
> -                       dev_err(host->parent,
> -                               "Failed to request WP GPIO: %d!\n", ret);
> +       ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0);
> +       if (ret) {
> +               if (ret == -EPROBE_DEFER)
>                         goto out;
> -               } else {
> -                               dev_info(host->parent, "Got WP GPIO #%d.\n",
> -                                        gpio);
> +               if (ret != -ENOENT) {
> +                       dev_err(host->parent,
> +                               "Failed to request WP GPIO: %d\n",
> +                               ret);
>                 }
> -       }
> -       if (explicit_inv_wp ^ gpio_inv_wp)
> -               host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;

Same issue with write-protect signal active high. After this patch
MMC_CAP2_RO_ACTIVE_HIGH is always set while before it was
conditionally set depending of the write-protect GPIO flag value.

> +       } else
> +               dev_info(host->parent, "Got WP GPIO\n");
>
>         if (of_find_property(np, "cap-sd-highspeed", &len))
>                 host->caps |= MMC_CAP_SD_HIGHSPEED;
> --

Passing true to mmc_gpiod_request_cd() and not setting
MMC_CAP2_RO_ACTIVE_HIGH makes card detection work again on this board.
The former is a one-liner but the later is more complicated since
AFAIU the idea of the GPIO descriptor code is to handle the flags but
in this case this detail is needed.

Should we set MMC_CAP2_{CD,RO}_ACTIVE_HIGH in
mmc_gpiod_request_{cd,ro} or add functions to get the flags for these
cd and wp GPIO in order to set the host->caps2 flags according to the
old logic?

Thanks a lot and best regards,
Javier
