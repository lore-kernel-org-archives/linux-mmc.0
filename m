From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] mmc: mmc: do not use CMD13 to get status after speed
 mode switch
Date: Tue, 21 Jun 2016 15:16:03 +0200
Message-ID: <CAPDyKFqaba9D4XtuDnPLcq2D4dpO6Cq9-RfhwoEu_vO=Pt9wEQ@mail.gmail.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
 <1463647662-27426-3-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1463647662-27426-3-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 19 May 2016 at 10:47, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> Per JEDEC spec, it is not recommended to use CMD13 to get card status
> after speed mode switch. below are two reason about this:
> 1. CMD13 cannot be guaranteed due to the asynchronous operation.
> Therefore it is not recommended to use CMD13 to check busy completion
> of the timing change indication.
> 2. After switch to HS200, CMD13 will get response of 0x800, and even the
> busy signal gets de-asserted, the response of CMD13 is aslo 0x800.
>
> Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Thanks, applied for next! (With a minor change, see below)

[...]

>
>         /* Switch HS to HS200 */
>         val = EXT_CSD_TIMING_HS200 |
>               card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
>                            val, card->ext_csd.generic_cmd6_time, true,
> -                          send_status, true);
> +                          false, true);

To keep consistency with other calls to __mmc_switch(), I change these lines to:

err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
                       val, card->ext_csd.generic_cmd6_time,
                       true, false, true);

>         if (err)
>                 goto out_err;
>
>         mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>
> -       if (!send_status) {
> -               err = mmc_switch_status(card);
> -               if (err)
> -                       goto out_err;
> -       }
> +       err = mmc_switch_status(card);
> +       if (err)
> +               goto out_err;
>
>         mmc_set_bus_speed(card);
>
> @@ -1243,7 +1227,6 @@ static void mmc_select_driver_type(struct mmc_card *card)
>  static int mmc_select_hs200(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       bool send_status = true;
>         unsigned int old_timing;
>         int err = -EINVAL;
>         u8 val;
> @@ -1260,9 +1243,6 @@ static int mmc_select_hs200(struct mmc_card *card)
>
>         mmc_select_driver_type(card);
>
> -       if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> -               send_status = false;
> -
>         /*
>          * Set the bus width(4 or 8) with host's support and
>          * switch to HS200 mode if bus width is set successfully.
> @@ -1274,20 +1254,18 @@ static int mmc_select_hs200(struct mmc_card *card)
>                 err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                    EXT_CSD_HS_TIMING, val,
>                                    card->ext_csd.generic_cmd6_time,
> -                                  true, send_status, true);
> +                                  true, false, true);

[...]

Kind regards
Uffe
