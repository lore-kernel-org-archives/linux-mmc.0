From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [FRC PATCH v2] mmc: core: Optimize case for exactly one
 erase-group budget TRIM
Date: Mon, 20 Jul 2015 13:19:09 +0200
Message-ID: <CAPDyKFpHTTmDktyxyabUA4Gwwx0qX9Lxr+EcXenno=Bme2XOXw@mail.gmail.com>
References: <1435052632-32441-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435052632-32441-1-git-send-email-david@protonic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Pierre Ossman <pierre@ossman.eu>, Sascha Hauer <s.hauer@pengutronix.de>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 June 2015 at 11:43, David Jander <david@protonic.nl> wrote:
> In the (not so unlikely) case that the mmc controller timeout budget is
> enough for exactly one erase-group, the simplification of allowing one
> sector has an enormous performance penalty. We optimize this special case
> by introducing a flag that prohibits erase-group boundary crossing, so
> that we can allow trimming more than one sector at a time.
>
> Signed-off-by: David Jander <david@protonic.nl>

Thanks, applied!

Kind regards
Uffe

> ---
>
> Changes since v1:
>  - Added more comment
>
>  drivers/mmc/core/core.c  | 38 ++++++++++++++++++++++++++++++++++----
>  include/linux/mmc/card.h |  1 +
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 92e7671..2771391 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2089,6 +2089,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>               unsigned int arg)
>  {
>         unsigned int rem, to = from + nr;
> +       int err;
>
>         if (!(card->host->caps & MMC_CAP_ERASE) ||
>             !(card->csd.cmdclass & CCC_ERASE))
> @@ -2139,6 +2140,23 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>         /* 'from' and 'to' are inclusive */
>         to -= 1;
>
> +       /*
> +        * Special case where only one erase-group fits in the timeout budget:
> +        * If the region crosses an erase-group boundary on this particular
> +        * case, we will be trimming more than one erase-group which, does not
> +        * fit in the timeout budget of the controller, so we need to split it
> +        * and call mmc_do_erase() twice if necessary. This special case is
> +        * identified by the card->eg_boundary flag.
> +        */
> +       if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) &&
> +           (from % card->erase_size)) {
> +               rem = card->erase_size - (from % card->erase_size);
> +               err = mmc_do_erase(card, from, from + rem - 1, arg);
> +               from += rem;
> +               if ((err) || (to <= from))
> +                       return err;
> +       }
> +
>         return mmc_do_erase(card, from, to, arg);
>  }
>  EXPORT_SYMBOL(mmc_erase);
> @@ -2234,16 +2252,28 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>         if (!qty)
>                 return 0;
>
> +       /*
> +        * When specifying a sector range to trim, chances are we might cross
> +        * an erase-group boundary even if the amount of sectors is less than
> +        * one erase-group.
> +        * If we can only fit one erase-group in the controller timeout budget,
> +        * we have to care that erase-group boundaries are not crossed by a
> +        * single trim operation. We flag that special case with "eg_boundary".
> +        * In all other cases we can just decrement qty and pretend that we
> +        * always touch (qty + 1) erase-groups as a simple optimization.
> +        */
>         if (qty == 1)
> -               return 1;
> +               card->eg_boundary = 1;
> +       else
> +               qty--;
>
>         /* Convert qty to sectors */
>         if (card->erase_shift)
> -               max_discard = --qty << card->erase_shift;
> +               max_discard = qty << card->erase_shift;
>         else if (mmc_card_sd(card))
> -               max_discard = qty;
> +               max_discard = qty + 1;
>         else
> -               max_discard = --qty * card->erase_size;
> +               max_discard = qty * card->erase_size;
>
>         return max_discard;
>  }
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 19f0175..704b60d 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -282,6 +282,7 @@ struct mmc_card {
>         unsigned int            erase_size;     /* erase size in sectors */
>         unsigned int            erase_shift;    /* if erase unit is power 2 */
>         unsigned int            pref_erase;     /* in sectors */
> +       unsigned int            eg_boundary;    /* don't cross erase-group boundaries */
>         u8                      erased_byte;    /* value of erased bytes */
>
>         u32                     raw_cid[4];     /* raw card CID */
> --
> 2.1.4
>
