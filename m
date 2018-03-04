From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 16/16] mmc: tmio: remove useless TMIO_MASK_CMD
 handling in tmio_mmc_host_probe()
Date: Sun, 4 Mar 2018 23:39:57 +0100
Message-ID: <20180304223957.3f3s3lbrerenyula@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-17-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nwa4ymbvg2u4kg23"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-17-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--nwa4ymbvg2u4kg23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:16AM +0900, Masahiro Yamada wrote:
> TMIO_MASK_CMD is properly enabled in tmio_mmc_start_command().
>=20
> We have no reason to set it up in tmio_mmc_host_probe().  (If we
> really wanted to set it in the probe, we would have to do likewise
> when resuming.)
>=20
> Even worse, the following code is extremely confusing:
>=20
>   _host->sdcard_irq_mask &=3D ~irq_mask;
>=20
> The logic is opposite between "->sdcard_irq_mask" and "irq_mask".
> The intention is not clear at a glance.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--nwa4ymbvg2u4kg23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqcdb0ACgkQFA3kzBSg
KbYKWQ//elSq8BiTicTAt9UFwRn4RrO5B+DNJ0MT8pu0m/uLRxggydHaHTlbUF26
UQWmWMoV68fYJI1Y+jZl9eQVWIVig9eJkxt5kiG4wzNEv7V0SvlcySEOLC1bmjf/
L3uFayil/EgZZ9HQijWqUwfz/EctsWd8OeizryDbBFAOtuNJaxnKC+aJhsYFrkZ2
B4vh/04WU7Ew9hVdpzdbIfA+rywRm5ObHy720uSZPtbHT+ewqgJdnqeHFQZRXRRw
tgKsGNPtaXsWKIXnucI9jcVrfw1I7myme+B+wdPd6kcdnk91lgCHfaYNSQTy46P/
BqVa2nTWHACRZOc1KBjzVLsUdUrs6cl8ObZwK5AE3waFPDoj5pDyO8bleMereT98
F0Ca3jV1M5bssTdFVeSAg/KMW2ppHnkzWBtOdRotFCt35n2Pg+FZ7L9kIDQwIxnj
Z/QCteOCYCynXC4bhArd3SYhXZsOO+dgrYetD7L2bl7pV9npxUQ9M9HU25bhD3Oz
rDMBPFwUofm/5kfbhKW/9VZqZINPVryANznqOBVg7m1bBxJlT8kZZEDhLLWMLgIQ
it989fN2LCI6PQp6fhqFVTcuvpe6O6YcRoff4teKY9FDpzIJGm+UEJANPHbhoRp6
lKZJ/u4MldEFLpmAYVA0vfUrKXPNuU+0Jm8oGGdxGrBNoLsIhbI=
=mJIR
-----END PGP SIGNATURE-----

--nwa4ymbvg2u4kg23--
