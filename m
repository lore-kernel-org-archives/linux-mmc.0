From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] mmc: sdhi: fill in actual_clock
Date: Tue, 3 Sep 2019 17:25:29 +0200
Message-ID: <20190903152529.GB6718@kunai>
References: <20190829183634.3376-1-tszucs@protonmail.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190829183634.3376-1-tszucs@protonmail.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 08:36:34PM +0200, Tam=C3=A1s Sz=C5=B1cs wrote:
> Save set clock in mmc_host actual_clock enabling exporting it via debugfs.
> This will indicate the precise SD clock in I/O settings rather than only =
the
> sometimes misleading requested clock.
>=20
> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>

Oops, I thought I replied already. For the record:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1uheUACgkQFA3kzBSg
KbaCwg/+O2P7U/V3PSUWunSFkHZg7dqiAeb5loMjy2RYmUnjrc7PCir2Cb44mRkz
Tyz9XMXpx3g+7VtqUNHG7pj76M7em1OdiulP631pOUroRmVzfo8vpEu/JJlGTAhG
cymJ5x4KSaBA5itAdYWa4TbIdIxfDTxCNkxdZvvpI8LwR5TZ6anPXgwZwQBeYEhk
jyFbyPgoa7ipivVCJKtNCIlxzWPvTOwNiOD/Y8AwL4MdvTXXqdIM6yD6lhao9wm2
+HaSrMYLX9yv0sFBP2OyOpB3tgTPtsyj9MTjYpffzvy/BVeombUE2qYJg2uuOAda
rcUWQNST5hMRoblcWaLoh1pEX5DiuDeV0J9x5x3cnuRAQnpevPo4mli/GLTyaZYB
nklFBJMhr3Yi9cXrnBYmtNvOnm8A6pjo7ML8G/5q3d1+LrqqMEEE2totRFs7/bw/
CXYhW5Y2/m3VEhPflPwq8nzg5jycVegtm9dz7FphAGvYuzCVY0zbggMNPVkBiTbS
RNZJGmlepoJJiR126SOJDNYyedH8zuHpj2DFazOZlfi+aBAehNBoGAmDJTiOzHrf
hXdhPFENueQgdu0nJ71mYNwqatqiYTgcPfSEA5mFV8g2ji5xsS80alB97neoODKS
lBCuQAWSwPF0oPQlTYgRhpd81h+9gYa7IX1SQoAeLIlQoCBo/lE=
=0Ztz
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
