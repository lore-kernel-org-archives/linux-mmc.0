From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3
	sd controller
Date: Sun, 7 Nov 2010 23:04:11 +0100
Message-ID: <20101107220411.GB5376@pengutronix.de>
References: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60491 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab0KGWEN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 17:04:13 -0500
Content-Disposition: inline
In-Reply-To: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 08, 2010 at 12:31:34PM -0700, Philip Rakity wrote:
>=20
> 8 bit width is a new feature in the sd 3.0 spec.  Add checks to
> ensure HOST_CONTROL register set 8 bit mode only if sd 3.0
>=20
> add quirk to indicate that board design supports 8 data lines.
> The controller can support 8 data bits but the board design may
> only bring out 4 data bits.

This isn't a quirk, this is platform_data, no?

Without looking deeply into it, I think we need to use the callback you
introduced in the other patch?

Regards,

   Wolfram

PS: Sorry if there already was a discussion I might have missed. The bus wi=
dth
thingie became a bit scattered, so I lost track...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzXIlsACgkQD27XaX1/VRs+kgCgl+7TLPq+IsiZcU+v2Z2AZLWc
XOIAoKeOrJFkKzUU2X25YcgJZgpHKpRE
=93Nt
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
