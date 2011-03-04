From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 02/12] mmc: sd: add support for signal voltage
 switch procedure
Date: Fri, 4 Mar 2011 12:47:32 +0100
Message-ID: <20110304114731.GB2227@pengutronix.de>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-3-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54718 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1CDLru (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 06:47:50 -0500
Content-Disposition: inline
In-Reply-To: <1299238369-1768-3-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, zhangfei.gao@gmail.com, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +	if (host->version >=3D SDHCI_SPEC_300)
> +		caps[1] =3D sdhci_readl(host, SDHCI_CAPABILITIES_1);

Now caps[1] can be uninitialized (didn't the compiler warn about this?)
Maybe

	caps[1] =3D host->version... ? sdhci_readl() : 0

(or simply an else branch)?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1w0VMACgkQD27XaX1/VRvBZACfX9k/e2qQtvjL4J/71Yl055tM
ULMAmgMQ+3aGgK4FVKmKUWqfE86soiyi
=gVCa
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
