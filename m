From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/7] regulator: add pbias regulator support
Date: Tue, 10 Dec 2013 10:40:05 +0000
Message-ID: <20131210104005.GB29268@sirena.org.uk>
References: <1385043627-30439-1-git-send-email-balajitk@ti.com>
 <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1386670577-3530-4-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y6v6BlSmAeeSvrQk"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46034 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab3LJKkJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 05:40:09 -0500
Content-Disposition: inline
In-Reply-To: <1386670577-3530-4-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com


--Y6v6BlSmAeeSvrQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2013 at 03:46:13PM +0530, Balaji T K wrote:

> +config REGULATOR_PBIAS
> +	tristate "PBIAS OMAP regulator driver"
> +	depends on ARCH_OMAP && MFD_SYSCON

That should be (ARCH_OMAP || COMPILE_TEST) && MFD_SYSCON

> +static int pbias_regulator_set_voltage(struct regulator_dev *dev,
> +			int min_uV, int max_uV, unsigned *selector)
> +{
> +	struct pbias_regulator_data *data = rdev_get_drvdata(dev);
> +	const struct pbias_reg_info *info = data->info;
> +	int ret, vmode;
> +
> +	if (min_uV <= 1800000)
> +		vmode = 0;
> +	else if (min_uV > 1800000)
> +		vmode = info->vmode;
> +
> +	ret = regmap_update_bits(data->syscon, data->pbias_reg,
> +						info->vmode, vmode);
> +	data->voltage = min_uV;

This is exactly the same as it was the first time it was posted and is
still buggy.  To repeat the get and set voltage functions should reflect
the actual voltage set in the hardware.

> +static int pbias_regulator_is_enable(struct regulator_dev *rdev)
> +{
> +	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
> +	const struct pbias_reg_info *info = data->info;
> +	int value;
> +
> +	regmap_read(data->syscon, data->pbias_reg, &value);
> +
> +	return value & info->enable_mask;
> +}

If the enable mask really can have multiple bits this won't do the right
thing - it'll return true if any bits are set.  It needs to make sure
all the bits are set.

> +#if CONFIG_OF

Why?

> +	drvdata->desc.n_voltages = 3;

This doesn't match your implementation which can only set two voltages.

--Y6v6BlSmAeeSvrQk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpu+BAAoJELSic+t+oim93y4QAIOSQ/XtYlTWEtImzEqZHmXX
oLQJPpcslbp+Qam0Um2hZe5WVg4131HhhH2vQl3TplcW/JU1oxUUEbn2rH7Stguz
5aC7uY9493Ue9mdrh39u90MIl2/u6c2aP2RU5K1RS6qkSFdLl5pSaWeGVBfwh2Rg
x38c11SQkjEbXHg0w05xTjoNz+C7Y2wWdkYlKLkObmCiBZLC4SvNMFXepK7E8HYC
UuUJf8XNpjOBCS3qWxiwvORZLQGO24pipfooVTa2ynCOKy6YcVEIw3mLxiyYdAg6
BG+O9+M+y9urKyRVQhlgevJTMYycEQq5E0cOJIp0v/UkO0XZCspf7dyOpFwMN0mJ
f1/G8MjHdVsKoxSa/uR/M/YKoyVq4B8vFCVu+HWXcQ+cpT8PZ6polY31VY2CS9W7
Mu7EJitTgElg08FOipjqy6w7HRcEkM9lfWMPPL2CS71DGvobfb6mfoWNkLm7EVd5
gp3prrauF49GusHWRelmZUkNSqS5WKp/hxK3OzsgapYfGvI0JWRq4mXeuMf0p6IJ
miPl5p89bv3ElURzDqF6AB+ofXAYklX63w36QS9BFUw/rW8Jp3/0rs3oR25l9abp
NFS57wYzJAzh9HuRvcMtDvkNJBB/jeoV8FlT4Aktz7H67C4axJX84pa6XMC7X6MZ
klrc5uOYJR/8sWkOGcQb
=witk
-----END PGP SIGNATURE-----

--Y6v6BlSmAeeSvrQk--
