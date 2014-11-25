From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] Production State Awareness support in host side
Date: Tue, 25 Nov 2014 11:57:23 +0100
Message-ID: <CAPDyKFq+fhJudMFhA1SAUgwBTbvFRu5F_F0UZjjPr5HU4SAhNg@mail.gmail.com>
References: <1416228726-8514-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFrCpoSsgECvC=gnMp6WDYAV+2os-uhzp03K-=E+Yv10AA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333EC9D394@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFrzmW5ADf86Q2t18X8cUUovGF-fuhDpQBUSCiPf9g4OUA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333EC9F16C@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFp8PCBMOtXr-SkUDSw6CZ4c-4AnY-btex5WpU+B9u4Ppw@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333ECADFBA@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFoajPtSbQGATd59Cu4tSEDxaWcBvp39ndm41O778B0uRQ@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333ECB6DEC@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:57850 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbaKYK5Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Nov 2014 05:57:24 -0500
Received: by mail-qa0-f44.google.com with SMTP id i13so191194qae.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2014 02:57:24 -0800 (PST)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333ECB6DEC@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

On 25 November 2014 at 10:17, Alex Lemberg <Alex.Lemberg@sandisk.com> w=
rote:
>
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Monday, November 24, 2014 2:24 PM
>> To: Alex Lemberg
>> Cc: linux-mmc; Chris Ball; Avi Shchislowski
>> Subject: Re: [PATCH 1/1] Production State Awareness support in host =
side
>>
>> [...]
>>
>> >> >>
>> >> >> I am not so sure we should finalize the production phase while
>> >> >> initializing the eMMC card like this.
>> >> >>
>> >> >> Certainly we should check the PSA state, but I think we should
>> >> >> return an error if we think the device hasn=E2=80=99t complete=
d
>> >> >> production. It should be the responsibility for the "programmi=
ng
>> >> >> tools" to finalize the
>> >> production, right!?
>> >> >
>> >> > According to eMMC spec, the switch to NORMAL should be done aft=
er
>> >> > device
>> >> soldering to final host (not programmer).
>> >> > Please refer to "Figure 32 =E2=80=94 Recommended Soldering proc=
edure" in
>> >> eMMC5.0 specification document.
>> >> > Also, since we are dealing with only "field" host here, we are =
not
>> >> touching/switching any other modes of PSA, but only Normal (field=
).
>> >> > This code should run only once - in the beginning of device lif=
e cycle.
>> >>
>> >> I get your point, but I am not so sure.
>> >>
>> >> To me, I wouldn't trust that the platform binaries has been
>> >> successfully programmed to the device, unless the programmer tool
>> >> takes care of switching the device to "normal".
>> >>
>> >
>> > Thanks Ulf!
>> > Also, please note - PSA PRE_SOLDERING_POST_WRITES mode intent to s=
ave
>> > device pre-loaded content during the soldering process.
>> > Flash data can be corrupted due to soldering procedure high
>> > temperature. So switching to Normal cannot be done by external
>> programmer.
>>
>> So, if flash data will be corrupted due to for example high temperat=
ures during
>> soldering, how will that be detected when using the "manual mode"?
>>
>> If that's the job for the platform software I fail to understand why=
 the
>> PRE_SOLDERING_POST_WRITES state needs to exists at all!?
>
> The flow of "Manual Mode" is:

Thanks for clarifying.

>
> [skipping few common steps]
> ...
> Host (Programmer) sets PRODUCTION_STATE_AWARENESS
> to 0x1 (PRE_SOLDERING_WRITES)
>
> Host (Programmer) perform pre-soldering data loading
> and/or device configuration
>
> Host (Programmer) sets PRODUCTION_STATE_AWARENESS
> To 0x2 (PRE_SOLDERING_POST_WRITES).
> No writes past this point

To repeat my question:

_Unless_ there are no validation of the device soldering performed by
the "programmer tool" past this point, why couldn't the host set
PRODUCTION_STATE_AWARENESS to 0x0 (NORMAL) at this point instead?

>
> Device Soldering
>
> Host (field) sets PRODUCTION_STATE_AWARENESS
> to 0x0 (NORMAL)
> ...
>
> Hope this will answer...
>

Kind regards
Uffe
