From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 1/4] mmc: renesas_sdhi: rename sh_mobile_sdhi as
 renesas_sdhi
Date: Wed, 22 Jun 2016 16:11:10 +0200
Message-ID: <20160622141110.GA1645@katana>
References: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
 <1465963317-28672-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45484 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbcFVOLX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jun 2016 10:11:23 -0400
Content-Disposition: inline
In-Reply-To: <1465963317-28672-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2016 at 01:01:54PM +0900, Simon Horman wrote:
> The SDHI driver is applicable to a wider range of SoCs than SH-Mobile,
> Renesas seems to be a more appropriate name.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

It feels strange to rename the file and leaving all the naming inside
the file still 'sh_mobile_*'. On the other hand, renaming all those,
too, is intrusive, so I wonder if we can't keep the filename "for
historic reasons"?

> ---
>  drivers/mmc/host/Kconfig                              | 4 ++--
>  drivers/mmc/host/Makefile                             | 2 +-
>  drivers/mmc/host/{sh_mobile_sdhi.c =3D> renesas_sdhi.c} | 0
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename drivers/mmc/host/{sh_mobile_sdhi.c =3D> renesas_sdhi.c} (100%)
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0aa484c10c0a..840b17150263 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -560,13 +560,13 @@ config MMC_TMIO
>  	  T7L66XB and also HTC ASIC3
> =20
>  config MMC_SDHI
> -	tristate "SH-Mobile SDHI SD/SDIO controller support"
> +	tristate "Renesas SDHI SD/SDIO controller support"
>  	depends on SUPERH || ARM || ARM64
>  	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>  	select MMC_TMIO_CORE
>  	help
>  	  This provides support for the SDHI SD/SDIO controller found in
> -	  SuperH and ARM SH-Mobile SoCs
> +	  SuperH, and Renesas ARM and arm64 based SoCs.
> =20
>  config MMC_CB710
>  	tristate "ENE CB710 MMC/SD Interface support"
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index af918d261ff9..206233218781 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -38,7 +38,7 @@ obj-$(CONFIG_MMC_TMIO)		+=3D tmio_mmc.o
>  obj-$(CONFIG_MMC_TMIO_CORE)	+=3D tmio_mmc_core.o
>  tmio_mmc_core-y			:=3D tmio_mmc_pio.o
>  tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))	+=3D tmio_mmc_dma.o
> -obj-$(CONFIG_MMC_SDHI)		+=3D sh_mobile_sdhi.o
> +obj-$(CONFIG_MMC_SDHI)		+=3D renesas_sdhi.o
>  obj-$(CONFIG_MMC_CB710)		+=3D cb710-mmc.o
>  obj-$(CONFIG_MMC_VIA_SDMMC)	+=3D via-sdmmc.o
>  obj-$(CONFIG_SDH_BFIN)		+=3D bfin_sdh.o
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/renesas=
_sdhi.c
> similarity index 100%
> rename from drivers/mmc/host/sh_mobile_sdhi.c
> rename to drivers/mmc/host/renesas_sdhi.c
> --=20
> 2.1.4
>=20

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXapx+AAoJEBQN5MwUoCm2RR0QALYGGH14CiSQhmPdT6PMguei
Aq2Pru0V4/k1/qDeCJ+vZGtfx/scQguOc10Q61D6lVqOVDDmyRNNFtcPcO7e41mQ
QfjOBw0QojEPc+nzIdhR9vEoNuDR7vyzSqgpRmWeKZh6Y5yWIpk9tT20FU5PmWSw
mzvynP11P5mCmoyHWoXJqU8gViAaIORNlVA6MN5Bz6bxwlM6XgbQzQuBf7Qk4bln
SBJKjV9cRGs9eIhYxvCSf10JQuEOv+3NpaTrUbzx7KTcPv2ygS0ydcIBCQ5J2a7E
8DHXBNHXsK/VsV3OvdR+OTkTSpIbgtilnCQQZ49rTNNeZFYL5no6E0RTx2M4osGi
wAKi1JYSTQE5bdUwnv/ya8iFg3pxJLMn+MX2KjGkRMpqYI/RiHPPh2cbdc3gkJ7h
6IUei/AUr8X/I3ufERGUQkm8wywr8fwB5xZLZj3awoYk8mbfzI6ZER/7svAWJX+Q
PL+OZi0w+OlZrbscItJLEjusI5tJpTg7iXv8XQrDhopPDoyUOJjsT+z2CoN9Y/pp
tkjUdQyeX2U+B4NwM3+l5A2bumZG7y8AFy5JtO/Bge5LZshEq4pxVO2fa5/L8CKQ
wG17MPc1/j1kWYwr5PNnKRX3TAsUKgVacs2+XfBdoA2Q0zqCpgO0bmmJCMuSQsng
9UZ1bWF88+vrPfwC5+8+
=WN1J
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
