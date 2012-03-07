From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency
 constraints
Date: Wed, 7 Mar 2012 19:38:03 +0000
Message-ID: <20120307193803.GF3107@opensource.wolfsonmicro.com>
References: <201203040101.53177.rjw@sisk.pl>
 <201203062214.53988.rjw@sisk.pl>
 <4F571CC9.7050609@intel.com>
 <201203071005.54890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zgr1mbP1ee4HJQ5m"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40273 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759701Ab2CGTiF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Mar 2012 14:38:05 -0500
Content-Disposition: inline
In-Reply-To: <201203071005.54890.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@ti.com>


--zgr1mbP1ee4HJQ5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2012 at 10:05:54AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 07, 2012, Adrian Hunter wrote:

> > Maybe this needs to be re-thought.  Userspace needs a simple, consisten=
t and
> > understandable set of pm controls across the entire kernel, not pieceme=
al
> > across different subsystems.

> Well, that's my opinion too, but other people don't seem to agree with it.

Well, it depends on what the knob is.  Some things definitely make sense
being generic (like the existing support for disabling runtime PM) but
people have suggested stuff like fiddling with IRQ latencies which really=
=20
seems far too detailed a thing to be twiddling from userspace and fairly
obscure in the system level impact so difficult for applications to take
advantage of usefully.

--zgr1mbP1ee4HJQ5m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV7kRAAoJEBus8iNuMP3dnXcP/0zBT+UksNirwyFvgD1N7iSm
74RGtY5Q8fdf7GWh+2eMPl+ssZB20Qys8VsXfg3eFnwdR+hUYV55yOdlzEELFhRN
kTWUVM4KT2rx6PBKbmBeVWjmmC5ptG80wuFfPAaaEAX1j8NBPX/LCDy55Qt4mRNI
AH4Ee/qRftBsggnU+UkEU+0Ga8+lG3InbvJJuqNIRzIDNo2V5+No2LFbwDi/oIK0
teZ5waPbT/YLVnY0idt5pBTtNkL6OADjYU3AGW8jCHsU527cWm+nODGSny3RiPze
tYb1f3inTy4Cog35e4F82gcP39MALXD3DlZyejLOASwIdhROsI+6RlcurjVvYQ0j
uqbsUainVJ5ubecSw2FU/rV9JPtEuhFz/oXuK6EU1BZeRSs+esgdUL49iLGQZzH4
Gxvvv+VEbbSCSS17Rxzibpi8b4b1HhuZTYm0UtLGwSgLgUVJIImRYHg4ui9hA9JN
KQOjLEPzWfMXBdvRCk+QZ7nFDGSo09+4ruKUELG4CzdDn/MJYSxCioEDyFb5s3cp
Fe3ktDgJAKPEH6JnFAxL3cWSBfusMcNwkmuzjEvscehoep7Tl85aGE4UTfQbpvRm
Qm/AuiPhCCbJ3UZOB0weMoQr/5R+7QMlRsF4yPCkG5pJ+xUuZB6Wp+ODpIp0X3yN
aXA7DSNYDE2Gaape0MUI
=KGOV
-----END PGP SIGNATURE-----

--zgr1mbP1ee4HJQ5m--
