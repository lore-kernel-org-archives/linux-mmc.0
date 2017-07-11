From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc_ops: fix a typo for comment of mmc_start_bkops
Date: Tue, 11 Jul 2017 16:43:59 +0200
Message-ID: <CAPDyKFoasn0+GKHTkb0nE=5LB+2m7sQfHP6VMNzNn3M1=mgpwQ@mail.gmail.com>
References: <1499135403-56224-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36705 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933390AbdGKOoA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:44:00 -0400
Received: by mail-qk0-f173.google.com with SMTP id p21so2620782qke.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:44:00 -0700 (PDT)
In-Reply-To: <1499135403-56224-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 4 July 2017 at 04:30, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Just a trivial fix for that found by reading the code.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 5f7c592..6dd8ecd 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -946,7 +946,7 @@ static int mmc_read_bkops_status(struct mmc_card *card)
>  /**
>   *     mmc_start_bkops - start BKOPS for supported cards
>   *     @card: MMC card to start BKOPS
> - *     @form_exception: A flag to indicate if this function was
> + *     @from_exception: A flag to indicate if this function was
>   *                      called due to an exception raised by the card
>   *
>   *     Start background operations whenever requested.
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
