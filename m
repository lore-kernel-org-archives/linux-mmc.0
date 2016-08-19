From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Fri, 19 Aug 2016 23:05:29 +0900
Message-ID: <5A6224B1-2845-4059-A537-EBEA7E6F09E6@gmail.com>
References: <20160808015803.2528-1-jaedon.shin@gmail.com> <8f42998e-6d5b-2ac7-3814-f7a4d6e8a6b9@intel.com> <CAOGqxeX8kcD9rX4nd+o=RTggEoPLZfK40GdBWKTT6-BTpxSvbg@mail.gmail.com> <AD331215-7115-426D-A089-263D6A0E54BF@gmail.com> <CAPDyKFqkoF2GU6QGc7GW1S2p8+A=XpU48sREcLiSkadPKHuibw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33736 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbcHSOFe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2016 10:05:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so1546535pfe.0
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2016 07:05:34 -0700 (PDT)
In-Reply-To: <CAPDyKFqkoF2GU6QGc7GW1S2p8+A=XpU48sREcLiSkadPKHuibw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org

Hi Ulf,

> On Aug 19, 2016, at 10:44 PM, Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
>=20
> On 19 August 2016 at 04:25, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> Hi Alan,
>>=20
>> On Aug 18, 2016, at 11:27 PM, Alan Cooper <alcooperx@gmail.com> =
wrote:
>>>=20
>>> It would be better to make this a MIPS only setting because this =
issue
>>> only exists for MIPS chips and some newer ARM chips will support 64
>>> bit DMA.
>>> Also, since there's been a general effort to reduce the use QUIRKs,
>>> you could clear the SDHCI_CAN_64BIT in CAPS1 instead of using the
>>> QUIRK.
>>>=20
>>> @@ -101,6 +101,9 @@ static int sdhci_brcmstb_probe(struct =
platform_device *pdev)
>>>       host->caps1 =3D sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>>       host->caps1 &=3D ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 =
|
>>>                       SDHCI_SUPPORT_DDR50);
>>> +#if defined(CONFIG_MIPS)
>>> +       host->caps1 &=3D ~SDHCI_CAN_64BIT;
>>> +#endif
>>>       host->quirks |=3D SDHCI_QUIRK_MISSING_CAPS |
>>>               SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>=20
>> It's better to me, but we should use host->cap instead of host->cap1. =
I will update
>> patch with your comment.
>=20
> Please, then also send this to the public linux-mmc list.
>=20
> Kind regards
> Uffe
>=20

I'm sorry I could not add the public linux-mmc list this mail thread, =
but=20
I have already sent the updated patch with linux-mmc.

https://patchwork.kernel.org/patch/9289189/

Thanks,
Jaedon

>>=20
>> Thanks,
>> Jaedon
>>=20
>>>=20
>>>=20
>>> Al
>>>=20
>>> On Thu, Aug 18, 2016 at 4:24 AM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>>>> On 08/08/16 04:58, Jaedon Shin wrote:
>>>>> Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk for Broadcom BRCMSTB =
SoCs. The
>>>>> Broadcom ARM and MIPS based BRCMSTB SDHCI host controllers are =
using
>>>>> ADMA, but the several chipsets have a incorrect capability about =
ADMA
>>>>> 64-bit.
>>>>>=20
>>>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>>>=20
>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>=20
>>>>> ---
>>>>> drivers/mmc/host/sdhci-brcmstb.c | 1 +
>>>>> 1 file changed, 1 insertion(+)
>>>>>=20
>>>>> diff --git a/drivers/mmc/host/sdhci-brcmstb.c =
b/drivers/mmc/host/sdhci-brcmstb.c
>>>>> index cce10fe3e19e..704267000ef0 100644
>>>>> --- a/drivers/mmc/host/sdhci-brcmstb.c
>>>>> +++ b/drivers/mmc/host/sdhci-brcmstb.c
>>>>> @@ -103,6 +103,7 @@ static int sdhci_brcmstb_probe(struct =
platform_device *pdev)
>>>>>                     SDHCI_SUPPORT_DDR50);
>>>>>     host->quirks |=3D SDHCI_QUIRK_MISSING_CAPS |
>>>>>             SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>>>> +     host->quirks2 |=3D SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
>>>>>=20
>>>>>     res =3D sdhci_add_host(host);
>>>>>     if (res)

