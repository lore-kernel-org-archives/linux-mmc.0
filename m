From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] [RFC] mmc: block: Replace "goto retry" by a proper do
 / while loop
Date: Thu, 29 Dec 2016 20:03:01 +0100
Message-ID: <CAPDyKFr5Jh1FP9TbpQCBWVGshuRRbTuS=Ne0CvSJZO_aUTF-7A@mail.gmail.com>
References: <1482156225-32517-1-git-send-email-geert@linux-m68k.org> <1482156225-32517-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f180.google.com ([209.85.210.180]:35009 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbcL2TDD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2016 14:03:03 -0500
Received: by mail-wj0-f180.google.com with SMTP id v7so364584621wjy.2
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2016 11:03:03 -0800 (PST)
In-Reply-To: <1482156225-32517-2-git-send-email-geert@linux-m68k.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 19 December 2016 at 15:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Compile-tested only.
>
> The extra assignment of 0 to err could be avoided:
>
>         do {
>                 if (!(card->quirks & MMC_QUIRK_INAND_CMD38) ||
>                     !(err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                        INAND_CMD38_ARG_EXT_CSD,
>                                        arg == MMC_TRIM_ARG ?
>                                        INAND_CMD38_ARG_TRIM :
>                                        INAND_CMD38_ARG_ERASE,
>                                        0)))
>                         err = mmc_erase(card, from, nr, arg);
>         } while (err == -EIO && !mmc_blk_reset(md, card->host, type));
>
> but that looks uglier to me, and makes the quirk handling less obvious.
> ---
>  drivers/mmc/core/block.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8c0e0833d481cf94..4159508df9eea277 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1164,21 +1164,19 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>                 arg = MMC_TRIM_ARG;
>         else
>                 arg = MMC_ERASE_ARG;
> -retry:
> -       if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> -               err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                                INAND_CMD38_ARG_EXT_CSD,
> -                                arg == MMC_TRIM_ARG ?
> -                                INAND_CMD38_ARG_TRIM :
> -                                INAND_CMD38_ARG_ERASE,
> -                                0);
> -               if (err)
> -                       goto out;
> -       }
> -       err = mmc_erase(card, from, nr, arg);
> -out:
> -       if (err == -EIO && !mmc_blk_reset(md, card->host, type))
> -               goto retry;
> +       do {
> +               err = 0;
> +               if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> +                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +                                        INAND_CMD38_ARG_EXT_CSD,
> +                                        arg == MMC_TRIM_ARG ?
> +                                        INAND_CMD38_ARG_TRIM :
> +                                        INAND_CMD38_ARG_ERASE,
> +                                        0);
> +               }
> +               if (!err)
> +                       err = mmc_erase(card, from, nr, arg);
> +       } while (err == -EIO && !mmc_blk_reset(md, card->host, type));
>         if (!err)
>                 mmc_blk_reset_success(md, type);
>  fail:
> --
> 1.9.1
>
