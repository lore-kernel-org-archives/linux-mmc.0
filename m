From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/1] fix card interrupt losing issue on freescale eSDHC
Date: Wed, 27 Jul 2011 09:47:10 +0200
Message-ID: <20110727074710.GS16561@pengutronix.de>
References: <1310966402-12318-1-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36811 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab1G0HrN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2011 03:47:13 -0400
Content-Disposition: inline
In-Reply-To: <1310966402-12318-1-git-send-email-tony.lin@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lin <tony.lin@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hello Tony,

On Mon, Jul 18, 2011 at 01:20:02PM +0800, Tony Lin wrote:
> apply workaround for imx eSDHC controller to avoid
> missing card interrupt so that SDIO function is workable
=46ixing a few typos (but note, I'm not a native speaker):

	mmc/sdhci-esdhc-imx: fix losing card interrupt

	Apply workaround for the imx eSDHC controller to avoid missing a
	card interrupt.

	Signed-off-by: ...

> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   39 ++++++++++++++++++++++++++=
+--------
>  1 files changed, 30 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sd=
hci-esdhc-imx.c
> index a19967d..da77cae 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -32,6 +32,8 @@
>  #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
> =20
>  #define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
> +
> +#define	SDHCI_CTRL_D3CD			0x08
>  /*
>   * The CMDTYPE of the CMD register (offset 0xE) should be set to
>   * "11" when the STOP CMD12 is issued on imx53 to abort one
> @@ -87,14 +89,31 @@ static void esdhc_writel_le(struct sdhci_host *ho=
st, u32 val, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data =3D pltfm_host->priv;
> -
> -	if (unlikely((reg =3D=3D SDHCI_INT_ENABLE || reg =3D=3D SDHCI_SIGNA=
L_ENABLE)
> -			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)))
> -		/*
> -		 * these interrupts won't work with a custom card_detect gpio
> -		 * (only applied to mx25/35)
> -		 */
> -		val &=3D ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> +	u32 data;
> +
> +	if (unlikely((reg =3D=3D SDHCI_INT_ENABLE || reg =3D=3D SDHCI_SIGNA=
L_ENABLE))) {
> +		if (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)
> +			/*
> +			 * these interrupts won't work with a custom
> +			 * card_detect gpio (only applied to mx25/35)
hmm, ok, this was here before, but I wonder about the "only applied to
mx25/35" part. How is that meant? I don't see logic to prevent other
socs using this workaround.

> +			 */
> +			val &=3D ~(SDHCI_INT_CARD_REMOVE | \
> +				SDHCI_INT_CARD_INSERT);
> +
> +		if (val & SDHCI_INT_CARD_INT) {
> +			/*
> +			 * clear D3CD bit and set D3CD bit to avoid
> +			 * missing card interrupt
> +			 * this is a eSDHC controller problem so that
> +			 * we need to apply following workaround
s/following/this/ ? If not, according to my (non-native) English you
need to add a "the" before "following".

> +			 */
> +			data =3D readl(host->ioaddr + SDHCI_HOST_CONTROL);
> +			data &=3D ~SDHCI_CTRL_D3CD;
> +			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
> +			data |=3D SDHCI_CTRL_D3CD;
> +			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
Is there some Documentation about this problem? If yes, maybe add a lin=
k
to it? Alternatively describe the problem more exact in a comment
please.

> +		}
> +	}
> =20
>  	if (unlikely((imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
>  				&& (reg =3D=3D SDHCI_INT_STATUS)
> @@ -165,7 +184,9 @@ static void esdhc_writeb_le(struct sdhci_host *ho=
st, u8 val, int reg)
>  		return;
>  	case SDHCI_HOST_CONTROL:
>  		/* FSL messed up here, so we can just keep those two */
> -		new_val =3D val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
> +		new_val =3D val & (SDHCI_CTRL_LED | \
> +				SDHCI_CTRL_4BITBUS | \
> +				SDHCI_CTRL_D3CD);
This makes the comment wrong---now there are three bits that can be
preserved.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
