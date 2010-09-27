From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 3/3] mmc: fix a warning when compile the
 sdhci d.d.
Date: Mon, 27 Sep 2010 12:54:13 +0200
Message-ID: <20100927105413.GE2664@pengutronix.de>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-3-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45771 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab0I0KyO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 06:54:14 -0400
Content-Disposition: inline
In-Reply-To: <1285233266-5039-3-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2010 at 11:14:26AM +0200, Giuseppe CAVALLARO wrote:
> This patch fixes a warning when compile the sdhci:
>   pwr may be used uninitialized in sdhci_set_power
> Also removes some include files that live in sdhci.h
> header file.
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Okay for the set_power-part (what compiler are you using? Newer one
should detect that BUG never returns). The include-removal could be in a
seperate patch, not sure if it is worth, though.

> ---
>  drivers/mmc/host/sdhci.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 5928b0a..058dacd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -18,13 +18,8 @@
>  #include <linux/io.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
> -#include <linux/scatterlist.h>
>  #include <linux/regulator/consumer.h>
> =20
> -#include <linux/leds.h>
> -
> -#include <linux/mmc/host.h>
> -
>  #include "sdhci.h"
> =20
>  #define DRIVER_NAME "sdhci"
> @@ -1050,11 +1045,9 @@ out:
> =20
>  static void sdhci_set_power(struct sdhci_host *host, unsigned short powe=
r)
>  {
> -	u8 pwr;
> +	u8 pwr =3D 0;
> =20
> -	if (power =3D=3D (unsigned short)-1)
> -		pwr =3D 0;
> -	else {
> +	if (power !=3D (unsigned short)-1) {
>  		switch (1 << power) {
>  		case MMC_VDD_165_195:
>  			pwr =3D SDHCI_POWER_180;
> --=20
> 1.5.5.6
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygd9UACgkQD27XaX1/VRtKHwCcDWBtGKAgb9iATKNdN2ZgVcW+
uyEAniXMbwLH3RJKDSSdkB11mJp5S6m9
=u3pc
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
