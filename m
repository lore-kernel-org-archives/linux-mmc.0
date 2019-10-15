From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Date: Tue, 15 Oct 2019 16:23:59 +0200
Message-ID: <20191015142359.GA1101003@ulmo>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-11-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Bartlomi
List-Id: linux-mmc@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
[...]
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index e3a2518503ed..8eb738cac0c7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -394,7 +394,7 @@ config PWM_ROCKCHIP
> =20
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
> -	depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>  	help
>  	  Generic PWM framework driver for Samsung.
> =20

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2l1n0ACgkQ3SOs138+
s6Eb7xAAsZ9JZaeRn7IjUZs/yz8zD5TWoNpojsmj6Kzf947MW5cgaZEJei22skVy
3Kv1ogZu1N2WO2L7v//P9waAgCs0EuHgeRkT+UgsW2AapaShdkNmMh0tgJNWGFLm
JwwGVB6rfjuBVYQgICBlfKzPdA9KDQNlxJPJmE3lC2kAQ5KWtsWHJIuWpk3zruQK
rZyp33ecFy4Xa+Sxue8CTgyUoHv+t7fhjtpAn/NgMJGy4WGi5lfn8S9bkb9uULHD
cZY4hv+EPC/GAaMQJ6HX9BwGnY1l+Mh8K7uH323OWAMQUqNAgKYuGvhUYSCtLPB1
WNdTjM1kkz93c1pLaikNdKtO3NhqrmXD+fKwmEF7xCQqEfBvPznq4ipHb4MHJEih
YLw8CGBBCX51LOghEJsYi0dMhvWdq4WFJcmXCcjWBYygVWkbvwkdCZSOTdeyI3GE
QTTlWslD1YDL7FuwCYPLBpldFi1JT8hFwP8oK3VTSxmpd4j8mjDKsMHpHtzzTGe/
6Le5t6ewz0rvR5ZFAnZB04VlIFV+l+Zx3e3Bxaqc2h/I6u1yagTZuPSknB7FJRPs
ic4Qr6sfKbK7LMuIIohElzhuVHcEeIfZ3NYAkWh7t9sqefIRrJUcDcPkz3sQ/8Vn
ChkBlbp/IuPwYuSPNI9nf7EW5vFjV7aTYZFXI7mj5M3kK5suvsU=
=4m87
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
