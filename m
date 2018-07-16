From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] mmc: core: improve reasonableness of bus width setting
 for HS400es
Date: Mon, 16 Jul 2018 12:11:54 +0200
Message-ID: <CAPDyKFpv_zedwgDRmHTUadaDYb-xBQLFRV0sAk116YbjOhY+GA@mail.gmail.com>
References: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hongjie Fang <hongjiefang@asrmicro.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Bastian Stender <bst@pengutronix.de>, Jin Qian <jinqian@google.com>, Chanho Min <chanho.min@lge.com>, Kyle Roeschley <kyle.roeschley@ni.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 July 2018 at 05:00, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will continue
> to set 4bit transfer mode if fail to set 8bit mode. The bus width
> should not be set to 4bit in HS400es.
>
> When fail to set 8bit mode, need return error directly for HS400es.
>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
> ---
>  drivers/mmc/core/mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..4bd6c09 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1021,8 +1021,11 @@ static int mmc_select_bus_width(struct mmc_card *card)
>                                  EXT_CSD_BUS_WIDTH,
>                                  ext_csd_bits[idx],
>                                  card->ext_csd.generic_cmd6_time);
> -               if (err)
> +               if (err) {
> +                       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
> +                               return err;
>                         continue;
> +               }

I would rather let mmc_select_hs400es() check the return code from
mmc_select_bus_width().

So, if the return code isn't MMC_BUS_WIDTH_8, mmc_select_hs400es()
should bail out.

[...]

Kind regards
Uffe
