From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Mon, 28 May 2012 15:43:17 +0100
Message-ID: <20120528144317.GF4032@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
 <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
 <CAPDyKFrrxyk-JpLFge5+0xbYjJ=-24avWn8Optfg88-i006-Ng@mail.gmail.com>
 <1925406B-D680-40BB-890A-78447EEB4583@marvell.com>
 <4FC33362.4010806@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46108 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753501Ab2E1OnU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 May 2012 10:43:20 -0400
Content-Disposition: inline
In-Reply-To: <4FC33362.4010806@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Philip Rakity <prakity@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2012 at 11:12:18AM +0300, Adrian Hunter wrote:
> On 28/05/12 06:32, Philip Rakity wrote:

> > I have started looking at this area and I am rather confused.  It seems to me two "dedicated" regulators are required.

> It probably pays not to assume too much about regulators.  For example:

> Sometimes vccq is always on, so there may be just 1 regulator for vcc.

Even if the supply is always on you can easily provide an always on
regulator.  From the point of view of the consumer if there are two
physical supplies needed it's much clearer and easier to just code that
and deal with the fact that we might have no control over them
externally, there's nothing device specific about that process.

> wl12xx/SDIO is setup with a fake regulator that actually controls
> the enable line.

Which enable line is this?  If it's not for the regulator why wouldn't
other boards control this line?

> There is a case where power is supplied at a different voltage than
> spec'ed i.e. commit 6e8201f57c9359c9c5dc8f9805c15a4392492a10

The commit message there is really unclear so it's very hard to
understand what the commit is supposed to do...  for one thing it's not
entirely obvious what the connection with fixed voltage regulators is or
why there might be an intermittent issue.

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw47xAAoJEBus8iNuMP3dzEoP/2+1q0Ibm/EvdqwYJM9bVGV0
B1f1mC5WZsq283l543ze/v9ksO6yKLq01UwVv/rxKO0bGualD2iv7b3aUlf0JDuB
xgsDPOIqHdPz8/Q/ELvco0Wj4X/1qx9HHUzHTymbEuILfS5UnOgfGPoKCxZ09EDO
YCE+HYHTgvKsa9V+j3PSx6jxU1XbJ/vhX/ZrFLTOFs2eeBFlbC1ldAYchqrOdhh4
mYNs9LaEkxbQ9zeHkSItijYPsq2hFxXBIkVbyPpsoNVqWgffC7IL6CO82t7aQ4YH
ldPNUpaldNYHNJ8OfM7jC201r5msEmhEMyiISvzK563crcozVO0q2jgaTqVJivLy
I+YcTRFetnaQE95UEFjprKaVozi5dJwO39J72CsTUS99V8cHRORzrqf40pDddg2B
VD54NIffOw9hKc+W+kImVkFiCioZ+FSUSLeDBPsuDtHJ4TenoXaKnYtgg/nr3jUR
5vJuUhVhynpZltR2zbg7+qlmivACOi7GJh/vcJhtFdMRHKaPrP0t0PABPH0/Z6ZP
0MXcHFpGYfllyxxqFrsOWnl4o3vHuTTI7R6fv6Erdhv7OeZm/PsNxdNpDNyMPHCN
sHMO9qXdB7UTdfAcAF1d03gTpHf+VsadVYRqQcg0CVeEarSQrgHwFlDxAj/pl0Xj
C+4oNQrOXswTm25CTJNV
=uinP
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
