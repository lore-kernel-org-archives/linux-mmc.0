From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Mon, 28 May 2012 15:46:17 +0100
Message-ID: <20120528144616.GH4032@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
 <1337960752-4944-10-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1337960752-4944-10-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2012 at 05:45:24PM +0200, Guennadi Liakhovetski wrote:
> Add a function to get a regulator, supplying card's Vdd on a specific host.
> If such a regulator is found, the function checks, whether a valid OCR mask
> can be obtained from this regulator.

This appears to be identical to the version I just reviewed...

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw4+xAAoJEBus8iNuMP3d0wAP/iOVyMYl5MIwoDDVGfqFBHqn
wNmsXkL9ZqtY1l8GITAHt23e8G4Jw46rL4LJqy8/N8PjCO7UEF5Y4liC8Q7RCrfx
4G53uoM/sWiuKpAZf/6dENtLbgM67U+S5efngy9hEaLzF1Vwfrs/LjGN2qKrPKb5
eA/zMPAp53SmNa86yDQNnFu+nPhnZ11SHI/hqCAPb8d6PaYEw3AueYtLhyZuko76
JqW+epHIR9Y0yhpTw2ijmTgiQFNAoDSXsa67A0TNp3boUSAAoFwc/3HR99MzZE3H
sU9dorwQyKN1O2VHi6ge8baoBEZRvexQ5sOTh7jimQ4YQVGrHB3pYQ8wDr7xMSXI
R2T+tll1VPm+yDSg+wsxevQcq34Xq3Cyq8bSYYzJxOr48wZEkf57dmbgO5ANPQ3p
Jr9qgBKyM0RVOBV2IwPfNRS9AFbjrpD5PHYXgP89SZBOutHIvxMJ55JsZycrMxjH
RSIgDbPA0ksr2FK6Grcazzgg04+iJgfjZ7B3PeHgCesea4bG+NS9z7ZRbqehhrS5
gvLdYmQOQ5dMS4cyanBFZ2K9fdXTaDa1olHRKJPWSYI+ATV6fvdMpaq54ehFTfAW
UukCbNdiS4Or025MJ6tUntcRpNe+Nl0lUze7rlnW7qUzECezzd38XqvbWlc5MgEN
qlRsTmN81p02aViaG55s
=0OXC
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--
