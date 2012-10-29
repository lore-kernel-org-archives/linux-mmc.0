From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND PATCH] mmc: omap_hsmmc: Enable HSPE bit for high speed
 cards
Date: Mon, 29 Oct 2012 18:17:19 +0200
Message-ID: <20121029161719.GI27566@arwen.pp.htv.fi>
References: <1351515408-19403-1-git-send-email-gururaja.hebbar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45981 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495Ab2J2QXR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 12:23:17 -0400
Content-Disposition: inline
In-Reply-To: <1351515408-19403-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: svenkatr@ti.com, cjb@laptop.org, balajitk@ti.com, grant.likely@secretlab.ca, nsekhar@ti.com, sudhakar.raj@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com

--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 29, 2012 at 06:26:48PM +0530, Hebbar, Gururaja wrote:
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
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> ---
> Rebased on mmc-next (v3.7.0-rc1)
> Only Build tested since EDMA support for AM335x is not yet added
>=20
> :100644 100644 be76a23... ed271fc... M	Documentation/devicetree/bindings/=
mmc/ti-omap-hsmmc.txt
> :100644 100644 8b4e4f2... 346af5b... M	arch/arm/plat-omap/include/plat/mm=
c.h
> :100644 100644 54bfd0c... 3fd95cb... M	drivers/mmc/host/omap_hsmmc.c
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

can't you do runtime revision detection for this ?

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
> index 54bfd0c..3fd95cb 100644
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

not part of $SUBJECT

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

is this really needed...

> +	    (ios->timing !=3D MMC_TIMING_UHS_DDR50) &&
> +	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) =3D=3D HSS)) {

=2E.. provided you check device's register ?

> +		regval =3D OMAP_HSMMC_READ(host->base, HCTL);
> +		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
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
> +
>  	return pdata;
>  }
>  #else
> --=20
> 1.7.0.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjqwPAAoJEIaOsuA1yqREp/UP/3IVk+UNxCeq6O+0cj1iepZZ
7/GnSfvC6vcgWCfnQN25mxkG2hAXlv+fdOVPpRRoXXjpewu1Zc3yWwipUS1Tyjwj
ZWPVd6W2O0Ct5vvSalp1m6iPoC102+Trk8QAQoqc+eiecQ+8arEhodF6EbVYOijC
quWmQf3wN2CHz0YI+K5Oz3jhmOpP+1PJ6A5ehAmUN5RrQvvXDF9KhP/vtAFOJwHu
dni9blOA5ZIfF/kOeesQ+Sr7X8l3B5JYUxans5y1gvDnVLpMdkjWpKqZqAyiW9Pq
uBH7NtuqTuhl+3RPI8+226grqyCQumvEdwxvKv0AgFK8TkQEPVwj/GIXgSYpuD5A
8WH7Xqq5SzmUfcPHzs46DPOy1sCiygL8Ab89KHtUFsX2SwJfRFJaO8PJu4uQsjJo
ecd8qnz3YdXOSdT+HAfdQhfVTV1TNbiBrJNZpAT8io6N7ORWcD5LyfW3+JYT4W2R
Q9l/k4qRuKvDalj31dllezGDdwADrPYme6dFeejicE336L2JoSS7IF8aevybql2O
A6qLG+OMj6kXnBlo7PlKDUcxCBXJtK7Pd/vsONOJDV+edw9QrJNB2val4cKyuLpK
RHDm/9Gr7+tyeNgT0qP+rkMgzFNIBGtkOE6jVlyyyX15MQsT8eadHs89dgh5/ENO
V/g955GypSwkJC6gnpJw
=BXNP
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
