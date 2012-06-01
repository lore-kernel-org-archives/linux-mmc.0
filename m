From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH 3/3] mmc: do not attempt UHS 1.8v support if board does
 not support it
Date: Fri, 1 Jun 2012 19:30:36 -0400
Message-ID: <CACwGpOAnqGkNTCBHMMX3yrO_5Vy53q_fBCaL4QsG_vQz6ttktw@mail.gmail.com>
References: <prakity@marvell.com>
	<1338168970-2052-1-git-send-email-prakity@marvell.com>
	<CAOGqxeXt5CSnWoq5F++F=2++bXys9uRvLuL0doOm6e+JLYxgFA@mail.gmail.com>
	<7A2ECBD8-D81C-497B-B641-1803BC5F928D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48074 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759554Ab2FAXah convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jun 2012 19:30:37 -0400
Received: by wibhn6 with SMTP id hn6so1107110wib.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Jun 2012 16:30:36 -0700 (PDT)
In-Reply-To: <7A2ECBD8-D81C-497B-B641-1803BC5F928D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Alan Cooper <alcooperx@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Philip,

 I don't think you should add yet another quirk for this. You should
plumb in a method to mask the capability registers to enable or
disable features you don't want. This would probably fix problems for
a lot of controller and board configurations.

-- Mark

On Fri, Jun 1, 2012 at 11:26 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> Alan,
>
> I have your patch in my mmc-next. =A0Our controller indicates it SUPP=
ORTS UHS modes.
> The regulators do NOT. =A0Cannot switch to 1.8v.
>
> Not the same problem as you saw.
>
> Philip
>
>
> On Jun 1, 2012, at 6:55 AM, Alan Cooper wrote:
>
>> I recently added a patch that prevents the switch to 1.8v if the hos=
t
>> capabilities register does not indicate support for any of the UHS
>> speeds (SDR50, DDR50, SDR104). This allowed our controller to work
>> with UHS cards in HS mode (50MHz, 3.3v).
>>
>> Al
>>
>> On Sun, May 27, 2012 at 9:36 PM, =A0<philipspatches@gmail.com> wrote=
:
>>> From: Philip Rakity <prakity@marvell.com>
>>>
>>> We have h/w that does not support 1.8v signaling even though the
>>> controller does support this. =A0If we enable 1.8v support UHS
>>> cards are recognised but recovery to 3.3v is not possible
>>> depending on the SD card.
>>>
>>> Ensure that when we do not support 1.8v UHS mode cards can
>>> work (in non UHS mode).
>>>
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> ---
>>> =A0drivers/mmc/host/sdhci.c =A0| =A0 71 +++++++++++++++++++++++----=
-----------------
>>> =A0include/linux/mmc/sdhci.h | =A0 =A03 ++
>>> =A02 files changed, 40 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 8d8dff0..f9b37c4 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2782,27 +2782,45 @@ int sdhci_add_host(struct sdhci_host *host)
>>> =A0 =A0 =A0 =A0 =A0 =A0mmc_card_is_removable(mmc))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>>>
>>> - =A0 =A0 =A0 /* Any UHS-I mode in caps implies SDR12 and SDR25 sup=
port. */
>>> - =A0 =A0 =A0 if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_S=
DR50 |
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_SUPPORT_DDR50))
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR12 | MM=
C_CAP_UHS_SDR25;
>>> + =A0 =A0 =A0 if (!(host->quirks2 & SDHCI_QUIRK2_HOST_NO_UHS_1_8V_S=
UPPORT)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Any UHS-I mode in caps implies SDR=
12 and SDR25 support. */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (caps[1] & (SDHCI_SUPPORT_SDR104 |=
 SDHCI_SUPPORT_SDR50 |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_=
SUPPORT_DDR50))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CA=
P_UHS_SDR12 | MMC_CAP_UHS_SDR25;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SDR104 supports also implies SDR50=
 support */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (caps[1] & SDHCI_SUPPORT_SDR104)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CA=
P_UHS_SDR104 | MMC_CAP_UHS_SDR50;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (caps[1] & SDHCI_SUPPORT_SDR5=
0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CA=
P_UHS_SDR50;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (caps[1] & SDHCI_SUPPORT_DDR50)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CA=
P_UHS_DDR50;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Does the host need tuning for SDR5=
0? */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (caps[1] & SDHCI_USE_SDR50_TUNING)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHC=
I_SDR50_NEEDS_TUNING;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Does the host need tuning for HS20=
0? */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->caps2 & MMC_CAP2_HS200)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHC=
I_HS200_NEEDS_TUNING;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initial value for re-tuning timer =
count */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_count =3D
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (caps[1] & SDHCI_RETU=
NING_TIMER_COUNT_MASK) >>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI=
_RETUNING_TIMER_COUNT_SHIFT;
>>>
>>> - =A0 =A0 =A0 /* SDR104 supports also implies SDR50 support */
>>> - =A0 =A0 =A0 if (caps[1] & SDHCI_SUPPORT_SDR104)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR104 | M=
MC_CAP_UHS_SDR50;
>>> - =A0 =A0 =A0 else if (caps[1] & SDHCI_SUPPORT_SDR50)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_SDR50;
>>> -
>>> - =A0 =A0 =A0 if (caps[1] & SDHCI_SUPPORT_DDR50)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_UHS_DDR50;
>>> -
>>> - =A0 =A0 =A0 /* Does the host need tuning for SDR50? */
>>> - =A0 =A0 =A0 if (caps[1] & SDHCI_USE_SDR50_TUNING)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_SDR50_NEEDS_TU=
NING;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In case Re-tuning Timer is not d=
isabled, the actual value of
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* re-tuning timer will be 2 ^ (n -=
 1).
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->tuning_count)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_count =3D=
 1 << (host->tuning_count - 1);
>>>
>>> - =A0 =A0 =A0 /* Does the host need tuning for HS200? */
>>> - =A0 =A0 =A0 if (mmc->caps2 & MMC_CAP2_HS200)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_HS200_NEEDS_TU=
NING;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Re-tuning mode supported by the Ho=
st Controller */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_mode =3D (caps[1] & SDHC=
I_RETUNING_MODE_MASK) >>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_RETUNING_MODE_SHIFT;
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0/* Driver Type(s) (A, C, D) supported by the host */
>>> =A0 =A0 =A0 =A0if (caps[1] & SDHCI_DRIVER_TYPE_A)
>>> @@ -2821,21 +2839,6 @@ int sdhci_add_host(struct sdhci_host *host)
>>> =A0 =A0 =A0 =A0else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->power_notify_type =3D MMC_HOST_=
PW_NOTIFY_NONE;
>>>
>>> - =A0 =A0 =A0 /* Initial value for re-tuning timer count */
>>> - =A0 =A0 =A0 host->tuning_count =3D (caps[1] & SDHCI_RETUNING_TIME=
R_COUNT_MASK) >>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_RET=
UNING_TIMER_COUNT_SHIFT;
>>> -
>>> - =A0 =A0 =A0 /*
>>> - =A0 =A0 =A0 =A0* In case Re-tuning Timer is not disabled, the act=
ual value of
>>> - =A0 =A0 =A0 =A0* re-tuning timer will be 2 ^ (n - 1).
>>> - =A0 =A0 =A0 =A0*/
>>> - =A0 =A0 =A0 if (host->tuning_count)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_count =3D 1 << (host->tu=
ning_count - 1);
>>> -
>>> - =A0 =A0 =A0 /* Re-tuning mode supported by the Host Controller */
>>> - =A0 =A0 =A0 host->tuning_mode =3D (caps[1] & SDHCI_RETUNING_MODE_=
MASK) >>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_RETU=
NING_MODE_SHIFT;
>>> -
>>> =A0 =A0 =A0 =A0ocr_avail =3D 0;
>>>
>>> =A0 =A0 =A0 =A0host->vmmc =3D regulator_get(mmc_dev(mmc), "vmmc");
>>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>>> index e9051e1..2367939 100644
>>> --- a/include/linux/mmc/sdhci.h
>>> +++ b/include/linux/mmc/sdhci.h
>>> @@ -92,6 +92,9 @@ struct sdhci_host {
>>>
>>> =A0#define SDHCI_QUIRK2_HOST_OFF_CARD_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1<<0)
>>>
>>> +/* host or board design does support 1.8v signaling */
>>> +#define SDHCI_QUIRK2_HOST_NO_UHS_1_8V_SUPPORT =A0 =A0 =A0 =A0 =A0(=
1<<1)
>>> +
>>> =A0 =A0 =A0 =A0int irq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Device IR=
Q */
>>> =A0 =A0 =A0 =A0void __iomem *ioaddr; =A0 /* Mapped address */
>>>
>>> --
>>> 1.7.0.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
