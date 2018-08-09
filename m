From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 01/40] dt-bindings: Add Tegra PMC pad configuration
 bindings
Date: Thu, 9 Aug 2018 14:13:50 +0200
Message-ID: <20180809121350.GO21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-2-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-2-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:51PM +0300, Aapo Vienamo wrote:
> Document the PMC pinctrl bindings for pad power state and signaling
> voltage configuration. Both nvidia,tegra186-pmc.txt and
> nvidia,tegra20-pmc.txt are modified as they both cover SoC generations
> for which these bindings apply.
>=20
> Add a header defining Tegra PMC pad voltage configurations.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  92 +++++++++++++++=
+++
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++++++++++++++=
++++++
>  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 ++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-=
pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.t=
xt
> index 5a3bf7c..d7fed4d 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> @@ -34,3 +34,95 @@ Board DTS:
>  	pmc@c360000 {
>  		nvidia,invert-interrupt;
>  	};
> +
> +=3D=3D Pad Control =3D=3D
> +
> +On Tegra SoCs a pad is a set of pins which are configured as a group.
> +The pin grouping is a fixed attribute of the hardware. The PMC can be
> +used to set pad power state and signaling voltage. A pad can be either
> +in active or power down mode. The support for power state and signaling
> +voltage configuration varies depending on the pad in question. 3.3 V and
> +1.8 V signaling voltages are supported on pins where software
> +controllable signaling voltage switching is available.
> +
> +Pad configurations are described is with pin configuration nodes which

The "is" in the middle there seems to be left-over from a previous
formulation of the sentence.

> +are placed under the pmc node and they are referred to by the pinctrl
> +client properties. For more information see
> +Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> +
> +Following pads are present on Tegra186:

"The following pads..."

> +csia		csib		dsi		mipi-bias
> +pex-clk-bias	pex-clk3	pex-clk2	pex-clk1
> +usb0		usb1		usb2		usb-bias
> +uart		audio		hsic		dbg
> +hdmi-dp0	hdmi-dp1	pex-cntrl	sdmmc2-hv
> +sdmmc4		cam		dsib		dsic
> +dsid		csic		csid		csie
> +dsif		spi		ufs		dmic-hv
> +edp		sdmmc1-hv	sdmmc3-hv	conn
> +audio-hv	ao-hv
> +
> +Required pin configuration properties:
> +  - pins: Must contain name of the pad(s) to be configured.

"the name". Also, I'm assuming that this can take a list of names, so
perhaps this should read:

	- pins: A list of strings, each of which contains the name of a pad
	    to be configured.

> +
> +Optional pin configuration properties:
> +  - low-power-enable: Configure the pad into power down mode
> +  - low-power-disable: Configure the pad into active mode

Do we need both of these? low-power could be a boolean property to mean
that the pad(s) should be configured in power down mode. If absent it
would mean that the pad(s) should be configured in normal mode. The only
reason why I can think of them to have to be separate is if we want to
define a configuration where the power mode is not touched. But is that
really something we need or want?

> +  - power-source: Must contain either TEGRA_IO_PAD_VOLTAGE_1V8 or
> +    TEGRA_IO_PAD_VOLTAGE_3V3 to select between signaling voltages.
> +    The values are defined in
> +    include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.

Why is this called "power-source"? This defines the signaling voltage of
the pad, so why not something like "power-level", or "voltage", or
"output-voltage"?

Or is this because it is a mux that will internally select either a
1.8 V or a 3.3 V source? In which case I guess this is okay. Perhaps
give some explanation of the mechanics of the underlying hardware to
make this more obvious.

> +
> +Note: The power state can be configured on all of the above pads except
> +      for ao-hv. Following pads have software configurable signaling
> +      voltages: sdmmc2-hv, dmic-hv, sdmmc1-hv, sdmmc3-hv, audio-hv,
> +      ao-hv.
> +
> +Pad configuration state example:
> +	pmc: pmc@7000e400 {
> +		compatible =3D "nvidia,tegra186-pmc";
> +		reg =3D <0 0x0c360000 0 0x10000>,
> +		      <0 0x0c370000 0 0x10000>,
> +		      <0 0x0c380000 0 0x10000>,
> +		      <0 0x0c390000 0 0x10000>;
> +		reg-names =3D "pmc", "wake", "aotag", "scratch";
> +
> +		...
> +
> +		sdmmc1_3v3: sdmmc1-3v3 {
> +			pins =3D "sdmmc1-hv";
> +			power-source =3D <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc1_1v8: sdmmc1-1v8 {
> +			pins =3D "sdmmc1-hv";
> +			power-source =3D <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};

Wouldn't these be implicitly low-power-disable? What if these are off by
default? Selecting these states would change the power source but keep
them in power down, no? Don't we want something like the below instead?

		sdmmc1_3v3: sdmmc1-3v3 {
			pins =3D "sdmmc1-hv";
			power-source =3D <TEGRA_IO_PAD_VOLTAGE_3V3>;
			/* low-power-disable implied here */
		};

		sdmmc1_1v8: sdmmc1-1v8 {
			pins =3D "sdmmc1-hv";
			power-source =3D <TEGRA_IO_PAD_VOLTAGE_1V8>;
			/* low-power-disable implied here */
		};

		sdmmc1_off: sdmmc1-off {
			pins =3D "sdmmc1-hv";
			low-power;
		};

That would allow the SDHCI driver to select between the two signaling
modes and a separate state for powering down the pad.

> +
> +		hdmi_off: hdmi-off {
> +			pins =3D "hdmi";
> +			low-power-enable;
> +		}
> +
> +		hdmi_on: hdmi-on {
> +			pins =3D "hdmi";
> +			low-power-disable;
> +		}

These would similarily become:

		hdmi_off: hdmi-off {
			pins =3D "hdmi";
			low-power;
		};

		hdmi_on: hdmi-on {
			pins =3D "hdmi";
		};

> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-p=
mc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index a74b37b..5363b90 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -195,3 +195,106 @@ Example:
>  		power-domains =3D <&pd_audio>;
>  		...
>  	};
> +
> +=3D=3D Pad Control =3D=3D
> +
> +On Tegra SoCs a pad is a set of pins which are configured as a group.
> +The pin grouping is a fixed attribute of the hardware. The PMC can be
> +used to set pad power state and signaling voltage. A pad can be either
> +in active or power down mode. The support for power state and signaling
> +voltage configuration varies depending on the pad in question. 3.3 V and
> +1.8 V signaling voltages are supported on pins where software
> +controllable signaling voltage switching is available.
> +
> +The pad configuration state nodes are placed under the pmc node and they
> +are referred to by the pinctrl client properties. For more information
> +see Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> +The pad name should be used as the value of the pins property in pin
> +configuration nodes.
> +
> +Following pads are present on Tegra124 and Tegra132:
> +audio		bb		cam		comp
> +csia		csb		cse		dsi
> +dsib		dsic		dsid		hdmi
> +hsic		hv		lvds		mipi-bias
> +nand		pex-bias	pex-clk1	pex-clk2
> +pex-cntrl	sdmmc1		sdmmc3		sdmmc4
> +sys_ddc		uart		usb0		usb1
> +usb2		usb_bias
> +
> +Following pads are present on Tegra210:
> +audio		audio-hv	cam		csia
> +csib		csic		csid		csie
> +csif		dbg		debug-nonao	dmic
> +dp		dsi		dsib		dsic
> +dsid		emmc		emmc2		gpio
> +hdmi		hsic		lvds		mipi-bias
> +pex-bias	pex-clk1	pex-clk2	pex-cntrl
> +sdmmc1		sdmmc3		spi		spi-hv
> +uart		usb0		usb1		usb2
> +usb3		usb-bias

What about chips prior to Tegra124?

Thierry

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsL/wACgkQ3SOs138+
s6FEgQ/+MtQ0fxIXDUNK2HsXkdHw2vRGHMBEuqJFZyTbAYLOhT4Oi0u91UIHkba5
m6yztZJQPLCtc3OU5HuXDqtCNYRD+HUoKpRgDqmjVlY0oKgzlnzVFmfmAwOAfH30
ktGPJC6o7aUB+5D2ed/uk4zLAywBvPFgP8KmcfYzRR1cRLG+mpzPbkcDKOd+XYX+
3nvG36eiEhfuNRE9PkpmiGHoXq8ktnZOikMFv0f1308uXJ4ynXrRck4EhTTX2gRd
KE3Z54UeV1o49ao41VSumr1Bu0gc53fpKl3nRgp/KoxO6c5wH90HCGebvXboNnf+
z6GYQxsZi7LfxMrgMUQ6mwDC81YY5Wb+zgb/yLy5pZy577FLe6F1sz2yZ5LMzcCT
wavSxlUGqi3TWDTFEQaaC7jdHBhc3YcHoNxue6Rto+15HZE3U6IXoHVmJVTjK6Oq
XnmKCVstIZvjt36Bbi8j4gTZm5o7Nbu3zXyuqQ4QN9gIiKCKOJefyxBhkmf2oPRQ
wA6RZS/x7zvvH62d67EsryLnHMS/DRYDJbUAVr4XCTIezK1obQ67yYlcnUj9zu3A
NZ7jPWaE5m22YXeWlfi3CGGbWXo1h5M8ME2WyEBNtZ0QR1xHmdpiAmnZ84HAe5NM
VXjgZBBmSbYYUfe3uDfsa7Mn++V2X0yZjJZKrQwSeP+6zWRYfks=
=OVwz
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
