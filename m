From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 32kHz clock removal causes problems omap_hsmmc
Date: Wed, 19 Dec 2012 11:18:11 +0100
Message-ID: <50D19463.5010605@ti.com>
References: <1352968293.10872.51.camel@cumari.coelho.fi> <20121218095450.GB27751@arwen.pp.htv.fi> <20121219094552.GN4985@opensource.wolfsonmicro.com> <50D19040.5090404@ti.com> <20121219100909.GO4985@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49163 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab2LSKSS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Dec 2012 05:18:18 -0500
In-Reply-To: <20121219100909.GO4985@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <balbi@ti.com>, Luciano Coelho <coelho@ti.com>, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, lrg@ti.com, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 12/19/2012 11:09 AM, Mark Brown wrote:
> On Wed, Dec 19, 2012 at 11:00:32AM +0100, Peter Ujfalusi wrote:
>=20
>> I don't know the state of the common clock framework for OMAPs. Is i=
t already
>> up in 3.7? Or going for 3.8? 3.9? 3.10?...
>> We need CCF to resolve this. I can cook up the clock driver for the =
32k clock
>> from twl, but in order to use it we need CCF on OMAP.
>=20
> Well, we at least ought to make sure it doesn't appear in the regulat=
or
> DT bindings even if it's handled via some OMAP magic - that was the k=
ey
> point here.

Sure. It must be a clock driver. I already have similar driver (for McP=
DM fclk
clock) for twl6040.
Let me check linux-next, if CCF is there for OMAP I can send the 32k cl=
ock
driver soon (after writing it and testing it). It is going to be for 3.=
9 but
we can roll it with us I think locally to resolv issues.

--=20
P=E9ter
