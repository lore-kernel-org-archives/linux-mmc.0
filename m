From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdio: get seg_size after the check of card
Date: Tue, 23 Aug 2016 12:30:21 +0200
Message-ID: <CAPDyKFrw0rQD1nUv-1+8te_RGdros+-nGRyB6kr4oYvJiecfFw@mail.gmail.com>
References: <1471753808-1087-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36170 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755256AbcHWKfc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2016 06:35:32 -0400
Received: by mail-wm0-f50.google.com with SMTP id q128so157259749wma.1
        for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2016 03:35:32 -0700 (PDT)
In-Reply-To: <1471753808-1087-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 21 August 2016 at 06:30, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> When using mmc_io_rw_extended. it's intent to avoid
> null pointer of card but actually it didn't prevent
> it as the seg_size already use the card. So we need
> to move this after the check.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/core/sdio_ops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 34f6e80..15a06b8 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -127,7 +127,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         struct scatterlist sg, *sg_ptr;
>         struct sg_table sgtable;
>         unsigned int nents, left_size, i;
> -       unsigned int seg_size = card->host->max_seg_size;
> +       unsigned int seg_size;
>
>         BUG_ON(!card);
>         BUG_ON(fn > 7);

Can we try to remove these BUG_ONs() instead and deploy proper error
handling - if needed.

> @@ -137,6 +137,8 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         if (addr & ~0x1FFFF)
>                 return -EINVAL;
>
> +       seg_size = card->host->max_seg_size;
> +
>         mrq.cmd = &cmd;
>         mrq.data = &data;
>
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe
