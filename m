From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: improve rationality of bus width setting for HS400es
Date: Mon, 9 Jul 2018 13:31:14 +0200
Message-ID: <CAPDyKFpzJV-UQbMa7_tHms7o3hMn9_g=H_M0jW+ZN9G=8XCqRg@mail.gmail.com>
References: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hongjie Fang <hongjiefang@asrmicro.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, Bastian Stender <bst@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Chanho Min <chanho.min@lge.com>, Kyle Roeschley <kyle.roeschley@ni.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 July 2018 at 08:47, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will try to
> set 4bit transfer mode if fail to set 8bit mode. The problem is that
> the bus width should not be set to 4bit in HS400es mode.

I guess it fails because there is something wrong. Can you please
elaborate under what circumstance the problem occurs?

>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
> ---
>  drivers/mmc/core/mmc.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..94c3cc5 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1337,9 +1337,28 @@ static int mmc_select_hs400es(struct mmc_card *card)
>         if (err)
>                 goto out_err;
>
> -       err = mmc_select_bus_width(card);
> -       if (err < 0)
> +       /* Switch card to 8 bit mode */
> +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +                        EXT_CSD_BUS_WIDTH,
> +                        EXT_CSD_BUS_WIDTH_8,
> +                        card->ext_csd.generic_cmd6_time);
> +       if (err) {
> +               pr_err("%s: switch to 8 bit mode for hs400es failed, err:%d\n",
> +                       mmc_hostname(host), err);
> +               goto out_err;
> +       }
> +
> +       mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
> +
> +       if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
> +               err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
> +       else
> +               err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
> +       if (err) {
> +               pr_err("%s: test 8 bit mode for hs400es failed, err:%d\n",
> +                       mmc_hostname(host), err);
>                 goto out_err;

Lot's open coding, no I don't like it.

Wouldn't it instead be possible to check the return value from
mmc_select_bus_width(), as it should tell what width it manage to
select. Then if it isn't 8-bit, then we should bail out. Does that
work?

> +       }
>
>         /* Switch card to HS mode */
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> --
> 1.9.1
>

Kind regards
Uffe
