From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/8] mmc: tegra: Implement HS400 delay line calibration
Date: Thu, 9 Aug 2018 13:48:05 +0200
Message-ID: <20180809114805.GM21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-5-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533650404-18125-5-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 05:00:00PM +0300, Aapo Vienamo wrote:
> Implement HS400 specific delay line calibration procedure.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Should this be before the previous patch in order to make sure the
calibration is performed as soon as the feature is available. This is
counting beans I guess, but it is technically possible for someone to
get everything up to patch 3/8 and then get the corresponding changes
in the DTS files to enable the mode and then have HS400 enabled without
this calibration.

Thierry

>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index d81143b..d0b68b7 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -56,6 +56,12 @@
>  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
>  #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
> =20
> +#define SDHCI_TEGRA_VENDOR_DLLCAL_CFG			0x1b0
> +#define SDHCI_TEGRA_DLLCAL_CALIBRATE			BIT(31)
> +
> +#define SDHCI_TEGRA_VENDOR_DLLCAL_STA			0x1bc
> +#define SDHCI_TEGRA_DLLCAL_STA_ACTIVE			BIT(31)
> +
>  #define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
>  #define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
> =20
> @@ -584,6 +590,24 @@ static void tegra_sdhci_set_dqs_trim(struct sdhci_ho=
st *host, u8 val)
>  	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
>  }
> =20
> +static void tegra_sdhci_hs400_dll_cal(struct sdhci_host *host)
> +{
> +	u32 reg;
> +	int err;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);
> +	reg |=3D SDHCI_TEGRA_DLLCAL_CALIBRATE;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);

Is this self-clearing? Or do we need to clear it manually in order for
a subsequent calibration procedure to succeed?

Thierry

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKfUACgkQ3SOs138+
s6G9MQ//QdjtfxfjkrmCbxq8Dr3mrsjX03o7Ttvkc5lnKy8OEFDf39wCEsM3ftEY
ibBbCDxaEy72T4324+oPhQnHDBeT8Is6yNiKRfeA0Zp1zkyruPZW9B2wbSQ575tB
mGq6oX6ePd0+C7Ok0NGL14wmZV1EL0ZPTQpZLmGEwUjXn6MyHG3jY5VuUGmedPyl
ExpMQ0EE8Nw+HECTdJlZYaIntjTkhDTrPGO4xDLA0VOXrlF8zCihsZf7UiRsHxP8
2dmmL9u1ul9iPwpKrbhD7ycfnKfDtwGoCNRLzvgN1Xx8vKYuUv527HmmBaGOJiYb
eu6AaiUXQtZ+8V6hqurK0p9/CZvukLXdbNji4EuNdgJHbXy9BBTNYlaCiMCnBzoq
4dfmQHxO/vDDNx8EPlSvNBOblAkfanI7p24LWDcl+BDXT5RzJvmpeYZKTAx46vQ0
+tJHrZYOO9axSo9xgKNXUKa1YOUSgqHUmSJXL0MqwjcHFjJYxdrwF/crf3ksmdqG
hjd0wwnw1Mdc36sXYQjQDQCtl08qhjkQzzDxvRtd7k4oe0TF23Y1LezJ/Zc4oR/G
r72ubrAmPjvajsExNo+MLY+mczYEfc+clFqfbjoR9UezxSQfihSQQIcWZku6ZDRY
fNkXCXTg/eWkJYbZmS+1H3mmyJeJdgWyAxX/hSa4RCsXa+Zp9Eo=
=t5sc
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
