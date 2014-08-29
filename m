From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: slot-gpio: switch to use flags when getting GPIO
Date: Fri, 29 Aug 2014 14:16:21 +0200
Message-ID: <CAPDyKFqw2N9zg41iz=qo3kQghmdYpafYdy545NYuu-Ji6pJELQ@mail.gmail.com>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-gpio@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 27 August 2014 13:00, Linus Walleij <linus.walleij@linaro.org> wrote:
> When the slot GPIO driver gets the GPIO to be used for card
> detect, it is now possible to specify a flag to have the line
> set up as input. Get rid of the explicit setup call for input
> and use the flag.
>
> The extra argument works as there are transition varargs
> macros in place in the <linux/gpio/consumer.h> header, in
> the future we will make the flags argument compulsory.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/core/slot-gpio.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 5f89cb83d5f0..908c2b29e79f 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -308,14 +308,10 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>         if (!con_id)
>                 con_id = ctx->cd_label;
>
> -       desc = devm_gpiod_get_index(host->parent, con_id, idx);
> +       desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
>         if (IS_ERR(desc))
>                 return PTR_ERR(desc);
>
> -       ret = gpiod_direction_input(desc);
> -       if (ret < 0)
> -               return ret;
> -
>         if (debounce) {
>                 ret = gpiod_set_debounce(desc, debounce);
>                 if (ret < 0)
> --
> 1.9.3
>
