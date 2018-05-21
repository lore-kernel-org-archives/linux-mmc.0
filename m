From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: Allow non-sleeping GPIO cd
Date: Tue, 22 May 2018 01:55:51 +0300
Message-ID: <CAHp75VdsMNn29TFDYXerZQfhCm6uiGHid8ZX7HOCygXNkmJDVA@mail.gmail.com>
References: <20180521223503.152131-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521223503.152131-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 22, 2018 at 1:35 AM, Evan Green <evgreen@chromium.org> wrote:

Some style concerns.

>  int mmc_gpio_get_cd(struct mmc_host *host)
>  {

> +       int can_sleep;
>         struct mmc_gpio *ctx = host->slot.handler_priv;

I would rather name it

int cansleep;

and put after ctx definition.

>
>         if (!ctx || !ctx->cd_gpio)
>                 return -ENOSYS;
>
> -       if (ctx->override_cd_active_level)
> -               return !gpiod_get_raw_value_cansleep(ctx->cd_gpio) ^
> -                       !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> +       can_sleep = gpiod_cansleep(ctx->cd_gpio);
> +       if (ctx->override_cd_active_level) {
> +               int value = can_sleep ?
> +                               gpiod_get_raw_value_cansleep(ctx->cd_gpio) :
> +                               gpiod_get_raw_value(ctx->cd_gpio);
> +               return !value ^ !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> +       }
>
> -       return gpiod_get_value_cansleep(ctx->cd_gpio);

> +       return can_sleep ? gpiod_get_value_cansleep(ctx->cd_gpio) :
> +                       gpiod_get_value(ctx->cd_gpio);

Perhaps same style as you use above woule be better, i.e.

retrun cansleep ?
  true_path:
  false_path;

>  }
>  EXPORT_SYMBOL(mmc_gpio_get_cd);

-- 
With Best Regards,
Andy Shevchenko
