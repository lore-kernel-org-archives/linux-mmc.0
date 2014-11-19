From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] Production State Awareness support in host side
Date: Wed, 19 Nov 2014 10:58:50 +0100
Message-ID: <CAPDyKFrzmW5ADf86Q2t18X8cUUovGF-fuhDpQBUSCiPf9g4OUA@mail.gmail.com>
References: <1416228726-8514-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFrCpoSsgECvC=gnMp6WDYAV+2os-uhzp03K-=E+Yv10AA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333EC9D394@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:40565 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbaKSJ6v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 04:58:51 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so136690qcx.13
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 01:58:50 -0800 (PST)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333EC9D394@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

On 18 November 2014 19:41, Alex Lemberg <Alex.Lemberg@sandisk.com> wrot=
e:
> Hi Ulf,
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Monday, November 17, 2014 3:34 PM
>> To: Avi Shchislowski
>> Cc: linux-mmc; Chris Ball; Alex Lemberg
>> Subject: Re: [PATCH 1/1] Production State Awareness support in host =
side
>>
>> On 17 November 2014 13:52, Avi Shchislowski <avi.shchislowski@sandis=
k.com>
>> wrote:
>> > Adding support for PSA (Production State Awareness) feature for al=
l
>> > eMMC devices with revision >=3D5.0 In this patch the eMMC driver w=
ill
>> > check if device was completed its Production State mode, and will
>> > switch it to Normal (field) mode.
>> > Switching to normal mode signal the device to complete its work in
>> > production mode and start working in regular performance mode.
>>
>> Please add some detail to what this patch does. Additionally why it'=
s needed.
>
> In this patch driver should recognize if eMMC device (Rev >=3D5.0) wa=
s not switched
> to Normal (0x00) PSA mode by storage vendor or Programmer house.
> For this, we are checking if device was leaved in PRE_SOLDERING_POST_=
WRITES (0x02)
> state - represents a state in which the device is in production and t=
he host
> (usually programmer) completed to load the content to the device.
> The host (usually programmer) sets the device to this state after con=
tent was loaded
> and just before soldering.
> After soldering the device to real host (not programmer), the device =
should be switched to
> Normal (0x00) mode.
> The Normal (0x00) mode of PSA register represents a state in which th=
e device is running
> in the field and uses =E2=80=9Cregular=E2=80=9D operations.
> Leaving device in PRE_SOLDERING_POST_WRITES (0x02) might not allow to=
 host write content
> to the device.
>
> More details about PSA feature can be found in eMMC 5.0 spec (Jedec:
>  JESD84-B50.pdf)
> http://www.jedec.org/standards-documents/technology-focus-areas/flash=
-memory-ssds-ufs-emmc/e-mmc
>
> Please let us know if more details required.

Okay, that was far better.

I am not so sure we should finalize the production phase while
initializing the eMMC card like this.

Certainly we should check the PSA state, but I think we should return
an error if we think the device hasn=E2=80=99t completed production. It=
 should
be the responsibility for the "programming tools" to finalize the
production, right!?

Kind regards
Uffe
