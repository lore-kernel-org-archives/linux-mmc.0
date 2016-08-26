From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Fri, 26 Aug 2016 08:49:34 +0200
Message-ID: <CAPDyKFo6-GZ_myX43orouUvWGA8aAhUD9Jrcpaz+LzApuQJFZA@mail.gmail.com>
References: <20160808015803.2528-1-jaedon.shin@gmail.com> <8f42998e-6d5b-2ac7-3814-f7a4d6e8a6b9@intel.com>
 <CAOGqxeX8kcD9rX4nd+o=RTggEoPLZfK40GdBWKTT6-BTpxSvbg@mail.gmail.com>
 <AD331215-7115-426D-A089-263D6A0E54BF@gmail.com> <CAPDyKFqkoF2GU6QGc7GW1S2p8+A=XpU48sREcLiSkadPKHuibw@mail.gmail.com>
 <5A6224B1-2845-4059-A537-EBEA7E6F09E6@gmail.com> <de010fff-1f22-96bb-f41f-99169fb6bb19@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32796 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbcHZGth (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2016 02:49:37 -0400
Received: by mail-wm0-f45.google.com with SMTP id d196so1470925wmd.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2016 23:49:36 -0700 (PDT)
In-Reply-To: <de010fff-1f22-96bb-f41f-99169fb6bb19@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>
Cc: Alan Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc <linux-mmc@vger.kernel.org>

On 25 August 2016 at 18:41, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 08/19/2016 07:05 AM, Jaedon Shin wrote:
>> Hi Ulf,
>>
>>> On Aug 19, 2016, at 10:44 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> On 19 August 2016 at 04:25, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>>>> Hi Alan,
>>>>
>>>> On Aug 18, 2016, at 11:27 PM, Alan Cooper <alcooperx@gmail.com> wrote:
>>>>>
>>>>> It would be better to make this a MIPS only setting because this issue
>>>>> only exists for MIPS chips and some newer ARM chips will support 64
>>>>> bit DMA.
>>>>> Also, since there's been a general effort to reduce the use QUIRKs,
>>>>> you could clear the SDHCI_CAN_64BIT in CAPS1 instead of using the
>>>>> QUIRK.
>>>>>
>>>>> @@ -101,6 +101,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>>>>>       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>>>>       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>>>>>                       SDHCI_SUPPORT_DDR50);
>>>>> +#if defined(CONFIG_MIPS)
>>>>> +       host->caps1 &= ~SDHCI_CAN_64BIT;
>>>>> +#endif
>>>>>       host->quirks |= SDHCI_QUIRK_MISSING_CAPS |
>>>>>               SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>>>
>>>> It's better to me, but we should use host->cap instead of host->cap1. I will update
>>>> patch with your comment.
>>>
>>> Please, then also send this to the public linux-mmc list.
>>>
>>> Kind regards
>>> Uffe
>>>
>>
>> I'm sorry I could not add the public linux-mmc list this mail thread, but
>> I have already sent the updated patch with linux-mmc.
>>
>> https://patchwork.kernel.org/patch/9289189/
>
> Humm, is not this one of these cases where we would expect the
> compatible string to dictacte whether enabling 64_BIT_DMA makes sense or
> not?

Yes!

Jaedon, can you please send an updated patch. Please also bump the
version number of the patch!

Kind regards
Uffe

>
> The patch is technically correct though.
> --
> Florian
