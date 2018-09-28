From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: slot-gpio: Fix debounce time to use miliseconds again
Date: Fri, 28 Sep 2018 17:45:17 +0200
Message-ID: <CAPDyKFqbwGhLOZ+VrS07KDWY-j8RLC0mwJEKvhWVHbQQdZqUrw@mail.gmail.com>
References: <CGME20180928122141eucas1p2feee237ecf064b6abddeda569f356c86@eucas1p2.samsung.com>
 <20180928122040.2221-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180928122040.2221-1-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 September 2018 at 14:20, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> The debounce value passed to mmc_gpiod_request_cd() function is in
> microseconds, but msecs_to_jiffies() requires the value to be in
> miliseconds to properly calculate the delay, so adjust the value stored
> in cd_debounce_delay_ms context entry.
>
> Fixes: 1d71926bbd59 ("mmc: core: Fix debounce time to use microseconds")
> Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card
> after card is inserted")
> Cc: stable@vger.kernel.org # v4.18+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied for fixes!

Kind regards
Uffe

> ---
> This patch fixes eMMC card detection on Exynos5410-based Odroid XU board,
> broken since Linux next-20180928.
> ---
>  drivers/mmc/core/slot-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 2a833686784b..86803a3a04dc 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -271,7 +271,7 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>         if (debounce) {
>                 ret = gpiod_set_debounce(desc, debounce);
>                 if (ret < 0)
> -                       ctx->cd_debounce_delay_ms = debounce;
> +                       ctx->cd_debounce_delay_ms = debounce / 1000;
>         }
>
>         if (gpio_invert)
> --
> 2.17.1
>
