From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [patch 1/1] sdhci-base-clock-freqency-change-in-spec-3.0
Date: Tue, 14 Sep 2010 15:45:39 +0200
Message-ID: <20100914134539.GE2629@pengutronix.de>
References: <AANLkTims_z+X_bOK2v3AekBZWg1LsSecRCUeAi5HGseW@mail.gmail.com>
 <20100914131853.GC17079@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51919 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab0INNpr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2010 09:45:47 -0400
Content-Disposition: inline
In-Reply-To: <20100914131853.GC17079@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2010 at 02:18:53PM +0100, Chris Ball wrote:
> Hi,
>=20
> On Fri, Aug 20, 2010 at 02:22:56AM -0400, zhangfei gao wrote:
> > From: Zhangfei Gao <zgao6@marvell.com>
> > Date: Fri, 20 Aug 2010 14:02:36 -0400
> > Subject: [PATCH] sdhci: base clock freqency change in spec 3.0
>=20
> Thanks, applied to mmc-next.
>=20
> We should have all of the changes required for SDHC 3.0 (8-bit wide data,
> 10-bit divided clock mode, base clock frequency change) present in the
> mmc-next tree now.  Would someone with access to 3.0 hardware be able to
> test that it's all working?

Is the 8-bit support really according to the standard? I wonder because
the bit currently used by sdhci.c is marked as "reserved/new assignment
now allowed" in the simplified v2.0 spec.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyPfIMACgkQD27XaX1/VRtWkACeIyKQyx02J5ENkac22GraEzAz
tAEAoKDMYQ4FrSl+3ObZZOQTCvRyPkgu
=LdMP
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
