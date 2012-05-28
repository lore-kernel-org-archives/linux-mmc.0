From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Mon, 28 May 2012 15:45:02 +0100
Message-ID: <20120528144502.GG4032@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
 <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46122 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754043Ab2E1OpE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 May 2012 10:45:04 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2012 at 05:14:52PM +0200, Guennadi Liakhovetski wrote:
> Add a function to get a regulator, supplying card's Vdd on a specific host.
> If such a regulator is found, the function checks, whether a valid OCR mask
> can be obtained from this regulator.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but

> +EXPORT_SYMBOL(mmc_regulator_get_vmmc);

regulator is all _GPL...

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw49nAAoJEBus8iNuMP3deFoP/3Jdt2bkACkgTwWTekEMTzob
oQJgyEV2EynoVKw6VuoQzBIAJLmrOoMqdoEpz3ccRWJ6Fq36vMbHqXaQeZBnL3c9
jMt12ejDRLs+xvkrNECsn0qXm1qm7HZk3+8ey9jPRmjXQx7HCdDSqVP1zWKuWEuO
SULKayS9ygFeS+fY9MuGItRAHM0tSicaPQNOnckBzSSC1pZ15G9ynmf01Szv7Ni5
96739LZjizxddn0bHU9s8+sD0W7GyMm8xaSg9+L45WRE/b4VoukGnDfnL+ROtUBq
EOa7Nkyct/WNl02fnLzOj35j0RM68OBmvcT12pvLzRAC6AZs2qA/rUhKIS1O7qPi
iK3grpZRqnyjr89Qcx1lXzGklKBhRiFjvn47WpVKvVo5tsOHa8utlGR8fhC6abBr
wI+0TgBBFNun5f1Xj/7Xozk+XISx3K6e54J2Bt5CCIVCV3UJSuMftdjywzBP0GsT
CNsMj9U/ezksVuQbO639xbpruzy9crW/+pCV/63qBgB//HhJ7Xskbp4xrDbUKmbI
+yKwPo09z9iTM3vq05Yi5kDIzOnY2l4ryJgmXP3GgdHMH4qkmRFXJ7D8AvQ04Urq
9/BcHWTIrveFiiSZfD7qFsmx83jlBaqX05IjFJwJvbbUACZVHXMs0y4P7UyLJmSR
F2O6Ypkexo0qO/+ed+FA
=maa6
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
