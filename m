From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2 v2] eSDHC: Fix errors when booting kernel with fsl
 esdhc
Date: Fri, 9 Sep 2011 11:07:27 +0200
Message-ID: <20110909090727.GH1912@pengutronix.de>
References: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
 <1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
 <20110722101512.GA1576@oksana.dev.rtsoft.ru>
 <2239AC579C7D3646A720227A37E0268118FD3B@039-SN1MPN1-005.039d.mgd.msft.net>
 <20110812100450.GA23333@oksana.dev.rtsoft.ru>
 <2239AC579C7D3646A720227A37E026811A1F8D@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37345 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933053Ab1IIJHc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2011 05:07:32 -0400
Content-Disposition: inline
In-Reply-To: <2239AC579C7D3646A720227A37E026811A1F8D@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Xu Lei-B33228 <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421 <B07421@freescale.com>


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I would do it in the IO accessors.
> >=20
> > Thanks,
> Any update for your comment?

It is still valid. You can go that road.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5p108ACgkQD27XaX1/VRvIBQCffGKejoGw9ddEjayX38ZnzzXs
CUIAn3n1SHj50BgI6OV4liBgPzO7h/7N
=gdxp
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
