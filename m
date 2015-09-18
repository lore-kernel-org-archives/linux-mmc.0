From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3] mmc: block: Add new ioctl to send multi commands
Date: Fri, 18 Sep 2015 11:24:05 +0100
Message-ID: <55FBE645.8030001@nvidia.com>
References: <1442242844-6859-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFqg5Ld+9LE5wHTZWy2M6gJSYqJVqBZ5vFjVkjyTRW_q+g@mail.gmail.com>
 <55F99261.60003@nvidia.com>
 <CAPDyKFpPkDYj6-3x0pdKOCZrhr+f4CduX+p9DO=GHuUO9kZBag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19038 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbbIRKYV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Sep 2015 06:24:21 -0400
In-Reply-To: <CAPDyKFpPkDYj6-3x0pdKOCZrhr+f4CduX+p9DO=GHuUO9kZBag@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Seshagiri Holi <sholi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Grundler <grundler@google.com>, Olof Johansson <olofj@chromium.org>


On 17/09/15 07:59, Ulf Hansson wrote:
> [...]
> 
>>>> +       /*
>>>> +        * The caller must have CAP_SYS_RAWIO, and must be calling this on the
>>>> +        * whole block device, not on a partition.  This prevents overspray
>>>> +        * between sibling partitions.
>>>> +        */
>>>> +       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
>>>> +               return -EPERM;
>>>
>>> This check is common for multi and non-multi. Please move it to the
>>> mmc_blk_ioctl() to avoid some code duplication.
>>
>> Yes that's true. I can move but it means also passing bdev to
>> __mmc_blk_ioctl_cmd() as another argument. It is not a big deal, but it
>> was more convenient to test here. If your preference is to consolidate
>> the tests to one place then I will move this test.
> 
> I was suggesting to move it to mmc_blk_ioctl() and not to
> __mmc_blk_ioctl_cmd(). That shouldn't cause any changes to any
> function-definitions, right!?

Sorry, completely mis-read. Yes that makes sense, will update.

Cheers
Jon
