From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Use the mmc host device index as the mmcblk
 device index
Date: Thu, 14 Apr 2016 09:26:39 +0200
Message-ID: <CAPDyKFq84iLYyMR=ruLOTgbm35hX=WY+UUCqPbfeFS6ALQPvYA@mail.gmail.com>
References: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
	<57064D96.1050402@samsung.com>
	<CAPDyKFpCAjizLOUABuo06_P0PEDTmOARmgwwLShb16PByYDcrg@mail.gmail.com>
	<570EF189.7030305@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <570EF189.7030305@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, Peter Hurley <peter@hurleysoftware.com>, Laszlo Fiat <laszlo.fiat@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 April 2016 at 03:25, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Ulf,
>
> Sorry for replying late.
>
> On 04/07/2016 10:07 PM, Ulf Hansson wrote:
>> On 7 April 2016 at 14:07, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> On 04/07/2016 04:57 PM, Ulf Hansson wrote:
>>>> Commit 520bd7a8b415 ("mmc: core: Optimize boot time by detecting cards
>>>> simultaneously") causes regressions for some platforms.
>>>>
>>>> These platforms relies on fixed mmcblk device indexes, instead of
>>>> deploying the defacto standard with UUID/PARTUUID. In other words their
>>>> rootfs needs to be available at hardcoded paths, like /dev/mmcblk0p2.
>>>>
>>>> Such guarantees have never been made by the kernel, but clearly the above
>>>> commit changes the behaviour. More precisely, because of that the order
>>>> changes of how cards becomes detected, so do their corresponding mmcblk
>>>> device indexes.
>>>>
>>>> As the above commit significantly improves boot time for some platforms
>>>> (magnitude of seconds), let's avoid reverting this change but instead
>>>> restore the behaviour of how mmcblk device indexes becomes picked.
>>>>
>>>> By using the same index for the mmcblk device as for the corresponding mmc
>>>> host device, the probe order of mmc host devices decides the index we get
>>>> for the mmcblk device.
>>>>
>>>> For those platforms that suffers from a regression, one could expect that
>>>> this updated behaviour should be sufficient to meet their expectations of
>>>> "fixed" mmcblk device indexes.
>>>>
>>>> Another side effect from this change, is that the same index is used for
>>>> the mmc host device, the mmcblk device and the mmc block queue. That
>>>> should clarify their relationship.
>>>
>>> I have tested with this patch..but there also are side-effects.
>>> Exynos4 series has the two host controller..one is sdhci, one is dwmmc for eMMC.
>>> In this case, dwmmc controller is probed after sdhci controller.
>>>
>>> Then eMMC is always assigned to mmcblk1.
>>
>> Okay, let me follow up with some questions.
>>
>> 1)
>> What is the sdhci controller used for?
>
> Some of Exynos4 series have two MMC host controller.
> As i mentioned, one is sdhci, other is dwmmc.
>
> sdhci controller can be used for eMMC/SD/SDIO. (emmc, T-flash, WiFi)

I see. So it seems the SDHCI controller can have SD cards (then
assuming those can be removable).

Prior commit 520bd7a8b415 ("mmc: core: Optimize boot time by detecting
cards simultaneously"), the picked mmcblk device index that
corresponded to the dwmmc controller, depended on whether the SD card
was inserted at boot or not.

My point is then, that fixed paths to the rootfs would work only for
one of the two scenarios; 1) The SD card is inserted at boot. 2) The
SD card isn't inserted at boot.

> And dwmmc controller can be only used for eMMC.
>
> It can choose which controller user uses.
> In normal, i recommend the dwmmc controller is used for eMMC.
> (There are some reason..I/O performance, and functionality.)
>
>>
>> 2)
>> Are you seeing regressions for Exynos for this? I was under the
>> assumption that your vendor trees contained patches to deal with fixed
>> mmcblk ids?
>
> Actually not...but i need to check more..in vendor tress.

Okay, thanks!

>
>>
>> 3)
>> You proposed [1] recently to use aliases in DT to support fixed mmcblk
>> ids. I do realize that as UUID/PARTUUID sometimes can be a bit
>> cumbersome to use for an embedded system. Using aliases via DT seems
>> like a very good option. To implement that on top of $subject patch
>> should be quite easy to fix (I am happy to help with it). Would that
>> address your concerns?
>
> I saw this patch was applied in your repository..So i will test with your tree.
> In normal case, i think it's not problem...but i remembered there is a rare case about removable case.
> I will try to test with all cases..:)

Okay, thanks for all you help!

[...]

Kind regards
Uffe
