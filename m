From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Date: Thu, 10 Jan 2019 16:12:00 +0100
Message-ID: <20190110151200.GD25353@ulmo>
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 11:36:48AM -0800, Sowjanya Komatineni wrote:
> This patch adds HW Command Queue for supported Tegra SDMMC
> controllers.
>=20
> As per SD Host 4.20 Spec for Host Control 1 Register, DMA Select
> options supported are
>=20
> With Host Version 4 Enable =3D 0,
> b'00:SDMA, b'10:32-bit ADMA2, b'11:64-bit ADMA2
>=20
> With Host Version 4 Enable =3D 1,
> b'00:SDMA, b'10:ADMA2, b'11:ADMA3
> Support for 32-bit or 64-bit system addressing of DMAs is selected
> thru 64-bit Addressing in Host Control 2 register.
>=20
> ADMA3 performs integrated descriptor and each command descriptor
> is followed by ADMA2 descriptor. Command queuing need to fetch
> command and transfer descriptors so need ADMA3 DMA Type.
>=20
> Tegra SDMMC Host design prevents write access to BLOCK_COUNT
> registers when CQE is enabled to prevent SW from updating block
> size during Command Queue mode so need tegra specific sdhci
> cqe callback.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-tegra.c | 107 +++++++++++++++++++++++++++++++++++=
+++++-
>  drivers/mmc/host/sdhci.c       |  16 ++++--
>  drivers/mmc/host/sdhci.h       |   1 +
>  4 files changed, 120 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1b58739d9744..5aa2de2c7609 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -250,6 +250,7 @@ config MMC_SDHCI_TEGRA
>  	depends on ARCH_TEGRA
>  	depends on MMC_SDHCI_PLTFM
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select MMC_CQHCI
>  	help
>  	  This selects the Tegra SD/MMC controller. If you have a Tegra
>  	  platform with SD or MMC devices, say Y or M here.
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7b95d088fdef..7beecd1da94a 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -33,6 +33,7 @@
>  #include <linux/ktime.h>
> =20
>  #include "sdhci-pltfm.h"
> +#include "cqhci.h"
> =20
>  /* Tegra SDHOST controller vendor register definitions */
>  #define SDHCI_TEGRA_VENDOR_CLOCK_CTRL			0x100
> @@ -89,6 +90,9 @@
>  #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
>  #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
> =20
> +/* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> +#define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> +
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	u32 nvquirks;
> @@ -128,6 +132,7 @@ struct sdhci_tegra {
>  	u32 default_tap;
>  	u32 default_trim;
>  	u32 dqs_trim;
> +	bool enable_hwcq;
>  };
> =20
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -836,6 +841,49 @@ static void tegra_sdhci_voltage_switch(struct sdhci_=
host *host)
>  		tegra_host->pad_calib_required =3D true;
>  }
> =20
> +static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	u32 cqcfg =3D 0;
> +
> +	/* Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
> +	 * registers when CQE is enabled.
> +	 */

Block comments usually have the opening /* on a line by itself.

> +	cqcfg =3D cqhci_readl(cq_host, CQHCI_CFG);
> +	if (cqcfg & CQHCI_ENABLE)
> +		cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
> +
> +	sdhci_cqe_enable(mmc);
> +
> +	if (cqcfg & CQHCI_ENABLE)
> +		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +
> +}

Extra blank line above.

> +
> +static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error =3D 0;
> +	int data_error =3D 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
> +static const struct cqhci_host_ops sdhci_tegra_cqhci_ops =3D {
> +	.enable	=3D sdhci_tegra_cqe_enable,
> +	.disable =3D sdhci_cqe_disable,
> +	.dumpregs =3D sdhci_tegra_dumpregs,
> +};
> +
>  static const struct sdhci_ops tegra_sdhci_ops =3D {
>  	.get_ro     =3D tegra_sdhci_get_ro,
>  	.read_w     =3D tegra_sdhci_readw,
> @@ -989,6 +1037,7 @@ static const struct sdhci_ops tegra186_sdhci_ops =3D=
 {
>  	.set_uhs_signaling =3D tegra_sdhci_set_uhs_signaling,
>  	.voltage_switch =3D tegra_sdhci_voltage_switch,
>  	.get_max_clock =3D tegra_sdhci_get_max_clock,
> +	.irq =3D sdhci_tegra_cqhci_irq,
>  };
> =20
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata =3D {
> @@ -1030,6 +1079,55 @@ static const struct of_device_id sdhci_tegra_dt_ma=
tch[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
> =20
> +static int sdhci_tegra_add_host(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	if (!tegra_host->enable_hwcq)
> +		return sdhci_add_host(host);
> +
> +	host->v4_mode =3D true;
> +
> +	ret =3D sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	host->mmc->caps2 |=3D MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +	cq_host =3D devm_kzalloc(host->mmc->parent,
> +				sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host) {
> +		ret =3D -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	cq_host->mmio =3D host->ioaddr + SDHCI_TEGRA_CQE_BASE_ADDR;
> +	cq_host->ops =3D &sdhci_tegra_cqhci_ops;
> +
> +	dma64 =3D host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |=3D CQHCI_TASK_DESC_SZ_128;
> +
> +	ret =3D cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret =3D __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	sdhci_cleanup_host(host);
> +	return ret;
> +
> +}

Gratuituous blank line above.

> +
>  static int sdhci_tegra_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> @@ -1039,6 +1137,7 @@ static int sdhci_tegra_probe(struct platform_device=
 *pdev)
>  	struct sdhci_tegra *tegra_host;
>  	struct clk *clk;
>  	int rc;
> +	struct resource *iomem;
> =20
>  	match =3D of_match_device(sdhci_tegra_dt_match, &pdev->dev);
>  	if (!match)
> @@ -1056,6 +1155,12 @@ static int sdhci_tegra_probe(struct platform_devic=
e *pdev)
>  	tegra_host->pad_control_available =3D false;
>  	tegra_host->soc_data =3D soc_data;
> =20
> +	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (resource_size(iomem) > SDHCI_TEGRA_CQE_BASE_ADDR)
> +		tegra_host->enable_hwcq =3D true;
> +	else
> +		tegra_host->enable_hwcq =3D false;
> +
>  	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
>  		rc =3D tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
>  		if (rc =3D=3D 0)
> @@ -1117,7 +1222,7 @@ static int sdhci_tegra_probe(struct platform_device=
 *pdev)
> =20
>  	usleep_range(2000, 4000);
> =20
> -	rc =3D sdhci_add_host(host);
> +	rc =3D sdhci_tegra_add_host(host);
>  	if (rc)
>  		goto err_add_host;
> =20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fde984d10619..c368230c364d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3308,10 +3308,18 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
> =20
>  	ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
>  	ctrl &=3D ~SDHCI_CTRL_DMA_MASK;
> -	if (host->flags & SDHCI_USE_64_BIT_DMA)
> -		ctrl |=3D SDHCI_CTRL_ADMA64;
> -	else
> -		ctrl |=3D SDHCI_CTRL_ADMA32;
> +	/* As per SD Host 4.20 Spec, Host with V4 Mode enable supports ADMA3
> +	 * DMA type. ADMA3 performs integrated descriptor which is needed for
> +	 * cmd queuing as it need to fetch both cmd and transfer descriptors.
> +	 */

Correct block comment style, please.

Thanks,
Thierry

> +	if (host->v4_mode) {
> +		ctrl |=3D SDHCI_CTRL_ADMA3;
> +	} else {
> +		if (host->flags & SDHCI_USE_64_BIT_DMA)
> +			ctrl |=3D SDHCI_CTRL_ADMA64;
> +		else
> +			ctrl |=3D SDHCI_CTRL_ADMA32;
> +	}
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> =20
>  	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, 512),
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b001cf4d3d7e..6e2a08f92645 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -88,6 +88,7 @@
>  #define   SDHCI_CTRL_ADMA1	0x08
>  #define   SDHCI_CTRL_ADMA32	0x10
>  #define   SDHCI_CTRL_ADMA64	0x18
> +#define   SDHCI_CTRL_ADMA3	0x18
>  #define   SDHCI_CTRL_8BITBUS	0x20
>  #define  SDHCI_CTRL_CDTEST_INS	0x40
>  #define  SDHCI_CTRL_CDTEST_EN	0x80
> --=20
> 2.7.4
>=20

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3YMAACgkQ3SOs138+
s6EH4Q//SVN4JRdUhc2pJvduFUs4enZhMmbqPjP1BDEUTgAgzOWTBgrtmYRYVXkA
kBSuux1xvohOgua4RapPquYWOoreJFPLCfkCt3uE+maLKDWRFtDbTXKPk7WjSAEs
vMVLRpUT3RAksUUzhvLCupS2RjezDF3JxEZAoUwYTNdLheWrhNykHDVjNMbyeV74
6WLXs7oG+Md8ziG2dz/ROqRahISQtKU1dcY9rKdogVadFX3ck0+IaOj/5NeEH5b3
UWAtheAaUHFeKkGbMYPXsFvYsinOstRBb6av63r+kOem/dNtl7YN5rXPKAh4zYI/
GylHsq/aBU4mm4BtfuVAcTM/GipGtPw+nLXkTAYMmM2aHDAIe9BkMMR0zZ48C3M/
iCcUjiqRtTjcW3xWzrckQqy7UfLUxV+eVXXiL9wvq3ukM/wLRYRUQbL2WB7BR7kj
fDotSPQowhN0LJLFr3Dnn0d1w+JQxO2BVuftrfiLzpagJ/DrVm41kqshv0zQ+2PX
dQtbzThuEQvdpt/L3zUXVvhunxaUusLXEsrA4qfUm9iiuvoc6C0SDi3hwQO/287W
5WXBpZNLu3qbC0Sf8heuaBFp3aUkxKObT7caCdkp6eTx9msQvTUW6OHz1z0h3DR2
3eiQSgvUCqMa98C8il1gBhYXZrYkTuGkl/Imz+ZthQZMG+jkJug=
=6/7V
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
