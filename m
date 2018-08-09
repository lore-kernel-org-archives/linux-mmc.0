From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 05/40] soc/tegra: pmc: Fix pad voltage configuration for
 Tegra186
Date: Thu, 9 Aug 2018 14:20:45 +0200
Message-ID: <20180809122045.GR21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-6-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-6-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:55PM +0300, Aapo Vienamo wrote:
> Implement support for the PMC_IMPL_E_33V_PWR register which replaces
> PMC_PWR_DET register interface of the SoC generations preceding
> Tegra186. Also add the voltage bit offsets to the tegra186_io_pads[]
> table and the AO_HV pad.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 55 ++++++++++++++++++++++++++++++++++---------=
------
>  include/soc/tegra/pmc.h |  1 +
>  2 files changed, 39 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 2d6f3fc..f926332 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -65,6 +65,8 @@
> =20
>  #define PWRGATE_STATUS			0x38
> =20
> +#define PMC_IMPL_E_33V_PWR		0x40
> +
>  #define PMC_PWR_DET			0x48
> =20
>  #define PMC_SCRATCH0_MODE_RECOVERY	BIT(31)
> @@ -154,6 +156,7 @@ struct tegra_pmc_soc {
>  	bool has_tsense_reset;
>  	bool has_gpu_clamps;
>  	bool needs_mbist_war;
> +	bool has_impl_33v_pwr;
> =20
>  	const struct tegra_io_pad_soc *io_pads;
>  	unsigned int num_io_pads;
> @@ -1073,20 +1076,29 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
> =20
>  	mutex_lock(&pmc->powergates_lock);
> =20
> -	/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
> -	value =3D tegra_pmc_readl(PMC_PWR_DET);
> -	value |=3D BIT(pad->voltage);
> -	tegra_pmc_writel(value, PMC_PWR_DET);
> +	if (pmc->soc->has_impl_33v_pwr) {
> +		value =3D tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
> +		if (voltage =3D=3D TEGRA_IO_PAD_1800000UV)
> +			value &=3D ~BIT(pad->voltage);
> +		else
> +			value |=3D BIT(pad->voltage);

Nit: blank lines surrounding the if ... else ... block might improve
readability of this a little.

Thierry

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMZ0ACgkQ3SOs138+
s6FWNw/+OAM3l/QWbf2RLvaGYH+1pFSK3IB/yN1mQPefXKHM6vQtEsXTBqO07MMx
2XKoA7oZ7EfSb6HJLR3Ns7LtaH7uP7+5qWRsuMzU4Ep2xKnY3s+gxb4Ngm14tzi9
8pS/FNrhLqvaNtSmUtYdedGElifLRvbonzdSmSKbyX6asjibFiJA7T40nWBokgxH
qIow1tkIdNbocj/ifspmz8rKPxPAwUKsE8su/nvZ5+WJPA+BDhe8i+/ADSH55XOo
Oc0yTHNMAT7DbCqqrHxwbgmljTeN8ESbwHhFfLWTabwpw2X25Fav5p4KHy89ICnM
zzRtJ+XiHCPZ4ue8GEDgJ97LOSxCrtqyzDXIQ+AcMp1hLcMP4NNST8drd9dSu0Bx
COTlEmtweN4Y22AeNRHxQaTOFwWxdw4IqGK8isDAq66c45EZIAqigYmmXEj7E7fb
nD/3fuJAUjXSoAKusqiEL5WDl6WBhkTRPYGzfVQdLTkjRJvE07Opqscq0L7xJRh2
TPoagtVIAdK4wx/OrJ/Hw6w5ve9hQVpqYdJQUUQqZFAm1xIaJ6KUzVLxTmXuMIrS
FaVsnxCbO1nTRGVL4r3uGwjcNt3N+tFMLDHmsJcQ9EKGIZ1Vr7ctz8DvsktoK31P
WkxJWpl6kAhjgAyHj4zfoBpR3AzTeNVefcOOIBpH1AxDkuYJsG0=
=NXuf
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--
