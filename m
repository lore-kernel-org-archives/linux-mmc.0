From: Russ Knize <Russ.Knize@motorola.com>
Subject: Re: [PATCH] mmc: power class support
Date: Mon, 4 Apr 2011 10:25:45 -0500
Message-ID: <BANLkTikDc4+mT=jeM1WFt53-7mM3B-GRVA@mail.gmail.com>
References: <AANLkTin_=jScYXaXNStx-RfmBopbY43fuV8ZdhcS4M3K@mail.gmail.com>
 <AANLkTinNGxQgfyph9PXh9cZdxQ+QFZwTw8=NpW-pPXpE@mail.gmail.com> <BANLkTi=x-6a5vtx3BHxifRBHEjimRApavQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:33338 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab1DDP0I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 11:26:08 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34FQRGF009209
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 11:26:27 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34FPSPf008771
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 11:26:27 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so6255837wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 08:26:05 -0700 (PDT)
In-Reply-To: <BANLkTi=x-6a5vtx3BHxifRBHEjimRApavQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

No, they were not switch timeouts.  They were immediate failures due
to touchiness about init sequence.  The card firmware was corrected
and the new samples don't have the issue.  I don't think there are any
of these buggy ones in the wild, but I expect to see buggy firmware
coming from other vendors.

Russ W. Knize
Mobile Devices Android Platform
Desk: 847-523-9381
Mobile: 224-622-1391



On Sun, Apr 3, 2011 at 11:11 PM, Andrei Warkentin <andreiw@motorola.com=
> wrote:
> On Fri, Apr 1, 2011 at 7:28 PM, Andrei Warkentin <andreiw@motorola.co=
m> wrote:
>> Hi Russ,
>>
>> On Fri, Apr 1, 2011 at 10:58 AM, Russ Knize <Russ.Knize@motorola.com=
> wrote:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Ignore switch er=
rors from buggy cards that actually
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* do switch succes=
sfully.
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_power=
_class(host, max_dtr, bus_width);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -=
EBADMSG)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto =
free_card;
>>> +
>>
>> 1) host->card is not yet set at this moment, you probably want to pa=
ss
>> card to mmc_set_power_class as well .
>> 2) It seems like you will call mmc_set_power_class even if bus_width
>> =3D=3D MMC_BUS_WIDTH_1. Is that supposed to work? 7.6.3 seems to imp=
ly
>> power classes only apply to 4-bit and 8-bit bus widths. As does the
>> paragraph on top of Page 138 of eMMC 4.41 spec, which says that for
>> 1-bit bus configuration the default applies (class 0).
>> 3) Since the current code supports DDR modes, you probably want to
>> extend support for PWR_CL_DDR_52_(360|195) as well.
>>
>> Just curious, for the cards reporting switch errors but nonetheless
>> switching to the power class, do they update the EXT_CSD field?
>>
>
> There was just a patch posted by Chuanxiao Dong ([PATCH v4 0/3]mmc:
> enable TRIM/ERASE caps for SDHCI host) against SDHCI core to enable
> setting proper timeout for R1B response-type commands, one of which i=
s
> CMD6 (SWITCH). The patch is applicable to the kernel sources you've
> tested your patch on. Were the failures you've seen for cards errorin=
g
> on MMC_SWITCH timeouts? Could you test with that change for the parts
> affected, and see if your problem in programming power level goes
> away?
>
> A
>
