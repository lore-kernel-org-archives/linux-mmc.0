From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: switch to ida_simple_ functions in block.c
Date: Wed, 1 Feb 2017 21:21:01 +0100
Message-ID: <CAPDyKFqcTQEZS=sx4zqENM-wTST6dtXorQ3G4u+-96SH1QNeHg@mail.gmail.com>
References: <9c4a989c-0962-0471-5e67-c405f5232efc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37785 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdBAUVD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 15:21:03 -0500
Received: by mail-wm0-f48.google.com with SMTP id v77so54864675wmv.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 12:21:03 -0800 (PST)
In-Reply-To: <9c4a989c-0962-0471-5e67-c405f5232efc@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 1 February 2017 at 19:44, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> ida code in block.c can be significantly simplified by switching to
> the ida_simple_ functions.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 31 +++++--------------------------
>  1 file changed, 5 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ede759dd..d5d8b0e6 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -90,7 +90,6 @@ static int max_devices;
>  #define MAX_DEVICES 256
>
>  static DEFINE_IDA(mmc_blk_ida);
> -static DEFINE_SPINLOCK(mmc_blk_lock);
>
>  /*
>   * There is one mmc_blk_data per slot.
> @@ -163,11 +162,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
>         if (md->usage == 0) {
>                 int devidx = mmc_get_devidx(md->disk);
>                 blk_cleanup_queue(md->queue.queue);
> -
> -               spin_lock(&mmc_blk_lock);
> -               ida_remove(&mmc_blk_ida, devidx);
> -               spin_unlock(&mmc_blk_lock);
> -
> +               ida_simple_remove(&mmc_blk_ida, devidx);
>                 put_disk(md->disk);
>                 kfree(md);
>         }
> @@ -1836,23 +1831,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         struct mmc_blk_data *md;
>         int devidx, ret;
>
> -again:
> -       if (!ida_pre_get(&mmc_blk_ida, GFP_KERNEL))
> -               return ERR_PTR(-ENOMEM);
> -
> -       spin_lock(&mmc_blk_lock);
> -       ret = ida_get_new(&mmc_blk_ida, &devidx);
> -       spin_unlock(&mmc_blk_lock);
> -
> -       if (ret == -EAGAIN)
> -               goto again;
> -       else if (ret)
> -               return ERR_PTR(ret);
> -
> -       if (devidx >= max_devices) {
> -               ret = -ENOSPC;
> -               goto out;
> -       }
> +       devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
> +       if (devidx < 0)
> +               return ERR_PTR(devidx);
>
>         md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
>         if (!md) {
> @@ -1941,9 +1922,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>   err_kfree:
>         kfree(md);
>   out:
> -       spin_lock(&mmc_blk_lock);
> -       ida_remove(&mmc_blk_ida, devidx);
> -       spin_unlock(&mmc_blk_lock);
> +       ida_simple_remove(&mmc_blk_ida, devidx);
>         return ERR_PTR(ret);
>  }
>
> --
> 2.11.0
>
