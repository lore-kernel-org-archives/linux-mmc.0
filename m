From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Fixed bug in one erase-group budget TRIM
Date: Tue, 25 Aug 2015 14:05:11 +0200
Message-ID: <CAPDyKFo91mh+EdAk8pUUXraPL03_NoKx06jzb7qWSwiSaRFkWA@mail.gmail.com>
References: <1438671513-16218-1-git-send-email-robin@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33317 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbbHYMFM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:05:12 -0400
Received: by igfj19 with SMTP id j19so9442925igf.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:05:12 -0700 (PDT)
In-Reply-To: <1438671513-16218-1-git-send-email-robin@protonic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robin van der Gracht <robin@protonic.nl>
Cc: David Jander <david@protonic.nl>, linux-mmc <linux-mmc@vger.kernel.org>

On 4 August 2015 at 08:58, Robin van der Gracht <robin@protonic.nl> wrote:
> When requesting a trim for several bytes, everything up to the next
> erase-group is erased. This causes data corruption.
>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 083cade..57edb2a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2227,9 +2227,8 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>          * and call mmc_do_erase() twice if necessary. This special case is
>          * identified by the card->eg_boundary flag.
>          */
> -       if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) &&
> -           (from % card->erase_size)) {
> -               rem = card->erase_size - (from % card->erase_size);
> +       rem = card->erase_size - (from % card->erase_size);
> +       if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) && (nr > rem)) {
>                 err = mmc_do_erase(card, from, from + rem - 1, arg);
>                 from += rem;
>                 if ((err) || (to <= from))
> --
> 2.1.4
>
