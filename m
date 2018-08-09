From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/8] mmc: tegra: Parse and program DQS trim value
Date: Thu, 9 Aug 2018 13:40:46 +0200
Message-ID: <20180809114046.GJ21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 04:59:58PM +0300, Aapo Vienamo wrote:
> Parse and program the HS400 DQS trim value from dt. Program a fallback
> value in case the property is missing.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7f1ac4a..426f7ea 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -43,6 +43,10 @@
>  #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
>  #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
> =20
> +#define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
> +#define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
> +#define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
> +
>  #define SDHCI_TEGRA_VENDOR_MISC_CTRL			0x120
>  #define SDHCI_MISC_CTRL_ENABLE_SDR104			0x8
>  #define SDHCI_MISC_CTRL_ENABLE_SDR50			0x10
> @@ -112,6 +116,7 @@ struct sdhci_tegra {
> =20
>  	u32 default_tap;
>  	u32 default_trim;
> +	u32 dqs_trim;
>  };
> =20
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -500,7 +505,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct s=
dhci_host *host)
>  		autocal->pull_down_hs400 =3D autocal->pull_down_1v8;
>  }
> =20
> -static void tegra_sdhci_parse_default_tap_and_trim(struct sdhci_host *ho=
st)
> +static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>  	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> @@ -515,6 +520,11 @@ static void tegra_sdhci_parse_default_tap_and_trim(s=
truct sdhci_host *host)
>  				       &tegra_host->default_trim);
>  	if (err)
>  		tegra_host->default_trim =3D 0;
> +
> +	err =3D device_property_read_u32(host->mmc->parent, "nvidia,dqs-trim",
> +				       &tegra_host->dqs_trim);
> +	if (err)
> +		tegra_host->dqs_trim =3D 0x11;

Okay, so there's only one value. I think that should be clarified in the
bindings documentation. It should mention that a single cell is used for
this. Also, I assume there are lower and upper limits for the valid
range of DQS trim values. Might make sense to specify those in the DT
bindings as well.

>  }
> =20
>  static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int =
clock)
> @@ -545,20 +555,33 @@ static unsigned int tegra_sdhci_get_max_clock(struc=
t sdhci_host *host)
>  	return clk_round_rate(pltfm_host->clk, UINT_MAX);
>  }
> =20
> +static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 val)
> +{
> +	u32 reg;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
> +	reg &=3D ~SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK;
> +	reg |=3D val<<SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
> +}

Nit: I dislike using "reg" as a variable representing a register value
because I keep interpreting it as designating a register offset. Hence
I tend to use more explicit "offset" for actual register offsets and
"value" for register values.

But maybe that's just me.

Thierry

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKD0ACgkQ3SOs138+
s6FmkQ/9F0beuA1UTQrpplGHi+FBskWP++XGlYwBOXM4LFWV+zGE21JLLcyC3S42
xVjbSPLhPk6NGak5cCQ+uJuVfdSJpNXZRdW5x+tMqO7WsPjINfL44VDTmg2mUdfF
0Dud5Kyv9lI5RrMKKsJiFnia7gyUyrB/eaoh4gmOklD7iv4D8PdjoD8CCawPjvCo
GK7mF3GxUo01I7x5gVByC/VjKbmG6if5IhiYhHml80OiPOcOtqhAsiuUAnTCSb1B
IiWuDZXnjwWR6uVe0c3/vNAPoaOUvJZdt9TVdntIr6Ib0bOYVCF/i5OF4wQgJGa2
rMZBdY1b6EtWL8/twMenlFXNN09g7c5+j8D+ScrZplLVO4gunOETy9mCqUP/lnLM
iqD9TtyzD8FW7yxYPoMyYJNv3Byl6g1uxt1xjBzb/N8a5NLgIijGt6ETMed3jZTD
5nk0rC5j7tQ0902GlvTAkkUXe6vemIMWXne+Dq+fEphDMPH6XmbW24UuZs+BKwfq
oteAddY+d+QkMl/q7DjbYDFajWTQczyqVo05cy7YcjJMUZEdHQTdjkXbJZZOyQE7
EgoDS033AczK7R3HMs2nDNTP+i0d7LR8ilgvf4aHETXv1EGMqGTz7LzSkb4Y34fv
1OYbSxz1V9YYqPLt2ISHD5ppPJcuWLH0Z+8CkSBuBBrXOSj+Vv8=
=Hq+P
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
