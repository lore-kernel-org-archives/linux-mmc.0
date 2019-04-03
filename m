From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2] mmc: tegra: add sdhci tegra suspend and resume
Date: Wed, 3 Apr 2019 10:49:22 +0200
Message-ID: <20190403084922.GE5238@ulmo>
References: <1554226641-22612-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554226641-22612-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, jonathanh@nvidia.com, anrao@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 10:37:21AM -0700, Sowjanya Komatineni wrote:
> This patch adds suspend and resume PM ops for tegra SDHCI.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 56 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index eafaaefab4a6..6c91926a012c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1611,11 +1611,65 @@ static int sdhci_tegra_remove(struct platform_dev=
ice *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int sdhci_tegra_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	int ret;
> +
> +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +		ret =3D cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;

I didn't spot this earlier, but I think we'd need cqhci_resume() here in
case of failure.

With that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykc5IACgkQ3SOs138+
s6EszQ//TkWf17Qu1wTq8l/vUCpn4kks/qsOMfrv83+b38TJwqGCem6T1Q8fEqj5
WiDAd29Vqv8UFvmHLqsGG+wgik9wgJn5kWXvwgachk0eN5nvx7F3NqyB9f+pCng9
ODq3JE5k01716y3t7iIBpXiYrENk9qdwZYlKYtCFY7cQxGvJJeHyXXwRj4tuM39f
qyOU2EU+zkf+rjhSLKdJNwKz4MIJ63NAdwz6q4TKgf/aip8RWa2FNtxcpXNVyAcq
Y8UubY2PWt/wqm9RF+B7G800W6wrsXUH6anDm2bs9hX2KHfgTyblQVarwV5s+1X8
X9eAIV8rk5BuznqLd2QD+5grOPa8lhmZd76vJDUIvrU2gIJl0eVB40CY/j1olgdU
fIpAC4Py1TNF4qMXbvKJoJXY9fxOUuFeMHwDOjeRqTA6ZzTAao8wXPPWf+I1v+LH
Z/cgkGR2Cuu55TP5cWMzwaOMaAlOitke2pCqBbbRVmwIEvh/gmhtWSsPHSqZHnH2
9ac6O+VZ4Spz6BqXBCc7Mn94jBB1As/GvgZG7t5Qxxf4HdzXDmkI+so8dlW7JUZn
lKgOJi/iGwVO2k+P/IFfDSo/kVTRY1kYDxX2kfB0tTe0Z1bDqj4kbgaNN8KsbyyQ
YGS9VWA0TGVArpM9o5J21P6NjCXFJ5SHfsJaoC8u/vbR4SGpecQ=
=J/FS
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
