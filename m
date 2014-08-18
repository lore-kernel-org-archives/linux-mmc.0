From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] mmc: slot-gpio: add gpiod variant to get wp GPIO
Date: Mon, 18 Aug 2014 13:25:42 +0200
Message-ID: <CAPDyKFo_mxvz-gBdkYQO7bm2X_kpVM-dKJe1b0ksTYXQN59T0Q@mail.gmail.com>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
	<1407864355-21545-2-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:47888 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbaHRLZo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 07:25:44 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so4258897qaq.10
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 04:25:44 -0700 (PDT)
In-Reply-To: <1407864355-21545-2-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>

On 12 August 2014 19:25, Linus Walleij <linus.walleij@linaro.org> wrote:
> This makes it possible to get the write protect (read only)
> GPIO line from a GPIO descriptor. Written to exactly mirror
> the card detect function.
>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/core/slot-gpio.c  | 48 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/slot-gpio.h |  3 +++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 908c2b29e79f..e3fce4493fab 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -326,6 +326,54 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>  EXPORT_SYMBOL(mmc_gpiod_request_cd);
>
>  /**
> + * mmc_gpiod_request_ro - request a gpio descriptor for write protection
> + * @host: mmc host
> + * @con_id: function within the GPIO consumer
> + * @idx: index of the GPIO to obtain in the consumer
> + * @override_active_level: ignore %GPIO_ACTIVE_LOW flag
> + * @debounce: debounce time in microseconds
> + *
> + * Use this function in place of mmc_gpio_request_ro() to use the GPIO
> + * descriptor API.  Note that it is paired with mmc_gpiod_free_ro() not
> + * mmc_gpio_free_ro().
> + *
> + * Returns zero on success, else an error.
> + */
> +int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
> +                        unsigned int idx, bool override_active_level,
> +                        unsigned int debounce)
> +{
> +       struct mmc_gpio *ctx;
> +       struct gpio_desc *desc;
> +       int ret;
> +
> +       ret = mmc_gpio_alloc(host);
> +       if (ret < 0)
> +               return ret;
> +
> +       ctx = host->slot.handler_priv;
> +
> +       if (!con_id)
> +               con_id = ctx->ro_label;
> +
> +       desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
> +       if (IS_ERR(desc))
> +               return PTR_ERR(desc);
> +
> +       if (debounce) {
> +               ret = gpiod_set_debounce(desc, debounce);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ctx->override_ro_active_level = override_active_level;
> +       ctx->ro_gpio = desc;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(mmc_gpiod_request_ro);
> +
> +/**
>   * mmc_gpiod_free_cd - free the card-detection gpio descriptor
>   * @host: mmc host
>   *
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index d2433381e828..a0d0442c15bf 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -25,6 +25,9 @@ void mmc_gpio_free_cd(struct mmc_host *host);
>  int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>                          unsigned int idx, bool override_active_level,
>                          unsigned int debounce);
> +int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
> +                        unsigned int idx, bool override_active_level,
> +                        unsigned int debounce);
>  void mmc_gpiod_free_cd(struct mmc_host *host);
>  void mmc_gpiod_request_cd_irq(struct mmc_host *host);
>
> --
> 1.9.3
>
