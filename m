From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] ARM: mmp2: support sdio device 8787
Date: Thu, 28 Jul 2011 13:36:46 +0800
Message-ID: <CAMj5BkiihE_5zd2Spv_1hPCQa3e-VYbyz9XH1Lnp3bGVaFVbTQ@mail.gmail.com>
References: <1654B53E-123B-43F5-B526-49D19D39D1F0@marvell.com>
	<1EA87C4D-1B63-40E4-AA86-20D2A02A17B7@marvell.com>
	<CAMj5BkgEWb4ejChy6NCdxLse9maG25Pr6JmTS3pt0HJk2ee1Eg@mail.gmail.com>
	<B6C7F083-E557-418D-9136-A37189F2770D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54118 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab1G1Fgr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 01:36:47 -0400
Received: by qwk3 with SMTP id 3so1159528qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2011 22:36:46 -0700 (PDT)
In-Reply-To: <B6C7F083-E557-418D-9136-A37189F2770D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bing Zhao <bzhao@marvell.com>, Frank Huang <frankh@marvell.com>

On Thu, Jul 28, 2011 at 12:23 PM, Philip Rakity <prakity@marvell.com> w=
rote:
>
> On Jul 27, 2011, at 7:44 PM, zhangfei gao wrote:
>
>>>> +
>>>> +static struct fixed_voltage_config sdio_power =3D {
>>>> + =A0 =A0 .supply_name =A0 =A0 =A0 =A0 =A0 =A0=3D "vmmc",
>>>> + =A0 =A0 .microvolts =A0 =A0 =A0 =A0 =A0 =A0 =3D 3000000,
>>>> + =A0 =A0 .gpio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mfp_to_gpi=
o(MFP_PIN_GPIO57),
>>>> + =A0 =A0 .enable_high =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
>>>> + =A0 =A0 .enabled_at_boot =A0 =A0 =A0 =A0=3D 0,
>>>> + =A0 =A0 .init_data =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &sdio_power_da=
ta,
>>>> +};
>>>> +
>>>
>>> ldo7 is the power source. =A0 The 8787 is the consumer and the code=
 should reflect this.
>>> GPIO57 is an on/off switch to the 8787.
>>>
>>>
>> Instead of LDO7, 8787 is powered with V_SD2, V_BATT, and VLDO12 on b=
rownstone.
>> Use PDn to control 8787 power is recommended method.
>> 1. Some LDO is shared and can not be cut down.
>> 2. Control LDO is much slower, some time is needed for voltage to
>> decay, and the time is not accurate to control.
>> 3. With LDO powered, 8787 is under control and 8787 could put itself
>> to the lowest state.
>
>
> LDO is dedicated to 8787 and can be left on. =A0 =A0The power picture=
 is ldo (as regulator)
> and 8787 as consumer. =A0Code does not show this relationship. =A0The=
 8787 in deep sleep
> draws very little power but since even this small power usage is a co=
ncern the disabling
> the ldo can reduce power further.

In fact, disable ldo may consume more power than put 8787 in low power
mode, since leakage from pin, which can not be controlled by 8787 any
more if ldo is disabled.
