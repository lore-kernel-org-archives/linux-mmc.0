From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4] mmc: core: improve reasonableness of bus width setting
 for HS400es
Date: Mon, 30 Jul 2018 17:06:10 +0200
Message-ID: <CAPDyKFoEsRz8eQmZ+qXOSZ=cF2pjsR5UYJHp9UgJ4-3b6ofcww@mail.gmail.com>
References: <1531818865-7387-1-git-send-email-hongjiefang@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531818865-7387-1-git-send-email-hongjiefang@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hongjie Fang <hongjiefang@asrmicro.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Bastian Stender <bst@pengutronix.de>, Chanho Min <chanho.min@lge.com>, Kyle Roeschley <kyle.roeschley@ni.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 17 July 2018 at 11:14, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
> mmc_select_hs400es() calls mmc_select_bus_width() which will continue
> to set 4bit transfer mode if fail to set 8bit mode. The bus width
> should not be set to 4bit in HS400es.
>
> When fail to set 8bit mode, need return error directly for HS400es.
>
> Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
> ---
>  drivers/mmc/core/mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4466f5d..0dbc512 100644
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
> +               err = -EIO;
>                 goto out_err;

ENOTSUPP seems more like the correct one.

Something like this:

err = err < 0 ? err : -ENOTSUPP;


> +       }
>
>         /* Switch card to HS mode */
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> --
> 1.9.1
>

Kind regards
Uffe
