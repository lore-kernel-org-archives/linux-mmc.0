From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 09/22] mmc: tmio: use mmc_can_gpio_cd() instead of
 checking TMIO_MMC_USE_GPIO_CD
Date: Tue, 2 Jan 2018 13:56:12 +0100
Message-ID: <20180102125612.jebftmcs3ti7jdfj@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-10-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ab37nb6l6p6nubyz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42169 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeABM4O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Jan 2018 07:56:14 -0500
Content-Disposition: inline
In-Reply-To: <1511540697-27387-10-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--ab37nb6l6p6nubyz
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

This patch is correct, yet needed some time for testing because it
inverts the results for R-Car SoCs. Again, it is correct that it inverts
it because those SoCs have GPIOs defined in their devicetrees, so they
shouldn't be using native hotplug. Still, this meant checking that no
regression gets introduced. Also, for R-Car Gen 2 & 3 native hotplug
seems to work fine, so I was trying to find out why we use GPIOs here. I
wasn't successful up to now, but since GPIOs work well, too, and seem to
react a bit faster even, I am fine with the patch being merged.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> ---
>=20
> Changes in v2: None
>=20
>  drivers/mmc/host/tmio_mmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc=
_core.c
> index efffb04..610f26f 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1232,7 +1232,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>  	}
>  	mmc->max_seg_size =3D mmc->max_req_size;
> =20
> -	_host->native_hotplug =3D !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
> +	_host->native_hotplug =3D !(mmc_can_gpio_cd(mmc) ||
>  				  mmc->caps & MMC_CAP_NEEDS_POLL ||
>  				  !mmc_card_is_removable(mmc));
> =20
> --=20
> 2.7.4
>=20

--ab37nb6l6p6nubyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpLgWgACgkQFA3kzBSg
KbZI9A/+Nu0n7m6w7rhVBv8MRTFiZezhvVFUzTFHsnD7q3IEJnpe1FI5jaKM5TQy
aQhpOl5/yNarMwe91v2cpezVEnJPIH1JWzwQvsu5xs63ZRbtVmp1Da9lhrA9hXpu
X9+7roKRQrgMsR9AvZXlf223siFwdOaP0X5rZf+SRiMyBkIxb2DGWgBpU9NJRRG8
g9m2s1miL0PuvofOvdfB94rdPMZ2cmUsiTr/iFrDu/ea0zZL/RaqJczlBOX7ABjb
5BcisuZofBv/0z5u5L2qqIF6WtSOL1uWnTY+MWxqdVx2/IHmpyXmDplz56BzHavD
FQmFPQ+1rupTgE9TduPLfMhstj/bPC8OGhCx4uXpfXMsTEDE2bIPUp+eaJg8FN+e
THw+s1RRGxhal5LYi7IR+euj0Kb/aEKbVvWWBOlbu/Jw4XAsXKOsltdPbFnIMuMQ
wDQ86vFXO26i7DTD48vwXElvz2EjqQdUt/+ikC1WQLyaavU2kE4a3Be7yVwuMm3Q
Xen9hUyOwc1j0feXC8v4YHScfP8D/Fh0NCEuxRZln2WFjY7bfh6dcv5R+s48ksv3
tg3rlFbOJZAtlZwBwF8ozbe3bW4zMHt4Ts0SJHrEXoOEiBq+IzRM5h6vbT4vNxAd
bw8KB4D1zL+m95cbXvk+4xUP8qnK5KwpZhRJfJUa4vMmm+jZWnY=
=DW0b
-----END PGP SIGNATURE-----

--ab37nb6l6p6nubyz--
