From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC][PATCH v2] mmc_block: Allow more than 8 partitions per card
Date: Tue, 15 Dec 2015 16:11:28 +0100
Message-ID: <CAPDyKFpxruv3SoEDKw-BAHGvT4nbD5e8Rk_9dtrtdh6gnsafcA@mail.gmail.com>
References: <1445533241-10292-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34814 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbLOPL3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2015 10:11:29 -0500
Received: by mail-qk0-f182.google.com with SMTP id p187so16978321qkd.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2015 07:11:29 -0800 (PST)
In-Reply-To: <1445533241-10292-1-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Colin Cross <ccross@android.com>, Adrian Hunter <adrian.hunter@intel.com>, Ben Hutchings <ben@decadent.org.uk>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Android Kernel Team <kernel-team@android.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 22 October 2015 at 19:00, John Stultz <john.stultz@linaro.org> wrote:
> From: Colin Cross <ccross@android.com>
>
> It is quite common for Android devices to utilize more
> then 8 partitions on internal eMMC storage.
>
> The vanilla kernel can support this via
> CONFIG_MMC_BLOCK_MINORS, however that solution caps the
> system to 256 minors total, which limits the number of
> mmc cards the system can support.
>
> This patch, which has been carried for quite awhile in
> the AOSP common tree, provides an alternative solution
> that doesn't seem to limit the total card count. So I
> wanted to submit it for consideration upstream.
>
> This patch sets the GENHD_FL_EXT_DEVT flag, which will
> allocate minor number in major 259 for partitions past
> disk->minors.
>
> It also removes the use of disk_devt to determine devidx
> from md->disk. md->disk->first_minor is always initialized
> from devidx and can always be used to recover it.
>
> Thoughts or feedback would be greatly appreciated.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Austin S Hemmelgarn <ahferroin7@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Android Kernel Team <kernel-team@android.com>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Colin Cross <ccross@android.com>
> [jstultz: Added context to commit message]
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Thanks, applied for next!

I did some minor changes to the change-log, and updated the prefix of
the commit msg header.

Kind regards
Uffe

> ---
> v2: Added context to commit message about CONFIG_MMC_BLOCK_MINORS
>     and its limitations.
>
>  drivers/mmc/card/block.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c742cfd..564436e 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -172,11 +172,7 @@ static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>
>  static inline int mmc_get_devidx(struct gendisk *disk)
>  {
> -       int devmaj = MAJOR(disk_devt(disk));
> -       int devidx = MINOR(disk_devt(disk)) / perdev_minors;
> -
> -       if (!devmaj)
> -               devidx = disk->first_minor / perdev_minors;
> +       int devidx = disk->first_minor / perdev_minors;
>         return devidx;
>  }
>
> @@ -2162,6 +2158,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         md->disk->queue = md->queue.queue;
>         md->disk->driverfs_dev = parent;
>         set_disk_ro(md->disk, md->read_only || default_ro);
> +       md->disk->flags = GENHD_FL_EXT_DEVT;
>         if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
>                 md->disk->flags |= GENHD_FL_NO_PART_SCAN;
>
> --
> 1.9.1
>
