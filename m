From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] mmc: block: Fix bug when removing RPMB chardev
Date: Wed, 4 Oct 2017 14:58:19 +0300
Message-ID: <fcf32b47-40bf-7b52-aa5b-6b8e517fa10e@intel.com>
References: <20171003135123.4934-1-linus.walleij@linaro.org>
 <c5f4052a-7c44-00a7-588b-a226a00a918e@intel.com>
 <CACRpkdYE9S+RML6Y_MU0LO0oWFJYsu2qfrxbuqhVQb=ktuTUNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:43029 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751934AbdJDMFF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Oct 2017 08:05:05 -0400
In-Reply-To: <CACRpkdYE9S+RML6Y_MU0LO0oWFJYsu2qfrxbuqhVQb=ktuTUNA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 04/10/17 12:09, Linus Walleij wrote:
> On Wed, Oct 4, 2017 at 9:39 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>>> @@ -2299,7 +2299,7 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
>>>       get_device(&rpmb->dev);
>>>       filp->private_data = rpmb;
>>>       mutex_lock(&open_lock);
>>> -     rpmb->md->usage++;
>>> +     mmc_blk_get(rpmb->md->disk);
>>
>> mmc_blk_get() also tries to mutex_lock(&open_lock)
> 
> Yeah :/ I fix.
> Sorry for this flunky (too)...
> 
>> But how do you know md still exists?
> 
> I was thinking that the reference counting is exactly for making sure
> it exists across open()/close()?

Previously the device being opened was the block device which had to exist.

But I think it is OK to assume md exists in mmc_rpmb_chrdev_open() because
rpmb->chrdev is removed before the main disk.

> 
>>  Looks like you need
>> to make the disk the parent of the rpmb device and then
>> use the disk to get a reference to md.
> 
> That sounds like it can be done relatively easily. Sounds like it should be a
> separate patch though, let me iterate this one first so we plug the biggest
> holes and then I try to come up with something for that too.

OK.  What about the "capable(CAP_SYS_RAWIO)" question?
