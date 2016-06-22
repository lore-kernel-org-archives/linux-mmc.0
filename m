From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 3/4] mmc: renesas_sdhi: rename DMA source file as
 renesas_sdhi_dma.c
Date: Wed, 22 Jun 2016 16:21:10 +0200
Message-ID: <20160622142110.GC1645@katana>
References: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
 <1465963317-28672-4-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45515 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbcFVOVq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jun 2016 10:21:46 -0400
Content-Disposition: inline
In-Reply-To: <1465963317-28672-4-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2016 at 01:01:56PM +0900, Simon Horman wrote:
> Rename the source file for DMA for Renesas SDHI as a follow-up to attachi=
ng
> DMA code to the renesas_sdhi driver rather than the tmio_core driver.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/mmc/host/Makefile                               | 2 +-
>  drivers/mmc/host/{tmio_mmc_dma.c =3D> renesas_sdhi_dma.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/mmc/host/{tmio_mmc_dma.c =3D> renesas_sdhi_dma.c} (100%)

Because of the modularization, I think the rename makes a lot of sense
here and is worth renaming the functions inside, too. What do you think?
I think the rename should include the DMA type used, though. Like
'renesas_sdhi_sysc_dmac.c' here and 'renesas_sdhi_internal_dmac.c' for
the new one in the next patch?

>=20
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4f7903fbef26..0ea7fb6f3d5e 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -38,7 +38,7 @@ obj-$(CONFIG_MMC_TMIO)		+=3D tmio_mmc.o
>  obj-$(CONFIG_MMC_TMIO_CORE)	+=3D tmio_mmc_core.o
>  tmio_mmc_core-y			:=3D tmio_mmc_pio.o
>  obj-$(CONFIG_MMC_SDHI)		+=3D renesas_sdhi.o
> -renesas_sdhi-$(subst m,y,$(CONFIG_MMC_SDHI_DMA))	+=3D tmio_mmc_dma.o
> +renesas_sdhi-$(subst m,y,$(CONFIG_MMC_SDHI_DMA))	+=3D renesas_sdhi_dma.o
>  obj-$(CONFIG_MMC_CB710)		+=3D cb710-mmc.o
>  obj-$(CONFIG_MMC_VIA_SDMMC)	+=3D via-sdmmc.o
>  obj-$(CONFIG_SDH_BFIN)		+=3D bfin_sdh.o
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/renesas_s=
dhi_dma.c
> similarity index 100%
> rename from drivers/mmc/host/tmio_mmc_dma.c
> rename to drivers/mmc/host/renesas_sdhi_dma.c
> --=20
> 2.1.4
>=20

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXap7WAAoJEBQN5MwUoCm2uYIP/iLnk9mXdhaVAmiRszM1wNQK
U5O/eeKMpbntBc5G8qLJ+NtT3KiPpPSERF055fSF7YTKwaWzYaaPGTA2bCyq3r2I
/UpiKMWmIwlRpxTnDrEx7TVAIPpcwimM/d23lYSVfzOLT0YJr1RdpPtFnrf663qL
7npo0eKIogVzxxIdzANicXlTJrk8FFwbXWe31NrQVroUX2q35OUcHWw4lhYTFSxm
nDb6uUqtH3q0pTPmtW7LhaejZA9HpqFoo9Egq8RSKpB8V2IOmuFUlF4mcgI48Hq6
2A/zJUK9WeEX1UiON005yDIo1PC/LgqItEVG4lUpJ21lwAmN2Kd4lsMTv6Zo7JF+
qDvxC5KVRRPsz3vXHxk/tlY30yn6Zt13LmJbrZVLmtkumWYeDPwypKUa33TIbx8P
m+Lax7xy0w4OXk5UfwO0znuqSu/k+CTnPLHo0VQBYQlGE8N5KGBrWpPe8xAHAeGF
e7U/zFD2EXyrj1/NADbbFZBo4nDtRaOtp7OM9RkQ/Kvue/M9W8SAuIGPVsrtoFl6
2Co1UV0jXCv+yH0Rja+dV3Gu4MBirIcvqF7KoPEfugY64RNc097DXuu8uC7cWxRm
Dojix1usAklXyJwt8P159KqhWo/lzgsCD5MzOq458ESYmo6iVLGV5U0C2zT+zOZa
qzGirB0gkgMF+njI4KpZ
=tLfm
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
