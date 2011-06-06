From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC] mmc: Enable the ADMA on esdhc imx driver
Date: Mon, 6 Jun 2011 18:49:46 +0200
Message-ID: <20110606164946.GA14126@pengutronix.de>
References: <1307005930-10935-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45509 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab1FFQtv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2011 12:49:51 -0400
Content-Disposition: inline
In-Reply-To: <1307005930-10935-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric.miao@linaro.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 05:12:10PM +0800, Richard Zhu wrote:
> Eanble the ADMA mode on freescale esdhc imx driver,
> tested on MX51 and MX53.

Please describe a little bit why the patch helps. Does it also work on mx25=
/35?
What does the new bit cover what the old one didn't cover? Why does the new=
 one
even exist?

>=20
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   40 ++++++++++++++++++++++++++++++=
-----
>  1 files changed, 34 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index a19967d..64f33cb 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -31,6 +31,8 @@
>  #define SDHCI_VENDOR_SPEC		0xC0
>  #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
> =20
> +#define  SDHCI_VENDOR_SPEC_INT_ADMA_ERR	0x10000000
> +

=46rom the code below, this name is wrong because the bit is not in VENDOR_=
SPEC.

> @@ -166,12 +189,16 @@ static void esdhc_writeb_le(struct sdhci_host *host=
, u8 val, int reg)
>  	case SDHCI_HOST_CONTROL:
>  		/* FSL messed up here, so we can just keep those two */
>  		new_val =3D val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
> -		/* ensure the endianess */
> +		/* ensure the endi1ness */

Ehrm?

> -		/* DMA mode bits are shifted */
> -		new_val |=3D (val & SDHCI_CTRL_DMA_MASK) << 5;
> +		if (val & SDHCI_CTRL_DMA_MASK) {
> +			/* DMA mode bits are shifted */
> +			new_val |=3D (val & SDHCI_CTRL_DMA_MASK) << 5;
> +
> +			esdhc_clrset_le(host, 0xffff, new_val, reg);
> +		} else
> +			esdhc_clrset_le(host, 0xff, val, reg);

Why can't we always write 16-bit? (and else-block needs braces)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3tBSoACgkQD27XaX1/VRvXugCePvKLBeEfnrlGUucKkmMSIUtq
lsUAn3hzzT8Lef0cn+6eukxc3p6CApgo
=c4WK
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
