From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
Date: Mon, 30 Jan 2012 12:01:14 -0700
Message-ID: <20120130190114.GR28397@ponder.secretlab.ca>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
 <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
 <201201301051.22396.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201201301051.22396.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 30, 2012 at 10:51:11AM +0100, Heiko St=FCbner wrote:
> Am Mittwoch, 2. November 2011, 21:36:03 schrieb Thomas Abraham:
>=20
> Hi Thomas,
>=20
> in patch 1/6:
> > +static struct platform_device_id sdhci_s3c_driver_ids[] =3D {
> > +       {
> > +               .name           =3D "s3c-sdhci",
> > +               .driver_data    =3D (kernel_ulong_t)NULL,
> > +       },
> > +       {
> > +               .name           =3D "exynos4-sdhci",
> > +               .driver_data    =3D EXYNOS4_SDHCI_DRV_DATA,
> > +       },
> > +};
> > +MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
>=20
>=20
> and in patch 6/6:
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id sdhci_s3c_dt_match[] =3D {
> > +	{ .compatible =3D "samsung,s3c6410-sdhci", },
> > +	{ .compatible =3D "samsung,exynos4210-sdhci",
> > +		.data =3D &exynos4_sdhci_drv_data },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
>=20
> wouldn't it be better to keep the naming consistent between of and no=
n-of?
> I.e. s3c-sdhci vs. s3c6410-sdhci. Since the driver is used for all S3=
C SoCs=20
> containing hsmmc controllers I think s3c-sdhci would be preferable he=
re.

History has shown that future devices aren't always compatible with ear=
lier
ones.  Compatible strings are expected to be specific to an exact devic=
e to
reduce the possibility of new hardware breaking assumptions.

Instead, new hardware can either claim compatibility with older
compatible strings (the compatible property in the DT is a list), or
can have the new string added to the match table in the driver;
whichever option makes the most sense.

g.
