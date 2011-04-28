From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mmc:sdhci:add support to request/free pins for
 controllers sharing hardware bus
Date: Thu, 28 Apr 2011 09:16:25 +0800
Message-ID: <BANLkTi=1YQExkRapdcd7HSM1ZXMONZ6xxA@mail.gmail.com>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
 <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com> <m3d3k9u0yy.fsf@pullcord.laptop.org>
 <BANLkTimXXirF6zqx9h9DMRSpx+o8_vb=3w@mail.gmail.com> <20110426065851.GA14534@pengutronix.de>
 <BANLkTineayh539zJx6GfxnpgCJwJdxYy0Q@mail.gmail.com> <89D3A89E-40C7-4938-9B58-24AA8E63DB8C@marvell.com>
 <BANLkTimdz+c82nK7PizOpQRCrqnBkr4ROA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56011 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab1D1BQq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 21:16:46 -0400
Received: by qwk3 with SMTP id 3so1025479qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 18:16:45 -0700 (PDT)
In-Reply-To: <BANLkTimdz+c82nK7PizOpQRCrqnBkr4ROA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Binghua.Duan@csr.com" <Binghua.Duan@csr.com>, "andreiw@motorola.com" <andreiw@motorola.com>

2011/4/28 Barry Song <21cnbao@gmail.com>:
> Hi Philip,
>
> 2011/4/26 Philip Rakity <prakity@marvell.com>:
>>
>> Barry,
>>
>> How are interrupts from SDIO devices handled ? =C2=A0 SDIO devices u=
se one of the pins to signal a interrupt to the host when data is avail=
abe.
>
> Good question. in fact, it is impossible to support both sharing all
> data bus and sdio interrupt in hardware except that hardware gives a
> special design with data1. Otherwise, controllers with shared pins
> requested at runtime will not support sdio devices with interrupts.

So the point is that leaving get/put_shared_pins implementation to
bottom level drivers. Let the bottom level handle possible details.

>
>>
>> Philip
>>
>> On Apr 26, 2011, at 12:27 AM, Barry Song wrote:
>>
>>> Hi Wolfram,
>>>
>>> 2011/4/26 Wolfram Sang <w.sang@pengutronix.de>:
>>>>>> * Where is the patch that implements the get_shared_pins() hook =
in
>>>>>> =C2=A0your driver?
>>>>> We send the common level patch ahead to get the upstream agreemen=
t so
>>>>> that we can maintain our bottom level sdhci codes better. We will=
 send
>>>>> the special driver patch after some time.
>>>>
>>>> Hmm, why should be there a functionality if there is no user for i=
t? A
>>>> reference user helps people understand how it is intended to be us=
ed.
>>>
>>> completely right. Of course this patch is based on real application=
s
>>> and SoCs. We are using ARASAN sd controller IP, it can be configura=
ted
>>> to use shared pins mode in SoC design. And it looks like it is a
>>> common requirement to save chip footprint by sharing data bus betwe=
en
>>> multi-controllers.
>>>
>>> Just because Our SoCs are still on the way to opensource and mainli=
ne.
>>> Even our arch/arm/mach-xxx hasn't been merged yet. Our target is
>>> syncing our codes with mainline. So as a modification to sdhci comm=
on
>>> level, we just get upstream's opinion for local maintaining earlier=
=2E
>>>
>>> Anyway, this patch may be applied later after our others are ready.=
 Or
>>> it can be now so that other SoC companies can use this feature.
>>>
>>>>
>>>> Regards,
>>>>
>>>> =C2=A0 Wolfram
>>>>
>>>> --
>>>> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
>>>> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>>>>
>>
>>
> -barry
>
