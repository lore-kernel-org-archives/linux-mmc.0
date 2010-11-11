From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v1 1/3]Add erase timeout calculation routine for sdhci
 host
Date: Thu, 11 Nov 2010 10:33:42 +0100
Message-ID: <20101111093341.GA3131@pengutronix.de>
References: <20101111090519.GB18170@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42201 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab0KKJdr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 04:33:47 -0500
Content-Disposition: inline
In-Reply-To: <20101111090519.GB18170@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Cc: cjb@laptop.org, adrian.hunter@nokia.com, linux-mmc@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 11, 2010 at 05:05:19PM +0800, Chuanxiao.Dong wrote:
> From 04704a1c769dc4d15b5fb54d65d8ad46f6c5f57a Mon Sep 17 00:00:00 2001
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Date: Thu, 11 Nov 2010 13:42:32 +0800
> Subject: [PATCH 1/3] mmc: add erase timeout calculation routine for sdhci=
 host
>=20
> Erase command needs R1b response which means after HD handle
> a CMD_RESPONSE interrupt, driver also need to wait for a while.
> For SDHCI host controller, HD also need to handle a DATA_END
> interrupt.
> During device handle erase cmd, if the blocks need to be erased
> are too many, some SDHCI host controller maybe launch a TIMEOUT
> interrupt before the erase cmd finishing. To avoid this kind of
> situation, SDHCI HD need to calculate a correct timeout value
> before issuing erase cmd. Patch added a routine to implement
> this.

Just a formal thing I noticed on a glimpse...

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 154cbf8..79fcca2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -879,6 +879,48 @@ static void sdhci_finish_data(struct sdhci_host *hos=
t)
>  		tasklet_schedule(&host->finish_tasklet);
>  }
> =20
> +static void sdhci_set_erasetimeout(struct sdhci_host *host,
> +		unsigned int erase_timeout)
> +{
> +	u64 current_timeout;
> +	int count =3D 0xe;

I'd suggest a define with a speaking name instead of all the hardcoded 0xe.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzbuHUACgkQD27XaX1/VRsoLwCgtBgaUrh+9K3jOsKyZeWi/RIv
fMMAoMrDcTnzzJUN4BHJvT4MuuRKsezQ
=imB0
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
