From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Fri, 15 Dec 2017 20:08:48 +0100
Message-ID: <20171215190848.bgazsmoqeznslv3a@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFqE7Pg8fJFyOtihdRnma+dFQd3+YPWGn6pXbpzhpERK9Q@mail.gmail.com>
 <CAK7LNASQfsnQY6henk5RvAysQUh3=cPXV1GPNeWeXgBxZvadAw@mail.gmail.com>
 <20171215111225.ekrau5e27xknb3jf@ninjato>
 <CAPDyKFopKm2psU19vGQfGL6WizXQA0vvzQubqsypvytbpRtyAA@mail.gmail.com>
 <20171215163055.vxxiswgsvfybf4hi@katana>
 <CAPDyKFpUE1s8+OXuyyRszFnpt5CN4G8d2vhwRhs-PkaL_VU7oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uubogp6tuzuz7bos"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpUE1s8+OXuyyRszFnpt5CN4G8d2vhwRhs-PkaL_VU7oQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--uubogp6tuzuz7bos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Other thoughts?
>=20
> Nope.

I have :) Another solution seems to be to switch to ioread16_rep and
friends. Those are defined on sparc64. Compiles locally here, now sent
it to buildbot.


--uubogp6tuzuz7bos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlo0HbsACgkQFA3kzBSg
KbaiiBAAoNKL9++dgkoAWR6E/qNQs1e4rkl1e8W1SUbRUpTqotJc2/XQg1FGrNst
bLz6myWJjHp9t9OxEwm9rpbGUgi232wG7skr7LmwkgkTeE9Pd3/gKfD+FlevGULE
GYKr62GXfr1+gpvVgAdFYrOvWGj6Oy1CYdXqo21Q9wB0B49ji7DCtbtlVN8wUBh+
OftQcm507KZZnraqqNhZvtTbUhXXFEFwJXTkW0F8KvhBnAhUgYUgxXPeh7H/1Pfs
9yDV9dvn6U1BZmOSKJ9kX0zor9f2mlNRr7456JMdxKsV1CVTe0nnafKpthfcpf+X
3/9JgricV1tcTp2cpZR2PHk0VowsxhCaVKRVoYHTXMjbleORHqXNFPyg/UQdQ2/E
XbwhSSWSic1m1otyWLvHv51vzwVVxyh+X+v/vj7bbQG78Rf7xjEfaXSH5ZMV/kyx
CiwyoPErABfCJ70fXPGpKmiArychV5STXfkh+8Gopv0Xsa0iJqD7OhD2Tm3kzF1e
WNutmo9tzrKY5N/RCtFnr9gAhci33uRPkEwOWkvB/DR2HrqnR5RaasutULWDr5ic
C4LHeXkCni/Alaa8daZ9nmqv9rv3dSTGqsbHF9RtkaQ70LNPutjdyUTa/oByVf7w
2pHlBgGBtF2zMpDffzs8cMPWBft5Rg+YGzlOhc4qMLUTpSUBRj0=
=GTkV
-----END PGP SIGNATURE-----

--uubogp6tuzuz7bos--
