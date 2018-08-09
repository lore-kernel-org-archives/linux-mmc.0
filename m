From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/8] mmc: tegra: Implement HS400 enhanced strobe
Date: Thu, 9 Aug 2018 13:43:45 +0200
Message-ID: <20180809114345.GL21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 04:59:59PM +0300, Aapo Vienamo wrote:
> Implement HS400 enhanced strobe.

Can you provide a little more information about what the impact is of
this? Does this increase throughput? How much?

>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 426f7ea..d81143b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -43,6 +43,9 @@
>  #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
>  #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
> =20
> +#define SDHCI_TEGRA_VENDOR_SYS_SW_CTRL			0x104
> +#define SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE		BIT(31)
> +
>  #define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
>  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
>  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
> @@ -271,6 +274,22 @@ static void tegra_sdhci_set_tap(struct sdhci_host *h=
ost, unsigned int tap)
>  	}
>  }
> =20
> +static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
> +					      struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host =3D mmc_priv(mmc);
> +	u32 reg;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
> +	pr_err("enhanced strobe: %d\n", ios->enhanced_strobe);

Left-over debug error?

> +	if (ios->enhanced_strobe)
> +		reg |=3D SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> +	else
> +		reg &=3D ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);

You might want to add blank lines around the if ... else ... block for
readability.

Thierry

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKPEACgkQ3SOs138+
s6Eb1RAAloFX6Tv2ZWx0XzekpM2KJlXdnj3HP5A+Eny4d69pJScQlCGD2eG8NRhJ
/CZpDUSjuB2vz49uA80N0c1OeHFHch7hd5k+rKVeK/p7q1s/vi1mD9IgKIbo89gQ
5TvgFnW8gMsmD7rPci7RY5a2De2U6/KIt0WxSK01QyCodAizS3gtrUX4rfcDv74y
V5MGe6gDTx6jXBu6X4WHf90fl9a2DcVXiSC8LkDuobYV0ukr6NEA32ogOW5+94e4
EqDoIj+V68+eRe/04Pcxg2CIGTwwCHhsFGQv53a09aPnaiS50AS62YqnhFnnoF1c
dBn8cVaUP7bTGktb9jWd5mvmTCIsTWY8p4iIidQ/M4RW7+9uDAYFswdJtLvhTcLg
f4zZxKqY8C/B5AibHjFCzJR77FHjmrpyjSo3C2Skg2zry3DxFRnwYD/5CbRbbLUj
5V0PqwbFHO78K1hn6hRS2aPmOp42OO4aaut4k+oCEaIm42KxlYTvM7P4TgkjxtkS
qDuO/evqbDGKVece7a+Rk/MSRc/NGnJBmOS7RlXzYqkgB1ivXXhKq9EwqevPSyIa
0YhQzOOydXvP9t9F57P1SS2u94wgjpGcWVhAbRLyJuInz+B1Dnpi+HHiuZQ6vdHn
hWr3iJvLi0yAUWrA4rKPYr9FfbgqGdYigdxqkK6QkslhJafBoUE=
=qF0n
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
