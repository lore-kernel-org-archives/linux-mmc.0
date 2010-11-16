From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 5/7] mmc: sdhci-of: support generic OF controllers
Date: Tue, 16 Nov 2010 22:32:18 +0100
Message-ID: <20101116213218.GB19893@pengutronix.de>
References: <1289939635-30742-1-git-send-email-robherring2@gmail.com> <1289939635-30742-6-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40192 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173Ab0KPVcY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 16:32:24 -0500
Content-Disposition: inline
In-Reply-To: <1289939635-30742-6-git-send-email-robherring2@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 16, 2010 at 02:33:53PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>=20
> The base sdhci driver requires a valid ops struct. Add empty struct to
> sdhci-of to allow generic controllers which don't need custom ops functio=
ns.
>=20
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

For the sdhci-patches, you should add linux-mmc@vger.kernel.org to the CC-l=
ist.
Done now...

> ---
>  drivers/mmc/host/sdhci-of-core.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of=
-core.c
> index dd84124..de292fe 100644
> --- a/drivers/mmc/host/sdhci-of-core.c
> +++ b/drivers/mmc/host/sdhci-of-core.c
> @@ -30,6 +30,9 @@
>  #include "sdhci-of.h"
>  #include "sdhci.h"
> =20
> +static struct sdhci_ops sdhci_of_ops =3D {
> +};
> +
>  #ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> =20
>  /*
> @@ -161,6 +164,8 @@ static int __devinit sdhci_of_probe(struct platform_d=
evice *ofdev,
>  	if (sdhci_of_data) {
>  		host->quirks =3D sdhci_of_data->quirks;
>  		host->ops =3D &sdhci_of_data->ops;
> +	} else {
> +		host->ops =3D &sdhci_of_ops;
>  	}
> =20
>  	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> --=20
> 1.7.1
>=20
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzi+GIACgkQD27XaX1/VRu7ggCfYvfI+N81ACxkbarIcE8lCeuC
v+UAnj4Apq9i4Zl1XIoR9rP7rqEBKeOa
=LNwq
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
