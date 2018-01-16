From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 22/22] mmc: tmio: remove dma_ops from
 tmio_mmc_host_probe() argument
Date: Tue, 16 Jan 2018 23:43:03 +0100
Message-ID: <20180116224303.sspgktqoqlieig53@tetsubishi>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-23-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o2p2voy2lr5yoqnr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-23-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--o2p2voy2lr5yoqnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:57AM +0900, Masahiro Yamada wrote:
> Drivers need to set up various struct members for tmio_mmc_host before
> calling tmio_mmc_host_probe().  Do likewise for host->dma_ops instead
> of passing it as a function argument.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I think I have done all the review by now. I'll do some more regression
testing tomorrow and then give Tested-by as well if everything works
fine (but it looks like it so far).


--o2p2voy2lr5yoqnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpef/YACgkQFA3kzBSg
KbawBw//UPg5tgUAInFyysISHeVpVQEc0Rb2ax2zKMRjhGxBOa/S63iswWDouKCK
4+vv14I10RE7C07XOO/WySZuuguRtTsLsd5dxVtcUtvvQu7DX6M787mE1sEkojpw
kS+2Fe9wn/YO3B5K5eutzSsZVrfTMEMD9BFhzwg4vtyxVj9DJZbIEsk++GGyr5uJ
xtG17K3KEIemt4Ju7wv4+CmXgfcTB64Wye6WcndpyIGALLPf6uW1peOE9jBmy6RO
DeQV1CsSi2oSQmnLODgcHNi10+k9rxRbZHX5PPwNxb379hB9gT4X9Le/vU41oHPb
AEWfcrPjQmAI8EItqfEvcp2z+nNhq63nQZPmaEQGz4yWnKDLYskLvVKon55u01wp
P00ML6QYRsOOiOsgjcjxcrV/x17T58l/kapdqTl80H6zUoLTdtJ/GXjxrYnFNjP+
51ZNDzVHH8o3zrLFMEaYG5QgBAWbVQnwqtOiwxAiuQ47B/DlAPIA2Sy4p5VJbmOr
zEoFxsHxIMm87L63d/cano+k0mBq2shwv8tXqzc/yOtEinmX7fxj9vYZbIgnVgM1
pbmU2O44qObOmzYrvif88tUZSW0iLnm2vqOgD7tjUPd1Ob0SZWyoR1X1FTdEeV5h
Zqk6Shc3KIg1Fna3z05ghUuTBPgj/WUALWvhMmxPVibXVG/D9+g=
=gce6
-----END PGP SIGNATURE-----

--o2p2voy2lr5yoqnr--
