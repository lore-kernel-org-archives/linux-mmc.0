From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mmc: core: switch to 1V8 or 1V2 for hs400es mode
Date: Mon, 10 Oct 2016 14:38:01 +0200
Message-ID: <CAPDyKFrRGee=g4Nc5Cyb1d1O7Gux3DG4GX=Q-izr+kbz5M+YEw@mail.gmail.com>
References: <1475216340-15344-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1475216340-15344-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "# 4.0+" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 30 September 2016 at 08:18, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> When introducing hs400es, I didn't notice that we haven't
> switched voltage to 1V2 or 1V8 for it. That happens to work
> as the first controller claiming to support hs400es, arasan(5.1),
> which is designed to only support 1V8. So the voltage is fixed to 1V8.
> But it actually is wrong, and will not fit for other host controllers.
> Let's fix it.
>
> Fixes: commit 81ac2af65793ecf ("mmc: core: implement enhanced strobe support")
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>
> Changes in v3:
> - add Doug's tag
>
> Changes in v2:
> - fix copy-paste error, mea culpa
>
>  drivers/mmc/core/mmc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3486bc7..f4ed5ac 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1263,6 +1263,16 @@ static int mmc_select_hs400es(struct mmc_card *card)
>                 goto out_err;
>         }
>
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_2V)
> +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
> +
> +       if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V)
> +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
> +
> +       /* If fails try again during next card power cycle */
> +       if (err)
> +               goto out_err;
> +
>         err = mmc_select_bus_width(card);
>         if (err < 0)
>                 goto out_err;
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
