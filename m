From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Remove unnecessary temporary variable
Date: Fri, 23 Jan 2015 08:42:20 +0100
Message-ID: <CAPDyKFp57WZ1Tt8MP-gRsVHybV3kP3fRnCSW09vwC5P4d8f1Jw@mail.gmail.com>
References: <1421852204-8930-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:60096 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbbAWHmV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jan 2015 02:42:21 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so4762462qac.13
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2015 23:42:20 -0800 (PST)
In-Reply-To: <1421852204-8930-1-git-send-email-tklauser@distanz.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 21 January 2015 at 15:56, Tobias Klauser <tklauser@distanz.ch> wrote:
> Directly return the result of mmc_blk_alloc_req() instead of assigning
> and returning the variable md.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 4409d79..2c98b72 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2193,7 +2193,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
>  {
>         sector_t size;
> -       struct mmc_blk_data *md;
>
>         if (!mmc_card_sd(card) && mmc_card_blockaddr(card)) {
>                 /*
> @@ -2209,9 +2208,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
>                 size = card->csd.capacity << (card->csd.read_blkbits - 9);
>         }
>
> -       md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
> +       return mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
>                                         MMC_BLK_DATA_AREA_MAIN);
> -       return md;
>  }
>
>  static int mmc_blk_alloc_part(struct mmc_card *card,
> --
> 2.2.2
>
>
