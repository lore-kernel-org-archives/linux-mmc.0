From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdio: deploy error handling instead of
 triggering BUG_ON
Date: Wed, 24 Aug 2016 11:30:29 +0200
Message-ID: <CAPDyKFrt3ZHrzR9TovG2a3nqs7pKqdVHoU-KXtgRsnFGaJK4DQ@mail.gmail.com>
References: <1472025499-6758-1-git-send-email-shawn.lin@rock-chips.com> <1472025499-6758-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35286 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbcHXKAP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2016 06:00:15 -0400
Received: by mail-wm0-f48.google.com with SMTP id f65so193790574wmi.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2016 02:59:53 -0700 (PDT)
In-Reply-To: <1472025499-6758-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 24 August 2016 at 09:58, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> When using mmc_io_rw_extended, it's intent to avoid null
> pointer of card and invalid func number. But actually it
> didn't prevent that as the seg_size already use the card.
> Currently the wrapper function sdio_io_rw_ext_helper already
> use card before calling mmc_io_rw_extended, so we should move
> this check to there. As to the func number, it was token from
> '(ocr & 0x70000000) >> 28' which should be enough to guarantee
> that it won't be larger than 7. But we should prevent the
> caller like wifi drivers modify this value. So let's move this
> check into sdio_io_rw_ext_helper either.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
> Changes in v2:
> - remove the BUG_ON and move these into sdio_io_rw_ext_helper
>
>  drivers/mmc/core/sdio_io.c  | 3 +++
>  drivers/mmc/core/sdio_ops.c | 2 --
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 78cb4d5..18f2938 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -307,6 +307,9 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>         unsigned max_blocks;
>         int ret;
>
> +       if ((!func->card) || (func->num > 7))

You also need to validate func and before func->card.

> +               return -EINVAL;
> +
>         /* Do the bulk of the transfer using block mode (if supported). */
>         if (func->card->cccr.multi_block && (size > sdio_max_byte_size(func))) {
>                 /* Blocks per command is limited by host count, host transfer
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 34f6e80..45397e8 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -129,8 +129,6 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         unsigned int nents, left_size, i;
>         unsigned int seg_size = card->host->max_seg_size;
>
> -       BUG_ON(!card);
> -       BUG_ON(fn > 7);
>         WARN_ON(blksz == 0);
>
>         /* sanity check */
> --
> 2.3.7
>
>

There are a couple of more BUG_ONs() that is being invoked when SDIO
func drivers abuses the SDIO func API.

In cases when the API allows us to propagate error codes we should do
that and just when the sdio_io_rw_ext_helper() is involved. In case
when the API don't allows to propagate error codes, we should convert
the BUG_ON() to  "if (WARN_ON()) return;".

Kind regards
Uffe
