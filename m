From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
Date: Tue, 31 Jan 2012 07:13:38 +0100
Message-ID: <201201310713.39553.heiko@sntech.de>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org> <201201301051.22396.heiko@sntech.de> <20120130190114.GR28397@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120130190114.GR28397@ponder.secretlab.ca>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Am Montag 30 Januar 2012, 20:01:14 schrieb Grant Likely:
> On Mon, Jan 30, 2012 at 10:51:11AM +0100, Heiko St=FCbner wrote:
> > Am Mittwoch, 2. November 2011, 21:36:03 schrieb Thomas Abraham:
> >=20
> > Hi Thomas,
> >=20
> > in patch 1/6:
> > > +static struct platform_device_id sdhci_s3c_driver_ids[] =3D {
> > > +       {
> > > +               .name           =3D "s3c-sdhci",
> > > +               .driver_data    =3D (kernel_ulong_t)NULL,
> > > +       },
> > > +       {
> > > +               .name           =3D "exynos4-sdhci",
> > > +               .driver_data    =3D EXYNOS4_SDHCI_DRV_DATA,
> > > +       },
> > > +};
> > > +MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
> >=20
> > and in patch 6/6:
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id sdhci_s3c_dt_match[] =3D {
> > > +	{ .compatible =3D "samsung,s3c6410-sdhci", },
> > > +	{ .compatible =3D "samsung,exynos4210-sdhci",
> > > +		.data =3D &exynos4_sdhci_drv_data },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
> >=20
> > wouldn't it be better to keep the naming consistent between of and
> > non-of? I.e. s3c-sdhci vs. s3c6410-sdhci. Since the driver is used =
for
> > all S3C SoCs containing hsmmc controllers I think s3c-sdhci would b=
e
> > preferable here.
>=20
> History has shown that future devices aren't always compatible with e=
arlier
> ones.  Compatible strings are expected to be specific to an exact dev=
ice to
> reduce the possibility of new hardware breaking assumptions.
>=20
> Instead, new hardware can either claim compatibility with older
> compatible strings (the compatible property in the DT is a list), or
> can have the new string added to the match table in the driver;
> whichever option makes the most sense.
ah, ok. Thanks for the explanation and I will keep that in mind.

Heiko
