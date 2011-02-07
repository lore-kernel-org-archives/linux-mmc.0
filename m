From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: sdhci: Replace SDHCI_QUIRK_NO_MULTIBLOCK with
 a platform hook.
Date: Mon, 7 Feb 2011 18:48:39 +0100
Message-ID: <20110207174839.GF3123@pengutronix.de>
References: <m3zkq9n115.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53865 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab1BGRsl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Feb 2011 12:48:41 -0500
Content-Disposition: inline
In-Reply-To: <m3zkq9n115.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 06, 2011 at 01:13:26AM -0500, Chris Ball wrote:
> Part of a quirk cleanup run.  This quirk was only used by sdhci-esdhc.
> This patch is untested.
>=20
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>

Hmm, for now I don't have a better alternative, but I somehow hink there mu=
st
be a better solution than to add one hook per

mmc->max_blk_count (changed by SDHCI_QUIRK_NO_MULTIBLOCK)
mmc->max_seg_size (changed by SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
mmc->caps (changed by SDHCI_QUIRK_FORCE_1_BIT_DATA and SDHCI_QUIRK_BROKEN_C=
ARD_DETECTION)

(and maybe this one also?)

mmc->max_blk_size (changed by SDHCI_QUIRK_FORCE_BLK_SZ_2048)

Will think about it...

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1QMHcACgkQD27XaX1/VRu5sACgsIZwRcbJwH64yAGnq6+Mdcma
N10An0713PSSYjNe+7UesOxZ8ZObTshI
=QONp
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
