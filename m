From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] CHROMIUM: mmc: Set pref erase size based on size.
Date: Wed, 22 Jun 2016 17:23:04 +0200
Message-ID: <CAPDyKFqdBLcqTEC98EvVOj0bN-BM9dcpT7CEd6Q+MyOOKPOx-A@mail.gmail.com>
References: <1464913638-5283-1-git-send-email-gwendal@chromium.org> <1464970132-26197-1-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464970132-26197-1-git-send-email-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 June 2016 at 18:08, Gwendal Grignou <gwendal@chromium.org> wrote:
> If available, eMMC stack uses HC_ERASE_GRP_SIZE as erase size.
> The perfererred erase size may need to be bigger to ensure discard
> operations are not too slow.
> Some high capacity eMMC (64MB) reports erase size to 512kB, resulting in
> long discard time.
> Calculate prefeerred erase size based on eMMC size.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Thanks, applied for next! I did update the changelog as well as the
comment in the code.

Please next time, try to work a bit more on the changelog. It really
helps when reviewing to understand what the change is all about.

Kind regards
Uffe

> ---
>  v2: fix comments
>  v3: rereading the patch, we should not compare to hc_erase_size again,
>      it has already been set properly in the caller function.
>
>  drivers/mmc/core/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index ef76b1c..bd881a0 100644
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
> +        * Note that if the value is too small, it can end up taking longer to
> +        * erase.
> +        * erase_size is already set to High Capacity Erase Size if available
> +        * when this function is called.
>          */
>         if (mmc_card_sd(card) && card->ssr.au) {
>                 card->pref_erase = card->ssr.au;
>                 card->erase_shift = ffs(card->ssr.au) - 1;
> -       } else if (card->ext_csd.hc_erase_size) {
> -               card->pref_erase = card->ext_csd.hc_erase_size;
>         } else if (card->erase_size) {
>                 sz = (card->csd.capacity << (card->csd.read_blkbits - 9)) >> 11;
>                 if (sz < 128)
> --
> 2.8.0.rc3.226.g39d4020
>
