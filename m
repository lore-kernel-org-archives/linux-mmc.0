From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] mmc: core: restore detect line inversion semantics
Date: Tue, 30 Sep 2014 17:07:19 +0200
Message-ID: <CABxcv=n-+H3wrAr_vzEsXK_vOwQc8520wM=LJhzw70ZoSbJ_Ew@mail.gmail.com>
References: <1412085943-16872-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1412085943-16872-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux GPIO List <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Linus,

On Tue, Sep 30, 2014 at 4:05 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> commit 98e90de99a0c43bd434da814c882c4332441871e
> "mmc: host: switch OF parser to use gpio descriptors"
> switched the semantic behaviour of card detect and read
> only flags such that the inversion capability flag would
> only be set if inversion was explicitly specified in the
> device tree, in the hopes that no-one was using double
> inversion.
>
> It turns out that the XOR:ing between the explicit
> inversion was indeed in use, so we need to restore the
> old semantics where both ways of inversion are checked
> and the end result XOR:ed.
>
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks a lot for the quick patch. It makes the card detection work
again but needs two subtle changes to have the same semantics than
before.

> -               ret = mmc_gpiod_request_cd(host, "cd", 0, false, 0);
> +               ret = mmc_gpiod_request_cd(host, "cd", 0, false,
> +                                          0, &gpio_invert);

As mentioned in the other thread, the old code uses
mmc_gpio_request_cd() which always sets override_active_level to true
so this should be:

ret = mmc_gpiod_request_cd(host, "cd", 0, true, 0, &gpio_invert);

> @@ -316,6 +317,8 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>                         return ret;
>         }
>
> +       *gpio_invert = gpiod_is_active_low(desc);
> +

The old code set gpio_inv_cd if (!(flags & OF_GPIO_ACTIVE_LOW)) so the
above should be:

*gpio_invert = !gpiod_is_active_low(desc);

And the same applies to the gpio_invert assignment in
mmc_gpiod_request_ro(). With these two changes:

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
