From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 4 Apr 2011 05:47:53 +0200
Message-ID: <20110404034753.GA1428@pengutronix.de>
References: <4D993199.1060206@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33857 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab1DDDr6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Apr 2011 23:47:58 -0400
Content-Disposition: inline
In-Reply-To: <4D993199.1060206@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 04, 2011 at 11:48:57AM +0900, Jaehoon Chung wrote:
> Sometimes we can't add the device,but we didn't check any error status.
> Need to check error status for mmc_add_host.

Thanks, this is correct, but...

> -	mmc_add_host(mmc);
> +	ret =3D mmc_add_host(mmc);
> +	if (unlikely(ret))
> +		goto err_free_mmc;

=2E.. you are leaking the irq and the lcd_classdev here.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2ZP2kACgkQD27XaX1/VRvt7gCeKU+GADq/waOAMS0aHLZayDh+
ivgAnjvaJlBLJSX9Vyrr4r/IMMEHEgss
=1wLq
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
