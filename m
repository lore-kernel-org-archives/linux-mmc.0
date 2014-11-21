From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] Production State Awareness support in host side
Date: Fri, 21 Nov 2014 14:16:18 +0100
Message-ID: <CAPDyKFp8PCBMOtXr-SkUDSw6CZ4c-4AnY-btex5WpU+B9u4Ppw@mail.gmail.com>
References: <1416228726-8514-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFrCpoSsgECvC=gnMp6WDYAV+2os-uhzp03K-=E+Yv10AA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333EC9D394@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFrzmW5ADf86Q2t18X8cUUovGF-fuhDpQBUSCiPf9g4OUA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333EC9F16C@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:64219 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbaKUNQT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Nov 2014 08:16:19 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so3754332qcx.30
        for <linux-mmc@vger.kernel.org>; Fri, 21 Nov 2014 05:16:18 -0800 (PST)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333EC9F16C@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

On 19 November 2014 11:58, Alex Lemberg <Alex.Lemberg@sandisk.com> wrot=
e:
>
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Wednesday, November 19, 2014 11:59 AM
>> To: Alex Lemberg
>> Cc: linux-mmc; Chris Ball; Avi Shchislowski
>> Subject: Re: [PATCH 1/1] Production State Awareness support in host =
side
>>
>> On 18 November 2014 19:41, Alex Lemberg <Alex.Lemberg@sandisk.com>
>> wrote:
>> > Hi Ulf,
>> >
>> >> -----Original Message-----
>> >> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> >> Sent: Monday, November 17, 2014 3:34 PM
>> >> To: Avi Shchislowski
>> >> Cc: linux-mmc; Chris Ball; Alex Lemberg
>> >> Subject: Re: [PATCH 1/1] Production State Awareness support in ho=
st
>> >> side
>> >>
>> >> On 17 November 2014 13:52, Avi Shchislowski
>> >> <avi.shchislowski@sandisk.com>
>> >> wrote:
>> >> > Adding support for PSA (Production State Awareness) feature for=
 all
>> >> > eMMC devices with revision >=3D5.0 In this patch the eMMC drive=
r will
>> >> > check if device was completed its Production State mode, and wi=
ll
>> >> > switch it to Normal (field) mode.
>> >> > Switching to normal mode signal the device to complete its work=
 in
>> >> > production mode and start working in regular performance mode.
>> >>
>> >> Please add some detail to what this patch does. Additionally why =
it's needed.
>> >
>> > In this patch driver should recognize if eMMC device (Rev >=3D5.0)=
 was
>> > not switched to Normal (0x00) PSA mode by storage vendor or Progra=
mmer
>> house.
>> > For this, we are checking if device was leaved in
>> > PRE_SOLDERING_POST_WRITES (0x02) state - represents a state in whi=
ch
>> > the device is in production and the host (usually programmer) comp=
leted to
>> load the content to the device.
>> > The host (usually programmer) sets the device to this state after
>> > content was loaded and just before soldering.
>> > After soldering the device to real host (not programmer), the devi=
ce
>> > should be switched to Normal (0x00) mode.
>> > The Normal (0x00) mode of PSA register represents a state in which=
 the
>> > device is running in the field and uses =E2=80=9Cregular=E2=80=9D =
operations.
>> > Leaving device in PRE_SOLDERING_POST_WRITES (0x02) might not allow=
 to
>> > host write content to the device.
>> >
>> > More details about PSA feature can be found in eMMC 5.0 spec (Jede=
c:
>> >  JESD84-B50.pdf)
>> > http://www.jedec.org/standards-documents/technology-focus-areas/fl=
ash-
>> > memory-ssds-ufs-emmc/e-mmc
>> >
>> > Please let us know if more details required.
>>
>> Okay, that was far better.
>>
>> I am not so sure we should finalize the production phase while initi=
alizing the
>> eMMC card like this.
>>
>> Certainly we should check the PSA state, but I think we should retur=
n an error if
>> we think the device hasn=E2=80=99t completed production. It should b=
e the responsibility
>> for the "programming tools" to finalize the production, right!?
>
> According to eMMC spec, the switch to NORMAL should be done after dev=
ice soldering to final host (not programmer).
> Please refer to "Figure 32 =E2=80=94 Recommended Soldering procedure"=
 in eMMC5.0 specification document.
> Also, since we are dealing with only "field" host here, we are not to=
uching/switching any other modes of PSA, but only Normal (field).
> This code should run only once - in the beginning of device life cycl=
e.

I get your point, but I am not so sure.

To me, I wouldn't trust that the platform binaries has been
successfully programmed to the device, unless the programmer tool
takes care of switching the device to "normal".

What does other people think?

Kind regards
Uffe
