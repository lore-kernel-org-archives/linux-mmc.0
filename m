From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 1/2] mmc: Add helper function to check if a card is
 removable
Date: Mon, 27 Sep 2010 12:23:21 +0200
Message-ID: <20100927102321.GA2664@pengutronix.de>
References: <1285576940-27587-1-git-send-email-matt@console-pimps.org>
 <1285576940-27587-2-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59416 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab0I0KXb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 06:23:31 -0400
Content-Disposition: inline
In-Reply-To: <1285576940-27587-2-git-send-email-matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>, zhangfei gao <zhangfei.gao@gmail.com>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 09:42:19AM +0100, Matt Fleming wrote:
> There are two checks that need to be made when determining whether a
> card is removable. A host controller may set MMC_CAP_NONREMOVABLE if the
> controller does not support removing cards (e.g. eMMC), in which case
> the card is physically non-removable. Also the 'mmc_assume_removable'
> module parameter can be configured at module load time, in which case
> the card may be logically non-removable.
>=20
> A helper function keeps the logic in one place so that code always
> checks both conditions.
>=20
> Because this new function is likely to be called from modules we now
> need to export the mmc_assume_removable symbol.
>=20
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygcJkACgkQD27XaX1/VRtX6QCeJvLNiPgisRR5rUYzXeSS+dYP
RFwAn1//HbI1yIrdvOWjlKhVgV0UXhSn
=lmEa
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
