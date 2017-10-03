From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: block: Fix bug when removing RPMB chardev
Date: Tue, 3 Oct 2017 12:00:05 +0200
Message-ID: <CACRpkdZ5=u3YtdgGFj1gk+4mSP36Cj2YD6z-nm7SEbM5cgkFWg@mail.gmail.com>
References: <20171002115918.11035-1-linus.walleij@linaro.org> <94d90383-c6de-910d-627e-f445f242f6f1@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:54890 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdJCKAH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2017 06:00:07 -0400
Received: by mail-it0-f48.google.com with SMTP id e134so10692642ite.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Oct 2017 03:00:06 -0700 (PDT)
In-Reply-To: <94d90383-c6de-910d-627e-f445f242f6f1@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Oct 3, 2017 at 10:32 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 02/10/17 14:59, Linus Walleij wrote:

>> +static void mmc_blk_rpmb_device_release(struct device *dev)
>> +{
>> +     struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
>> +
>> +     dev_info(dev, "removed\n");
>
> Do we really need this message?

Nah. More for symmetry since we print when we add partitions
we also print when we remove them so it seemed consistent to
me.

>> +     /* From this point, the .release() function cleans up the device */
>> +     rpmb->dev.release = mmc_blk_rpmb_device_release;
>
> This should be before device_initialize(&rpmb->dev) then the error path
> becomes just put_device(&rpmb->dev).

The way I dealt with it in the GPIO subsystem was to not assign
this pointer until later, and manage resources in the initilializer
function (such as the error path) until that point.

But I rewrote it like you say.

> But further up is:
>         rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
>         if (!rpmb)
>                 return -ENOMEM;
> where it looks like you are leaking the ida.

OMG you're right. Fixed it for v2.

>> -     device_del(&rpmb->dev);
>> -     ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
>> -     kfree(rpmb);
>> +     /*
>> +      * Unless something is holding a reference to the device, this
>> +      * drops the last reference and triggers the device to cleanup
>> +      * and calls the .remove() callback.
>> +      */
>
> This comment seems redundant since it is just describing how reference
> counting works.

OK I cut the crap. :)

> Also I noticed this function:
>
> static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
> {
>         struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
>                                                   struct mmc_rpmb_data, chrdev);
>
>         put_device(&rpmb->dev);
>         mutex_lock(&open_lock);
>         rpmb->md->usage--;
>         mutex_unlock(&open_lock);
>
>         return 0;
> }
>
> What is going on with 'usage'?  It looks weird.

It is the same reference counting as was present before the patch
converting the block device to a character device. Not my invention.
It's been there since the conception of the MMC stack.

While the get_device()/put_device() is reference counting the
RPMB device per se, this is refcounting the block device that
is backing the RPMB char device, so that the block device
cannot be removed if the character device is using it for
RPMB access.

> What happens if you do this:
>         open the rpmb device
>         unbind the host controller
>         try to use an ioctl
>         close the rpmb device

It's analogous to the similar usecase I had in GPIO:

What if you're holding (in userspace) a reference to a resource and
the hardware backing the resource goes away?

In GPIO I chose to "numb" the device so that any further ioctl()s
would just be silently ignored but for RPMB I guess we should
simply start returning errors.

Since I'm still supporting the old refcounting with md->usage
as described above, it should behave the same as the old
codebase, which might not be very good behaviour but atleast
it is not a regression.

Posting the v2 soon.

Yours,
Linus Walleij
