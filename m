From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048
 with a pklatform hook.
Date: Mon, 7 Feb 2011 18:40:39 +0100
Message-ID: <20110207174039.GE3123@pengutronix.de>
References: <m31v3lofm1.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55443 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab1BGRko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Feb 2011 12:40:44 -0500
Content-Disposition: inline
In-Reply-To: <m31v3lofm1.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 06, 2011 at 01:13:10AM -0500, Chris Ball wrote:
> Part of a quirk cleanup run.  This quirk was only used by sdhci-esdhc.
> This patch is untested.
>=20
> Signed-off-by: Chris Ball <cjb@laptop.org>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9e15f41..fcd6188 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1962,8 +1962,8 @@ int sdhci_add_host(struct sdhci_host *host)
>  	 * Maximum block size. This varies from controller to controller and
>  	 * is specified in the capabilities register.
>  	 */
> -	if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
> -		mmc->max_blk_size =3D 2;
> +	if (host->ops->get_max_blk_size) {
> +		mmc->max_blk_size =3D host->ops->get_max_blk_size(host);
>  	} else {
>  		mmc->max_blk_size =3D (caps & SDHCI_MAX_BLOCK_MASK) >>
>  				SDHCI_MAX_BLOCK_SHIFT;

I tend to think this could be fixed using io-accessors when reading the
caps register?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1QLpcACgkQD27XaX1/VRsvAgCfWA/aUBRrbCOBeU7cGTQIohle
e4EAoKV2NrCQd+0x2WZJzi2LibzKM2Ri
=o2zm
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
