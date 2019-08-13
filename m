From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] mmc: tegra: Implement enable_dma() to set dma_mask
Date: Tue, 13 Aug 2019 11:36:51 +0200
Message-ID: <20190813093651.GE1137@ulmo>
References: <20190812224217.12423-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190812224217.12423-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, jonathanh@nvidia.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, vdumpa@nvidia.com
List-Id: linux-mmc@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 03:42:17PM -0700, Nicolin Chen wrote:
> Commit 68481a7e1c84 ("mmc: tegra: Mark 64 bit dma broken on Tegra186")
> added a SDHCI_QUIRK2_BROKEN_64_BIT_DMA flag to let sdhci core fallback
> to 32-bit DMA so as to fit the 40-bit addressing on Tegra186. However,
> there's a common way, being mentioned in sdhci.c file, to set dma_mask
> via enable_dma() callback in the device driver directly.
>=20
> So this patch implements an enable_dma() callback in the sdhci-tegra,
> in order to set an accurate DMA_BIT_MASK, other than 32-bit or 64-bit.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

I like this. However, I'd prefer if we set the DMA mask explicitly for
each generation. A while ago, I had done a similar patch which relied on
some core changes that no longer seem necessary with this enable_dma()
hook. You can find the DMA masks for each generation in that patch:

	http://patchwork.ozlabs.org/patch/1020678/

Thierry

> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index f4d4761cf20a..23289adb78d6 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -16,6 +16,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
> @@ -104,6 +105,7 @@
> =20
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
> +	u64 dma_bit_mask;
>  	u32 nvquirks;
>  	u8 min_tap_delay;
>  	u8 max_tap_delay;
> @@ -749,6 +751,19 @@ static void tegra_sdhci_set_clock(struct sdhci_host =
*host, unsigned int clock)
>  	}
>  }
> =20
> +static int tegra_sdhci_enable_dma(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> +	const struct sdhci_tegra_soc_data *soc_data =3D tegra_host->soc_data;
> +	struct device *dev =3D mmc_dev(host->mmc);
> +
> +	if (soc_data->dma_bit_mask)
> +		return dma_set_mask_and_coherent(dev, soc_data->dma_bit_mask);
> +
> +	return 0;
> +}
> +
>  static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -1370,6 +1385,7 @@ static const struct sdhci_ops tegra186_sdhci_ops =
=3D {
>  	.write_l    =3D tegra_sdhci_writel,
>  	.set_clock  =3D tegra_sdhci_set_clock,
>  	.set_bus_width =3D sdhci_set_bus_width,
> +	.enable_dma =3D tegra_sdhci_enable_dma,
>  	.reset      =3D tegra_sdhci_reset,
>  	.set_uhs_signaling =3D tegra_sdhci_set_uhs_signaling,
>  	.voltage_switch =3D tegra_sdhci_voltage_switch,
> @@ -1384,20 +1400,13 @@ static const struct sdhci_pltfm_data sdhci_tegra1=
86_pdata =3D {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   /* SDHCI controllers on Tegra186 support 40-bit addressing.
> -		    * IOVA addresses are 48-bit wide on Tegra186.
> -		    * With 64-bit dma mask used for SDHCI, accesses can
> -		    * be broken. Disable 64-bit dma, which would fall back
> -		    * to 32-bit dma mask. Ideally 40-bit dma mask would work,
> -		    * But it is not supported as of now.
> -		    */
> -		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	.ops  =3D &tegra186_sdhci_ops,
>  };
> =20
>  static const struct sdhci_tegra_soc_data soc_data_tegra186 =3D {
>  	.pdata =3D &sdhci_tegra186_pdata,
> +	.dma_bit_mask =3D DMA_BIT_MASK(40),
>  	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL |
>  		    NVQUIRK_HAS_PADCALIB |
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> @@ -1410,6 +1419,7 @@ static const struct sdhci_tegra_soc_data soc_data_t=
egra186 =3D {
> =20
>  static const struct sdhci_tegra_soc_data soc_data_tegra194 =3D {
>  	.pdata =3D &sdhci_tegra186_pdata,
> +	.dma_bit_mask =3D DMA_BIT_MASK(39),
>  	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL |
>  		    NVQUIRK_HAS_PADCALIB |
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> --=20
> 2.17.1
>=20

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ShLIACgkQ3SOs138+
s6Hucw//S7RpqDYyK6kxObaiY3jb9h8P8Goo/iuBWANHCIBSUh/Odd5x+pGkx8Qt
zPMCccHu7Kwj0pAro3N6rX+e5WmG+gzEL/81+sPps9Kuuw2cGz2vFzYrElQmmj51
9sZDS/KfcpkZ7CBFj0i8YMNNJ4suwpQyVbsTHHsaCe/rCEr4ACGdbHMCarQkX6O0
q9a0kgLj/8wdOXEzpPJQCzFsm/pUF6LGguq7eriKrJNIsObgCVQUBBLMkUXmkp+5
yGv2Ko7djq/lWf9tZ1TZcXMfeVUan/+NMeZ23GFR+vvDpX6UqP6L0AWjPgugamS2
qVfOlK+8U9/ubQdOGByIi9qYZpV/gs/6KFeQnztJNhIH76GyMvil7zPa098POnj8
a3lnNApUlfEsszL2fz9cxHEeJGzdGfGQBCQhhnIx0V9b/ypOMUus1OhbJvtf0Zbp
iFjg69C5zpWSq7UoW35X1D0xwPObfEb8IK/+dyNFS+Me9F0DXDrumczECYvvsK8P
sUee/K7ZGqGT51ZB8RcNweeKnLmYF78xRIjkKUqfC8J0XflRp+zK8X04D1Md8TA1
c3puztYz3S9L/9N/WEXXa7YFah+3s7GTJr50z71OSK8qFpHGO3YgzbCuQXKAimJQ
jkiznX6EU53RHgye/T2wwC+AlQGOJywTzUPLLUmUyBy3KNrZ9Fs=
=iYEF
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
