From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Date: Tue, 2 Apr 2019 16:41:18 +0000
Message-ID: <BYAPR12MB3398861980C3F967CD209393C2560@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
 <20190402145901.GF8017@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402145901.GF8017@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Aniruddha Tvs Rao <anrao@nvidia.com>, Timo Alho <talho@nvidia.com>, Bitan Biswas <bbiswas@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

> On Mon, Apr 01, 2019 at 10:27:33PM -0700, Sowjanya Komatineni wrote:
> > This patch adds suspend and resume PM ops for tegra SDHCI.
> >=20
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 45=20
> > +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-tegra.c=20
> > b/drivers/mmc/host/sdhci-tegra.c index eafaaefab4a6..68263ea4a93e=20
> > 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -1611,11 +1611,54 @@ static int sdhci_tegra_remove(struct platform_d=
evice *pdev)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_PM_SLEEP
> > +static int sdhci_tegra_suspend(struct device *dev) {
> > +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	int ret;
> > +
> > +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > +		ret =3D cqhci_suspend(host->mmc);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret =3D sdhci_suspend_host(host);
> > +	if (ret)
> > +		return ret;
> > +
> > +	clk_disable_unprepare(pltfm_host->clk);
> > +	return 0;
> > +}
> > +
> > +static int sdhci_tegra_resume(struct device *dev) {
> > +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	int ret;
> > +
> > +	clk_prepare_enable(pltfm_host->clk);
>
> You need to check this for errors here.
>
> > +
> > +	ret =3D sdhci_resume_host(host);
> > +	if (ret)
> > +		return ret;
>
> And clk_disable_unprepare() in case of failure.
>
> > +
> > +	if (host->mmc->caps2 & MMC_CAP2_CQE)
> > +		return cqhci_resume(host->mmc);
>
> Same here. Also make sure to sdhci_suspend_host() if cqhci_resume() fails=
. It's probably best to have a standard error cleanup path for this.
>
> Thierry

Thanks Thierry. Will add error check and cleanup for clock and sdhci_resume=
_host.
Regarding, cqhci_resume always returns 0. Infact, it does nothing as resume=
 happens on first cqhci_request.
Since helper functions exists in cqhci driver, was using it for explicit re=
sume call.
