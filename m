From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] sdhci: add quirk for max len ADMA descriptors
Date: Thu, 23 Dec 2010 12:26:06 +0100
Message-ID: <20101223112606.GB5044@pengutronix.de>
References: <1293096475-19634-1-git-send-email-olof@lixom.net>
 <1293096475-19634-2-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55334 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab0LWL0I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2010 06:26:08 -0500
Content-Disposition: inline
In-Reply-To: <1293096475-19634-2-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 23, 2010 at 03:27:54AM -0600, Olof Johansson wrote:
> Some controllers misparse segment length 0 as being 0, not 65536. Add
> a quirk to deal with it.
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>

I tend to NACK it (but I am not the maintainer). I'd prefer to see a
draft of your idea of a sdhci_add_host_fixup()-function :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0TMc4ACgkQD27XaX1/VRvfZQCePPASret/0KxTJveeJAK/Gxj7
eOAAnRKemmQZ8mxcT3m6wTfpDhrFmr3/
=3WtD
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
