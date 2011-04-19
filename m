From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/5] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
Date: Tue, 19 Apr 2011 12:21:10 +0200
Message-ID: <20110419102110.GE4164@pengutronix.de>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
	<1301042931-4869-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0814608683059368196=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1301042931-4869-5-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--===============0814608683059368196==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>  config MMC_SDHCI_ESDHC_IMX
> -	bool "SDHCI platform support for the Freescale eSDHC i.MX controller"
> +	bool "SDHCI support for the Freescale eSDHC i.MX controller"
>  	depends on ARCH_MX25 || ARCH_MX35 || ARCH_MX5
>  	depends on MMC_SDHCI
> -	select MMC_SDHCI_PLTFM
> +	select MMC_SDHCI_ESDHC
>  	select MMC_SDHCI_IO_ACCESSORS
>  	help
> -	  This selects the Freescale eSDHC controller support on the platform
> -	  bus, found on platforms like mx35/51.
> +	  This selects the Freescale eSDHC controller support on platforms
> +	  like mx35/51.

While we are at it, mx25 could be added and mx53 (and you know better
what else will be coming ;))

> diff --git a/drivers/mmc/host/sdhci-esdhc.c b/drivers/mmc/host/sdhci-esdh=
c.c
> new file mode 100644
> index 0000000..b3d1bc1
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-esdhc.c
> @@ -0,0 +1,413 @@
> +/*
> + * Freescale eSDHC controller driver for MPCxxx and i.MX.
> + *
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + *   Author: Xiaobo Xie <X.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> + *
> + * Copyright (c) 2009 MontaVista Software, Inc.
> + *   Author: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> + *
> + * Copyright (c) 2010 Pengutronix e.K.
> + *   Author: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/sdhci-pltfm.h>
> +#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
> +#include <mach/hardware.h>
> +#endif
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +/*
> + * Ops and quirks for the Freescale eSDHC controller.
> + */
> +
> +#define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
> +				SDHCI_QUIRK_BROKEN_CARD_DETECTION | \
> +				SDHCI_QUIRK_NO_BUSY_IRQ | \
> +				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
> +				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
> +				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
> +				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET | \
> +				SDHCI_QUIRK_NO_CARD_NO_RESET)

These are not the current quirks. Meanwhile BROKEN_CARD_DETECTION is
gone as well as NO_CARD_NO_RESET (at least for imx). My additions to use
GPIOs for card detect and write protect are also not in this version.

[...]

> +static struct sdhci_pltfm_data sdhci_esdhc_mpc_pdata =3D {
> +	.quirks =3D ESDHC_DEFAULT_QUIRKS,
> +	.ops =3D &sdhci_esdhc_mpc_ops,
> +};
> +#endif

Please mark the #endif with comments of the expression they are
depending on, e.g.

#endif /* CONFIG_MMC_SDHCI_ESDHC_MPC */

if it is not immediately visible. That helps readability.

[...]

Phew, due to all these hardware bugs, the driver will get messy, even if
we try hard. Any chances that future revisions of the core will be
updated? :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2tYhUACgkQD27XaX1/VRtMpACgvd33e+O/nMFWpnZOp5ptskMF
e0gAmwdL+4iU5R+jV+/AX03kUkcFzXms
=ET2u
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--

--===============0814608683059368196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0814608683059368196==--
