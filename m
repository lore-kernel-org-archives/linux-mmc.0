From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdio: improve mmc_io_rw_extended
Date: Thu, 23 Mar 2017 11:05:27 +0100
Message-ID: <CAPDyKFrFPBqGwqe8hFuDb--9U_VNkj-c2rx=WVNKjiwcuTzBuA@mail.gmail.com>
References: <76e7bc2c-0cb0-4fca-7e2f-00770cd72a1b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:35841 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdCWKFb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2017 06:05:31 -0400
Received: by mail-ua0-f180.google.com with SMTP id x52so5812146uax.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2017 03:05:28 -0700 (PDT)
In-Reply-To: <76e7bc2c-0cb0-4fca-7e2f-00770cd72a1b@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 22 March 2017 at 21:59, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Improve mmc_io_rw_extended a little:
> - using DIV_ROUND_UP achieves the same but is better readable
> - simplify code by using sg_set_buf
> - simplify one statement by using -= operator
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_ops.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 3c0d3ab4..abaaba38 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -152,7 +152,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         data.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
>
>         left_size = data.blksz * data.blocks;
> -       nents = (left_size - 1) / seg_size + 1;
> +       nents = DIV_ROUND_UP(left_size, seg_size);
>         if (nents > 1) {
>                 if (sg_alloc_table(&sgtable, nents, GFP_KERNEL))
>                         return -ENOMEM;
> @@ -161,10 +161,9 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>                 data.sg_len = nents;
>
>                 for_each_sg(data.sg, sg_ptr, data.sg_len, i) {
> -                       sg_set_page(sg_ptr, virt_to_page(buf + (i * seg_size)),
> -                                       min(seg_size, left_size),
> -                                       offset_in_page(buf + (i * seg_size)));
> -                       left_size = left_size - seg_size;
> +                       sg_set_buf(sg_ptr, buf + i * seg_size,
> +                                  min(seg_size, left_size));
> +                       left_size -= seg_size;
>                 }
>         } else {
>                 data.sg = &sg;
> --
> 2.12.0
>
