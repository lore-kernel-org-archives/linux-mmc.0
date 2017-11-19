From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] mmc: tmio: use mmc_can_gpio_cd() instead of checking
 TMIO_MMC_USE_GPIO_CD
Date: Sun, 19 Nov 2017 20:47:19 +0100
Message-ID: <20171119194719.v72z24ugpb2j2q32@tetsubishi>
References: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
 <1510136220-31853-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2q43tg72faclajuj"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46948 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdKSTrU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 19 Nov 2017 14:47:20 -0500
Content-Disposition: inline
In-Reply-To: <1510136220-31853-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--2q43tg72faclajuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 07:16:59PM +0900, Masahiro Yamada wrote:
> To use a GPIO line for card detection, TMIO_MMC_USE_GPIO_CD is used
> by a legacy board (arch/sh/boards/mach-ecovec24).
>=20
> For DT platforms, the "cd-gpios" property is a legitimate way for that
> in case the IP-builtin card detection can not be used for some reason.
> mmc_of_parse() calls mmc_gpiod_request_cd() to set up ctx->cd_gpio if
> the "cd-gpios" property is specified.

So, it fixed the DT not recognized via TMIO_MMC_USE_GPIO_CD? Did I get
this right?

>=20
> To cater to both cases, mmc_can_gpio_cd() is a correct way to check
> which card detection logic is used.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  drivers/mmc/host/tmio_mmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc=
_core.c
> index 7c0e952..9fd0874 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1228,7 +1228,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
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

--2q43tg72faclajuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloR38YACgkQFA3kzBSg
Kbawxg/+MbtR24PNrWCuLlZc8mJw4yLoLkI40VeqUS9k+MCZfrsCMS5dOx1pJHc1
D99PwB5CjWTsari2LjDpX60iktkNFGdgz5LVl/mKqp3nbeFG50bBt+0rI6oG805a
9GxQDeM4WjmGlmg0A1upRn5BzEX4FTVIHA+US/vbeLaKXnMw1xqlWRhcguq1+tJD
iWQgRnCz+IS7IwONkMvMOKtaoy5PVJXSexQOB/f7e4g/W1a6AsuI4CM8yjEthifo
miRHcCEC3VRfRJ9P3jQzhvkaBp+a27frrjbQanu3JYfoCXBrW6d1nlPR57SWtCrS
xe8nhyxyi0AYAwzXXH/rIPeIik/Jf2dAf82ryz2YKJqJjnxLbrNnLAxue72Ukze7
EaOZxDIHheX7Um8Q6WFPd80jG1xP8P/M4QAO5w3K/ImPSRuA0H3pYwYUE+FrExYx
/+NTmrbJsHsK4E9w5F1bqBGdDL5qdeDXevTQAAlkS1jpwR+9FtwMlTz/bjLzMXSv
YZgPq0wxMHuKgLFXfNefOk5kGX/gSInn9n9J45fBt8yKarrYfsTWw0RfReUMEZse
8J8dgoU7Yetp+R3Hjeaele7dnqhzhVLXk2tV1IOURu1V+fNBflK6IyHopMaV+q1H
+Z/DqJ0251lk19J4btrlqGjkoU81IYE+k+adcDMatfsOlyyZA6I=
=GZxb
-----END PGP SIGNATURE-----

--2q43tg72faclajuj--
