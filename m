From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
 compliant with UHS-1
Date: Fri, 25 Apr 2014 14:38:20 +0200
Message-ID: <20140425123820.GA15179@pengutronix.de>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56731 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaDYMia (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 08:38:30 -0400
Content-Disposition: inline
In-Reply-To: <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 23, 2014 at 08:07:57PM +0100, Russell King wrote:
> Patch suggested by Dong Aisheng <dongas86@gmail.com>, this avoids
> additional clock start/stop cycles during the transition to 1.8V
> signalling mode.
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I tested the series on imx6s with a RIoT board. With this patch applied
the RIoT board emmc does not work. Here is the output of the board:

# dmesg | grep mmc2
mmc2: no vqmmc regulator found
mmc2: no vmmc regulator found
mmc2: SDHCI controller on 219c000.usdhc [219c000.usdhc] using ADMA
mmc2: BKOPS_EN bit is not set
mmc2: Timeout waiting for hardware interrupt.
mmc2: Timeout waiting for hardware interrupt.
mmc2: Timeout waiting for hardware interrupt.
mmc2: Timeout waiting for hardware interrupt.
mmc2: error -110 whilst initialising MMC card
mmc2: BKOPS_EN bit is not set
mmc2: Timeout waiting for hardware interrupt.
mmc2: Timeout waiting for hardware interrupt.
mmc2: Timeout waiting for hardware interrupt.
mmc2: Timeout waiting for hardware interrupt.
mmc2: error -110 whilst initialising MMC card
mmc2: BKOPS_EN bit is not set

Any ideas?

Regards,

Markus

> ---
>  drivers/mmc/host/sdhci.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 748333ba6e96..0bcef2d42da4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host *ho=
st, struct mmc_ios *ios)
>  			host->ops->set_clock(host, host->clock);
>  		}
> =20
> -
> -		/* Reset SD Clock Enable */
> -		clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -		clk &=3D ~SDHCI_CLOCK_CARD_EN;
> -		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -
>  		if (host->ops->set_uhs_signaling)
>  			host->ops->set_uhs_signaling(host, ios->timing);
>  		else {
> @@ -1546,9 +1540,6 @@ static void sdhci_do_set_ios(struct sdhci_host *hos=
t, struct mmc_ios *ios)
>  			ios->drv_type =3D (preset & SDHCI_PRESET_DRV_MASK)
>  				>> SDHCI_PRESET_DRV_SHIFT;
>  		}
> -
> -		/* Re-enable SD Clock */
> -		host->ops->set_clock(host, host->clock);
>  	} else
>  		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> =20
> @@ -1757,9 +1748,6 @@ static int sdhci_do_start_signal_voltage_switch(str=
uct sdhci_host *host,
>  		ctrl |=3D SDHCI_CTRL_VDD_180;
>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> =20
> -		/* Wait for 5ms */
> -		usleep_range(5000, 5500);
> -
>  		/* 1.8V regulator output should be stable within 5 ms */
>  		ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  		if (ctrl & SDHCI_CTRL_VDD_180)
> --=20
> 1.8.3.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTWlc8AAoJEEpcgKtcEGQQrSYQAIvJAPhR1pDsyvNqLpmCXtWA
xX/BVxhZRuOC/fQy2doG5qDhdCXS6fCaPgtl3ejxz6OQGWJf/sB13G97wRb9/R3K
aFLBMOEqIelMB5YkI9mWd7dK3ZpjcLEjxLpk61k7mz1830+JjhMzcg23pkzRC3jK
sFbAp0by+pYx1jw10je+V4qlXWXBXX9QVmLtMXCNUtkgcI5+htRgC7ivyB0MS9e+
K4ctC5I7KD9/mNQ9EbDljS1AlEAkxfxhQ+CJgiJiDa0zwKTlcFkag1r9cJptWO6f
U7F7rzLz7WXzFij6/UdXt1MT2ItSmu2OwCslMnJ2Vt2vVdAP39Z1RJXsG3SJt29q
CXCr4QwaX5xga+1rVVshMJauichEbs8xgP+3aaSR71UUQTr9F20+91kKlyQE6HYm
vtln0pHEqR2ZHmidDwLWgDZWTY+txeewa8E1nUMrHiDpC1B37+bctjFQo5czGsFK
F5ZL/xmBNb/C8LaRyL4+qUhC+uhxaDQrfODVEyIXzQlBuOSuZZ6lN/EyMX4Xqssf
uPTP8gUEPjd9J10sf5KFQUGEHcsQl69Rhgekb8P/+O3EhIS1l0smFGKA63rFq7JX
JaN415TWQYWi85j9sm7msJ7aSH0BArudxLH3x2GFebpXGSOsZNBsD7Iz+vGmPiM0
Jk8kl5BGzNr9WuvZ7EBM
=4VZe
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
