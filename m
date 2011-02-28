From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Mon, 28 Feb 2011 15:47:41 +0100
Message-ID: <20110228144741.GF15532@pengutronix.de>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54855 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab1B1Ort (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 09:47:49 -0500
Content-Disposition: inline
In-Reply-To: <1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, richard.zhao@freescale.com, Freescale@lists.linaro.org, eric.miao@linaro.org


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2011 at 07:32:05PM +0800, Richard Zhu wrote:
> Fix the NO INT in the Multi-BLK IO in SD/MMC, and
> Multi-BLK read in SDIO
>=20
> The CMDTYPE of the CMD register(offset 0xE) should be set to
> "11" when the STOP CMD12 is issued on imx53 to abort one
> open ended multi-blk IO. Otherwise one the TC INT wouldn't
> be generated.
>=20
> In exact block transfer, the controller doesn't complete the
> operations automatically as required at the end of the
> transfer and remains on hold if the abort command is not sent.
> As a result, the TC flag is not asserted and SW  received timeout
> exeception. set bit1 of Vendor Spec registor to fix it
>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   77 ++++++++++++++++++++++++++++++=
++++-
>  drivers/mmc/host/sdhci-pltfm.h     |    2 +-
>  2 files changed, 75 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 9b82910..32af7c4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -15,13 +15,41 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> +#include <linux/slab.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sdhci-pltfm.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sdio.h>
>  #include <mach/hardware.h>
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> =20
> +/* Abort type definition in the command register  */
> +#define  SDHCI_CMD_ABORTCMD	0xC0

Won't that belong into sd.h (unless I misunderstood your last mail)?

> +/* VENDOR SPEC register */
> +#define SDHCI_VENDOR_SPEC	0xC0
> +
> +/*
> + * The CMDTYPE of the CMD register(offset 0xE) should be set to

Check spaces.

> + * "11" when the STOP CMD12 is issued on imx53 to abort one
> + * open ended multi-blk IO. Otherwise one the TC INT wouldn't
> + * be generated.
> + * In exact block transfer, the controller doesn't complete the
> + * operations automatically as required at the end of the
> + * transfer and remains on hold if the abort command is not sent.
> + * As a result, the TC flag is not asserted and SW  received timeout
> + * exeception. Bit1 of Vendor Spec registor is used to fix it.
> + */

This is a better description, thanks. But what does the bit technically
do? Can't we keep it enabled all the time? Can't we use it to fix CMD12,
too?

> +#define IMX_MULTIBLK_NO_INT		(1 << 0)
> +
> +struct pltfm_imx_data {
> +	int flags;
> +	u32 mod_val;
> +};

Hmm, to me, just using cpu_is_mx53() is more readable than introducing
another layer of flags/quirks.

> +
> +static struct sdhci_ops sdhci_esdhc_ops;
> +

Move them to the front. But I did this already, so no worries :) I will
ping Chris to merge my series, so we will have something better to
develop on.


>  static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u3=
2 val, int reg)
>  {
>  	void __iomem *base =3D host->ioaddr + (reg & ~0x3);
> @@ -38,20 +66,51 @@ static u16 esdhc_readw_le(struct sdhci_host *host, in=
t reg)
>  	return readw(host->ioaddr + reg);
>  }
> =20
> +static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
> +{
> +	switch (reg) {
> +	case SDHCI_INT_STATUS:
> +		if (val & SDHCI_INT_DATA_END) {
> +			u32 v;
> +			v =3D readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> +			if (v & 0x2) {
> +				v &=3D ~0x2;

Forgot to mention this before. Please use a define instead of hardocded
values.

I skipped the rest because we probably need to answer the questions
above first and to get a stable base with out conflicts.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1rtY0ACgkQD27XaX1/VRuK3QCffUeeef7bIiuQTUc9y6g+vkqB
09wAoMlTjh1T7B/JJwC7fAyqy5rvwEOo
=SfDC
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
