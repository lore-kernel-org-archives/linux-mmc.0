From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 16/40] mmc: tegra: Disable card clock during pad
 calibration
Date: Thu, 9 Aug 2018 14:54:22 +0200
Message-ID: <20180809125422.GX21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-17-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Weqbz6OltVu8XOAh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-17-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--Weqbz6OltVu8XOAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:06PM +0300, Aapo Vienamo wrote:
> Disable the card clock during automatic pad drive strength calibration
> and re-enable it afterwards.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 9e22fec..c2b388b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -260,11 +260,35 @@ static void tegra_sdhci_configure_cal_pad(struct sd=
hci_host *host, bool enable)
>  	}
>  }
> =20
> +static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool=
 enable)
> +{
> +	bool orig_enabled;

I don't see a need for the orig_ prefix. If you're concerned that
"enable" and "enabled" might clash, perhaps "status" would be a better
name?

Thierry

> +	u32 reg;
> +
> +	reg =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	orig_enabled =3D !!(reg & SDHCI_CLOCK_CARD_EN);
> +
> +	if (orig_enabled =3D=3D enable)
> +		return orig_enabled;
> +
> +	if (enable)
> +		reg |=3D SDHCI_CLOCK_CARD_EN;
> +	else
> +		reg &=3D ~SDHCI_CLOCK_CARD_EN;
> +
> +	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
> +
> +	return orig_enabled;
> +}
> +
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
> +	bool card_clk_enabled;
>  	u32 reg;
>  	int ret;
> =20
> +	card_clk_enabled =3D tegra_sdhci_configure_card_clk(host, false);
> +
>  	tegra_sdhci_configure_cal_pad(host, true);
> =20
>  	reg =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> @@ -278,6 +302,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_ho=
st *host)
> =20
>  	tegra_sdhci_configure_cal_pad(host, false);
> =20
> +	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
> +
>  	if (ret)
>  		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>  }
> --=20
> 2.7.4
>=20

--Weqbz6OltVu8XOAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsOX4ACgkQ3SOs138+
s6GWGBAAuqsUpd7Kr2tZ77UbLE2xA3bjaLkR6HPsuzzz1NPp07QsIAy+r0hOwmE6
TY8qahazQ0p1nHYkbHQ1F6gmzakv/cxSF9rXCH/BavR4RaMYYX+hkghFb18iLgZf
rFGNvzLL5WfDHzmxoO6955RZYndlbM1wsqs/Ck4ZA0mTKW5G1UoA8daSaM1ndc9N
m/QnaC9wTo84u6ezRT7NhQDB06r1wQgRermFCF/GzrjbyfLy0u5jwI8ESGYeVa/B
h4onjxr0eTBEg/EqdUjbn12s8n/to7MrTkZuWQjnMrg4ZlXVo4dkm1fIusXFbtss
rzxcc+J0QIyOw0MRoxQyvasTKaU4lhwOwUQWcUavC8M7S/KsV4eVi8ThwKtjlnW5
2V6F50eTsvaQ0UZ5cL8LUJOr2MCsyhHazTIx25fF9NsVuvMU/o2vOSOpImKp76hR
B2QqnudO2NIvS4d4qM7byiNLA/gZ6/QSzAItMQYzKQMCybl7mPtCpwzjhYcAfaJs
nEyfLFFnrC9lNFC7PHZyMg5x987iDiqWGZH/t0JquMTcikMksfnBfsmkYMbeAGu9
2MykVLmldDEmMNw+GhagVW4ryXOqtvI1QCuv1SfqeLVRjrgXtES4YlJrO5XYjxva
8j2lAIZC978gYvYjgTfBFYuKqtE1eM28H8qh32QAb+DZQ5u2u/M=
=eKZr
-----END PGP SIGNATURE-----

--Weqbz6OltVu8XOAh--
