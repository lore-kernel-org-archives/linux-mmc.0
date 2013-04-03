From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] mmc: mxs-mmc: add cd-inverted and non-removeable
Date: Wed, 03 Apr 2013 09:56:41 +0200
Message-ID: <515BE0B9.4010209@pengutronix.de>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2RCWWELMTGKQJBFFRLAQN"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40098 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629Ab3DCH4v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Apr 2013 03:56:51 -0400
In-Reply-To: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RCWWELMTGKQJBFFRLAQN
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 03/25/2013 04:02 PM, Marc Kleine-Budde wrote:
> Hello,
>=20
> this patch add support for the cd-inverted and non-removeable property =
(as
> defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver. Test=
ed on a
> custom imx28 board.
>=20
> This series applies to Chris Ball's cjb/mmc-next branch.

ping

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2RCWWELMTGKQJBFFRLAQN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFb4LwACgkQjTAFq1RaXHOA+ACgieZ/CLy6N4iOx0a4ehJi6hDI
uMIAn0/B+thWoPBGVC9W1/QGvdfj88jH
=MmEy
-----END PGP SIGNATURE-----

------enig2RCWWELMTGKQJBFFRLAQN--
