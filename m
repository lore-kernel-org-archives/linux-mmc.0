From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Sat, 27 Aug 2016 12:56:10 -0700
Message-ID: <7edcef69-d364-8845-a677-3827a50f4da1@gmail.com>
References: <20160808015803.2528-1-jaedon.shin@gmail.com>
 <8f42998e-6d5b-2ac7-3814-f7a4d6e8a6b9@intel.com>
 <CAOGqxeX8kcD9rX4nd+o=RTggEoPLZfK40GdBWKTT6-BTpxSvbg@mail.gmail.com>
 <AD331215-7115-426D-A089-263D6A0E54BF@gmail.com>
 <CAPDyKFqkoF2GU6QGc7GW1S2p8+A=XpU48sREcLiSkadPKHuibw@mail.gmail.com>
 <5A6224B1-2845-4059-A537-EBEA7E6F09E6@gmail.com>
 <de010fff-1f22-96bb-f41f-99169fb6bb19@gmail.com>
 <501206D1-D60B-4BA7-99C0-C38065C3AE9E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33991 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755130AbcH0T4N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Aug 2016 15:56:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id t127so9419385oie.1
        for <linux-mmc@vger.kernel.org>; Sat, 27 Aug 2016 12:56:12 -0700 (PDT)
In-Reply-To: <501206D1-D60B-4BA7-99C0-C38065C3AE9E@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Alan Cooper <alcooperx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org

Le 26/08/2016 à 21:02, Jaedon Shin a écrit :
> Hi Florian,
> 
> On Aug 26, 2016, at 1:41 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 08/19/2016 07:05 AM, Jaedon Shin wrote:
>>> Hi Ulf,
>>>
>>>> On Aug 19, 2016, at 10:44 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>
>>>> On 19 August 2016 at 04:25, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>>>>> Hi Alan,
>>>>>
>>>>> On Aug 18, 2016, at 11:27 PM, Alan Cooper <alcooperx@gmail.com> wrote:
>>>>>>
>>>>>> It would be better to make this a MIPS only setting because this issue
>>>>>> only exists for MIPS chips and some newer ARM chips will support 64
>>>>>> bit DMA.
>>>>>> Also, since there's been a general effort to reduce the use QUIRKs,
>>>>>> you could clear the SDHCI_CAN_64BIT in CAPS1 instead of using the
>>>>>> QUIRK.
>>>>>>
>>>>>> @@ -101,6 +101,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>>>>>>      host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>>>>>      host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>>>>>>                      SDHCI_SUPPORT_DDR50);
>>>>>> +#if defined(CONFIG_MIPS)
>>>>>> +       host->caps1 &= ~SDHCI_CAN_64BIT;
>>>>>> +#endif
>>>>>>      host->quirks |= SDHCI_QUIRK_MISSING_CAPS |
>>>>>>              SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>>>>
>>>>> It's better to me, but we should use host->cap instead of host->cap1. I will update
>>>>> patch with your comment.
>>>>
>>>> Please, then also send this to the public linux-mmc list.
>>>>
>>>> Kind regards
>>>> Uffe
>>>>
>>>
>>> I'm sorry I could not add the public linux-mmc list this mail thread, but 
>>> I have already sent the updated patch with linux-mmc.
>>>
>>> https://patchwork.kernel.org/patch/9289189/
>>
>> Humm, is not this one of these cases where we would expect the
>> compatible string to dictacte whether enabling 64_BIT_DMA makes sense or
>> not?
>>
>> The patch is technically correct though.

Hi Jaedon,

> 
> Yes, It's right way that uses host->cap according to the previous discussion
> for this driver and commit 5eaa7476f937 ("mmc: sdhci: Allow CAPS check for 
> SDHCI_CAN_64BIT to use overridden caps").
> 
> If the 64bit ARM chipsets have own compatible string, the patch like as below
> 
> 	if (of_device_is_compatible(pdev->dev.of_node, "brcm,bcm7425-sdhci"))
> 		host->caps &= ~SDHCI_CAN_64BIT;
> 
> Could you tell me the some newer 64bit ARM chipsets have possible own compatible
> string?

All ARM 32-bit brcmstb chips are LPAE capable, which means that the
SDHCI controller may have to deal with bus addresses larger than
32-bits, so we always need SDHCI_CAN_64BIT to be set for that to happen
and work correctly.

On ARM 64-bit brcmstb chips, we may not have enough memory such that the
SDHCI controller needs to deal with > 32-bits bus addresses, but same
thing, this may happen and the controller is fully capable of, so we
also need SDHCI_CAN_64BIT.

In both cases, the controller should be fully operational with > 32-bits
physical addresses.

On BMIPS chips, we should probably clear SDHCI_CAN_64BIT because AFAIR,
it really is broken (Al, can you confirm?), but at the same time, the
DMA-API should never hand us buffers which exceed the 32-bits bus
address boundary because of the processor and chip memory map
limitations anyway, is that what you encountered though?

At the moment, brcm,bcm7425-sdhci is used across all 3 types of SoCs
(BMIPS, ARM and ARM64) while we should probably allocate a new one for
ARM and newer and then we could reliably base the clearing of
SDHCI_CAN_64BIT based on brcm,bcm7425-sdhci.

Finally, Arnd's suggestions of using "dma-ranges" is fine, but I do not
think we quite need this here because we really need to advertise the
right set of capabilities based on the generation/version of the
controller deployed in specific chips.

I would like to have Al's feedback on this, since he wrote the driver ;)

Thanks!
-- 
Florian

