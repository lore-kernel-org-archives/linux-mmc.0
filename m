From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Thu, 25 Aug 2016 09:41:32 -0700
Message-ID: <de010fff-1f22-96bb-f41f-99169fb6bb19@gmail.com>
References: <20160808015803.2528-1-jaedon.shin@gmail.com>
 <8f42998e-6d5b-2ac7-3814-f7a4d6e8a6b9@intel.com>
 <CAOGqxeX8kcD9rX4nd+o=RTggEoPLZfK40GdBWKTT6-BTpxSvbg@mail.gmail.com>
 <AD331215-7115-426D-A089-263D6A0E54BF@gmail.com>
 <CAPDyKFqkoF2GU6QGc7GW1S2p8+A=XpU48sREcLiSkadPKHuibw@mail.gmail.com>
 <5A6224B1-2845-4059-A537-EBEA7E6F09E6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34508 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760347AbcHYQnG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2016 12:43:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id g202so3507801pfb.1
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2016 09:41:35 -0700 (PDT)
In-Reply-To: <5A6224B1-2845-4059-A537-EBEA7E6F09E6@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org

On 08/19/2016 07:05 AM, Jaedon Shin wrote:
> Hi Ulf,
> 
>> On Aug 19, 2016, at 10:44 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 19 August 2016 at 04:25, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>>> Hi Alan,
>>>
>>> On Aug 18, 2016, at 11:27 PM, Alan Cooper <alcooperx@gmail.com> wrote:
>>>>
>>>> It would be better to make this a MIPS only setting because this issue
>>>> only exists for MIPS chips and some newer ARM chips will support 64
>>>> bit DMA.
>>>> Also, since there's been a general effort to reduce the use QUIRKs,
>>>> you could clear the SDHCI_CAN_64BIT in CAPS1 instead of using the
>>>> QUIRK.
>>>>
>>>> @@ -101,6 +101,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>>>>       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>>>       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>>>>                       SDHCI_SUPPORT_DDR50);
>>>> +#if defined(CONFIG_MIPS)
>>>> +       host->caps1 &= ~SDHCI_CAN_64BIT;
>>>> +#endif
>>>>       host->quirks |= SDHCI_QUIRK_MISSING_CAPS |
>>>>               SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>>
>>> It's better to me, but we should use host->cap instead of host->cap1. I will update
>>> patch with your comment.
>>
>> Please, then also send this to the public linux-mmc list.
>>
>> Kind regards
>> Uffe
>>
> 
> I'm sorry I could not add the public linux-mmc list this mail thread, but 
> I have already sent the updated patch with linux-mmc.
> 
> https://patchwork.kernel.org/patch/9289189/

Humm, is not this one of these cases where we would expect the
compatible string to dictacte whether enabling 64_BIT_DMA makes sense or
not?

The patch is technically correct though.
-- 
Florian
