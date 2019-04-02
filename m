From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Date: Tue, 2 Apr 2019 18:48:02 +0200
Message-ID: <20190402164802.GA7797@ulmo>
References: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
 <20190402145901.GF8017@ulmo>
 <BYAPR12MB3398861980C3F967CD209393C2560@BYAPR12MB3398.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398861980C3F967CD209393C2560@BYAPR12MB3398.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Aniruddha Tvs Rao <anrao@nvidia.com>, Timo Alho <talho@nvidia.com>, Bitan Biswas <bbiswas@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 04:41:18PM +0000, Sowjanya Komatineni wrote:
> > On Mon, Apr 01, 2019 at 10:27:33PM -0700, Sowjanya Komatineni wrote:
> > > This patch adds suspend and resume PM ops for tegra SDHCI.
> > >=20
> > > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 45=20
> > > +++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 44 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c=20
> > > b/drivers/mmc/host/sdhci-tegra.c index eafaaefab4a6..68263ea4a93e=20
> > > 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -1611,11 +1611,54 @@ static int sdhci_tegra_remove(struct platform=
_device *pdev)
> > >  	return 0;
> > >  }
> > > =20
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int sdhci_tegra_suspend(struct device *dev) {
> > > +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > > +	int ret;
> > > +
> > > +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > > +		ret =3D cqhci_suspend(host->mmc);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	ret =3D sdhci_suspend_host(host);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	clk_disable_unprepare(pltfm_host->clk);
> > > +	return 0;
> > > +}
> > > +
> > > +static int sdhci_tegra_resume(struct device *dev) {
> > > +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > > +	int ret;
> > > +
> > > +	clk_prepare_enable(pltfm_host->clk);
> >
> > You need to check this for errors here.
> >
> > > +
> > > +	ret =3D sdhci_resume_host(host);
> > > +	if (ret)
> > > +		return ret;
> >
> > And clk_disable_unprepare() in case of failure.
> >
> > > +
> > > +	if (host->mmc->caps2 & MMC_CAP2_CQE)
> > > +		return cqhci_resume(host->mmc);
> >
> > Same here. Also make sure to sdhci_suspend_host() if cqhci_resume() fai=
ls. It's probably best to have a standard error cleanup path for this.
> >
> > Thierry
>=20
> Thanks Thierry. Will add error check and cleanup for clock and sdhci_resu=
me_host.
> Regarding, cqhci_resume always returns 0. Infact, it does nothing as resu=
me happens on first cqhci_request.
> Since helper functions exists in cqhci driver, was using it for explicit =
resume call.

Yeah, I think it's good to use it. And I think it's also the safest
option to handle errors from it properly because somebody may eventually
add code to it that can fail. If we properly handle errors we'll be
prepared for when that happens.

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjkj0ACgkQ3SOs138+
s6EwEBAAhV3DcxKntQenphq/Inls3vasqeZSK1NBBoE+Ym+CZhO2v6+TGJOuEaxu
RfoeodVB/6jasOplTv7EiBbxEuEdj4xzcSi2jVQnv6m4nQaflMpguvHbPd9M1TGO
x/QMYxI2sBctVLjq8eiTBTbuclJki9M16Y4tlVXcgjFtgBb6Dyb7QJ86+PKOFazA
56v/S7yY4++hcqHI0F1+fovDxNdgzQF5fUNi7CMWQA5q82qOw98mnZf3dm4H84ba
ftjKD0gDJst+f0N7AipcXTEACGgD4Y+aOFs5jnmj0rAw14CfTi31GzPFNlCKq1Hp
VlTSVQQOisdEI3nlalaf0b9IAn1kyarPqCgPQLPHm0/TiaZ7qp5o7bf1Eh7v29zC
KSUNCjtKVh7bOzQJxPkPLFDjOVf8ocvYWXkGr33I1bF3aBlHYBUzS+9RRegwNed7
ZH7t2LuKMHCprQ9hH30xDVKOrZCxT4GgIYYc+1lSrVFrsSeuHlMgOrwokJ3qwF4p
mACxduNPyOClRJZQKksvqThgtg3aW9NxQaP/x2G5yCNihU9xk0zgrzz3HT542o0K
Vl/cwKHcMaDRFJLQSWDOa7ZOJ6kc/baI3Vs4//3zaF5C24Y8exTGVdjGky0+LDJ8
QmDJSEwKmYcW2tyXbs1yyZ+3W2T8X5my4SMhOEW11j5H9qvKSE0=
=uStW
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
