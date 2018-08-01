From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5] mmc: core: improve reasonableness of bus width setting
 for HS400es
Date: Wed, 1 Aug 2018 14:16:59 +0200
Message-ID: <CAPDyKFoRw39g=wMghJCPid+z0U66cez4N6yPK3TDDPseWoiqQw@mail.gmail.com>
References: <1533005709-10909-1-git-send-email-hongjiefang@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533005709-10909-1-git-send-email-hongjiefang@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hongjie Fang <hongjiefang@asrmicro.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Bastian Stender <bst@pengutronix.de>, Chanho Min <chanho.min@lge.com>, Kyle Roeschley <kyle.roeschley@ni.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 31 July 2018 at 04:55, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will continue
> to set 4bit transfer mode if fail to set 8bit mode. The bus width
> should not be set to 4bit in HS400es.
>
> When fail to set 8bit mode, need return error directly for HS400es.
>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..82af1e0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1338,8 +1338,12 @@ static int mmc_select_hs400es(struct mmc_card *card)
>                 goto out_err;
>
>         err = mmc_select_bus_width(card);
> -       if (err < 0)
> +       if (err != MMC_BUS_WIDTH_8) {
> +               pr_err("%s: switch to 8bit bus width failed, err:%d\n",
> +                       mmc_hostname(host), err);
> +               err = err < 0 ? err : -ENOTSUPP;
>                 goto out_err;
> +       }
>
>         /* Switch card to HS mode */
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
