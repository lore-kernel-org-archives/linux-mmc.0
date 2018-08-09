From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 13/40] mmc: tegra: Poll for calibration completion
Date: Thu, 9 Aug 2018 14:46:16 +0200
Message-ID: <20180809124616.GV21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-14-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ln+iIw7POnzHEEo5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-14-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--Ln+iIw7POnzHEEo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:03PM +0300, Aapo Vienamo wrote:
> Implement polling with 10 ms timeout for automatic pad drive strength
> calibration.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7d98455..c8ff267 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/iopoll.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> @@ -50,6 +51,9 @@
>  #define SDHCI_AUTO_CAL_START			BIT(31)
>  #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
> =20
> +#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
> +#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
> +
>  #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
> @@ -228,13 +232,20 @@ static void tegra_sdhci_reset(struct sdhci_host *ho=
st, u8 mask)
> =20
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
> -	u32 val;
> +	u32 reg;
> +	int ret;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	reg |=3D SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> =20

I know this is preexisting, but I want to make sure we cover this so we
don't run into this down the road: do these bits automatically clear on
calibration completion? Can we run these multiple times and get
everything properly calibrated?

Thierry

> -	mdelay(1);
> +	/* 10 ms timeout */
> +	ret =3D readl_poll_timeout(host->ioaddr + SDHCI_TEGRA_AUTO_CAL_STATUS,
> +				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
> +				 1, 10000);
> =20
> -	val =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> -	val |=3D SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> -	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	if (ret)
> +		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>  }
> =20
>  static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int =
clock)
> --=20
> 2.7.4
>=20

--Ln+iIw7POnzHEEo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsN5cACgkQ3SOs138+
s6GYHRAAhnIxTqOFS5JCDqKLbQXPIDN9Wv4B49j5P9LXKghw8CzwpvVa4UY51zeX
J5vOocxd29RgKSSE0nKeh4/4/PBtjSSvArLsrn4S866NX7Dib5kO5SOxYKaP6nBu
kOWWkbn9lFwhMAV0ocS+XJSsJaDKRpT7piCXNZPkwHyXQCk4Uevdhcog2S4gI31u
TC9d7G2KZHxtl9Vs49XrIRS0MSIZ5EmgLG9bFGYwqRihu1N+scS3fCFO1RNch9ls
Qz1sm5j5F0nu+1PzSFcJaxZIS/r0ooNg3ru49x/ZLh+sKI3wPSxRPGslk7rUFOJt
catDb4HfdQNuaNzEkSfmv4NiXz/fJthwwru4XVUoY/uTmGj8IO9D+cVLO985ZR4S
FJXSD61T5CS2K5oJF35sCB0I52DaaT8rfTKLL+6HN2IvORg03OhH++hBjwAsIa24
eqZrWQjzwLEJdFAR2I+e3Dmc3FirXckcD9dT8B372QfLzO5t6geVq8donIdO38Vr
eP0ci67ldBmCyzryePiZxaSXPYtzw0wRAAw2UkoQ2MJBaYf0mRZ1CRx7mABwbDL+
GGxQ4Gg4YVbB+hkjU9jzG2LScReLiTJA7sUicMu6aqa2SlZsl3d3BuJhDfC7QIsE
RSCuZmWdbMz4PGgHVCI8/qCmelANORzTw8Y+8jECvE68aj6l79s=
=6oib
-----END PGP SIGNATURE-----

--Ln+iIw7POnzHEEo5--
