From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 09/22] mmc: tmio: use mmc_can_gpio_cd() instead of
 checking TMIO_MMC_USE_GPIO_CD
Date: Mon, 4 Dec 2017 23:22:21 +0100
Message-ID: <20171204222221.j76mqfc4oqq2oyth@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-10-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wz3o4uhfixflk6we"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-10-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--wz3o4uhfixflk6we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:44AM +0900, Masahiro Yamada wrote:
> To use a GPIO line for card detection, TMIO_MMC_USE_GPIO_CD is set
> by a legacy board (arch/sh/boards/mach-ecovec24).
>=20
> For DT platforms, the "cd-gpios" property is a legitimate way for that
> in case the IP-builtin card detection can not be used for some reason.
> mmc_of_parse() calls mmc_gpiod_request_cd() to set up ctx->cd_gpio if
> the "cd-gpios" property is specified.
>=20
> To cater to both cases, mmc_can_gpio_cd() is a correct way to check
> which card detection logic is used.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

My gut feeling is that your patch is correct, but I need to have another
look at this native_hotplug code with a fresh brain and take your other
patches into account as well then, too.


--wz3o4uhfixflk6we
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlolypoACgkQFA3kzBSg
Kbb2AQ//RGMKaEnLUkmV7FjyiAXJfh3RCfFkk/Jfl54fTGhs7b1kYvZuk+JeKdyo
WbfQRUbDV2RWa/nHBUT44Hib1UeeRw2t8G5S+RKlw5eaOnGsqQ0uwJOjawMKw5Ji
Ps30g4Q4k9ex2Ds7KP0jxjyh7alo64djKIr/KOK2Peggrs4KEXzfJiLC3frUOKvW
zWPI/UiMyakuzfA3UeGRuM/Huhhtdwpz/kIGQCKfIKLx2y+f4sSvXUwisvYMKTAH
IB+vkptFl/FMBUyouLX/G5KPF7wB99AHq3UC8zPlwlm4fCaKECNeaZtZTlC4NVnu
qZyvcSGru017beP2xRAZXTG5jv0/nbCSZyptT6IgqYULmnVxMo7XaLe5p7hrFDAm
KjIxwZcfGxK1dfXZobWLoCDN58xaDocQlbkqF3BIbrNY2nrRqKNmGApJTNseSraZ
oSOG+FhCuascsmZB0Xdsz4SpV3EykavcS/66XhtQI/sjRTltPYHpIA1LlubAYArS
OlfOe6/pmV04Jfp9eVj3fz11rHnTm9HCVm683XVt/85R7/S7VH2QG5t9GkwJNVa1
RIwVqjBVDv0QmkMx55OANNA2gUpzMifTZv7Xl6UbBhb1B2JH2v21L9yrF3nqNeoR
Fb1lA3ZzVsNKFUwbrnqWgYTQelzldfXUEzorR6rHboiARpUy1d0=
=ZA/I
-----END PGP SIGNATURE-----

--wz3o4uhfixflk6we--
