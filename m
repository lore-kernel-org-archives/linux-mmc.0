From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Tue, 19 Oct 2010 17:07:43 +0200
Message-ID: <20101019150743.GA26784@pengutronix.de>
References: <1287492541-3060-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33201 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab0JSPHq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2010 11:07:46 -0400
Content-Disposition: inline
In-Reply-To: <1287492541-3060-1-git-send-email-eric@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org, r65037@freescale.com, shawn.gsc@gmail.com, linux-arm-kernel@lists.infradead.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2010 at 02:49:01PM +0200, Eric B=E9nard wrote:
> this patch fix timeout problems on i.MX51 as suggested by
> Richard Zhu.
> more tests are needed to check if this quirk can be removed
> for i.MX25 and 35.

Didn't you have such boards?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky9tD8ACgkQD27XaX1/VRsTCwCfXg9h4gIPTglmoOf2+jBDTFS/
fO0AnjgI7Z0QFcXU2oNP6Sz5t/tgS+TI
=aNKk
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
