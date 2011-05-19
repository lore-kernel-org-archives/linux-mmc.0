From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get
 them self registered
Date: Thu, 19 May 2011 11:40:46 +0200
Message-ID: <20110519094046.GA2219@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49996 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864Ab1ESJk5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 05:40:57 -0400
Content-Disposition: inline
In-Reply-To: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> Changes since v1:
>  * Rebase on cjb's mmc-next tree

Is it maybe possible that you get access to
http://opensource.freescale.com/git or another machine? A branch to pull
=66rom would be more convenient, because the series does not apply to
mmc-next anymore, so an extra step to go "back in time" is needed.

(minor) When applying I got:

Applying: mmc: sdhci: make sdhci-pltfm device drivers self registered
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:384: trailing whitespace.
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:817: space before tab in=
 indent.
 	struct tegra_sdhci_platform_data *plat;
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:867: trailing whitespace.

Applying: sdhci: rename sdhci-esdhc-imx.c to sdhci-esdhc.c
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:780: trailing whitespace.

See later comments for further issues.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3U5Z4ACgkQD27XaX1/VRvTrACfeBXJzoQO911nMrx10wtlkXDw
p1EAmwYXFQH6XMdjXZLuJRLA5pDE3h9o
=tg5z
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
