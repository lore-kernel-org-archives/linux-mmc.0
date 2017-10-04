From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: block: Fix bug when removing RPMB chardev
Date: Wed, 4 Oct 2017 11:39:41 +0200
Message-ID: <CAPDyKFpAki-2oJR9HmN+tD90kbTdJXz=ke7WWehALzmwiSBV-w@mail.gmail.com>
References: <20171004091007.26729-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:55038 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdJDJjm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2017 05:39:42 -0400
Received: by mail-it0-f51.google.com with SMTP id f79so102904ita.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Oct 2017 02:39:42 -0700 (PDT)
In-Reply-To: <20171004091007.26729-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 4 October 2017 at 11:10, Linus Walleij <linus.walleij@linaro.org> wrote:
> I forgot to account for the fact that the device core holds a
> reference to a device added with device_initialize() that need
> to be released with a corresponding put_device() to reach a 0
> refcount at the end of the lifecycle.
>
> This led to a NULL pointer reference when freeing the device
> when e.g. unbidning the host device in sysfs.
>
> Fix this and use the device .release() callback to free the
> IDA and free:ing the memory used by the RPMB device.
>
> Before this patch:
>
> /sys/bus/amba/drivers/mmci-pl18x$ echo 80114000.sdi4_per2 > unbind
> [   29.797332] mmc3: card 0001 removed
> [   29.810791] Unable to handle kernel NULL pointer dereference at
>                virtual address 00000050
> [   29.818878] pgd = de70c000
> [   29.821624] [00000050] *pgd=1e70a831, *pte=00000000, *ppte=00000000
> [   29.827911] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> [   29.833282] Modules linked in:
> [   29.836334] CPU: 1 PID: 154 Comm: sh Not tainted
>                4.14.0-rc3-00039-g83318e309566-dirty #736
> [   29.844604] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
> [   29.851562] task: de572700 task.stack: de742000
> [   29.856079] PC is at kernfs_find_ns+0x8/0x100
> [   29.860443] LR is at kernfs_find_and_get_ns+0x30/0x48
>
> After this patch:
>
> /sys/bus/amba/drivers/mmci-pl18x$ echo 80005000.sdi4_per2 > unbind
> [   20.623382] mmc3: card 0001 removed
>
> Fixes: 0ab0c7c0e65a ("mmc: block: Convert RPMB to a character device")
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This looks good to me. However I wait a bit to get an ack from Adrian
as well - before I queue this up for fixes!

Kind regards
Uffe

> ---
> ChangeLog v3->v4:
> - Also skip the lock now that we take it inside mmc_blk_get()/
>   mmc_blk_put()
> ChangeLog v2->v3:
> - Fix the block device reference counting: instead of manipulating
>   md->usage directly, call the proper refcounting functions
>   mmc_blk_get() and mmc_blk_put().
> ChangeLog v1->v2:
> - Drop the print from removing the RPMB partition
> - Refactor the error path of the RPMB to use refcounting
> - Drop the verbose comment on refcounts
> ---
>  drivers/mmc/core/block.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index c29dbcec7c61..ea80ff4cd7f9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2298,9 +2298,7 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
>
>         get_device(&rpmb->dev);
>         filp->private_data = rpmb;
> -       mutex_lock(&open_lock);
> -       rpmb->md->usage++;
> -       mutex_unlock(&open_lock);
> +       mmc_blk_get(rpmb->md->disk);
>
>         return nonseekable_open(inode, filp);
>  }
> @@ -2311,9 +2309,7 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
>                                                   struct mmc_rpmb_data, chrdev);
>
>         put_device(&rpmb->dev);
> -       mutex_lock(&open_lock);
> -       rpmb->md->usage--;
> -       mutex_unlock(&open_lock);
> +       mmc_blk_put(rpmb->md);
>
>         return 0;
>  }
> @@ -2329,6 +2325,13 @@ static const struct file_operations mmc_rpmb_fileops = {
>  #endif
>  };
>
> +static void mmc_blk_rpmb_device_release(struct device *dev)
> +{
> +       struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> +
> +       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> +       kfree(rpmb);
> +}
>
>  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>                                    struct mmc_blk_data *md,
> @@ -2347,8 +2350,10 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>                 return devidx;
>
>         rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
> -       if (!rpmb)
> +       if (!rpmb) {
> +               ida_simple_remove(&mmc_rpmb_ida, devidx);
>                 return -ENOMEM;
> +       }
>
>         snprintf(rpmb_name, sizeof(rpmb_name),
>                  "mmcblk%u%s", card->host->index, subname ? subname : "");
> @@ -2359,6 +2364,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>         rpmb->dev.bus = &mmc_rpmb_bus_type;
>         rpmb->dev.devt = MKDEV(MAJOR(mmc_rpmb_devt), rpmb->id);
>         rpmb->dev.parent = &card->dev;
> +       rpmb->dev.release = mmc_blk_rpmb_device_release;
>         device_initialize(&rpmb->dev);
>         dev_set_drvdata(&rpmb->dev, rpmb);
>         rpmb->md = md;
> @@ -2368,7 +2374,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>         ret = cdev_device_add(&rpmb->chrdev, &rpmb->dev);
>         if (ret) {
>                 pr_err("%s: could not add character device\n", rpmb_name);
> -               goto out_remove_ida;
> +               goto out_put_device;
>         }
>
>         list_add(&rpmb->node, &md->rpmbs);
> @@ -2383,18 +2389,16 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>
>         return 0;
>
> -out_remove_ida:
> -       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> -       kfree(rpmb);
> +out_put_device:
> +       put_device(&rpmb->dev);
>         return ret;
>  }
>
>  static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
> +
>  {
>         cdev_device_del(&rpmb->chrdev, &rpmb->dev);
> -       device_del(&rpmb->dev);
> -       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> -       kfree(rpmb);
> +       put_device(&rpmb->dev);
>  }
>
>  /* MMC Physical partitions consist of two boot partitions and
> --
> 2.13.5
>
