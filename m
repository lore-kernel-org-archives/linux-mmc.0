From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/3 ] mmc: add support for h/w clock gating of sd
	controller
Date: Sat, 4 Dec 2010 22:02:13 +0100
Message-ID: <20101204210213.GA671@pengutronix.de>
References: <3C50EC54-F380-4AE8-A417-4D3557FEB588@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36979 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab0LDVCP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Dec 2010 16:02:15 -0500
Content-Disposition: inline
In-Reply-To: <3C50EC54-F380-4AE8-A417-4D3557FEB588@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Linus Walleij <linus.Walleij@stericsson.com>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

minor comments in addition to Nicolas:

On Fri, Dec 03, 2010 at 11:26:50AM -0800, Philip Rakity wrote:

> hardware clock gating is enabled by setting the mmc quirk

It's not a quirk, it's a capability :)

> MMC_CAP_CLOCK_GATING_HW

Why not MMC_CAP_HW_CLOCK_GATING? Might be a mileage, though...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkz6rFUACgkQD27XaX1/VRt9JgCgjqYjUhnSZhGnz8piT5vv4FO/
nawAnjyjypMYLEYEJeKoZTf8fMjdBdq7
=yMUt
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
