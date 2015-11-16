From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH V2 1/3] mmc: sdhci-pltfm: Add DT properties to set various QUIRKS
Date: Mon, 16 Nov 2015 18:43:53 -0500
Message-ID: <CAOGqxeXQH1UcZqu5PiC3Sr7BUOHcLodR8Od5JoSrvzBALsp7Qg@mail.gmail.com>
References: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
	<1446836164-16259-2-git-send-email-alcooperx@gmail.com>
	<CAPDyKFoFgohMb2dqGQQM_pRFH96EP58ff=N69=oRYEzoj71r0g@mail.gmail.com>
	<CAOGqxeU73rkktbooAQeKXG6XZcOR3RqYG_gjr1PuE5E6k6bVNw@mail.gmail.com>
	<CAPDyKFo2CLA3LpiNDqHK1WOajjCXoBWVRzTkYCYwJh9z2gcx-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34820 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbKPXny (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Nov 2015 18:43:54 -0500
Received: by qgec40 with SMTP id c40so61633656qge.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2015 15:43:54 -0800 (PST)
In-Reply-To: <CAPDyKFo2CLA3LpiNDqHK1WOajjCXoBWVRzTkYCYwJh9z2gcx-Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On Fri, Nov 13, 2015 at 4:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 November 2015 at 20:44, Alan Cooper <alcooperx@gmail.com> wrote:
>> On Thu, Nov 12, 2015 at 4:35 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 6 November 2015 at 19:56, Al Cooper <alcooperx@gmail.com> wrote:
>>>> Add support for "broken-ddr50", "broken-64-bit-dma"
>>>> and "broken-timeout-value" device tree properties.
>>>> The properties will cause the corresponding quirks bits to be set.
>>>> This allows some of the platform specific QUIRKS setting to be
>>>> moved out of the driver and into the Device Tree node.
>>>>
>>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-pltfm.c | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>>>> index 87fb5ea..cc0730c 100644
>>>> --- a/drivers/mmc/host/sdhci-pltfm.c
>>>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>>>> @@ -90,10 +90,14 @@ void sdhci_get_of_property(struct platform_device *pdev)
>>>>         if (of_get_property(np, "no-1-8-v", NULL))
>>>>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>>>
>>>> +       if (of_get_property(np, "broken-64-bit-dma", NULL))
>>>> +               host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
>>>> +
>>>
>>> To me this is yet another step in the wrong direction of sdhci.
>>>
>>> Not only have we added a quirk which we likely could avoided, but now
>>> you also suggest to add a DT binding for it.
>>>
>>> Please try to avoid this, we shouldn't need to add one DT binding per
>>> quirk, right?
>>
>> The BRCMSTB SDHCI driver needs to support a mix of existing and future
>> ARM and MIPS SoC's on a variety of boards, and many of the
>> combinations have issues. In older separate MIPS/ARM internal versions
>> of the driver, issues were handled by a combination of QUIRKS and the
>> use of custom SDHCI registers that allowed the Host CAPS registers to
>> be changed on a per chip basis. While working on a unified driver for
>> 4.1, I realized that almost all the issues solved by overriding the
>> CAPs registers could also be done using an existing QUIRK and if I had
>> device tree properties that set the QUIRKs, that all the chip/board
>> specific knowledge would end up in the device tree node instead of in
>> the driver. This also allowed me to stop using the non-standard CAPS
>> override registers that tended to change per chip. This approach also
>> allows the driver to work, without change, on future chips/boards as
>> long as they don't have any new issues and they have the proper device
>> tree node.
>>
>> Would there be any objection to me continuing this approach if I moved
>> all the functionality into the sdhci-brcm.c driver and left sdhci.c
>> and sdhci-pltfm.c untouched?
>
> Let me elaborate a bit on what I think you/we need to do.
>
> The problem with the quirks is that these exists because of how the
> sdhci code is designed.
>
> Sdhci core should have been implemented as a pure library providing a
> set of common functions. Today it's more of a driver than a library.
> All, or at least most of the variant specific code, should have been
> dealt from each of the sdhci variant drivers, instead of via quirks
> and sdhci callbacks.
>
> If you didn't notice my recent statement regarding the above on
> linux-mmc, let's me say it again. I have a reached a point where I
> think sdhci has become unmaintainable (and non-optimized coding wise)
> and I am therefore encouraging people to stop adding new quirks or
> sdhci callbacks, but instead "libraryfy" sdhci. I would really
> appreciate if you could help moving sdhci in that direction!
>
> That said, you won't be able to leave the sdhci core code untouched,
> because that would in principle mean that you will need to duplicate
> much of the sdhci code into your sdhci-brcm driver. Instead, try to
> split-up/re-factor common sdhci code into library functions, which
> your sdhci-brcm driver can use.
>
> I guess one of the hardest part in this effort will be to not break
> existing sdhci variant drivers. Let's do our best in that effort, but
> we will rely on more people to participate in testing/coding.
>
>>
>>>
>>>>         if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
>>>>                 host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>>>>
>>>> -       if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
>>>> +       if (of_get_property(np, "broken-timeout-value", NULL) ||
>>>> +           of_device_is_compatible(np, "fsl,p2020-esdhc") ||
>>>>             of_device_is_compatible(np, "fsl,p1010-esdhc") ||
>>>>             of_device_is_compatible(np, "fsl,t4240-esdhc") ||
>>>>             of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>>>> @@ -106,6 +110,8 @@ void sdhci_get_of_property(struct platform_device *pdev)
>>>>
>>>>         if (of_find_property(np, "enable-sdio-wakeup", NULL))
>>>>                 host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>>>> +       if (of_find_property(np, "broken-ddr50", NULL))
>>>> +               host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
>>>
>>> Same comment as above.
>>>
>>> Let me also refer to the response from Scott Branden to the earlier
>>> version of this patchset.
>>> http://permalink.gmane.org/gmane.linux.kernel.mmc/34614
>>>
>>> Perhaps we should invent a sdhci library function, which each sdhci
>>> variant can use to set capabilities through. Typically useful for
>>> those variants that have a non-reliable capabilities register.
>>>
>>
>> Do you mean something more than using SDHCI_QUIRK_MISSING_CAPS which
>> allows the driver to supply the 2 CAPS registers instead of having
>> sdhci.c get them by reading the Host CAPS registers?
>
> Yes, something like that, but preferably without needing to use *any* quirk.
>
> From an sdhci core perspective there could be a library function which
> parses the Host CAPS register. Some sdhci variants could use that
> function and some couldn't since the informations in the CAPS register
> isn't reliable.

As a possible first step, what about the following:
Change sdhci_add_host() to take an additional parameter that, if not
NULL, is a pointer to a data structure that contains overrides for
CAPS and CAPS1 in the form of a mask/value pair. These pairs would be
used by sdhci_add_host() to modify any field after reading the CAPS
and CAPS1 registers. With this in place it looks like the following
QUIRKS would no longer be needed because they could be handled in the
variant drivers using overrides:
SDHCI_QUIRK_FORCE_DMA
SDHCI_QUIRK_BROKEN_DMA
SDHCI_QUIRK_BROKEN_ADMA
SDHCI_QUIRK_FORCE_BLK_SZ_2048
SDHCI_QUIRK_MISSING_CAPS
SDHCI_QUIRK2_NO_1_8_V
SDHCI_QUIRK2_BROKEN_DDR50
SDHCI_QUIRK2_BROKEN_64_BIT_DMA

I would add device tree properties for the overrides to my variant
driver. I could also add the overrides as module params. There are
also many drivers that hook the sdhci_readl() routine to modify the
CAPS fields that could be changed to use the overrides.

With this change, my variant driver that supports more than 10
different MIPS/ARM SoC's would be very small with all the SoC
differences handled using overrides in the device tree and without the
use of any QUIRKS.

>
>>
>>>>  }
>>>>  #else
>>>>  void sdhci_get_of_property(struct platform_device *pdev) {}
>>>> --
>>>> 1.9.0.138.g2de3478
>>>>
>>>
>>> Kind regards
>>> Uffe
>>
>> Thanks
>> Al
>
> Kind regards
> Uffe

Thanks
Al
