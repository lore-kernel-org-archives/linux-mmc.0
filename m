From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 2/2] mmc: sdhci: disable MMC_CAP_NEEDS_POLL in
 nonremovable case
Date: Mon, 27 Sep 2010 12:23:54 +0200
Message-ID: <20100927102354.GB2664@pengutronix.de>
References: <1285576940-27587-1-git-send-email-matt@console-pimps.org>
 <1285576940-27587-3-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59429 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab0I0KX4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 06:23:56 -0400
Content-Disposition: inline
In-Reply-To: <1285576940-27587-3-git-send-email-matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>, zhangfei gao <zhangfei.gao@gmail.com>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 09:42:20AM +0100, Matt Fleming wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
>=20
> When a controller requires SDHCI_QUIRK_BROKEN_CARD_DETECTION, we poll
> for card insertion/removal, and that creates interrupts.  There's no
> need to be doing this if we have a non-removable card.
>=20
> This patch requires cards to be removable before we're willing to set
> MMC_CAP_NEEDS_POLL.
>=20
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Matt Fleming <matt@console-pimps.org>
> [cjb: modified changelog and code indentation]
> Signed-off-by: Chris Ball <cjb@laptop.org>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygcLoACgkQD27XaX1/VRtg2ACgoqXQrJrTBXO5r4FbqMRi8Ko3
0LoAoIaD8Iq67rannPTRjenMD6nUxDx/
=G6DQ
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
