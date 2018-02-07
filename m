From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 06/16] mmc: tmio: refactor .get_ro hook
Date: Wed, 7 Feb 2018 20:09:51 +0100
Message-ID: <20180207190951.viniisquogyk2av6@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-7-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4hyxqrgwjik2wcxf"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44213 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754038AbeBGTJx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Feb 2018 14:09:53 -0500
Content-Disposition: inline
In-Reply-To: <1516206496-16612-7-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--4hyxqrgwjik2wcxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:06AM +0900, Masahiro Yamada wrote:
> This IP provides the write protect signal level in the status
> register, but it is also possible to use GPIO for WP.  They are
> exclusive, so it is not efficient to call mmc_gpio_get_ro() every
> time from tmio_mmc_get_ro() if we know gpio_ro is not used.
>=20
> Check the capability of gpio_ro just once in the probe function,
> then set mmc_gpio_get_ro to .get_ro if it is the case.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--4hyxqrgwjik2wcxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7Tv4ACgkQFA3kzBSg
KbZwZQ//TWe1qgH1C2ufhOJ0BrEo4/hqT7Q/Qiq1m2vwNxFoQL51ZH1mV9iURMeg
WNR3SQlRs49vUYhylEIoTu78KWaCnSPYt1PnXPLWNc5/P5LJWp0AwHPUkbmgptXL
VnbKWtchCK0XUrYVL6gc5wBshZXMdBETy3L7l/MZCdeBDcL69/8fxWW9bhjhqekT
Bbz/DXk0ge8SPQ4K8rpXFn3GHy8wf3mbSg561JMYRyWOF0zx6MmTQkNtlLPcyXxq
U4zQ+UUgN4yT3pn1HOfxtI8atVqiP/DcIs3eauOgvmneH19N3uGcVF3LjUhb7+Xt
4xfG0gURmfNffVicNJ+Xzw20ofzPCiQ5fCc50H0csjyx05+FVjLaHXBJh6XPiOJg
cdUOz+rQBi1lhrYDO8ryZnIcyiIBphsUrLsRfV+28E7hqcPEHZ6SYbWcM3c5o9G7
+6mUNU6UzSN337R1eGsQ4T1H9lywrA5KSidd3Il3X+qJd8nawKiNN9ekMpzei8M0
ZxJ5Sb4vpS45REvRJV6FniXNzDcpDdsC2vrrA3t/thlQ0YIuHyWh8IwVXbY5KewQ
lrN58vLg5LKW/fJedxZExdr5tdTkpupgluZNcZpsN6ACHJ1cYu7VQ9GsxfUcP/6g
jErcmxGJIgFC/eLO4iCxJfozKa7NTf3R8KTpSs9hjAwr3lLo8zY=
=I/jZ
-----END PGP SIGNATURE-----

--4hyxqrgwjik2wcxf--
