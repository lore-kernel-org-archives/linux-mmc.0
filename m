From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Fri, 25 Feb 2011 21:38:49 +0100
Message-ID: <20110225203849.GC2192@pengutronix.de>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36915 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790Ab1BYUi5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 15:38:57 -0500
Content-Disposition: inline
In-Reply-To: <1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, linuxzsc@gmail.com, richard.zhao@freescale.com


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2011 at 06:13:26PM +0800, Richard Zhu wrote:

> Fix the NO INT in the Multi-BLK IO in SD/MMC, and
> Multi-BLK read in SDIO

This description is too short. Why does it not work before, and why does
this patch help?

>=20
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   41 ++++++++++++++++++++++++++++++=
+++++-
>  drivers/mmc/host/sdhci-esdhc.h     |    5 ++++
>  2 files changed, 45 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 9b82910..a09f786 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -17,6 +17,8 @@
>  #include <linux/clk.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sdhci-pltfm.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sdio.h>
>  #include <mach/hardware.h>
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
> @@ -38,6 +40,27 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int=
 reg)
>  	return readw(host->ioaddr + reg);
>  }
> =20
> +static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
> +{
> +	switch (reg) {
> +	case SDHCI_INT_STATUS:
> +		/*
> +		 * Fix no INT bug in SDIO MULTI-BLK read
> +		 * clear bit1 of Vendor Spec registor after TC
> +		 */

Same for this comment. Make it more descriptive, please

> +		if (val & SDHCI_INT_DATA_END) {
> +			u32 v;
> +			v =3D readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> +			if (v & 0x2) {
> +				v &=3D (~0x2);

Braces not needed.

> +				writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> +			}

Can't you clear it unconditionally?

> +		}
> +		break;
> +	}
> +	writel(val, host->ioaddr + reg);
> +}
> +
>  static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -45,12 +68,27 @@ static void esdhc_writew_le(struct sdhci_host *host, =
u16 val, int reg)
>  	switch (reg) {
>  	case SDHCI_TRANSFER_MODE:
>  		/*
> +		 * Fix no INT bug in SDIO MULTI-BLK read
> +		 * set bit1 of Vendor Spec registor
> +		 */
> +		if ((host->cmd->opcode =3D=3D SD_IO_RW_EXTENDED)
> +				&& (host->cmd->data->blocks > 1)
> +				&& (host->cmd->data->flags & MMC_DATA_READ)) {
> +			u32 v;
> +			v =3D readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> +			v |=3D 0x2;
> +			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> +		}
> +		/*
>  		 * Postpone this write, we must do it together with a
>  		 * command write that is down below.
>  		 */
>  		pltfm_host->scratchpad =3D val;
>  		return;
>  	case SDHCI_COMMAND:
> +		/*Set the CMD_TYPE of the CMD12, fix no INT in MULTI_BLK IO */
> +		if (host->cmd->opcode =3D=3D MMC_STOP_TRANSMISSION)
> +			val |=3D SDHCI_CMD_ABORTCMD;

Can't we handle it the same way than the SDIO case? I have to admit,
even after reading the docs, I don't fully get what this bit1 is about.

>  		writel(val << 16 | pltfm_host->scratchpad,
>  			host->ioaddr + SDHCI_TRANSFER_MODE);
>  		return;
> @@ -113,7 +151,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, =
struct sdhci_pltfm_data *pd
>  	clk_enable(clk);
>  	pltfm_host->clk =3D clk;
> =20
> -	if (cpu_is_mx35() || cpu_is_mx51())
> +	if (!cpu_is_mx25())
>  		host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> =20
>  	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
> @@ -133,6 +171,7 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
> =20
>  static struct sdhci_ops sdhci_esdhc_ops =3D {
>  	.read_w =3D esdhc_readw_le,
> +	.write_l =3D esdhc_writel_le,

You are applying it for all imx-versions?

>  	.write_w =3D esdhc_writew_le,
>  	.write_b =3D esdhc_writeb_le,
>  	.set_clock =3D esdhc_set_clock,
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdh=
c.h
> index 303cde0..c93168c 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -43,6 +43,11 @@
> =20
>  #define ESDHC_HOST_CONTROL_RES	0x05
> =20
> +/* Abort type definition in the command register  */
> +#define  SDHCI_CMD_ABORTCMD	0xC0

So, this is vendor-specific, too?

> +/* VENDOR SPEC register */
> +#define SDHCI_VENDOR_SPEC	0xC0
> +
>  static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int=
 clock)
>  {
>  	int pre_div =3D 2;

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1oE1kACgkQD27XaX1/VRsZqgCePWYFsRDzjeJHHU+WdxmcX7km
YkoAoJLL+svkK2ZeQwkve9F0fbyUV7th
=+rCG
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
