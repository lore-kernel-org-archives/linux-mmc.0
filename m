From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: Allow non-sleeping GPIO cd
Date: Mon, 28 May 2018 13:27:53 +0200
Message-ID: <CAPDyKFq+-CSs2oo9EarJCgMYuFstMAyggoroc8YFkikqbR7Y5w@mail.gmail.com>
References: <20180525192523.204873-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525192523.204873-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Douglas Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 25 May 2018 at 21:25, Evan Green <evgreen@chromium.org> wrote:
> This change uses the appropriate _cansleep or non-sleeping API for
> reading GPIO card detect state. This allows users with GPIOs that
> never sleep to avoid a warning when certain quirks are present.
>
> The sdhci controller has an SDHCI_QUIRK_NO_CARD_NO_RESET, which
> indicates that a controller will not reset properly if no card is
> inserted. With this quirk enabled, mmc_get_cd_gpio is called in
> several places with a spinlock held and interrupts disabled.
> gpiod_get_raw_value_cansleep is not happy with this situation,
> and throws out a warning.
>
> For boards that a) use controllers that have this quirk, and b) wire
> card detect up to a GPIO that doesn't sleep, this is a spurious warning.
> This change silences that warning, at the cost of pushing this problem
> down to users that have sleeping GPIOs and controllers with this quirk.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

I decided to queue this up for next. Let's see if there is anybody
objecting to that.

As stated, I think that possible option 3) would be nice, but I am
fine with this for now.

Thanks and kind regards
Uffe

> ---
> Changes since v1:
>         - Style fixups as suggested by Andy
>
> This is my initial solution to the warning I was trying to face down
> in my previous RFC [1]. Upsides of this solution is it manages to
> avoid the warning in places where the warning doesn't apply, and is
> low-risk. Other approaches I considered:
>
> 1. Changing sdhci_get_cd to reach through mmc and get the GPIO value
> directly (without sleeping) rather than calling mmc_gpio_get_cd,
> which uses the cansleep functions. I didn't love this because a) it
> seemed ugly to be reaching into mmc_host like that and b) I'd have to
> duplicate the logic in mmc_gpio_get_cd, which seemed brittle.
>
> 2. Using mmc_gpio_set_cd_isr to record when the card detect pin
> changes, and then in sdhci_do_reset we wouldn't actually need to
> get CD state, just look at the cached value. This seemed risky to me
> since it would affect all sdhci controllers, and I don't know that
> everybody using gpio-cd can do interrupts on their pins.
>
> 3. Adding mmc_gpio_get_cd_nosleep(). That one's still doable if
> preferred, but I'd have to give some thought to when sdhci wires
> up to which one.
>
> I'm up for other suggestions. This one most just seemed like the
> best first stab of minimally addressing the warning without rocking
> the boat otherwise.
>
> [1] https://patchwork.kernel.org/patch/10374633/
> ---
>  drivers/mmc/core/slot-gpio.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 31f7dbb15668..1ca8220690f2 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -76,15 +76,22 @@ EXPORT_SYMBOL(mmc_gpio_get_ro);
>  int mmc_gpio_get_cd(struct mmc_host *host)
>  {
>         struct mmc_gpio *ctx = host->slot.handler_priv;
> +       int cansleep;
>
>         if (!ctx || !ctx->cd_gpio)
>                 return -ENOSYS;
>
> -       if (ctx->override_cd_active_level)
> -               return !gpiod_get_raw_value_cansleep(ctx->cd_gpio) ^
> -                       !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> +       cansleep = gpiod_cansleep(ctx->cd_gpio);
> +       if (ctx->override_cd_active_level) {
> +               int value = cansleep ?
> +                               gpiod_get_raw_value_cansleep(ctx->cd_gpio) :
> +                               gpiod_get_raw_value(ctx->cd_gpio);
> +               return !value ^ !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> +       }
>
> -       return gpiod_get_value_cansleep(ctx->cd_gpio);
> +       return cansleep ?
> +               gpiod_get_value_cansleep(ctx->cd_gpio) :
> +               gpiod_get_value(ctx->cd_gpio);
>  }
>  EXPORT_SYMBOL(mmc_gpio_get_cd);
>
> --
> 2.13.5
>
