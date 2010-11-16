From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/7] mmc: sdhci-of: fix build on non-powerpc platforms
Date: Tue, 16 Nov 2010 22:44:09 +0100
Message-ID: <20101116214409.GC19893@pengutronix.de>
References: <1289939635-30742-1-git-send-email-robherring2@gmail.com> <1289939635-30742-5-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58417 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab0KPVoQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 16:44:16 -0500
Content-Disposition: inline
In-Reply-To: <1289939635-30742-5-git-send-email-robherring2@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 16, 2010 at 02:33:52PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>=20
> Explicitly include err.h, of_address.h and of_irq.h.
> Make use of machine_is() conditional on PPC.
>=20
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Hmm, sins of the past :/ I wonder if we can get away with less #ifdeffery, =
will
think about it...

> ---
>  drivers/mmc/host/sdhci-of-core.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of=
-core.c
> index fa19d84..dd84124 100644
> --- a/drivers/mmc/host/sdhci-of-core.c
> +++ b/drivers/mmc/host/sdhci-of-core.c
> @@ -13,6 +13,7 @@
>   * your option) any later version.
>   */
> =20
> +#include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -20,8 +21,12 @@
>  #include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/mmc/host.h>
> +#ifdef CONFIG_PPC
>  #include <asm/machdep.h>
> +#endif
>  #include "sdhci-of.h"
>  #include "sdhci.h"
> =20
> @@ -112,7 +117,11 @@ static bool __devinit sdhci_of_wp_inverted(struct de=
vice_node *np)
>  		return true;
> =20
>  	/* Old device trees don't have the wp-inverted property. */
> +#ifdef CONFIG_PPC
>  	return machine_is(mpc837x_rdb) || machine_is(mpc837x_mds);
> +#else
> +	return false;
> +#endif
>  }
> =20
>  static int __devinit sdhci_of_probe(struct platform_device *ofdev,
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

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzi+ykACgkQD27XaX1/VRu9pgCgyn4Ot2V5Rz78y7F35oX3BcFP
20gAoMVTlD6OMnWGIHkE/22GZ7KTgQpm
=KQrA
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
