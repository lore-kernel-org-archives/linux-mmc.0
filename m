From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 32kHz clock removal causes problems omap_hsmmc
Date: Wed, 19 Dec 2012 15:31:53 +0100
Message-ID: <50D1CFD9.2050205@ti.com>
References: <1352968293.10872.51.camel@cumari.coelho.fi> <20121218095450.GB27751@arwen.pp.htv.fi> <20121219094552.GN4985@opensource.wolfsonmicro.com> <50D19040.5090404@ti.com> <20121219100909.GO4985@opensource.wolfsonmicro.com> <50D19463.5010605@ti.com> <20121219103206.GQ4985@opensource.wolfsonmicro.com> <1355913954.5273.21.camel@cumari.coelho.fi> <50D19D54.2000307@ti.com> <20121219130128.GC17993@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33765 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab2LSOcB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Dec 2012 09:32:01 -0500
In-Reply-To: <20121219130128.GC17993@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: Luciano Coelho <coelho@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, lrg@ti.com, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, r.sricharan@ti.com

On 12/19/2012 02:01 PM, Felipe Balbi wrote:
> Hi,
>=20
> +Sricharan who commited that
>=20
> On Wed, Dec 19, 2012 at 11:56:20AM +0100, Peter Ujfalusi wrote:
>> On 12/19/2012 11:45 AM, Luciano Coelho wrote:
>>>> Well, we still haven't got the foggiest idea what the actual probl=
em is
>>>> beyond that it's probably related to the 32kHz clock in some way (=
unless
>>>> it was one of the other reverts that coincidentally made a differe=
nce,
>>>> but we don't know what they were) so it's unlikely that just rando=
mly
>>>> implementing clock support is going to fix anything immediately he=
re.
>>>
>>> This is exactly what I had to revert (as I mentioned in the other e=
mail,
>>> I had to revert the other patches otherwise compilation would break=
):
>>>
>>> 0e8e5c34 "regulator: twl: Remove references to 32kHz clock from DT =
bindings"
>>> e76ab829 "regulator: twl: Remove references to the twl4030 regulato=
r"
>>> 029dd3ce "regulator: twl: Remove another unused variable warning"
>>
>> Yeah. 32k clock is not provided by twl.
>>
>> As I said I need to take a look at CCF to see if it already there. I=
f it is
>> clock driver + mapping + patch for wl12xx should fix the issue you a=
re facing.
>>
>>> Let me know if you need more info.
>>
>> BTW: have you happened to ubdate u-boot recently? There is a nice ea=
ster egg
>> added there:
>> f3f98bb ARM: OMAP4/5: Do not configure non essential pads, clocks, d=
plls.
>>
>> Which means that _essential_ clocks and pads are no longer configure=
d.
>=20
> anything essential you can list ?

Depends on the definition of essential.
Serial and mmc works.
I said it was an easter egg since it was... well... quite a bit of surp=
rise
that the same kernel started to fail for example in all audio operation=
 when I
updated the u-boot, which I tend to do every now and then to see if the=
re are
no regression.

So it was a nice surprise. Even the commit message agreed that it is go=
ing to
break the drivers:

    Note that this is going to break the kernel drivers. But this
    is the only way to get things fixed in the kernel.

Usually if I know I will going to break something intentionally I tend =
to send
warnings and give some grace periods for the interested guys to adopt.

And this is why people are not testing u-boot. We tend to have one work=
ing
binary moving from SD card to other and update it only, __only__ when i=
t can
not be avoided.

If we work together, we should work together...

Do not take it personal. I just had tough days...

--=20
P=E9ter
