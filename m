From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: optimize mmc_calc_max_discard
Date: Wed, 14 Feb 2018 11:38:24 +0100
Message-ID: <CAPDyKFrSdWQNBL+9UKGwRK3QQ3u4vE2qmn4N92yjwVC8E_j_Qg@mail.gmail.com>
References: <1518047981-23958-1-git-send-email-vlvrdv@gmail.com> <1518111705-11122-1-git-send-email-vlvrdv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518111705-11122-1-git-send-email-vlvrdv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergio Valverde <vlvrdv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 February 2018 at 18:41, Sergio Valverde <vlvrdv@gmail.com> wrote:
> If the max_discard value is zero, the conditional branch that checks the
> trim capabilities will never update this value with max_trim.
>
> Change the condition statement to also check the max_discard value in order
> to avoid an unnecessary call to mmc_do_calc_max_discard.
>
> Signed-off-by: Sergio Valverde <vlvrdv@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes in v2:
> - Evaluate max_discard to avoid unnecessary calls to mmc_can_trim.
>
>  drivers/mmc/core/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1f0f44f..c32c0f4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2567,7 +2567,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
>                 return card->pref_erase;
>
>         max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
> -       if (mmc_can_trim(card)) {
> +       if (max_discard && mmc_can_trim(card)) {
>                 max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
>                 if (max_trim < max_discard)
>                         max_discard = max_trim;
> --
> 2.7.4
>
