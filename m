From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix regression with optional GPIOs
Date: Tue, 8 Dec 2015 01:19:23 +0100
Message-ID: <CAPDyKFpxiOJJdh-nLXjxv3DYJnW3RAf_9aqMfds46=-oqPd5ng@mail.gmail.com>
References: <1449528845-25189-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34849 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbbLHATY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2015 19:19:24 -0500
Received: by qkfb125 with SMTP id b125so6233315qkf.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Dec 2015 16:19:24 -0800 (PST)
In-Reply-To: <1449528845-25189-1-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>

+Linus

On 7 December 2015 at 23:54, Tony Lindgren <tony@atomide.com> wrote:
> Commit ce037275861e ("mmc: pwrseq_simple: use GPIO descriptors array API")
> changed the handling MMC power sequence so GPIOs no longer are optional.
>
> This broke SDIO WLAN at least for omap5 that can't yet use the reset GPIOs
> with pwrseq_simple as a wait is needed after enabling the SDIO device.

Can you elaborate on this. Did it break omap5 or not? :-)

Also, I am interested to know more about the waiting period you need.
I assume that's because of the HW's characteristic?

Why can't we have that being described in DT and then make
pwrseq_simple *wait* if needed?

>
> Let's fix the problem by allocating the GPIO values array during init
> depending on the optional GPIOs found.

Certainly it shall be optional! I wonder how I could let that patch
slip through, my bad!

Thanks for fixing this!

>
> Note that depending on the board specific configuration, some of the GPIOs
> can be permanently set up with pulls, so we want to keep pwrseq_simple
> GPIOs optional.
>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mmc/core/pwrseq_simple.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -24,6 +24,7 @@ struct mmc_pwrseq_simple {
>         bool clk_enabled;
>         struct clk *ext_clk;
>         struct gpio_descs *reset_gpios;
> +       int *values;
>  };
>
>  static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
> @@ -31,13 +32,15 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>  {
>         int i;
>         struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
> -       int values[reset_gpios->ndescs];

I would prefer if we don't need to keep this memory on the heap.

Can't we instead keep a local copy of the reset_gpios->ndesc and when
pwrseq->reset_gpios doesn't exist use a default value?

> +
> +       if (!reset_gpios || !reset_gpios->ndescs)
> +               return;
>
>         for (i = 0; i < reset_gpios->ndescs; i++)
> -               values[i] = value;
> +               pwrseq->values[i] = value;
>
>         gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
> -                                      values);
> +                                      pwrseq->values);
>  }
>
>  static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
> @@ -84,6 +87,7 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>         if (!IS_ERR(pwrseq->ext_clk))
>                 clk_put(pwrseq->ext_clk);
>
> +       kfree(pwrseq->values);
>         kfree(pwrseq);
>  }
>
> @@ -111,12 +115,20 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>                 goto free;
>         }
>
> -       pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
> +       pwrseq->reset_gpios = gpiod_get_array_optional(dev, "reset",
> +                                                      GPIOD_OUT_HIGH);
>         if (IS_ERR(pwrseq->reset_gpios)) {

The original code also considered -ENOSYS, as that's the return code
you get when CONFIG_GPIOLIB is unset, I think we need that as well.

Although, perhaps it's more correct that the gpiolib API returns NULL
instead of ERR_PTR(-ENOSYS)?

I have added Linus, to see if he has any comments on this.

>                 ret = PTR_ERR(pwrseq->reset_gpios);
>                 goto clk_put;
>         }
>
> +       if (pwrseq->reset_gpios && pwrseq->reset_gpios->ndescs) {
> +               pwrseq->values = kzalloc(pwrseq->reset_gpios->ndescs *
> +                                        sizeof(int), GFP_KERNEL);
> +               if (!pwrseq->values)
> +                       goto clk_put;

This will leak a gpio cookie as it needs a gpiod_put_array().

> +       }
> +
>         pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>
>         return &pwrseq->pwrseq;
> --
> 2.6.2
>

One final comment, gpiod_put_array() doesn't deal with NULL pointers.
You need to check that in mmc_pwrseq_simple_free().

Kind regards
Uffe
