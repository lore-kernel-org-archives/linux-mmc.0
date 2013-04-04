From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: mxs-mmc: add non-removeable property
Date: Thu, 04 Apr 2013 16:25:42 +0200
Message-ID: <515D8D66.2040402@pengutronix.de>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de> <1364223751-28253-3-git-send-email-mkl@pengutronix.de> <87r4iqpey3.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UVDCXFUNAABORXOPTLLM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43049 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761625Ab3DDOZ7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 10:25:59 -0400
In-Reply-To: <87r4iqpey3.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UVDCXFUNAABORXOPTLLM
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/04/2013 04:07 PM, Chris Ball wrote:
> Hi,
>=20
> On Mon, Mar 25 2013, Marc Kleine-Budde wrote:
>> +	host->non_removeable =3D of_property_read_bool(np, "non-removable");=

>> +	if (host->non_removeable)
>> +		mmc->caps |=3D MMC_CAP_NONREMOVABLE;
>=20
> The correct spelling is "non_removable", as used in the DT property.
>=20
> Thanks,

Will fix.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2UVDCXFUNAABORXOPTLLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFdjXAACgkQjTAFq1RaXHPQKwCfTEhnW4BzuDb8WDsSa8EkUf5y
OQ0An0Z8ROUCxJE/pG/qSdI/o41rXVHb
=Xy1Y
-----END PGP SIGNATURE-----

------enig2UVDCXFUNAABORXOPTLLM--
