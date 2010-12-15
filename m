From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/4] sdhci: add quirk for broken sdio irq
Date: Wed, 15 Dec 2010 11:57:01 +0100
Message-ID: <20101215105701.GC3515@pengutronix.de>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
 <1292388576-25600-3-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58358 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab0LOK5E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 05:57:04 -0500
Content-Disposition: inline
In-Reply-To: <1292388576-25600-3-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 14, 2010 at 10:49:34PM -0600, Olof Johansson wrote:
> Some controllers can't handle SDIO IRQ properly. Give a way to
> disable it.
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/mmc/host/sdhci.c  |    6 +++++-
>  include/linux/mmc/sdhci.h |    2 ++
>  2 files changed, 7 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c0094c1..98f3d3d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1871,7 +1871,10 @@ int sdhci_add_host(struct sdhci_host *host)
>  		mmc->f_min =3D host->max_clk / SDHCI_MAX_DIV_SPEC_200;
> =20
>  	mmc->f_max =3D host->max_clk;
> -	mmc->caps |=3D MMC_CAP_SDIO_IRQ;
> +	mmc->caps =3D 0;

That would clear flags already set in custom probe functions (check
sdhci-pxa) for example.

> +
> +	if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
> +		mmc->caps |=3D MMC_CAP_SDIO_IRQ;

As we are running out of quirk-bits, can you imagine a solution without
a quirk (same for the other patch)?

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0Inv0ACgkQD27XaX1/VRsFUACeJkigYG9apBTS3LwsZpoCxmkF
8poAmwU9bq6EPt/PoI//yl9vM6+c4kWi
=4w9J
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
