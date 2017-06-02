From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: SDHI clock imbalance
Date: Fri, 2 Jun 2017 11:37:01 +0200
Message-ID: <20170602093701.3kn52zfmpgy7kcqo@ninjato>
References: <CAMuHMdX7_u_3TFK22inUp367LR3R77S72RAtRWPFnKE9-cUtpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftgcce6j3vacwgov"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX7_u_3TFK22inUp367LR3R77S72RAtRWPFnKE9-cUtpw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--ftgcce6j3vacwgov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

> While investigating suspend/resume for the R-Car Gen3 clock driver, I
> noticed a clock imbalance for SDHI on Salvator-X.

Thanks for the heads up! Which branch did you use?
renesas-drivers/master? This is important since we had quite some
refactoring going on lately.

Regards,

   Wolfram


--ftgcce6j3vacwgov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkxMbkACgkQFA3kzBSg
KbbXvw//WCZoXZBJ5OaurnKgMqwmohTiV86nD918XC3hsAq9Kb3YmG4Cbcx+LHJ4
H2bZ7xuliICesfZSrPQ3UNfAC32tJLQ8fvp/4GinjymmDkoAQ2TCiEvFAEbK1X9f
mvP1CcEIY/wiOttuTe3HKuxXw8BoXmKbER3P5+AHCpDV3tJMfLIMsJn+b/3Jwc52
lysrqWuFi5MOeBTlJcNBF4VPmL9rM1p5bbER3YAlgF421jh0qZ6JwIjWYoVBt1jY
SVX2WzduJYSRF3ysrS8S9MYmNh1y40tDpw2PLpb44bSRCiLJl/lvcTM4K7vYvtZN
v1loHaPEp/vFMMA52oBQdHKFfR1621HkEb8KqtGkjdIEQE1y/0BeEGgrxDSrBqJA
orFU9ZPBzTdfhznV3sWmDxqvp7k8lJSJ/o4Q3x9KyM0giQkj3gqFMWppAz/Z0G0I
euR5CFZvscvVVzS5x2OYUqJ8n79X1YPbdFmwJMxpWzOTzicLxgBXMdA1ZbdAOB9V
1fTU3zjskT7e0lRMKVEs1PSl+ncmKx6jCfXtASQOe1kVwfrCKi/saxvR9QyY8moZ
qZjkCIbONOqrvCPu4pMQT0a4RVwzKP81ZJLw2VeV19KVfxhJKnisnsSsZTtFo3Cl
GmDKSfORdGhKg4vsu3AGlTvgBXg4evxZ6Sz7YuXs8fgFzL/nAHY=
=q/bi
-----END PGP SIGNATURE-----

--ftgcce6j3vacwgov--
