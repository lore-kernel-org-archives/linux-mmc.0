From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND PATCH V2] mmc: omap_hsmmc: Enable HSPE bit for high
 speed cards
Date: Wed, 31 Oct 2012 12:04:22 +0200
Message-ID: <20121031100422.GA10094@arwen.pp.htv.fi>
References: <1351672116-17309-1-git-send-email-gururaja.hebbar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49961 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab2JaKKW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 31 Oct 2012 06:10:22 -0400
Content-Disposition: inline
In-Reply-To: <1351672116-17309-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: balbi@ti.com, svenkatr@ti.com, cjb@laptop.org, balajitk@ti.com, grant.likely@secretlab.ca, nsekhar@ti.com, sudhakar.raj@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 01:58:35PM +0530, Hebbar, Gururaja wrote:
> HSMMC IP on AM33xx need a special setting to handle High-speed cards.
> Other platforms like TI81xx, OMAP4 may need this as-well. This depends
> on the HSMMC IP timing closure done for the high speed cards.
>=20
> From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
>=20
> The MMC/SD/SDIO output signals can be driven on either falling edge or
> rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
> to reach better timing performance, and thus to increase data transfer
> frequency.
>=20
> There are few pre-requisites for enabling the HSPE bit
> - Controller should support High-Speed-Enable Bit and
> - Controller should not be using DDR Mode and
> - Controller should advertise that it supports High Speed in
>   capabilities register and
> - MMC/SD clock coming out of controller > 25MHz
>=20
> Note:
> The implementation reuses the output of calc_divisor() so as to reduce
> code addition.
>=20
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> ---
> Rebased on mmc-next (v3.7.0-rc1)
> Only Build tested since EDMA support for AM335x is not yet added
>=20
> Changes in V2
> 	- Added note in commit message about code re-use
> 	- replaced ((a & BIT(n) =3D=3D BIT(n))) with (a & BIT(n)) since
> 	  effectively both are same.
>=20
> :100644 100644 be76a23... ed271fc... M	Documentation/devicetree/bindings/=
mmc/ti-omap-hsmmc.txt
> :100644 100644 8b4e4f2... 346af5b... M	arch/arm/plat-omap/include/plat/mm=
c.h
> :100644 100644 54bfd0c... 5ea4c9d... M	drivers/mmc/host/omap_hsmmc.c
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
>  arch/arm/plat-omap/include/plat/mmc.h              |    1 +
>  drivers/mmc/host/omap_hsmmc.c                      |   30 ++++++++++++++=
+++++-
>  3 files changed, 31 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Do=
cumentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index be76a23..ed271fc 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -19,6 +19,7 @@ ti,dual-volt: boolean, supports dual voltage cards
>  "supply-name" examples are "vmmc", "vmmc_aux" etc
>  ti,non-removable: non-removable slot (like eMMC)
>  ti,needs-special-reset: Requires a special softreset sequence
> +ti,needs-special-hs-handling: HSMMC IP needs special setting for handlin=
g High Speed
> =20
>  Example:
>  	mmc1: mmc@0x4809c000 {
> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/i=
nclude/plat/mmc.h
> index 8b4e4f2..346af5b 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -126,6 +126,7 @@ struct omap_mmc_platform_data {
>  		/* we can put the features above into this variable */
>  #define HSMMC_HAS_PBIAS		(1 << 0)
>  #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
> +#define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
>  		unsigned features;
> =20
>  		int switch_pin;			/* gpio (card detect) */
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 54bfd0c..5ea4c9d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -62,6 +62,7 @@
> =20
>  #define VS18			(1 << 26)
>  #define VS30			(1 << 25)
> +#define HSS			(1 << 21)
>  #define SDVS18			(0x5 << 9)
>  #define SDVS30			(0x6 << 9)
>  #define SDVS33			(0x7 << 9)
> @@ -89,6 +90,7 @@
>  #define MSBS			(1 << 5)
>  #define BCE			(1 << 1)
>  #define FOUR_BIT		(1 << 1)
> +#define HSPE			(1 << 2)
>  #define DDR			(1 << 19)
>  #define DW8			(1 << 5)
>  #define CC			0x1
> @@ -489,6 +491,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_ho=
st *host)
>  	struct mmc_ios *ios =3D &host->mmc->ios;
>  	unsigned long regval;
>  	unsigned long timeout;
> +	unsigned long clkdiv;
> =20
>  	dev_vdbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
> =20
> @@ -496,7 +499,8 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_ho=
st *host)
> =20
>  	regval =3D OMAP_HSMMC_READ(host->base, SYSCTL);
>  	regval =3D regval & ~(CLKD_MASK | DTO_MASK);
> -	regval =3D regval | (calc_divisor(host, ios) << 6) | (DTO << 16);
> +	clkdiv =3D calc_divisor(host, ios);
> +	regval =3D regval | (clkdiv << 6) | (DTO << 16);
>  	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
>  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
>  		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
> @@ -507,6 +511,27 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_h=
ost *host)
>  		&& time_before(jiffies, timeout))
>  		cpu_relax();
> =20
> +	/*
> +	 * Enable High-Speed Support
> +	 * Pre-Requisites
> +	 *	- Controller should support High-Speed-Enable Bit
> +	 *	- Controller should not be using DDR Mode
> +	 *	- Controller should advertise that it supports High Speed
> +	 *	  in capabilities register
> +	 *	- MMC/SD clock coming out of controller > 25MHz
> +	 */
> +	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
> +	    (ios->timing !=3D MMC_TIMING_UHS_DDR50) &&
> +	    (OMAP_HSMMC_READ(host->base, CAPA) & HSS)) {
> +		regval =3D OMAP_HSMMC_READ(host->base, HCTL);
> +		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)

that clk rate could be a symbolic define.

> +			regval |=3D HSPE;
> +		else
> +			regval &=3D ~HSPE;
> +
> +		OMAP_HSMMC_WRITE(host->base, HCTL, regval);
> +	}
> +
>  	omap_hsmmc_start_clock(host);
>  }
> =20
> @@ -1700,6 +1725,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_=
pdata(struct device *dev)
>  	if (of_find_property(np, "ti,needs-special-reset", NULL))
>  		pdata->slots[0].features |=3D HSMMC_HAS_UPDATED_RESET;
> =20
> +	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
> +		pdata->slots[0].features |=3D HSMMC_HAS_HSPE_SUPPORT;

this could be of_property_read_bool().

--=20
balbi

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkPemAAoJEIaOsuA1yqRE9HwP/2lclxOXCeuHymIWwND4ixpK
BZJ0MHwn7aLIb4WqHvkM5UYSiTWDFeNSXtWcxT9RjY8fX9Qs3QH5vmPs/wLRXYjZ
fx5pJzeaQ0dBgAjpYevigE78K+e3KehMGUe/LhVZq4RfXfTjmcSQRV5zEk0MT47h
2Wib1+u6dpAFN0KMn1oUnOCTtOFY8qGUuUP1/xIJPCXUPzAOfOydw2H47Y/pAVOp
Emmic0bBlvMewb8FTHTLyEKHBZdX/jfBSi+HnrEbRdA8l59G7Bm30C1CsJFsBG00
KL61TrgYLes3G7WywD1pvF95YwbVv7jXRTc3cf84H+SK+VazvLcSTu4y6wc3rfRS
PnxOtGMw6tO7m3EETpo5jr2VzxjccOprVmMdm6jhwTXRh/wqqyYnQxVO0iA6lF1X
1Y07nKmJJyyl07xlflITA1nIQnNZutYFKIzLWKkUS9kC5cp2dUMiiaey11Nu8kEI
Di3puI2A5ou40pGCDuyPBFkuuwUAEpFpDRRtWFkI+wITnae5U5SC3OHXZleEgDfn
Nm2Gfvf7cHbHQx51dWB9bZGtlTrf5DGgx4GhU/cLzP6/KBH0Cg6keJI3ut+zhopw
U1T5jxJ9G2SlsF/sHBXFDxBvK9Hp+pMUm93VV3CqzWfYW+YANaYG3mOUaaI6Yde7
DRpDKpC7D5u9hE+xuGuh
=+0xz
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
