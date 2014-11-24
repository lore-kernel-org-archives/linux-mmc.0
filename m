From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] Production State Awareness support in host side
Date: Mon, 24 Nov 2014 13:23:56 +0100
Message-ID: <CAPDyKFoajPtSbQGATd59Cu4tSEDxaWcBvp39ndm41O778B0uRQ@mail.gmail.com>
References: <1416228726-8514-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFrCpoSsgECvC=gnMp6WDYAV+2os-uhzp03K-=E+Yv10AA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333EC9D394@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFrzmW5ADf86Q2t18X8cUUovGF-fuhDpQBUSCiPf9g4OUA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333EC9F16C@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFp8PCBMOtXr-SkUDSw6CZ4c-4AnY-btex5WpU+B9u4Ppw@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333ECADFBA@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:42520 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbaKXMX5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 07:23:57 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so7392664qcw.37
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 04:23:56 -0800 (PST)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333ECADFBA@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

[...]

>> >>
>> >> I am not so sure we should finalize the production phase while
>> >> initializing the eMMC card like this.
>> >>
>> >> Certainly we should check the PSA state, but I think we should re=
turn
>> >> an error if we think the device hasn=E2=80=99t completed producti=
on. It
>> >> should be the responsibility for the "programming tools" to final=
ize the
>> production, right!?
>> >
>> > According to eMMC spec, the switch to NORMAL should be done after =
device
>> soldering to final host (not programmer).
>> > Please refer to "Figure 32 =E2=80=94 Recommended Soldering procedu=
re" in
>> eMMC5.0 specification document.
>> > Also, since we are dealing with only "field" host here, we are not
>> touching/switching any other modes of PSA, but only Normal (field).
>> > This code should run only once - in the beginning of device life c=
ycle.
>>
>> I get your point, but I am not so sure.
>>
>> To me, I wouldn't trust that the platform binaries has been successf=
ully
>> programmed to the device, unless the programmer tool takes care of s=
witching
>> the device to "normal".
>>
>
> Thanks Ulf!
> Also, please note - PSA PRE_SOLDERING_POST_WRITES mode intent to save=
 device
> pre-loaded content during the soldering process.
> Flash data can be corrupted due to soldering procedure high temperatu=
re. So switching
> to Normal cannot be done by external programmer.

So, if flash data will be corrupted due to for example high
temperatures during soldering, how will that be detected when using
the "manual mode"?

If that's the job for the platform software I fail to understand why
the PRE_SOLDERING_POST_WRITES state needs to exists at all!?

Kind regards
Uffe
