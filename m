From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: renesas_sdhi: rename DTRAN_MODE_BUS_WID_TH to
 DTRAN_MODE_BUS_WIDTH
Date: Mon, 15 Oct 2018 00:27:32 +0200
Message-ID: <20181014222732.GA3260@kunai>
References: <1538566780-30794-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538566780-30794-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 08:39:40PM +0900, Masahiro Yamada wrote:
> Socionext UniPhier SoCs use the almost the same internal DMAC.
> My datasheet says 'BUS_WIDTH' instead of 'BUS_WID_TH'.  I suspect
> this is a typo.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Already fixed in mmc/next.


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDws8ACgkQFA3kzBSg
Kbae0hAAk1ud4fQ9XRysjZGWzFaoGAk9vpJ/kzPlXu1xTq6gA90U+j6tJ9yOi6DK
FjnExPdUTtdpHeZ5jbwAmZQbJJObHhkpXBQMPyesRJkfdwo9Ne6oTGuefZayjL4M
x4UnYpp64xvnageUNEsu5zAgq5sx8TEnN1Ru69G0KnRhE7CXgqVNU2QFsgKpLQ6c
PqHd3imb4JqXmYHeWlcsHLWY5qz6FfbSqz9oADml8w092FoaE1MMqicFwk6CUTBy
0TTLOajVxBg1/V0rXUSFqYtBjsZApU7CERHoiWs+WmeTWk5qRRXLLUBx6d97pD8s
PjAPLUn0FAvVkQTjO63Utw3Z3MutyFSIpdPYe411ytFLCzCWPMECFeOObEh6tta+
o5izZrh7fYBFJEyPOYelRVxFN4NlUfvBPGuMB7Pvw0n6Yqs6OPBWF6MlZLqsCH3I
tu9JJ0Vr2NSfBTPrnbIL+oatdW/Ih3cJDkx/By+5WORkpJrTmOGiJOzR0xBeIlxY
hZ9ntYyPjE3EbjyjYh5FeTw+rOI+siFtg2zh5btXgz6Qf3Jk1wJf5wJvbJRG2FH2
cUtlX1Wsg9jL5gulUH3tQIbbqEQVm3p8t9bE85vXeu799QU7EwD+pMoqpM3T1fDc
6e5pDlxGkzKQPHFqHwNcQQK7CeYseQuyhyAEmFD0gl8nAzypVdQ=
=TH/1
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
