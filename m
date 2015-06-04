From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH] mmc: core: Optimize case for exactly one erase-group
 budget TRIM
Date: Thu, 4 Jun 2015 10:31:59 +0200
Message-ID: <CAPDyKFocxYD+q_CQQ4Kz6ZZ88P+DwWcwfrEGEJJEEgkFT5r+MA@mail.gmail.com>
References: <1433320469-29453-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35661 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbbFDIcA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 04:32:00 -0400
Received: by qkhq76 with SMTP id q76so20159646qkh.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2015 01:31:59 -0700 (PDT)
In-Reply-To: <1433320469-29453-1-git-send-email-david@protonic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Pierre Ossman <pierre@ossman.eu>, Sascha Hauer <s.hauer@pengutronix.de>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 3 June 2015 at 10:34, David Jander <david@protonic.nl> wrote:
> In the (not so unlikely) case that the mmc controller timeout budget is
> enough for exactly one erase-group, the simplification of allowing one
> sector has an enormous performance penalty. We optimize this special case
> by introducing a flag that prohibits erase-group boundary crossing, so
> that we can allow trimming more than one sector at a time.
>
> Signed-off-by: David Jander <david@protonic.nl>

Hi David,

Thanks for working on this!

> ---
>  drivers/mmc/core/core.c  | 21 +++++++++++++++++----
>  include/linux/mmc/card.h |  1 +
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 92e7671..6c9611b 100644
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
> @@ -2139,6 +2140,15 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>         /* 'from' and 'to' are inclusive */
>         to -= 1;
>
> +       if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) &&
> +           (from % card->erase_size)) {
> +               rem = card->erase_size - (from % card->erase_size);
> +               err = mmc_do_erase(card, from, from + rem - 1, arg);
> +               from += rem;
> +               if ((err) || (to <= from))
> +                       return err;
> +       }
> +

Urgh, this function is becoming a bit messy. Would it be possible to
split the code into some helper functions instead - and adding some
additional comments of what goes on maybe?

>         return mmc_do_erase(card, from, to, arg);
>  }
>  EXPORT_SYMBOL(mmc_erase);
> @@ -2234,16 +2244,19 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>         if (!qty)
>                 return 0;
>
> +       /* We can only erase one erase group special case */

Could you extend this comment a bit. I think it deserves that.

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

Kind regards
Uffe
