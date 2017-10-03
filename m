From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Fix bug when removing RPMB chardev
Date: Tue, 3 Oct 2017 14:07:19 +0300
Message-ID: <2d54cc9e-7c2c-20b8-9bc9-64f4c0605db7@intel.com>
References: <20171002115918.11035-1-linus.walleij@linaro.org>
 <94d90383-c6de-910d-627e-f445f242f6f1@intel.com>
 <CACRpkdZ5=u3YtdgGFj1gk+4mSP36Cj2YD6z-nm7SEbM5cgkFWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:38606 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdJCLOF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Oct 2017 07:14:05 -0400
In-Reply-To: <CACRpkdZ5=u3YtdgGFj1gk+4mSP36Cj2YD6z-nm7SEbM5cgkFWg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 03/10/17 13:00, Linus Walleij wrote:
> On Tue, Oct 3, 2017 at 10:32 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Also I noticed this function:
>>
>> static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
>> {
>>         struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
>>                                                   struct mmc_rpmb_data, chrdev);
>>
>>         put_device(&rpmb->dev);
>>         mutex_lock(&open_lock);
>>         rpmb->md->usage--;
>>         mutex_unlock(&open_lock);
>>
>>         return 0;
>> }
>>
>> What is going on with 'usage'?  It looks weird.
> 
> It is the same reference counting as was present before the patch
> converting the block device to a character device. Not my invention.
> It's been there since the conception of the MMC stack.
> 
> While the get_device()/put_device() is reference counting the
> RPMB device per se, this is refcounting the block device that
> is backing the RPMB char device, so that the block device
> cannot be removed if the character device is using it for
> RPMB access.
> 
>> What happens if you do this:
>>         open the rpmb device
>>         unbind the host controller
>>         try to use an ioctl
>>         close the rpmb device
> 
> It's analogous to the similar usecase I had in GPIO:
> 
> What if you're holding (in userspace) a reference to a resource and
> the hardware backing the resource goes away?
> 
> In GPIO I chose to "numb" the device so that any further ioctl()s
> would just be silently ignored but for RPMB I guess we should
> simply start returning errors.
> 
> Since I'm still supporting the old refcounting with md->usage
> as described above, it should behave the same as the old
> codebase, which might not be very good behaviour but atleast
> it is not a regression.

How do you know you are not dropping the last reference when you do
md->usage-- ?
