From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: renesas_sdhi_core: on R-Car 2+, make use of CBSY bit
Date: Tue, 30 May 2017 22:02:18 +0200
Message-ID: <20170530200218.q4s2dlrxusrdgpm2@ninjato>
References: <20170530090346.19088-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nc5ki6rvfvarmpxm"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530090346.19088-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--nc5ki6rvfvarmpxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 11:03:46AM +0200, Wolfram Sang wrote:
> Most registers need to wait until the command is completed, not
> necessarily until the bus is free. At least, R-Car 2+ SoCs can signal
> that via the CBSY bit, so let's use it there instead of SCLKDIVEN to
> save a little bit of delay.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Tested with a Renesas Lager board (H2). Moved big files around across dif=
ferent
> SD cards, re- inserted cards multiple times. All worked fine.
>=20
> @Dirk: can you do some additional testing for your use case? That would b=
e much
> appreciated!

OK, since Dirk told me he'll need some more time to test it anyhow and
Simon meanwhile sent some cleanup patches, I'll simply post an updated
version of this patch once Simon's cleanup patches hit mmc/next. I think
this will be easiest.


--nc5ki6rvfvarmpxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlktz8YACgkQFA3kzBSg
KbbYjg//by1IwNI2J4oayp9h8NiXAc3cFHiisuaCcwVEKPfh7sgI3pmrD84saSZM
IgsRfQMtwFQUCH3693dsNqwZMP+wMa1J0S65VGLpkek6mLurE9lRCgT0E1k8Vum5
841E3fO5WBqUYRzNaee51ItDv2SbkDDFT+Do5BJAEs2kVXf6NNIki1ecDUEXl1TP
+yj4SQV3GTSpAoS8/+X3hlQqIAHBUuogMoquHA4OAlIb+SoMXVuMDtnbWixf2S88
vLAVDorOUTJjzPelDI0XIwiyNYXMajplukk41TlJTFP1SbhS9HZIncWzrXQYJUU9
TCs7cTlFooWffviKoiSc6zJCuEE9oYvNDInZyMO0B/y4NMBQ3VhPAvjWVzTlOAdv
chVF+/YW7Y+scKPc8c+TfmDK7bQ4bh4unhMEPprHKh4cUREIphn3InN9di6R0I4W
KidGzOelrWzOitkJ3fICf6xuHiSRh5mthXUA6vT79FJTpJgWhh7+X3RYV465rhuR
Mptt8VhY/kmfmXPIZjErxfP1lJkgQBBRMz1HiTpbvCo/5a/texTExe0ouGGhyNm7
RTxqAs9H6u5CtbKcjWtQbWUKdY4P0vXiaAhnqhAbcq1B4wKkjO+rk+x5SdQgjP/n
uC+h0TEpueQbOIvTJ9DYoZMIzzSMvAQg2RjtWjV6EmUUrvwgOw8=
=bYUK
-----END PGP SIGNATURE-----

--nc5ki6rvfvarmpxm--
