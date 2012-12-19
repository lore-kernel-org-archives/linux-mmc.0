From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 32kHz clock removal causes problems omap_hsmmc
Date: Wed, 19 Dec 2012 11:00:32 +0100
Message-ID: <50D19040.5090404@ti.com>
References: <1352968293.10872.51.camel@cumari.coelho.fi> <20121218095450.GB27751@arwen.pp.htv.fi> <20121219094552.GN4985@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121219094552.GN4985@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <balbi@ti.com>, Luciano Coelho <coelho@ti.com>, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, lrg@ti.com, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 12/19/2012 10:45 AM, Mark Brown wrote:
> On Tue, Dec 18, 2012 at 11:54:50AM +0200, Felipe Balbi wrote:
>=20
>> damn, this is still part of our v3.7-rc kernel. Original commit was =
done
>> with no testing whatsoever and caused a big regression to (at least)
>> TI's WiFi driver which depend on SDIO to function.
>=20
>> Too bad things break and even when reported nobody gives a rat's ***
>> about them :-s
>=20
> I guess it's going to be even more of an issue going forward given th=
e
> recent events but FWIW it was always very unusual to see any review o=
f
> any TWL patches, the PMIC appeared to have been rather abandoned so t=
he
> only way of getting any testing was to put stuff in -next and hope.

As for the twl-regulator I still have plan to do a major cleanup there.=
 It is
just sad that it received the DT bindings for the current code. The DT =
support
addition would have been the perfect place to sanitize it. Now it is ju=
st
going to be a huge pain in the back.

As for the 32k clock:
I don't know the state of the common clock framework for OMAPs. Is it a=
lready
up in 3.7? Or going for 3.8? 3.9? 3.10?...
We need CCF to resolve this. I can cook up the clock driver for the 32k=
 clock
from twl, but in order to use it we need CCF on OMAP.

--=20
P=E9ter
