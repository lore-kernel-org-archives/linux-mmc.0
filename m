From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Sun, 28 Aug 2016 19:53:51 +0900
Message-ID: <B964A840-3F8D-4B4D-A7C4-8AA76EF35E59@gmail.com>
References: <20160808015803.2528-1-jaedon.shin@gmail.com> <8f42998e-6d5b-2ac7-3814-f7a4d6e8a6b9@intel.com> <CAOGqxeX8kcD9rX4nd+o=RTggEoPLZfK40GdBWKTT6-BTpxSvbg@mail.gmail.com> <AD331215-7115-426D-A089-263D6A0E54BF@gmail.com> <CAPDyKFqkoF2GU6QGc7GW1S2p8+A=XpU48sREcLiSkadPKHuibw@mail.gmail.com> <5A6224B1-2845-4059-A537-EBEA7E6F09E6@gmail.com> <de010fff-1f22-96bb-f41f-99169fb6bb19@gmail.com> <501206D1-D60B-4BA7-99C0-C38065C3AE9E@gmail.com> <7edcef69-d364-8845-a677-3827a50f4da1@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33689 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755273AbcH1Kx6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Aug 2016 06:53:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id i6so7545618pfe.0
        for <linux-mmc@vger.kernel.org>; Sun, 28 Aug 2016 03:53:57 -0700 (PDT)
In-Reply-To: <7edcef69-d364-8845-a677-3827a50f4da1@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alan Cooper <alcooperx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org

On Aug 28, 2016, at 4:56 AM, Florian Fainelli <f.fainelli@gmail.com> =
wrote:
>=20
> Le 26/08/2016 =C3=A0 21:02, Jaedon Shin a =C3=A9crit :
>> Hi Florian,
>>=20
>> On Aug 26, 2016, at 1:41 AM, Florian Fainelli <f.fainelli@gmail.com> =
wrote:
>>>=20
>>> On 08/19/2016 07:05 AM, Jaedon Shin wrote:
>>>> Hi Ulf,
>>>>=20
>>>>> On Aug 19, 2016, at 10:44 PM, Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
>>>>>=20
>>>>> On 19 August 2016 at 04:25, Jaedon Shin <jaedon.shin@gmail.com> =
wrote:
>>>>>> Hi Alan,
>>>>>>=20
>>>>>> On Aug 18, 2016, at 11:27 PM, Alan Cooper <alcooperx@gmail.com> =
wrote:
>>>>>>>=20
>>>>>>> It would be better to make this a MIPS only setting because this =
issue
>>>>>>> only exists for MIPS chips and some newer ARM chips will support =
64
>>>>>>> bit DMA.
>>>>>>> Also, since there's been a general effort to reduce the use =
QUIRKs,
>>>>>>> you could clear the SDHCI_CAN_64BIT in CAPS1 instead of using =
the
>>>>>>> QUIRK.
>>>>>>>=20
>>>>>>> @@ -101,6 +101,9 @@ static int sdhci_brcmstb_probe(struct =
platform_device *pdev)
>>>>>>>     host->caps1 =3D sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>>>>>>     host->caps1 &=3D ~(SDHCI_SUPPORT_SDR50 | =
SDHCI_SUPPORT_SDR104 |
>>>>>>>                     SDHCI_SUPPORT_DDR50);
>>>>>>> +#if defined(CONFIG_MIPS)
>>>>>>> +       host->caps1 &=3D ~SDHCI_CAN_64BIT;
>>>>>>> +#endif
>>>>>>>     host->quirks |=3D SDHCI_QUIRK_MISSING_CAPS |
>>>>>>>             SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>>>>>=20
>>>>>> It's better to me, but we should use host->cap instead of =
host->cap1. I will update
>>>>>> patch with your comment.
>>>>>=20
>>>>> Please, then also send this to the public linux-mmc list.
>>>>>=20
>>>>> Kind regards
>>>>> Uffe
>>>>>=20
>>>>=20
>>>> I'm sorry I could not add the public linux-mmc list this mail =
thread, but=20
>>>> I have already sent the updated patch with linux-mmc.
>>>>=20
>>>> https://patchwork.kernel.org/patch/9289189/
>>>=20
>>> Humm, is not this one of these cases where we would expect the
>>> compatible string to dictacte whether enabling 64_BIT_DMA makes =
sense or
>>> not?
>>>=20
>>> The patch is technically correct though.
>=20
> Hi Jaedon,
>=20
>>=20
>> Yes, It's right way that uses host->cap according to the previous =
discussion
>> for this driver and commit 5eaa7476f937 ("mmc: sdhci: Allow CAPS =
check for=20
>> SDHCI_CAN_64BIT to use overridden caps").
>>=20
>> If the 64bit ARM chipsets have own compatible string, the patch like =
as below
>>=20
>> 	if (of_device_is_compatible(pdev->dev.of_node, =
"brcm,bcm7425-sdhci"))
>> 		host->caps &=3D ~SDHCI_CAN_64BIT;
>>=20
>> Could you tell me the some newer 64bit ARM chipsets have possible own =
compatible
>> string?
>=20
> All ARM 32-bit brcmstb chips are LPAE capable, which means that the
> SDHCI controller may have to deal with bus addresses larger than
> 32-bits, so we always need SDHCI_CAN_64BIT to be set for that to =
happen
> and work correctly.
>=20
> On ARM 64-bit brcmstb chips, we may not have enough memory such that =
the
> SDHCI controller needs to deal with > 32-bits bus addresses, but same
> thing, this may happen and the controller is fully capable of, so we
> also need SDHCI_CAN_64BIT.
>=20
> In both cases, the controller should be fully operational with > =
32-bits
> physical addresses.
>=20
> On BMIPS chips, we should probably clear SDHCI_CAN_64BIT because =
AFAIR,
> it really is broken (Al, can you confirm?), but at the same time, the
> DMA-API should never hand us buffers which exceed the 32-bits bus
> address boundary because of the processor and chip memory map
> limitations anyway, is that what you encountered though?
>=20
> At the moment, brcm,bcm7425-sdhci is used across all 3 types of SoCs
> (BMIPS, ARM and ARM64) while we should probably allocate a new one for
> ARM and newer and then we could reliably base the clearing of
> SDHCI_CAN_64BIT based on brcm,bcm7425-sdhci.
>=20
> Finally, Arnd's suggestions of using "dma-ranges" is fine, but I do =
not
> think we quite need this here because we really need to advertise the
> right set of capabilities based on the generation/version of the
> controller deployed in specific chips.
>=20
> I would like to have Al's feedback on this, since he wrote the driver =
;)
>=20
> Thanks!
> --=20
> Florian

Thanks for your detailed replay, and I understand why it must use a =
compatible
string for all brcmstb chips. I'm sending the bumped patch for BMIPS =
quickly.

Thanks,
Jaedon=
