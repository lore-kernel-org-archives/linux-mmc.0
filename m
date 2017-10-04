From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] mmc: block: Fix bug when removing RPMB chardev
Date: Wed, 4 Oct 2017 11:09:15 +0200
Message-ID: <CACRpkdYE9S+RML6Y_MU0LO0oWFJYsu2qfrxbuqhVQb=ktuTUNA@mail.gmail.com>
References: <20171003135123.4934-1-linus.walleij@linaro.org> <c5f4052a-7c44-00a7-588b-a226a00a918e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:48402 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbdJDJJQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2017 05:09:16 -0400
Received: by mail-it0-f42.google.com with SMTP id m123so15379219ita.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Oct 2017 02:09:16 -0700 (PDT)
In-Reply-To: <c5f4052a-7c44-00a7-588b-a226a00a918e@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Oct 4, 2017 at 9:39 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

>> @@ -2299,7 +2299,7 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
>>       get_device(&rpmb->dev);
>>       filp->private_data = rpmb;
>>       mutex_lock(&open_lock);
>> -     rpmb->md->usage++;
>> +     mmc_blk_get(rpmb->md->disk);
>
> mmc_blk_get() also tries to mutex_lock(&open_lock)

Yeah :/ I fix.
Sorry for this flunky (too)...

> But how do you know md still exists?

I was thinking that the reference counting is exactly for making sure
it exists across open()/close()?

>  Looks like you need
> to make the disk the parent of the rpmb device and then
> use the disk to get a reference to md.

That sounds like it can be done relatively easily. Sounds like it should be a
separate patch though, let me iterate this one first so we plug the biggest
holes and then I try to come up with something for that too.

Yours,
Linus Walleij
