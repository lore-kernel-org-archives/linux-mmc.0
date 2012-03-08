From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] sh_mmcif / PM: Use PM QoS latency constraint
Date: Thu, 8 Mar 2012 11:03:35 +0000
Message-ID: <20120308110335.GF3638@opensource.wolfsonmicro.com>
References: <201203040101.53177.rjw@sisk.pl>
 <201203042053.19314.rjw@sisk.pl>
 <201203080027.27435.rjw@sisk.pl>
 <201203080030.28965.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42081 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752679Ab2CHLDh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Mar 2012 06:03:37 -0500
Content-Disposition: inline
In-Reply-To: <201203080030.28965.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Kevin Hilman <khilman@ti.com>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2012 at 12:30:28AM +0100, Rafael J. Wysocki wrote:

> +	dev_pm_qos_hide_latency_limit(&pdev->dev);
> +

Shouldn't the core be able to cope with cleaning things up by itself
here?  It seems like it'd be easier/less error prone to do that.

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWJIAAAoJEBus8iNuMP3dVaQP/29IsZwjPn4kOGb9jDc8obhN
rEtIXqcB4wxd1sovz53Be7QE9vp30RrmssIsI2eTWoQtEKjNAsGkFi/q2ByRP00B
yQwxdcmZc0r12yF9sRdd+1u9XQwfkhJKDIgQ8VNO3LUTCmgyE1uOZss1jeRhV0g7
yReuV9zCds9/Vf2HQiRlumWSY9JuPn5hf8exyRzXAcdK/vcTguIZGGz/RWlywMdY
G7wtzOu0CMNWo7EptbNN3Cy4lWJhzXIPL56rh2Ofz2lRDd36og69UmWO/Rtw38nI
wkzpbbAsVoxg0wnhalLrCphgJ8RyG61umlCqelpTZ4Otl6vhfKR+sdgkvbGb55Nf
oNzEqLOx1OoVPTN6Fjc4ycfQE3hpFvzp6UHTEWsc/O3iTD/w0yfMusX+8CpJbZRu
hewk02OYlCXjadT1jkhjI0Q2fttkWy7SKiQdAbKDB8qcM9jUf5+mZo/U6QFXFIjR
AIkX7L3K5H6XJot8bJK0l/KU0vN5U964ysSi6QLBjcraz9ATqpj7eUFsojZG3GHi
F6oYI/ihZESP1Y+GqkFUVsCf6uGnGj+JHfc5onVXzHZM7bYKj06mCzvM/YYZB3Kt
T1NiRFjgx9sYp5A0HJhvcV/g0RuSlK2fr6DAHMGty6Sw8D10KlPDrIrDoI1v1Me3
poA6Wplb5JVbOFGJ7rOQ
=9s+V
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
