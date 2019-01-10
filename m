From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad
 drive strength config
Date: Thu, 10 Jan 2019 15:48:53 +0100
Message-ID: <20190110144853.GB25353@ulmo>
References: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 12:57:52PM -0800, Sowjanya Komatineni wrote:
> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc which has pad configuration registers in the pinmux
> reigster domain.
> Pad drive strengths for Tegra186 and Later are
> part of SDMMC device node itself.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Hi Rob,

any chance you could take a look at this?

Thanks,
Thierry

> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..2cecdc71d94c 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -39,12 +39,16 @@ sdhci@c8000200 {
>  	bus-width =3D <8>;
>  };
> =20
> -Optional properties for Tegra210 and Tegra186:
> +Optional properties for Tegra210, Tegra186 and Tegra194:
>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for
> +  Tegra210 where pad config registers are in the pinmux register domain
> +  for pull-up-strength and pull-down-strength values configuration when
> +  using pads at 3V3 and 1V8 levels.
>  - nvidia,only-1-8-v : The presence of this property indicates that the
>    controller operates at a 1.8 V fixed I/O voltage.
>  - nvidia,pad-autocal-pull-up-offset-3v3,
> --=20
> 2.7.4
>=20

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3W1UACgkQ3SOs138+
s6H3axAAozYOuxywpdMdLfOIgXUnfWBigHXMNhK4eINNJyBlqfSnQmHLuNoWoXJ0
6evDzZY6rHZ94K1UlsMIz7cNvZrxdn1Rt0lq1+ye8ohgWdCP5cFZoESZX59xGGLN
E5iyiPEmUN+Ec8PKefOFLUAH2xPE+4syKqDbXQV4Lm9Maj7HzFT9YwK5Pwazv224
AYDC45wZMP5U7QLm07bcaJ4clytxtRaPvDBxT+ugaJy4DrdWNcsbSI6jyEcjaxh2
zzPLbb1ujVXSz+EFpZ/voAuxM85eruFMDmBIaKA640LDMjq1nEknSa0Y8wZYFwG5
F3/59TdkuRFylNVRwCStt0n39tFNxsvxuqzkhM6gWgCMyVD7mBS/kXnp0v0v/DoB
nkKIf+eJljrgTh4w4C4OS+edga9F7HS9DuH1a9iATq8HxSKkJjsLPkCKxwKOZhhk
kDPUc7tFq7hwffkXsSoYNszEVM75kF2ujWUW5dqOPiTy7YxsyvjrJUgmViEBfYZO
S1BM/N3c5QKMO+M2ilArDiIArZwfLaWi9OypGi50NBYskei+50IGMbMWLildV2sv
UjRmWWN1Ms1kQxmHA9TphLUtUdArvWxMZPy+fe0bThMBKPrWtA30v/GkWWjhSI/C
FY0j3+yBOPccAb0XlGDuEYLIHiXYuJtvJstET4Ky1fkpnVXSJBg=
=aOWC
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
