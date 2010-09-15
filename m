From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [patch 1/1] sdhci-base-clock-freqency-change-in-spec-3.0
Date: Wed, 15 Sep 2010 12:10:19 +0200
Message-ID: <20100915101019.GC5985@pengutronix.de>
References: <AANLkTims_z+X_bOK2v3AekBZWg1LsSecRCUeAi5HGseW@mail.gmail.com>
 <20100914131853.GC17079@void.printf.net>
 <20100914134539.GE2629@pengutronix.de>
 <AANLkTi=7gXkF+JpOfM+KaWxHPDzT=0SL5oSXDw0hTmJm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34758 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0IOKK1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 06:10:27 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=7gXkF+JpOfM+KaWxHPDzT=0SL5oSXDw0hTmJm@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2010 at 11:35:18AM +0800, zhangfei gao wrote:

> > Is the 8-bit support really according to the standard? I wonder because
> > the bit currently used by sdhci.c is marked as "reserved/new assignment
> > now allowed" in the simplified v2.0 spec.
>=20
> Attached capacity in sdh 3.0.
> 6-bit base clock frequece is support in 1.0 and 2.0, support 10M to 63M.
> 8-bit is supported in 3.0, and support 10M to 255M.

I meant 8-bit bus width. Which bit in which register selects this?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyQm4sACgkQD27XaX1/VRuafACgxxhhat+eHjTEFspi+Nwn3/K8
gVsAnRuhxy2C452n57jxhDDYdNdtZrP6
=H7hA
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
