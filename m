From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] mmc: block: Fix bug when removing RPMB chardev
Date: Thu, 5 Oct 2017 12:48:12 +0200
Message-ID: <CACRpkdbNtsNkrLUaAywWG3raBdJhb4RMT-MAWW-XuAk7smC+TQ@mail.gmail.com>
References: <20171003135123.4934-1-linus.walleij@linaro.org>
 <c5f4052a-7c44-00a7-588b-a226a00a918e@intel.com> <CACRpkdYE9S+RML6Y_MU0LO0oWFJYsu2qfrxbuqhVQb=ktuTUNA@mail.gmail.com>
 <fcf32b47-40bf-7b52-aa5b-6b8e517fa10e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:50718 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJEKsN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Oct 2017 06:48:13 -0400
Received: by mail-io0-f180.google.com with SMTP id 97so689306iok.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Oct 2017 03:48:13 -0700 (PDT)
In-Reply-To: <fcf32b47-40bf-7b52-aa5b-6b8e517fa10e@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Oct 4, 2017 at 1:58 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 04/10/17 12:09, Linus Walleij wrote:

>>> But how do you know md still exists?
>>
>> I was thinking that the reference counting is exactly for making sure
>> it exists across open()/close()?
>
> Previously the device being opened was the block device which had to exist.
>
> But I think it is OK to assume md exists in mmc_rpmb_chrdev_open() because
> rpmb->chrdev is removed before the main disk.

That's my thought too. But thinking it over there could be a race if e.g.
you write a script with a loop hammering the device in/out with bind/unbind
at the same time opening and closing the RPMB chardev and holding
a handle to it.

It is not a very realistic usecase but I will try to provoke it anyways.

> OK.  What about the "capable(CAP_SYS_RAWIO)" question?

The flag has a very strange definition in
include/uapi/linux/capability.h:

/* Allow sending USB messages to any device via /dev/bus/usb */
#define CAP_SYS_RAWIO        17

So I read in the codebase how this flag is actuallt used. It seems to
universally apply for cases where userspace is allowed to read or
write directly into device registers.

So I dropped that since the character device is only able to do ioctl()s,
no raw I/O. RPMB is and always was strictly ioctl-based.
We should simply plug the hole and not letting people shoot themselves
in the foot with this.

I think it is bogus that we have it even for the block device, but it may
be argued that the stuff returned from the ioctl reading card info
is "kind of" RAWIO. I guess that is why it's there. But we are using well
structured ioctls so it is really irrelevant. The flag is not
needed or used for anything (the subsystems using it is checking for
it explicitly, it is not checked in the core fs code or anything), we could
just drop it from the block devices too.

Yours,
Linus Walleij
