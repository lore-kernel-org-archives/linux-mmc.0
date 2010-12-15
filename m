From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 12:37:30 +0100
Message-ID: <20101215113730.GF3515@pengutronix.de>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
 <1292388576-25600-5-git-send-email-olof@lixom.net>
 <4D08A798.1070709@codeaurora.org>
 <20101215113528.GB2500@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33246 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab0LOLhl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 06:37:41 -0500
Content-Disposition: inline
In-Reply-To: <20101215113528.GB2500@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Return value is not checked.
>=20
> Good catch. Thanks.

It is checked in sdhci-pltfm.c ;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0IqHoACgkQD27XaX1/VRs9VQCgzLJj0SS8kYEhQ1oSeHFi3Dfk
0N4AoLD+TmD4ptRMdjZ+a82CcxKMh2tn
=Ml6H
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
