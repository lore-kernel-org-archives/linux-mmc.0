From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 4/4] mmc: mmci: augment driver to handle gpio descriptors
Date: Thu, 14 Aug 2014 07:56:22 -0700
Message-ID: <CAAVeFuKo0DxN9Ff1G9o+ZXp8T+J-ZBE90cqcu5Pdgsq_jAZouw@mail.gmail.com>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org> <1407864355-21545-4-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1407864355-21545-4-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 12, 2014 at 10:25 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
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

I am not familiar with this driver, but since mmc_gpiod_request_cd()
uses gpiod_get(), can't you call it outside of the (!np) condition?
You should not have to do this kind of check when using the gpiod API.

> +               if (!ret)
> +                       dev_info(mmc_dev(mmc), "got CD GPIO (table)\n");
> +               else {

I think you want to add brackets around the dev_info() line to make
checkpatch.pl happy.

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

Same remark as above.

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
> +               }

I wonder (again, without knowing better) if this gpiod/gpio fallback
logic should not be put directly into mmc_gpio_request_ro/cd instead
of having two functions? Couldn't other drivers also benefit from it
that way?
