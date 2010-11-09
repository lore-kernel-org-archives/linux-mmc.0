From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Fwd: can we remove the quirk
  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN ?
Date: Tue, 9 Nov 2010 12:55:17 +0100
Message-ID: <20101109115517.GD3223@pengutronix.de>
References: <4D68A6A7-2D95-463F-875B-DB52ECCC53F1@marvell.com>
 <65EBF3EE-DE1E-46A4-BF41-A9D5A6096673@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57932 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab0KILzT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 06:55:19 -0500
Content-Disposition: inline
In-Reply-To: <65EBF3EE-DE1E-46A4-BF41-A9D5A6096673@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zhangfei.gao@gmail.com>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 09, 2010 at 03:45:15AM -0800, Philip Rakity wrote:
>=20
> reposting since we are discussing removing quirks.  =20
>=20
> We could partition the quirks into one set for controller quirks and one =
set for platform quirks.  That would give us another 32 quirks.=20

IMHO we need less quirks, not more. Adding the number of potential
quirks just delays the underlying problem. Also, unless someone
enlightens me, I don't think there are platform quirks, only
platform_data?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzZNqUACgkQD27XaX1/VRtdlQCgqePclcbOaJuwrNg0OoPyMM53
RzgAn3CB2LGR1sVBR/5OVxt1/NeGxTr7
=5vl2
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
