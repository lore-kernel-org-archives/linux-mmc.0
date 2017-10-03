From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Fix bug when removing RPMB chardev
Date: Tue, 3 Oct 2017 11:32:00 +0300
Message-ID: <94d90383-c6de-910d-627e-f445f242f6f1@intel.com>
References: <20171002115918.11035-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29382 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbdJCIiq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Oct 2017 04:38:46 -0400
In-Reply-To: <20171002115918.11035-1-linus.walleij@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 02/10/17 14:59, Linus Walleij wrote:
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
> [   20.627288] mmc_rpmb mmcblk3rpmb: removed
> 
> Fixes: 0ab0c7c0e65a ("mmc: block: Convert RPMB to a character device")
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index c29dbcec7c61..2033a71bacc3 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2329,6 +2329,14 @@ static const struct file_operations mmc_rpmb_fileops = {
>  #endif
>  };
>  
> +static void mmc_blk_rpmb_device_release(struct device *dev)
> +{
> +	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> +
> +	dev_info(dev, "removed\n");

Do we really need this message?

> +	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> +	kfree(rpmb);
> +}
>  
>  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>  				   struct mmc_blk_data *md,
> @@ -2371,6 +2379,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>  		goto out_remove_ida;
>  	}
>  
> +	/* From this point, the .release() function cleans up the device */
> +	rpmb->dev.release = mmc_blk_rpmb_device_release;

This should be before device_initialize(&rpmb->dev) then the error path
becomes just put_device(&rpmb->dev).

But further up is:
	rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
	if (!rpmb)
		return -ENOMEM;
where it looks like you are leaking the ida.

>  	list_add(&rpmb->node, &md->rpmbs);
>  
>  	string_get_size((u64)size, 512, STRING_UNITS_2,
> @@ -2384,17 +2394,22 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>  	return 0;
>  
>  out_remove_ida:
> +	put_device(&rpmb->dev);
>  	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
>  	kfree(rpmb);
>  	return ret;
>  }
>  
>  static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
> +
>  {
>  	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
> -	device_del(&rpmb->dev);
> -	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> -	kfree(rpmb);
> +	/*
> +	 * Unless something is holding a reference to the device, this
> +	 * drops the last reference and triggers the device to cleanup
> +	 * and calls the .remove() callback.
> +	 */

This comment seems redundant since it is just describing how reference
counting works.

> +	put_device(&rpmb->dev);
>  }
>  
>  /* MMC Physical partitions consist of two boot partitions and
> 

Also I noticed this function:

static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
{
	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
						  struct mmc_rpmb_data, chrdev);

	put_device(&rpmb->dev);
	mutex_lock(&open_lock);
	rpmb->md->usage--;
	mutex_unlock(&open_lock);

	return 0;
}

What is going on with 'usage'?  It looks weird.
What happens if you do this:
	open the rpmb device
	unbind the host controller
	try to use an ioctl
	close the rpmb device
