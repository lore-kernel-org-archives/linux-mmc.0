From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V7 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Tue, 22 Mar 2011 09:54:29 +0100
Message-ID: <20110322085429.GA2134@pengutronix.de>
References: <1300684936-8218-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300684936-8218-5-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110321130844.GG9686@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900D32B1@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35678 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab1CVIyb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 04:54:31 -0400
Content-Disposition: inline
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900D32B1@039-SN1MPN1-001.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <R65037@freescale.com>
Cc: linux-mmc@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

(please don't drop the list)

> I saw that some ones are discussing the implementation of the ACMD23 in t=
he community.
> The new command introduced by SDHC spec3.0.
> This feature can solve the concern that mentioned by this patch.
> http://www.spinics.net/lists/linux-mmc/msg06428.html
> If the ACMD23 is implemented, the predefined-block number multi-block IO =
can be achieved without any confusion.
> It seems that the ACMD12 would be used in the another multi-block IO mode=
 in those serial patches.

So do you want to carry this patch until SDHC V3 is mainline and then
change or do you prefer to skip this patch altogether?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2IY8UACgkQD27XaX1/VRuC+ACeO5w+XTIqk8TnUPIGNV6B+0rv
7qwAnAu54yEvsPjK5kz3wRK2O2o4KfSa
=WgmL
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
