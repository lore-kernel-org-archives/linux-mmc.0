From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 20/40] mmc: tegra: Add a workaround for tap value change
 glitch
Date: Thu, 9 Aug 2018 14:58:04 +0200
Message-ID: <20180809125804.GY21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-21-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B7FF+pnjRCrp0ISR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-21-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--B7FF+pnjRCrp0ISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:10PM +0300, Aapo Vienamo wrote:
> Add quirk to disable the card clock during configuration of the tap
> value in tegra_sdhci_set_tap() and issue sdhci_reset() after value
> change. This is a workaround to avoid propagation of a potential
> glitch caused by setting the tap value.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 3c10451..a2375ad 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -47,6 +47,9 @@
>  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
>  #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
> =20
> +#define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
> +#define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
> +
>  #define SDHCI_TEGRA_AUTO_CAL_CONFIG			0x1e4
>  #define SDHCI_AUTO_CAL_START				BIT(31)
>  #define SDHCI_AUTO_CAL_ENABLE				BIT(29)
> @@ -68,6 +71,7 @@
>  #define NVQUIRK_ENABLE_DDR50				BIT(5)
>  #define NVQUIRK_HAS_PADCALIB				BIT(6)
>  #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
> +#define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
> =20
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
> @@ -499,12 +503,32 @@ static unsigned int tegra_sdhci_get_max_clock(struc=
t sdhci_host *host)
> =20
>  static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int ta=
p)
>  {
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> +	const struct sdhci_tegra_soc_data *soc_data =3D tegra_host->soc_data;
> +	bool card_clk_enabled =3D false;
>  	u32 reg;
> =20
> +	/*
> +	 * Touching the tap values is a bit tricky on some SoC generations.
> +	 * The quirk enables a workaround for a glitch that sometimes occurs if
> +	 * the tap values are changed.
> +	 */
> +
> +	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP)
> +		card_clk_enabled =3D tegra_sdhci_configure_card_clk(host, false);
> +
>  	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
>  	reg &=3D ~SDHCI_CLOCK_CTRL_TAP_MASK;
>  	reg |=3D tap << SDHCI_CLOCK_CTRL_TAP_SHIFT;
>  	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
> +
> +	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP &&
> +		    card_clk_enabled) {

This is weirdly aligned.

> +		udelay(1);

Can this also become a usleep_range()? I may be too paranoid about
this...

Thierry

> +		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +		tegra_sdhci_configure_card_clk(host, card_clk_enabled);
> +	}
>  }
> =20
>  static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcod=
e)
> @@ -758,7 +782,8 @@ static const struct sdhci_pltfm_data sdhci_tegra210_p=
data =3D {
>  static const struct sdhci_tegra_soc_data soc_data_tegra210 =3D {
>  	.pdata =3D &sdhci_tegra210_pdata,
>  	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL |
> -		    NVQUIRK_HAS_PADCALIB,
> +		    NVQUIRK_HAS_PADCALIB |
> +		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
>  };
> =20
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata =3D {
> @@ -783,7 +808,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_p=
data =3D {
>  static const struct sdhci_tegra_soc_data soc_data_tegra186 =3D {
>  	.pdata =3D &sdhci_tegra186_pdata,
>  	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL |
> -		    NVQUIRK_HAS_PADCALIB,
> +		    NVQUIRK_HAS_PADCALIB |
> +		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
>  };
> =20
>  static const struct of_device_id sdhci_tegra_dt_match[] =3D {
> --=20
> 2.7.4
>=20

--B7FF+pnjRCrp0ISR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsOlwACgkQ3SOs138+
s6F0BBAAoaIQAqFlshNymfiyhxa0gQPgVnTkQbJtwzhZGZqYkjfpQNUWWOKzH44l
902s3VSsRE6E0vIPjL3l1P16g/msr6YBCPHcx7M0uICxAdDpYn33RtuxUdsSSysq
6DrGPt4p3iE9+Zigxtl65CdDXKiU9neZOsiJ/SgmdTMIlFAy9hKxjT4EIRspdIYq
pa2oLL2b5teaBzvWd0Fshmg7gkDSIEmfrbD/iT+KkMUiOW0wJX4D98f80YSujSwB
cel3raQiwOmYo4IcVrO4JV6NKhmrJ60cZTBz/xaIGTm/RzmlR3huoilYGNu4xMpG
HCT9IrQa3YkBi07qN+qzPNCzU1gzj+bwdgA5RGv3wd65m0wOWJyxrZOwzc3EbJwo
VwqPrxqJqoVorvF42pOHvunPhEGGV6ZqQapvIZBP1ERrG2mOyIZ1sqpBDl78RuKn
/HCxpT5Tk55HcJo6S9bkINlNwQs8CSVOostuZUW4WUpp+AI4xCUAkUEFuMY2ZKG3
vzsE2GBwIVHI+Pcd5jQLY1ylecXOoYlTvdmZHk9KHwe+l+pVlnrPRcqDdYFwI/7J
ntsVgvIXBT3oqZZgfHpwGirvMvdpjh5Nmx9dnafoaWUvW8ijQqd/sZchHqV2jk3n
eHYo41aNTq5EAAdmnyeTxYpOIr5E428edqDUVWx9q2hvPebF610=
=b49y
-----END PGP SIGNATURE-----

--B7FF+pnjRCrp0ISR--
