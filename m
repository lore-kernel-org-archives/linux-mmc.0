From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: enable SDIO IRQs for RCar Gen3
Date: Mon, 16 May 2016 21:44:25 +0200
Message-ID: <CAPDyKFqOnObYG_cK4Svg7eWdZYuO0VZuh+xLa-eo5FeDq6z=DQ@mail.gmail.com>
References: <1462806067-26724-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462806067-26724-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 9 May 2016 at 17:01, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Tested on a Salvator-X board with a Spectec SDW-823 WLAN card.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Just to let you know, this one was queued a while ago so it was
included in the 4.7 pull request.

Thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 5309c73be1f04f..f750f9494410b0 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -71,7 +71,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
>  static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
>         .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
>                           TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
> -       .capabilities   = MMC_CAP_SD_HIGHSPEED,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>         .bus_shift      = 2,
>  };
>
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
