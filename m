From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
Date: Wed, 4 Jul 2018 23:26:43 +0300
Message-ID: <CAHp75VeQdfoo8Q4EHqAJZ49kXwsgCWGyxgVPB187swKsB=XFTg@mail.gmail.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com> <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Anson Huang <Anson.Huang@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, Evan Green <evgreen@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 2, 2018 at 2:42 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 2, 2018 at 3:32 AM Anson Huang <Anson.Huang@nxp.com> wrote:

>> -       char cd_label[0];
>> +       char cd_label[];
>
> Not that I am the smartest in the world when it comes to how the
> C compilers work this out.
>
> But isn't that equivalent to:
> char *cd_label;
> ?

No.

sizeof(foo) == bar in the original code and with your change it would be
sizeof(foo) == bar + sizeof(void *)

On top of that, the actual memory is going in one chunk and requires
only one allocation.

But, I like your below stuff, though comments

> From facb3799f479bfd4dad99c25c9c5d4c77b14c9b0 Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Mon, 2 Jul 2018 13:35:01 +0200
> Subject: [PATCH] mmc: slot-gpio: Allocate GPIO labels dynamically
>
> The use of string pointers in the MMC slot GPIO context is
> pretty dubious, allocating some 2*len extra bytes for each
> label of the ro and wp pins.
>
> Tidy this up using kasprintf() with dynamic allocation of
> labels for these strings.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/slot-gpio.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index ef05e0039378..c417801b366e 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -27,7 +27,7 @@ struct mmc_gpio {
>      bool override_cd_active_level;
>      irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
>      char *ro_label;
> -    char cd_label[0];
> +    char *cd_label;
>      u32 cd_debounce_delay_ms;
>  };
>
> @@ -47,13 +47,18 @@ int mmc_gpio_alloc(struct mmc_host *host)
>  {

>      size_t len = strlen(dev_name(host->parent)) + 4;

Do you need this still?

>      struct mmc_gpio *ctx = devm_kzalloc(host->parent,
> -                sizeof(*ctx) + 2 * len,    GFP_KERNEL);
> +                        sizeof(*ctx), GFP_KERNEL);
>
>      if (ctx) {
> -        ctx->ro_label = ctx->cd_label + len;
>          ctx->cd_debounce_delay_ms = 200;
> -        snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
> -        snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
> +        ctx->cd_label = devm_kasprintf(host->parent, GFP_KERNEL,
> +                "%s cd", dev_name(host->parent));
> +        if (!ctx->cd_label)
> +            return -ENOMEM;
> +        ctx->ro_label = devm_kasprintf(host->parent, GFP_KERNEL,
> +                "%s ro", dev_name(host->parent));
> +        if (!ctx->ro_label)
> +            return -ENOMEM;
>          host->slot.handler_priv = ctx;
>          host->slot.cd_irq = -EINVAL;
>      }

-- 
With Best Regards,
Andy Shevchenko
