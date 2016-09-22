From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/5] mmc: core: switch to 1V8 or 1V2 for hs400es mode
Date: Thu, 22 Sep 2016 11:39:30 +0200
Message-ID: <CAPDyKFoy=CgU=_6R0N0kHr48QyVOqjTzmppfc6Mzde5Fa6tHSQ@mail.gmail.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com> <1474422233-29355-3-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474422233-29355-3-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "# 4.0+" <stable@vger.kernel.org>, 4.4#@263.net, +@263.net
List-Id: linux-mmc@vger.kernel.org

On 21 September 2016 at 03:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> When introducing hs400es, I didn't notice that we haven't
> switched voltage to 1V2 or 1V8 for it. That happens to work
> as the first controller claiming to support hs400es, arasan(5.1),
> which is designed to only support 1V8. So the voltage is fixed to 1V8.
> But it actually is wrong, and will not fit for other host controllers.
> Let's fix it.
>
> Fixes: commit 81ac2af65793ecf ("mmc: core: implement enhanced strobe support")
> Cc: <stable@vger.kernel.org> 4.4# +
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/core/mmc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3486bc7..3163bb9 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1263,6 +1263,16 @@ static int mmc_select_hs400es(struct mmc_card *card)
>                 goto out_err;
>         }
>
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)

/s/EXT_CSD_CARD_TYPE_HS200_1_2V/EXT_CSD_CARD_TYPE_HS400_1_2V

> +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
> +
> +       if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)

/s/EXT_CSD_CARD_TYPE_HS200_1_8V/EXT_CSD_CARD_TYPE_HS400_1_8V

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

Kind regards
Uffe
