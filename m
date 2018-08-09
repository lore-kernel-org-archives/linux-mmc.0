From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 15/40] mmc: tegra: Power on the calibration pad
Date: Thu, 9 Aug 2018 14:52:26 +0200
Message-ID: <20180809125226.GW21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-16-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7kW37LRKoI6fR2de"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-16-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--7kW37LRKoI6fR2de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:05PM +0300, Aapo Vienamo wrote:
> Automatic pad drive strength calibration is performed on a separate pad
> identical to the ones used for driving the actual bus. Power on the
> calibration pad during the calibration procedure and power it off
> afterwards to save power.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 53c035b9..9e22fec 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -54,6 +54,7 @@
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
> +#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
> =20
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
> @@ -240,11 +241,32 @@ static void tegra_sdhci_reset(struct sdhci_host *ho=
st, u8 mask)
>  	tegra_host->ddr_signaling =3D false;
>  }
> =20
> +static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool =
enable)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Enable or disable the additional I/O pad used by the drive strength
> +	 * calibration process.
> +	 */
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	if (enable) {
> +		reg |=3D SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
> +		sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +		udelay(1);
> +	} else {
> +		reg &=3D ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
> +		sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +	}

Might be worth extracting the common write as well. This would of course
mean that we either have to conditionalize the udelay() again, or we
just keep it in both cases. Doesn't really hurt to wait a little on
disabling, right?

Either way is fine with me. Though it would be nice if we could make the
udelay() go away and use a sleeping variant if possible. This isn't run
very often, so even if we overshoot by a couple of microseconds it isn't
that bad. 1 us is pretty short, but I've been burnt by busy loops a
couple of times, so I like to avoid them at all costs.

Thierry

--7kW37LRKoI6fR2de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsOQoACgkQ3SOs138+
s6GZtxAAoh/mGnKo4jAJUsNpr86cp6zTl3H564xjbckbeB0P7XHqLkqvnOYab14D
fywWzwse5T1zB6cNeps6OpmLkjptQeQ91suM5N/4kvHHjlWJmOtfh6OZ0+w7MtF/
FI5gxpXdpV77t5cny8rGBl+sn34TXyxTTWWBTlAPOwT1EqlSt4FfGZIF5jCt/BRS
yneA0xmznO0GY9PTjc/x48Rl0AMjACowGItoAyL0J5YLxIRKoUT3ygsaDwYa/KRd
dE6xN2H+y84d3+C7Jkwk2ytgqCkQP+kkYpACt/JmhvCrJrtX7TtVF7s37w2oJZYC
0cXlrgYAJsDFUejofCn60t3QhRArJ+rpnM+TfPYFiuA6EMLgA7tgJtzNlFx0GB3X
mA7Hcyp/LZl7apdrHYNjVZN5SpRN0geeoCDw2WDuUw7BCg6ga+juuxLI30HcISRD
dILKNjTElMnXmBbb8p7Xo4Kn6v406yTWknIRGdOV0mdZ1xv/Fiyw2v+R3yEqdXyt
Dz+eyK8ciV1uRvJO1W4xAO28ENq7lfAAkr0dFU0I2/K3eJjaulwLPmtjSsbZVH1G
yuEQqv7zdmJ2VPuxxfbwZLQAdogJDflmUJisk6s5DiKSlR0dVryrt8svUe/sX1Xa
8FbI3dfkY4oZHv9riRlJ/+K4gJzATTW6I0NoWUfBJ550qDtSv5A=
=Blms
-----END PGP SIGNATURE-----

--7kW37LRKoI6fR2de--
