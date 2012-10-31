From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3] mmc: omap_hsmmc: Enable HSPE bit for high speed cards
Date: Wed, 31 Oct 2012 14:26:39 +0200
Message-ID: <20121031122639.GA10998@arwen.pp.htv.fi>
References: <1351684656-30275-1-git-send-email-gururaja.hebbar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351684656-30275-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: balbi@ti.com, svenkatr@ti.com, cjb@laptop.org, balajitk@ti.com, grant.likely@secretlab.ca, nsekhar@ti.com, sudhakar.raj@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, rob@landley.net, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 05:27:36PM +0530, Hebbar, Gururaja wrote:
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

this looks good to my eyes, hopefully I haven't missed anything:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> Rebased on mmc-next (v3.7.0-rc1)
> Only Build tested since EDMA support for AM335x is not yet added
>=20
> Changes in V2
> 	- Added note in commit message about code re-use
> 	- replaced ((a & BIT(n) =3D=3D BIT(n))) with (a & BIT(n)) since
> 	  effectively both are same.
>=20
> Changes in V3
> 	- use symbolic define for hardcoded value (25000000)
> 	- use of_property_read_bool() instead of of_find_property()
>=20
> :100644 100644 be76a23... ed271fc... M	Documentation/devicetree/bindings/=
mmc/ti-omap-hsmmc.txt
> :100644 100644 8b4e4f2... 346af5b... M	arch/arm/plat-omap/include/plat/mm=
c.h
> :100644 100644 5434fd8... 4f7fcee... M	drivers/mmc/host/omap_hsmmc.c
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
>  arch/arm/plat-omap/include/plat/mmc.h              |    1 +
>  drivers/mmc/host/omap_hsmmc.c                      |   31 ++++++++++++++=
+++++-
>  3 files changed, 32 insertions(+), 1 deletions(-)
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
> index 5434fd8..4f7fcee 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -63,6 +63,7 @@
> =20
>  #define VS18			(1 << 26)
>  #define VS30			(1 << 25)
> +#define HSS			(1 << 21)
>  #define SDVS18			(0x5 << 9)
>  #define SDVS30			(0x6 << 9)
>  #define SDVS33			(0x7 << 9)
> @@ -90,6 +91,7 @@
>  #define MSBS			(1 << 5)
>  #define BCE			(1 << 1)
>  #define FOUR_BIT		(1 << 1)
> +#define HSPE			(1 << 2)
>  #define DDR			(1 << 19)
>  #define DW8			(1 << 5)
>  #define CC			0x1
> @@ -113,6 +115,7 @@
>  #define MMC_TIMEOUT_MS		20
>  #define OMAP_MMC_MIN_CLOCK	400000
>  #define OMAP_MMC_MAX_CLOCK	52000000
> +#define HSMMC_CLKOUT	25000000
>  #define DRIVER_NAME		"omap_hsmmc"
> =20
>  /*
> @@ -495,6 +498,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_ho=
st *host)
>  	struct mmc_ios *ios =3D &host->mmc->ios;
>  	unsigned long regval;
>  	unsigned long timeout;
> +	unsigned long clkdiv;
> =20
>  	dev_vdbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
> =20
> @@ -502,7 +506,8 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_ho=
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
> @@ -513,6 +518,27 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_h=
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
> +		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > HSMMC_CLKOUT)
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
> @@ -1709,6 +1735,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_=
pdata(struct device *dev)
>  	if (!of_property_read_u32(np, "max-frequency", &max_freq))
>  		pdata->max_freq =3D max_freq;
> =20
> +	if (of_property_read_bool(np, "ti,needs-special-hs-handling"))
> +		pdata->slots[0].features |=3D HSMMC_HAS_HSPE_SUPPORT;
> +
>  	return pdata;
>  }
>  #else
> --=20
> 1.7.0.4
>=20

--=20
balbi

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkRj/AAoJEIaOsuA1yqREwWMQAJ+yMrdRn7sC1n+Cv5nKuoo7
aD5GxMCmLVCicjoIN6w5sH8TAwy17Y9/+ZeCrU7c07p8Z5EGPE2gIeV78y99Ye0b
pEZ40IVfe8iPwD+Zbvv4L1vA1Nn6mX++JDI4Mr3Ot8T4gPAHoiUwI5wIhnTkHW2Z
EkIJofrvXj6+mVm/sLiQQqdFeNf5mqh5Qq4cglUpnO9Ly2tJ1FwoCF/jA1TSYUuw
3hj/94UBxxahGelm/9CKVz0m9VtUwqfLxwP+98nbuE1sU3gn4GBaaLnvJRScp9QQ
zXcfhrgU3bzOlNEvPw/ITFA7gguwdMgVJNiMSJiBpnMGElGNl5hpI3Vza/47BxWp
Pn0ECd/30wpQtiGWUXHn+rSSCI5Jnn/Pz++yFQQAtT4MTgsHRK24/YZHb8cqF+n9
DO3sJBXCV0VGqMDI9Zjx/MN1sskH7s4tRCk5HV9eveEkk+Dt9YB4F7H73wFjXeou
90M18gS5PZ0GmNCYoapijHMaos9E8ez3SB4VhxaTN2qAqsnyr7cSper9yPlbVftD
3RxeI15qdXRFcp3YTVRz8C98PjiX6d5RNv3ACrkUKY5vE4NKOZhMB4xmfURkGYcx
QWn0RZRqDqMVvbE8ExGoNuldreu8cAjW+3FE1DpkmVmvMlIeqPOCVYjG8IWobEQE
tCG4YiGiBeQbBoqJn+Hp
=PjbK
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
