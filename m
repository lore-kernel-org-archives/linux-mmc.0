From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Revert "mmc: sdhi: use maximum width for the sdbuf
 register"
Date: Thu, 3 Aug 2017 11:53:55 +0200
Message-ID: <20170803095355.GA3251@katana>
References: <20170803094947.1490-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170803094947.1490-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Biju Das <biju.das@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 11:49:47AM +0200, Wolfram Sang wrote:
> This reverts commit 785b215250310c690142abb1bdbb0767b8487c49. There is a
> secondary SDHI instance on Gen2 with has a 32-bit wide SDBUF register
> while all other registers are 16 bit apart. So, the logic used here does
> not apply and we need to rethink this and start cleanly from scratch.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Extra info for Ulf: I can't work on that in the next days, so I thought
it would be good to ASAP fix the regression in mmc/next at least.


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmC8q8ACgkQFA3kzBSg
KbbcKw/9G9vZkXVPp+y9eGdmHpL2i2rIh2MWgoq7KSCQvk7hGCuoBLK2GHSeHg+n
a+/SnTdkcYR0Aw7MoEsh3khQLhHe5AYRbdla+r7LqgP5SQ/ganpiHWo869NjNLRw
nbbd0+gIdJ6v34x+BGVyyBRX4nit7YsUP68bzB5J+1cAFwGBwmFEYvnVLsP7A4hj
66wZ9a6rk9/gb0Ac6H4LCNZKumYNOLiY+uQHxhNyvRGOqGa3pNzUnsJwMiIlLcBa
xpvFvMxPf0CoWDNrGk5AAnZtjQtVukQjzdAOYanac8+DYdVuyvUY6KZiq3faN0my
40rXj5p/6P0Jp/pGB23bQaAflxp1ch3Z9Tgtlo24lLLp5E8fMvlrh+9j4uASWX8H
/MhQGrGgdnelaZ6h7GDRer10Yw8q0y37S8LGCWzuETVMKkDaVpw+TK6Lf5GcjTqo
m05BoYH2RXkhGsLl1C6oQIJydTW3qlWx8O5gsf0AZZg1+uvQmbD0pY4T2XMJxTqJ
Bww36BcgqOdiOgpm+DCtuOBUNLQ/bc6TayYI3PsZAuXbTKwoNb/Z7vAK2udWGoQu
cQbteOWpiIhJ2qEZQTnzBmoXcxwjcgOS5luK294kcB1k/RwFTf/yQ+H73oA+ig7C
Xy2Fg25rpvUgDChl9UxpV56yl/Nc3UBue8j0Tvcu5yyeWphX8bs=
=fGZs
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
