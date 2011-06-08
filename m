From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V1] mmc: Enable the ADMA on esdhc imx driver
Date: Wed, 8 Jun 2011 22:30:22 +0200
Message-ID: <20110608203022.GC21996@pengutronix.de>
References: <1307503005-3969-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52656 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1FHUaf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 16:30:35 -0400
Content-Disposition: inline
In-Reply-To: <1307503005-3969-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric.miao@linaro.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2011 at 11:16:45AM +0800, Richard Zhu wrote:
> Eanble the ADMA2 mode on freescale esdhc imx driver,
> tested on MX51 and MX53.

What does the new, vendor specific bit in the interrupt register cover what=
 the
old ADMA_ERROR bit did not cover? And is the old one the same as in mx25, so
the new bit can be seen as the fixup which makes ADMA work only on mx51/53?

Information like this should be added to the define, so people will clearly
know later.

>=20
> Only ADMA2 mode is enabled, MX25/35 can't support the ADMA2 mode.
> So this patch is only used for MX51/53.
> The ADMA2 mode supported or not can be distinguished by the
> Capability Register(offset 0x40) of eSDHC module.
> Up to now, only MX51/MX53 set the ADMA2 supported bit(Bit20) in the
> Capability Register.
>=20
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   36 ++++++++++++++++++++++++++++++=
+-----
>  1 files changed, 31 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index a19967d..8015e1a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -31,6 +31,8 @@
>  #define SDHCI_VENDOR_SPEC		0xC0
>  #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
> =20
> +#define  SDHCI_SPEC_INT_ADMA_ERR	0x10000000

There is no register SDHCI_SPEC_*. I'd suggest
"SDHCI_INT_VENDOR_SPEC_ADMA_ERROR".

> +	if (unlikely(reg =3D=3D SDHCI_CAPABILITIES)) {
> +		if (val & SDHCI_CAN_DO_ADMA1) {
> +			val &=3D ~SDHCI_CAN_DO_ADMA1;
> +			val |=3D SDHCI_CAN_DO_ADMA2;

Why is this needed? Above you say, MX51/53 has ADMA2 bit already set?
And you would set ADMA2 for mx25/35 now?

> @@ -154,7 +177,7 @@ static void esdhc_writew_le(struct sdhci_host *host, =
u16 val, int reg)
> =20
>  static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  {
> -	u32 new_val;
> +	u16 new_val;

Why? esdhc_clrset_le wants a u32.

> =20
>  	switch (reg) {
>  	case SDHCI_POWER_CONTROL:
> @@ -168,10 +191,12 @@ static void esdhc_writeb_le(struct sdhci_host *host=
, u8 val, int reg)
>  		new_val =3D val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
>  		/* ensure the endianess */
>  		new_val |=3D ESDHC_HOST_CONTROL_LE;
> -		/* DMA mode bits are shifted */
> -		new_val |=3D (val & SDHCI_CTRL_DMA_MASK) << 5;
> +		if (val & SDHCI_CTRL_DMA_MASK)
> +			/* DMA mode bits are shifted */
> +			new_val |=3D (val & SDHCI_CTRL_DMA_MASK) << 5;

I think the if doesn't save much than just doing this simple operation; it =
also
adds another line and level of indentation.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3v294ACgkQD27XaX1/VRtDAQCeJFVgUMgs3uJuI6vf3D9Gf59h
JQoAoLGYQS8BA9M6Ldi7fFq372r8zY/v
=Wcri
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
