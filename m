From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: properly init drv_type
Date: Tue, 5 Dec 2017 17:24:28 +0100
Message-ID: <CAPDyKFqitcRpRjrvhw+yrP0tC5EGwX_XormEwEbWfr011UDVww@mail.gmail.com>
References: <20171130144910.4320-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171130144910.4320-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Colin Ian King <colin.king@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 30 November 2017 at 15:49, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> When the latest version of parsing the new eMMC bindings was moved from
> core.c to mmc.c, it was overlooked that drv_type could be used
> uninitialized. Fix it!
>
> Fixes: 6186d06c519e21 ("mmc: parse new binding for eMMC fixed driver type")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a552f61060d212..0d1c6b025ca596 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1290,7 +1290,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>
>  static void mmc_select_driver_type(struct mmc_card *card)
>  {
> -       int card_drv_type, drive_strength, drv_type;
> +       int card_drv_type, drive_strength, drv_type = 0;
>         int fixed_drv_type = card->host->fixed_drv_type;
>
>         card_drv_type = card->ext_csd.raw_driver_strength |
> --
> 2.11.0
>
