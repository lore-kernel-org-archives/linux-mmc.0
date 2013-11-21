From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v3 3/8] regulator: add pbias regulator support
Date: Thu, 21 Nov 2013 14:46:23 +0000
Message-ID: <20131121144623.GA8120@sirena.org.uk>
References: <1385043627-30439-4-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385043627-30439-4-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com
List-Id: linux-mmc@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 07:50:22PM +0530, Balaji T K wrote:

> +static int pbias_regulator_set_voltage(struct regulator_dev *dev,
> +			int min_uV, int max_uV, unsigned *selector)
> +{
> +	struct pbias_regulator_data *data = rdev_get_drvdata(dev);
> +	const struct pbias_bit_map *bmap = data->bmap;
> +	int ret, vmode;
> +
> +	if (min_uV <= 1800000)
> +		vmode = 0;
> +	else if (min_uV > 1800000)
> +		vmode = bmap->vmode;
> +
> +	ret = regmap_update_bits(data->syscon, data->pbias_reg,
> +						bmap->vmode, vmode);
> +	data->voltage = min_uV;

> +static int pbias_regulator_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
> +
> +	return data->voltage;
> +}

These don't match up with each other - the get and set voltage calls
should reflect what the hardware state is, not what was requested by the
caller.  You should be able to use the regmap helpers I think.

> +static int pbias_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
> +	const struct pbias_bit_map *bmap = data->bmap;
> +	int ret;
> +
> +	ret = regmap_update_bits(data->syscon, data->pbias_reg,
> +					bmap->enable_mask, bmap->enable);

regulator_enable_regmap() and similarly for disable() and is_enabled().

> +	supply_name = initdata->constraints.name;
> +
> +	of_property_read_u32(np, "startup-delay-us", &startup_delay);
> +	ret = of_property_read_u32(np, "pbias-reg-offset",
> +				   &drvdata->pbias_reg);
> +	if (ret) {
> +		dev_err(&pdev->dev, "no pbias-reg-offset property set\n");
> +		return ret;
> +	}

This looks like it should be added as a standard property for overridig
the regulator delay if it can't be set based on the compatible string
alone due to board dependencies.  Do something like what's done for
regulator-ramp-delay.

> +err_regulator:
> +	kfree(drvdata->desc.name);
> +	return ret;

devm_kzalloc().

> +static int __init pbias_regulator_init(void)
> +{
> +	return platform_driver_register(&pbias_regulator_driver);
> +}
> +subsys_initcall(pbias_regulator_init);

module_platform_driver().

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjhy8AAoJELSic+t+oim9FgAP/3DOgHLOu5/FReSkZ4DAWUDe
2exoaRwlJ4FUtcpuN69vIcBWkONOZtwEhlVdsGOvHUTOuEP3g/jpaEHs5n2QhZir
BHC79OtJ9Q14MaCTyJw3Qrflh8WkMi2bHiGrq8RxTCkRIO+8FQxiiWMHipMzvsM5
ISmZXn6ipykCnl8dJwcJXhHpjkmxerimHQN4jfjhCggrpirxpw9h/mtwQNm22+lx
Jd3EuoU14/3us+8rFsm+mGueiR/1hTHdrgEZk2KKAV27DuLfc/U9tQZECBhFDawW
HKXj4BBdRTY55umLh+YvilBJdjXyUC+Dz2dzC7FIfrK3acOBzhHoh8cOkDHSiIdv
vVMz/jRucHGZX5w/EJg3rsse5YDIpBZCzkK7YjWeNH24VZAkwylb18VMeQYGU7I/
f0/hFbFmLml14+m9glD1yyJdSKogdE1Sg3/Yx617kveY9hHUEY/ql7FyP7i9r6BE
fYEtJ7wiY4SSsrUXdKmKV1MtqvJaKUWpcdYKypLa+CM6ViAVGz2s+NncIY5lsBCB
Mzy2/y9f5gLmpQgCmYTEHrSu1vTpk1rA9FEl2O7h7ja7TLvMA1HtogW8uhYwgTx+
lsjq8jknhlZXCh2wZSpLr+tXCKeH8bAeqL0t6rBLQkMsZDG5yHq5our/6tJ+ACFS
DNq9ZBTS64UgujKqmb26
=bIz+
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
