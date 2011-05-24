From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 2/7] mmc: sdhci: eliminate sdhci_of_host and
 sdhci_of_data
Date: Tue, 24 May 2011 21:26:13 +0200
Message-ID: <20110524192613.GA25727@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46426 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1EXT0V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 15:26:21 -0400
Content-Disposition: inline
In-Reply-To: <1304601778-13837-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2011 at 09:22:53PM +0800, Shawn Guo wrote:
> The patch migrates the use of sdhci_of_host and sdhci_of_data to
> sdhci_pltfm_host and sdhci_pltfm_data, so that the former pair can
> be eliminated.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

We might be able to get rid of the migrated entries in sdhci-pltfm.h, but t=
his
is a task for later IMO.

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3cBlUACgkQD27XaX1/VRsn3gCdHYNVwx8eKSD/hq4IJUyCEbUu
1voAoLnI6BfV2jruGUeJnGeBJXnELkiB
=BQlA
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
