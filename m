From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 02/40] dt-bindings: mmc: tegra: Add pad voltage control
 properties
Date: Thu, 9 Aug 2018 14:15:00 +0200
Message-ID: <20180809121500.GP21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-3-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-3-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:52PM +0300, Aapo Vienamo wrote:
> Document the pinctrl bindings used by the SDHCI driver to reconfigure
> pad voltages on controllers supporting multiple voltage levels.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 9bce578..90c214d 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -38,3 +38,25 @@ sdhci@c8000200 {
>  	power-gpios =3D <&gpio 155 0>; /* gpio PT3 */
>  	bus-width =3D <8>;
>  };
> +
> +Optional properties for Tegra210 and Tegra186:
> +- pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
> +  configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
> +  for controllers supporting multiple voltage levels. The order of names
> +  should correspond to the pin configuration states in pinctrl-0 and
> +  pinctrl-1.

Do we also want "sdmmc-off" to allow SDMMC pads to be powered down when
the slot or card is not used?

Thierry

> +
> +Example:
> +sdhci@700b0000 {
> +	compatible =3D "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
> +	reg =3D <0x0 0x700b0000 0x0 0x200>;
> +	interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks =3D <&tegra_car TEGRA210_CLK_SDMMC1>;
> +	clock-names =3D "sdhci";
> +	resets =3D <&tegra_car 14>;
> +	reset-names =3D "sdhci";
> +	pinctrl-names =3D "sdmmc-3v3", "sdmmc-1v8";
> +	pinctrl-0 =3D <&sdmmc1_3v3>;
> +	pinctrl-1 =3D <&sdmmc1_1v8>;
> +	status =3D "disabled";
> +};
> --=20
> 2.7.4
>=20

--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMEQACgkQ3SOs138+
s6EKVQ/9Hkhh22E0hhTKV3WiJWymoURwVYwRFr/2l3Hk/IqQYO+48fPgKaQ2yxyx
W7CSmOP0uYd0kxaiFjQtnFDRwmT/nn+SGiYk6Vf+HEbGn4GeReVXRxSiiFvySNVU
bF/9z1aMBaAeAnXrvp9pvMZsEy0fA3+qZGZUAvYEZjrcbWp1Ew0JHbLc8x2QlNVr
l4/vm/OBsoliidFGCB/hyFoLTwb2+wUSUuUfLCkNADYJ12y78+njPgB0pJDBoG0p
pQHb9csVIaeSdfHv4SxIBS2jS2VsLraWQ56gMILsst74RNz/6rXu36VPK3MuXvrD
73RsBjb8E28TJS1WPKubtuRmSXWUzMCaYsY73K70dk1APhkz9gYWhdgtXeTLhxAZ
k4sPQFJw5U1Vx3xhy4tKKrr6tnXV+8GTl3ufO5IabPTms+/GVfad06v5Ot/WX6fh
gOe4ic/rWqxjHt30Qr9aq8NLjyXEWxZ64GJwf30UcpFDLq4jcANt/dnMdmrnZwlX
+fgDLcizuUDxToWN3cwLxlS0GekZARu0Qkfaq5z80xgmTrTi5DuYskeHBNhfGN8c
hLpfE0yxD9jrLJCqA8LDYTAZmFbBhoCEVTJ4BwEpBvBdyzGLstj/+wLcUTnKBGoq
zK9gpP+oMV3toAQvguswH71LlYBfYcfHVfgT+Qb3Xc3v9uhnxLo=
=LFLg
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--
