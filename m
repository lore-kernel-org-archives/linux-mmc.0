From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V6 3/4] mmc: sdhci-esdhc: make the writel/readl as the
 general APIs
Date: Thu, 17 Mar 2011 21:55:19 +0100
Message-ID: <20110317205519.GA29231@pengutronix.de>
References: <1300343647-15735-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300343647-15735-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40947 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab1CQUza (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 16:55:30 -0400
Content-Disposition: inline
In-Reply-To: <1300343647-15735-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, eric.miao@linaro.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Thu, Mar 17, 2011 at 02:34:06PM +0800, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   43 ++++++++++++++++++++++++++++++=
------
>  drivers/mmc/host/sdhci-pltfm.h     |    2 +-
>  2 files changed, 37 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 3b52485..5768e06 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
> +#include <linux/slab.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sdhci-pltfm.h>
>  #include <mach/hardware.h>
> @@ -24,6 +25,13 @@
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> =20
> +#define IMX_GPIO_CD_WP			(1 << 0)

Hmm, that sounds like a macro for a gpio-number. What about
ESDHC_FLAG_GPIO_FOR_CD_WP or something like that?

> +
> +struct pltfm_imx_data {
> +	int flags;
> +	u32 mod_val;

Maybe 'scratchpad' was not the best name, but 'mod_val' seems worse to me.

Those are minor things, but there is one thing which needs respinning IMHO:
While it looks functionally OK, I'll tell you (once again) that you cast too
much. Please be careful about that in the future!

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2CdTYACgkQD27XaX1/VRtPAQCeJOaLFqrJcA4NF6vPIg0BCAmM
ucAAoKjBDWgEUHvAqcPT9YXNfAPUK6AX
=k7EP
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
