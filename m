From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: make array 'width' static const
Date: Tue, 11 Jul 2017 16:43:50 +0200
Message-ID: <CAPDyKFoMJXR_xp_V8KpuoT+8eGjW=4LXfudCuR67PZGbGeOWWA@mail.gmail.com>
References: <20170629181219.12837-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170629181219.12837-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 June 2017 at 20:12, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> array width is on-stack and not modified and should be
> made static const.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 12d2fbe9c520..76da1687ab37 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -909,7 +909,7 @@ static int sd_set_bus_width(struct rtsx_usb_sdmmc *host,
>                 unsigned char bus_width)
>  {
>         int err = 0;
> -       u8 width[] = {
> +       static const u8 width[] = {
>                 [MMC_BUS_WIDTH_1] = SD_BUS_WIDTH_1BIT,
>                 [MMC_BUS_WIDTH_4] = SD_BUS_WIDTH_4BIT,
>                 [MMC_BUS_WIDTH_8] = SD_BUS_WIDTH_8BIT,
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
