From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH v2] mmc: Set pref erase size based on size.
Date: Fri, 10 Jun 2016 10:02:43 -0700
Message-ID: <CANEJEGtbnhh=Bru5T2+o2VFrpeZ2KRAK6FJfFEH4FpaUJM1Jkw@mail.gmail.com>
References: <1464908184-20153-1-git-send-email-gwendal@chromium.org> <1464913638-5283-1-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464913638-5283-1-git-send-email-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: Grant Grundler <grundler@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 2, 2016 at 5:27 PM, Gwendal Grignou <gwendal@chromium.org> wrote:
> If available, eMMC stack uses HC_ERASE_GRP_SIZE as preferred erase size.
> However, that size is the minimal size we must use, not the optimal size.
> Calculate the optimal size based on whole device size and fall back to
> HC_ERASE_GRP_SIZE if too small.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  v2: fix comments
>
>  drivers/mmc/core/core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index ef76b1c..b858907 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1987,17 +1987,17 @@ void mmc_init_erase(struct mmc_card *card)
>          * to that size and alignment.
>          *
>          * For SD cards that define Allocation Unit size, limit erases to one
> -        * Allocation Unit at a time.  For MMC cards that define High Capacity
> -        * Erase Size, whether it is switched on or not, limit to that size.
> -        * Otherwise just have a stab at a good value.  For modern cards it
> -        * will end up being 4MiB.  Note that if the value is too small, it
> -        * can end up taking longer to erase.
> +        * Allocation Unit at a time.
> +        * For MMC, have a stab at a good value.  For modern cards it
> +        * will end up being 4MiB.
> +        * Be sure the size is at least the High Capacity Erase Size, as long
> +        * as it is defined, even if not used.
> +        * Note that if the value is too small, it can end up taking longer to
> +        * erase.

The last sentence is a key point.

I want to point out the difference in erasing ~23GB of a 32GB device
as specified by the number of secure erase commands sent:
   ~44K commands (default: single erase block): ~30 minutes
   ~700 commands (32MB chunks) : ~90 seconds
   1 command: < 6 seconds

cheers,
grant

>          */
>         if (mmc_card_sd(card) && card->ssr.au) {
>                 card->pref_erase = card->ssr.au;
>                 card->erase_shift = ffs(card->ssr.au) - 1;
> -       } else if (card->ext_csd.hc_erase_size) {
> -               card->pref_erase = card->ext_csd.hc_erase_size;
>         } else if (card->erase_size) {
>                 sz = (card->csd.capacity << (card->csd.read_blkbits - 9)) >> 11;
>                 if (sz < 128)
> @@ -2015,6 +2015,8 @@ void mmc_init_erase(struct mmc_card *card)
>                         if (sz)
>                                 card->pref_erase += card->erase_size - sz;
>                 }
> +               if (card->ext_csd.hc_erase_size > card->pref_erase)
> +                       card->pref_erase = card->ext_csd.hc_erase_size;
>         } else
>                 card->pref_erase = 0;
>  }
> --
> 2.8.0.rc3.226.g39d4020
>
