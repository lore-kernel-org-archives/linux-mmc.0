From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/3] mmc: renesas_sdhi: add eMMC HS400 mode support
Date: Wed, 7 Feb 2018 23:26:30 +0100
Message-ID: <20180207222630.r3axjxia3mflk5qk@ninjato>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fh745hr6bgncodpl"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119133906.11280-1-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--fh745hr6bgncodpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> * [PATCH] clk: renesas: rcar-gen3: Fix SD divider setting

I tried to address this one before:

[PATCH 0/3] clk: renesas: rcar-gen3-cpg: updates to SD divider table

but this had problems with H3 ES1.0 :(

I haven't yet compared the above dependency patch with what I did back
then. Will need to do that hopefully tomorrow. But as I read it, it
worked fine for you on H3 ES1.0?


--fh745hr6bgncodpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7fRUACgkQFA3kzBSg
KbZFRBAAikp4wg3DlNHtvG+z2TIzTeor68iAOFfCIqOTGvv3z2zAuhrPwmN2o5Qu
61KhSJf7aMDrnAc7wnu/yPBNan/N53hly1+RNlTEnIXYRZsLET4m3Ro1KrpD6A6M
Okon9CSrLj3BtPp6JYvRbH7okRtTL//JEL4O2Un1n48K2AmRMwHHhWnkXquEGdKp
+yLiw9hdrN+gqIwXgP2sPENW7o7KimsEOpt2tiSk4mdg70UG1pmk7/0BgLQeO+AH
SahKtexkc/1VxloRxyjW5r5a//iLDQmlch7MrZXArWbmG8pLBZ7hRvC4po8VIn/l
XB6VqT85Qynytsh/kI4uKW/RWNI4vl/bwkICPsP0p9a7I0/qnZOyjyzQubqD8SpD
dTcQ457bdYGkUDd81KHCUSOQE/DtCJ31gdtquYhdTxv9X+B4QCPKzhcueO1eybPk
gWcNbjgwnsgODjP5lhwOhdPkz0SzZFPuJJ16AVEaXHJ200sv9nMWVNQ+Ra/cXzle
b2QUBWVOp8mdTnGG1oO6wretJkNNCdGFXmOKivfrFw+p+fWr1uFbAh2SY1Gc3yxo
CWkuBju/y/Pqqwbtd780S1t22ned1Vy4qxqSn8CURIPYaJWyP1Qk/iVTC6UkTpro
KaISYWlglBv6jehrFQq8C8e4yhblvqv2RnsXhmYivWy4Vl3MQp0=
=bj8C
-----END PGP SIGNATURE-----

--fh745hr6bgncodpl--
