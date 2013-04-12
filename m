From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 0/3] mmc: mxs-mmc: add cd-inverted, non-removable and
 broken-cd
Date: Fri, 12 Apr 2013 16:12:53 +0200
Message-ID: <51681665.5010303@pengutronix.de>
References: <1365585225-11360-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GUOUDODTJPUBNUMFAJKS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44015 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3DLONJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Apr 2013 10:13:09 -0400
In-Reply-To: <1365585225-11360-1-git-send-email-mkl@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, cjb@laptop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GUOUDODTJPUBNUMFAJKS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/10/2013 11:13 AM, Marc Kleine-Budde wrote:
> Hello,
>=20
> this patch add support for the cd-inverted, non-removeable and broken-c=
d
> property (as defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc=
 driver.
> Tested on a custom imx28 board.
>=20
> This series applies to Chris Ball's cjb/mmc-next branch.
>=20
> Changes since v2:
> - add Hector Palacios's patch "[PATCH 3/3] mmc: mxs-mmc: add broken-cd =
property"
>=20
> Changes since v1:
> - add Shawn's Acked-by
> - fixed typo in [PATCH 2/2] mmc: mxs-mmc: add non-removeable property
>   (tnx Chris)

ping

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2GUOUDODTJPUBNUMFAJKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFoFmkACgkQjTAFq1RaXHNEgACfb+GvllsCcC/sxIeFhqOlfnv3
HTUAn2ElNg1kLwHT8YGHg6jZrj3y7D0v
=BPPu
-----END PGP SIGNATURE-----

------enig2GUOUDODTJPUBNUMFAJKS--
