From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Fri, 15 Dec 2017 12:12:25 +0100
Message-ID: <20171215111225.ekrau5e27xknb3jf@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFqE7Pg8fJFyOtihdRnma+dFQd3+YPWGn6pXbpzhpERK9Q@mail.gmail.com>
 <CAK7LNASQfsnQY6henk5RvAysQUh3=cPXV1GPNeWeXgBxZvadAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g7cikj2kmyvg2af3"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNASQfsnQY6henk5RvAysQUh3=cPXV1GPNeWeXgBxZvadAw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--g7cikj2kmyvg2af3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> After 2, COMPILE_TEST will work correctly.
>=20
> Then, Wolfram mentioned we would need to include <linux/io.h> from tmio_m=
mc.h
>=20
> https://patchwork.kernel.org/patch/10074333/
>=20
>=20
> I was waiting for a patch from him.

Yes, I am sorry. I am currently swamped with I2C work, not so much time
for SDHI. However, I did this patch now and pushed the branch out to see
if buildbot is happy.

Ulf, this patch then in deed should ideally be applied before 1-8 here.


--g7cikj2kmyvg2af3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlozrhkACgkQFA3kzBSg
KbajhA//fGAnPpO2r3K7JdXdUzN11UE1vX7s78CWeLAVJwhczFOpKJiuKoxMgfHT
P3VPBHqaBfXqOFSaqc3xx8O3FbKBhOGNop7bC2U6Hc9Z/Y7ayjJ1BcsX2Hcbfs01
VHuFbrcZ7gaU+H/78eZa2D9uVzGFcx0CgMJ0z4QyzL1p1ekm8TXiGiJcUQaRM6ko
c51kYicGinFQ5+HcR+xMAJuIF3qMCTQ/BRUbTThhu6lOaFLXLmlY2snocE01kdcp
tMRbaA7Qi6OMx5Vjt8kBkqPB6pOXNFzgDvYLyUeJsL27mF2Fim8ZBvcftT2PuGFm
LCxDEIFJuNzzeKREw0HVf6zNuIssAfY6S0MjIzUsqk50oqPSSf/BCedspTExzrpw
4Q23SkEsDmtY833oruFbrYgfedgwlcZhBMYcqFzq1z+iHNY8X/hxRQn5uH47USUH
porpPODBQaCpOMeuvOsJSKV5vtVLe7cicc0EeZBA9JtEyTl5/8Uowytv+y487k6D
m6ruX+5gwBjeRMsF5isdpAMYMkQ29tQa72JnI4wm4+dI4l77TmfHHlY7Sr7HoQVu
MtW1J5gVQepGjpxzVA/Hn/9LtXRi3Aju0O4noE0ZOTSQZ75p1v2iakMkpAvsTfrM
279TxICSohwUK31JHUUauKbYiVustsPDB/J6FDY5+1512cfY/eQ=
=Nehq
-----END PGP SIGNATURE-----

--g7cikj2kmyvg2af3--
