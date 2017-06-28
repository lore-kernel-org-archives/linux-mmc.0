From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v3 2/4] mmc: tmio, renesas-sdhi: add dataend to
 DMA ops
Date: Wed, 28 Jun 2017 16:34:37 +0200
Message-ID: <20170628143437.kjfk7rpaen6im6wa@ninjato>
References: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
 <1498053630-7780-3-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lfjejbl2bg756nk6"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498053630-7780-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--lfjejbl2bg756nk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 04:00:28PM +0200, Simon Horman wrote:
> Add dataend to DMA ops to allow DMAC implementation dependent
> handling of DMA data end.
>=20
> Also implement the operation for SDHI.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--lfjejbl2bg756nk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllTvnkACgkQFA3kzBSg
KbbY9xAAoNADJ1FmxZ63i4rmpimnaDhqMVfG0lHDrCQGLr39k2FTp1bDwQD4OOGO
RaRSFj7eN0/DbLYR9N51IzcAISQla5Z+s7yUkBC+021RS5JGacUvSkzjW24RNmm8
sewMpYF+yYo/N+XsHn8n0vb2CZ2/z96Zf727YYhSW12dDjwSeakZzEc/tmfi2LgF
la8eoMWQ/p19PDFlUqjuHnFd+ArfF4v2nfppnWiQ3DbcoZTjnV3Bp4/ZjoS2WSu9
zDk/Tm4AfSQAf8mbupmZoGaazV4Anf0E8Qndhy2EHk94UZnSpFDl3ZDBStnAM8AV
uSjQVIaCC0tMH1PMGtGkvGjFKD9MbPxg4IA0SgxFYvgZs8aIU9PG98xcdBrK+K2O
veKXJicc0HefIq5Uj+oXVwAQJ1lO2EHl7hKSCZIk98CumlWUbiYQjHNFeWKOuPP2
NNv3nvGRuWifoDpJWYw/w5F6T+NnrHKMb2ZriptBn+iLsodyth1nncDjhkFtHqDJ
yTtxBSDQ6xKn5grvBXFAGtV7mOG3c2wGnyvaBUdCo2TLEtlNu8sI94gVyXOD7aEh
C8iEDuYHOu44uJF8bsZd/NdhXlOWJd1xmJDp4bQTmFarjBfhvEcj54/JEU8WITHK
XZMLrXjP3ISK/pix2GD4u4fRnYhbnMZpyEBiEtpLgR9J66LmUg4=
=FTQt
-----END PGP SIGNATURE-----

--lfjejbl2bg756nk6--
