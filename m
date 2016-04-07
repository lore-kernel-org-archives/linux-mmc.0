From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Use the mmc host device index as the mmcblk
 device index
Date: Thu, 7 Apr 2016 15:07:29 +0200
Message-ID: <CAPDyKFpCAjizLOUABuo06_P0PEDTmOARmgwwLShb16PByYDcrg@mail.gmail.com>
References: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
	<57064D96.1050402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35815 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969AbcDGNHb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2016 09:07:31 -0400
Received: by mail-wm0-f41.google.com with SMTP id 191so91109207wmq.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2016 06:07:30 -0700 (PDT)
In-Reply-To: <57064D96.1050402@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, Peter Hurley <peter@hurleysoftware.com>, Laszlo Fiat <laszlo.fiat@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "# 4.0+" <stable@vger.kernel.org>

On 7 April 2016 at 14:07, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 04/07/2016 04:57 PM, Ulf Hansson wrote:
>> Commit 520bd7a8b415 ("mmc: core: Optimize boot time by detecting cards
>> simultaneously") causes regressions for some platforms.
>>
>> These platforms relies on fixed mmcblk device indexes, instead of
>> deploying the defacto standard with UUID/PARTUUID. In other words their
>> rootfs needs to be available at hardcoded paths, like /dev/mmcblk0p2.
>>
>> Such guarantees have never been made by the kernel, but clearly the above
>> commit changes the behaviour. More precisely, because of that the order
>> changes of how cards becomes detected, so do their corresponding mmcblk
>> device indexes.
>>
>> As the above commit significantly improves boot time for some platforms
>> (magnitude of seconds), let's avoid reverting this change but instead
>> restore the behaviour of how mmcblk device indexes becomes picked.
>>
>> By using the same index for the mmcblk device as for the corresponding mmc
>> host device, the probe order of mmc host devices decides the index we get
>> for the mmcblk device.
>>
>> For those platforms that suffers from a regression, one could expect that
>> this updated behaviour should be sufficient to meet their expectations of
>> "fixed" mmcblk device indexes.
>>
>> Another side effect from this change, is that the same index is used for
>> the mmc host device, the mmcblk device and the mmc block queue. That
>> should clarify their relationship.
>
> I have tested with this patch..but there also are side-effects.
> Exynos4 series has the two host controller..one is sdhci, one is dwmmc for eMMC.
> In this case, dwmmc controller is probed after sdhci controller.
>
> Then eMMC is always assigned to mmcblk1.

Okay, let me follow up with some questions.

1)
What is the sdhci controller used for?

2)
Are you seeing regressions for Exynos for this? I was under the
assumption that your vendor trees contained patches to deal with fixed
mmcblk ids?

3)
You proposed [1] recently to use aliases in DT to support fixed mmcblk
ids. I do realize that as UUID/PARTUUID sometimes can be a bit
cumbersome to use for an embedded system. Using aliases via DT seems
like a very good option. To implement that on top of $subject patch
should be quite easy to fix (I am happy to help with it). Would that
address your concerns?

>
> I think it's not good that make another problem for solving something.
> It needs more discussion for this..

Thanks for testing and your comments!

Kind regards
Uffe

[1]
http://www.spinics.net/lists/linux-mmc/msg35980.html
