From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/9] mmc: sh_mobile_sdhi: improve prerequisite for
 hw_reset
Date: Tue, 13 Dec 2016 12:08:35 +0100
Message-ID: <20161213110835.GF2773@katana>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
 <20161212195128.16633-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdWnhtQb6OyZ5Q-O3H4h+D2bWu=z2q=K2qY9oDfCZKxzeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWnhtQb6OyZ5Q-O3H4h+D2bWu=z2q=K2qY9oDfCZKxzeQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -       if (host->mmc->caps & MMC_CAP_UHS_SDR104) {
> > +       if (of_data && of_data->scc_offset && host->mmc->caps & MMC_CAP=
_UHS_SDR104) {
>=20
> For readability, you may want to add parentheses around the last check,
> and break the long line before the classical punch card line limit.

Your wish comes true in patch 7 :)


--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYT9azAAoJEBQN5MwUoCm23l4P/R/Fir6I7uDAb7ScBijYG1bb
xQUuH2bj+1hDxxxx4h954zpgJ1GPqR5ZLdVYSmDPnpiqWWd1T9Ajwbl53il0CC6T
e3rTp+h+dWOmRZP56L7V71pRXssmfYA+/Bcv3w8BnVFcO4or1sTihwNkajNlsP28
0urcbMVB+NSEANgXiVaFuFgkwWpl2Hbnkfpqs/3GL9RuDC/lPL7g6M8bkXs6Vn9n
Yhr1xLlKvYOxjcGZmDhs2AO1v0WZs5u2CHuuTULbYsSI3D2yaLNvLUjnqjLiGw6L
22RnygWIsB802aLOSkTr1+CQFVNlJTWjoiBQamuN3epp1cdQ6RFbfY0ZjgP91r5a
7j1Hti4n+r/HOOhgRoCCu3uWYWcX0L3DfHr8eLAbB0keRfqQ4Bjna4UiGZ884U7z
ki0sLmN0HXQdEGyv6Ae6k+rPfKBAnuxdxIMjPUZcB+30nhhuiUJ2iQJyRrVt/A33
ZdyqYML1A+FIOUq1GuZayrI4nrYcY/HbGirvoGTtdrvANA6QJ+Ugm9siyl2T5z25
2ZkXQ4KFP1gImFLKV8ExtVijzpngeziwup5g88IJEhqU1ZFkAGoQul8QH/14owdI
8mEmnX+frGY/T4/cU6LJA09VUCFouIBm+7pzrHq4DpSNZvrTbH8uGQxOO1Exm+p9
CxHWfp+Au3Fs6X8Rfscx
=EV3h
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--
