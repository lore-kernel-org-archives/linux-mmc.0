From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v3 3/8] regulator: add pbias regulator support
Date: Tue, 3 Dec 2013 16:06:43 +0000
Message-ID: <20131203160643.GE27568@sirena.org.uk>
References: <1385043627-30439-4-git-send-email-balajitk@ti.com>
 <20131121144623.GA8120@sirena.org.uk>
 <529DFEA7.9010707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dYpzLy1CJFIhs6l3"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:47152 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab3LCQHE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2013 11:07:04 -0500
Content-Disposition: inline
In-Reply-To: <529DFEA7.9010707@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com


--dYpzLy1CJFIhs6l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 09:24:15PM +0530, Balaji T K wrote:
> On Thursday 21 November 2013 08:16 PM, Mark Brown wrote:

> >These don't match up with each other - the get and set voltage calls
> >should reflect what the hardware state is, not what was requested by the
> >caller.  You should be able to use the regmap helpers I think.

> get_voltage returns the min_uV, saved in set_voltage since pbias
> only need to programmed if the voltage supply in for pbias cell is less than
> or greater than 1.8V, so vmode bit will be set for 3V and also for 3.3V too.

That's the problem...

--dYpzLy1CJFIhs6l3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSngGQAAoJELSic+t+oim9i2UP/jVT/vtYhwqY/R3vaiABy/Eh
aShe9wqIJ5NR2ECzdZaJJUyoW9Dwyo3dH0d9MCaC1SGo0zEU7UFgGPJkHNiG6TS6
ppNGHgAa7fMkTOfGPlQ1jd/V4xQjP7utJLY7REjs7+jteUxGTL8BA7uYLwhkp0DM
NUU6CQg45hIicc2sgpTVR3UDiEBHYEySYTV8gh3vjKFTyKKhvHfQDCxoAXHLW0Us
S5v8sh6/7+vBOhLdou4KAlF+thbp9zCeHV3t4UOtmbwpkoeXa1ACKZznP5t61LV6
ieoq72ISLw8eKYEtTbX3UOmhjFjX5hKY2s6OizHpWmYvfP+3GBtoJuhYxCBVA6wN
ujTL9EpsAy64vEwXUj6SED4GdHm6n5RBq+g/ogZrWoEp8P//ohgtQ74xG4n4dJ+R
BURztzMMz+kP6D0RfhON9/s7fq5BND4ERde4cg9CyqQplLVABU7iq9dof4SkDiwG
mBpy/KnKT5Ojy9llktf1F9ITeB7tDPfbUV9o0ib2jgoZGfG45j/KngZ1XvwHa1MA
jv0KNdPUJ4opR2cMtMinQrvYqZYTiplAUm2EOBs1jmzvRG7BbpT7iJY+YZ6DYOmd
3CpDeOZfqY6evlHbNvh40hnzqc7SvrVjRUVAudCP4VvddU9vnY86JKwb4LtvZws1
BVIx+q0bSl6BrDWtYp0+
=PIqp
-----END PGP SIGNATURE-----

--dYpzLy1CJFIhs6l3--
