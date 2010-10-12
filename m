From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2] mmc_rescan: reduce verbosity
Date: Tue, 12 Oct 2010 10:41:22 +0200
Message-ID: <20101012084122.GA4470@pengutronix.de>
References: <20101012060045.GA8252@pengutronix.de>
 <1286868577-7729-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40943 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757029Ab0JLIlX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 04:41:23 -0400
Content-Disposition: inline
In-Reply-To: <1286868577-7729-1-git-send-email-eric@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2010 at 09:29:37AM +0200, Eric B=E9nard wrote:
> since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
> includes a pr_info which prints 4 lines each second for hosts configured
> with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
> This patch enable the log only if CONFIG_MMC_DEBUG is selected.
>=20
> Signed-off-by: Eric B=E9nard <eric@eukrea.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky0HzIACgkQD27XaX1/VRuovwCaAuan3NjpLf3onNDEraBmDimY
KtQAnRAFZQOYSyuCeaYRrxRuf9IMt0i0
=OnRv
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
