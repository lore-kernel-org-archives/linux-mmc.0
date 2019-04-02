From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Date: Tue, 2 Apr 2019 16:59:01 +0200
Message-ID: <20190402145901.GF8017@ulmo>
References: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, jonathanh@nvidia.com, anrao@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:27:33PM -0700, Sowjanya Komatineni wrote:
> This patch adds suspend and resume PM ops for tegra SDHCI.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 45 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index eafaaefab4a6..68263ea4a93e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1611,11 +1611,54 @@ static int sdhci_tegra_remove(struct platform_dev=
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
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	return 0;
> +}
> +
> +static int sdhci_tegra_resume(struct device *dev)
> +{
> +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	int ret;
> +
> +	clk_prepare_enable(pltfm_host->clk);

You need to check this for errors here.

> +
> +	ret =3D sdhci_resume_host(host);
> +	if (ret)
> +		return ret;

And clk_disable_unprepare() in case of failure.

> +
> +	if (host->mmc->caps2 & MMC_CAP2_CQE)
> +		return cqhci_resume(host->mmc);

Same here. Also make sure to sdhci_suspend_host() if cqhci_resume()
fails. It's probably best to have a standard error cleanup path for
this.

Thierry

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjeLMACgkQ3SOs138+
s6ENvA/+LkCvdh3owTukZ+MogvqrxofbtGNH4nHaaXtN/Jew7QYNGL/5Hr3l9hHt
4TboAQ+J9Fyx/uwLa6wVp/rSInwZFnfkzDYfJEyJHE6ev8eTLkzEAPaEQ+lY0Fn8
Vq0Sg7Z4PaJKf8flwNBeT3OCXgEUaUowO/udTPlRGHiA04RZSRXF3s4d/lr8oWpw
FDVu/bCDQWJSrElVY5mkAyScUw2OkJpiNsVC/hClOwXPfvbsCzpdjdiOl9yeGgDp
Q/f+ZQhyGr+CxW9LxzJYy085Yl3S/02gcABoFF1GB+U7qnLY24ND2UbrcdM2j0kG
h8mQ02gMghii88fsqUjGP00D4hXpccRzGVEiVbtvhSjN+BZRPoVvbrebmKH6CETV
GVqA8Yi/2mKDSgsFYYk8wzbK0UBYgCOnx2Y6JU4w0kV+0G2GEdgupUy6hoPBLcMC
U791byj7Uwwknn1QZE2a/psx5n8p4BJlRJMRn1b2gdCmnQCNsQNx6ACKYRfn5nMX
rv9Mo/v+LE95uSHM9mODCDoRyOYC9rEVZsEYyL1Cd6OuSGH4cjxPOObmRAq6Gf7N
B8c3/PYIc160+leRIz/0INofaVORMU/4ppGdCKFOZ88tagzSY+3AcZFMLzmw76kz
TbxGonOnuTsfkpUkAkdw/YsdasOH5dS/YdKTrROp7BVBqZ0LpoE=
=3vRk
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
