From: Laszlo Fiat <laszlo.fiat@gmail.com>
Subject: Re: [PATCH] mmc: block: Use the mmc host device index as the mmcblk
 device index
Date: Sun, 10 Apr 2016 20:04:05 +0200
Message-ID: <CA+7w51h=A4vVjkJTEvNoRG=GRt-GPSwqN4N4P3k-OqnubPo+kg@mail.gmail.com>
References: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38300 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653AbcDJSEI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Apr 2016 14:04:08 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so77596927wme.1
        for <linux-mmc@vger.kernel.org>; Sun, 10 Apr 2016 11:04:06 -0700 (PDT)
In-Reply-To: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hello,

I have tested this patch on top of v4.6-rc2 + our usual out-of-tree
patches from [1], and there is still no SDIO wifi showing up on
baytrail-t. dmesg is available at [2].

[1] https://github.com/hadess/rtl8723bs/tree/master/patches
[2] https://bugzilla.kernel.org/show_bug.cgi?id=112571#c9


Best regards,

Laszlo Fiat

On Thu, Apr 7, 2016 at 9:57 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Commit 520bd7a8b415 ("mmc: core: Optimize boot time by detecting cards
> simultaneously") causes regressions for some platforms.
>
> These platforms relies on fixed mmcblk device indexes, instead of
> deploying the defacto standard with UUID/PARTUUID. In other words their
> rootfs needs to be available at hardcoded paths, like /dev/mmcblk0p2.
>
> Such guarantees have never been made by the kernel, but clearly the above
> commit changes the behaviour. More precisely, because of that the order
> changes of how cards becomes detected, so do their corresponding mmcblk
> device indexes.
>
> As the above commit significantly improves boot time for some platforms
> (magnitude of seconds), let's avoid reverting this change but instead
> restore the behaviour of how mmcblk device indexes becomes picked.
>
> By using the same index for the mmcblk device as for the corresponding mmc
> host device, the probe order of mmc host devices decides the index we get
> for the mmcblk device.
>
> For those platforms that suffers from a regression, one could expect that
> this updated behaviour should be sufficient to meet their expectations of
> "fixed" mmcblk device indexes.
>
> Another side effect from this change, is that the same index is used for
> the mmc host device, the mmcblk device and the mmc block queue. That
> should clarify their relationship.
>
> Reported-by: Peter Hurley <peter@hurleysoftware.com>
> Reported-by: Laszlo Fiat <laszlo.fiat@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 520bd7a8b415 ("mmc: core: Optimize boot time by detecting cards
> simultaneously")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/card/block.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 3bdbe50..8a0147d 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -86,7 +86,6 @@ static int max_devices;
>
>  /* TODO: Replace these with struct ida */
>  static DECLARE_BITMAP(dev_use, MAX_DEVICES);
> -static DECLARE_BITMAP(name_use, MAX_DEVICES);
>
>  /*
>   * There is one mmc_blk_data per slot.
> @@ -105,7 +104,6 @@ struct mmc_blk_data {
>         unsigned int    usage;
>         unsigned int    read_only;
>         unsigned int    part_type;
> -       unsigned int    name_idx;
>         unsigned int    reset_done;
>  #define MMC_BLK_READ           BIT(0)
>  #define MMC_BLK_WRITE          BIT(1)
> @@ -2202,19 +2200,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                 goto out;
>         }
>
> -       /*
> -        * !subname implies we are creating main mmc_blk_data that will be
> -        * associated with mmc_card with dev_set_drvdata. Due to device
> -        * partitions, devidx will not coincide with a per-physical card
> -        * index anymore so we keep track of a name index.
> -        */
> -       if (!subname) {
> -               md->name_idx = find_first_zero_bit(name_use, max_devices);
> -               __set_bit(md->name_idx, name_use);
> -       } else
> -               md->name_idx = ((struct mmc_blk_data *)
> -                               dev_to_disk(parent)->private_data)->name_idx;
> -
>         md->area_type = area_type;
>
>         /*
> @@ -2264,7 +2249,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>          */
>
>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> -                "mmcblk%u%s", md->name_idx, subname ? subname : "");
> +                "mmcblk%u%s", card->host->index, subname ? subname : "");
>
>         if (mmc_card_mmc(card))
>                 blk_queue_logical_block_size(md->queue.queue,
> @@ -2418,7 +2403,6 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
>         struct list_head *pos, *q;
>         struct mmc_blk_data *part_md;
>
> -       __clear_bit(md->name_idx, name_use);
>         list_for_each_safe(pos, q, &md->part) {
>                 part_md = list_entry(pos, struct mmc_blk_data, part);
>                 list_del(pos);
> --
> 1.9.1
>
