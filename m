From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3] mmc: block: Add new ioctl to send multi commands
Date: Thu, 17 Sep 2015 08:59:40 +0200
Message-ID: <CAPDyKFpPkDYj6-3x0pdKOCZrhr+f4CduX+p9DO=GHuUO9kZBag@mail.gmail.com>
References: <1442242844-6859-1-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFqg5Ld+9LE5wHTZWy2M6gJSYqJVqBZ5vFjVkjyTRW_q+g@mail.gmail.com>
	<55F99261.60003@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34416 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbbIQG7l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2015 02:59:41 -0400
Received: by wicfx3 with SMTP id fx3so10232852wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2015 23:59:40 -0700 (PDT)
In-Reply-To: <55F99261.60003@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Seshagiri Holi <sholi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Grundler <grundler@google.com>, Olof Johansson <olofj@chromium.org>

[...]

>>> +       /*
>>> +        * The caller must have CAP_SYS_RAWIO, and must be calling this on the
>>> +        * whole block device, not on a partition.  This prevents overspray
>>> +        * between sibling partitions.
>>> +        */
>>> +       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
>>> +               return -EPERM;
>>
>> This check is common for multi and non-multi. Please move it to the
>> mmc_blk_ioctl() to avoid some code duplication.
>
> Yes that's true. I can move but it means also passing bdev to
> __mmc_blk_ioctl_cmd() as another argument. It is not a big deal, but it
> was more convenient to test here. If your preference is to consolidate
> the tests to one place then I will move this test.

I was suggesting to move it to mmc_blk_ioctl() and not to
__mmc_blk_ioctl_cmd(). That shouldn't cause any changes to any
function-definitions, right!?

Kind regards
Uffe
