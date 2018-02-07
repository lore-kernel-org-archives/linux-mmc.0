From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 05/16] mmc: slot-gpio: add a helper to check
 capability of GPIO WP detection
Date: Wed, 7 Feb 2018 20:06:25 +0100
Message-ID: <20180207190625.vaosboluf2jcfop6@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-6-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7thxwjmuytw3bn4e"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-6-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--7thxwjmuytw3bn4e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:05AM +0900, Masahiro Yamada wrote:
> Like mmc_can_gpio_cd(), mmc_can_gpio_ro() will also be useful for host
> drivers to know whether GPIO write-protect detection is supported.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--7thxwjmuytw3bn4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7Ti0ACgkQFA3kzBSg
KbaKTw/9HmgEMusxqOgs1VlPUaSP1ydOlIDZXQc7Ff8M2JAQlu42xqmmu+UY6GLj
6eiXKSgSpnYONORI3B1VhCrNPwOPPzeV579B8mSL8dGs4iP9AEYAdbhayVzukMnG
qYiCRRGZMAQkSOhG4euhrrEeqDKiqMuBshWBI90df/fNseQqoLDkTzYKs4k0qpA/
eoewx0Q3U3P5kN6paT4FX1REMmJZj2yTHNoosWicChrr7pxpQkCsTaR+i5ezzVKN
Hvl4Gp16PuK1gZYjALNAKBWQRxMxWjMN1DxZ8tqSrNSsvN5bn8R2NlUr/5REYp4c
IdBxdnZbU5cxXGCrjz3s++ZmW8sMf9BwEk+tZwCutiIgjPu2402dgUy1R/MHN6ZE
YvcVrhuhxRKgyLrbwW/q2ftsICUVmhB3El2yqkVmDANJWIr+yUdWs1dg1+/X6Cbb
QPRZIPukKfxHbzMElRQe0eFKHxTv4q7Exn2U+NU721q64NTV+ExJUHItMNyN97n8
i+T9wfdcvxWGsRkaI+G/UCgOb/7bQEQPSF1wBrgnjUEPYjVHUZj4GT+pPPHLeCbw
yPH0q4SYgtApXXqGAMTK2vMjzouriVesyrYLOvHlsPdzJEI7y1NM93MhNuQu1KiV
WJXLy0wfRjI6TDmnbmranN0DY3crWLj3EiI1kYTtd3eHiEWpIho=
=wfCH
-----END PGP SIGNATURE-----

--7thxwjmuytw3bn4e--
