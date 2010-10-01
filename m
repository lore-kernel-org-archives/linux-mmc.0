From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
	sdhci-pltfm driver (V3)
Date: Fri, 1 Oct 2010 09:07:45 +0200
Message-ID: <20101001070745.GA17812@pengutronix.de>
References: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com> <20100930232526.GA29636@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49951 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478Ab0JAHHw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Oct 2010 03:07:52 -0400
Content-Disposition: inline
In-Reply-To: <20100930232526.GA29636@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Giuseppe CAVALLARO <peppe.cavallaro@st.com>, linux-mmc@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Looks like we're waiting for a version of your STM driver with final
> changes from Wolfram's review -- do you think you'll submit that soon?

If I didn't forget something, he won't need a special driver. Just a
platform_device with the standard pltfm-driver and a custom init-function a=
nd
quirks. The latter go into the board-configuration.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyliMEACgkQD27XaX1/VRtEjQCfUt118lSHSYck8YWWeUKP+Cyv
NrMAnA4gp8cRaTfc27Gy6OApOIfEckG7
=RYBT
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
