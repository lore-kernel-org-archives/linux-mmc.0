From: Balaji T K <balajitk@ti.com>
Subject: Re: [RFC PATCH v3 3/8] regulator: add pbias regulator support
Date: Tue, 3 Dec 2013 21:24:15 +0530
Message-ID: <529DFEA7.9010707@ti.com>
References: <1385043627-30439-4-git-send-email-balajitk@ti.com> <20131121144623.GA8120@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46807 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab3LCPyX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Dec 2013 10:54:23 -0500
In-Reply-To: <20131121144623.GA8120@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com

On Thursday 21 November 2013 08:16 PM, Mark Brown wrote:
> On Thu, Nov 21, 2013 at 07:50:22PM +0530, Balaji T K wrote:
>
>> +static int pbias_regulator_set_voltage(struct regulator_dev *dev,
>> +			int min_uV, int max_uV, unsigned *selector)
>> +{
>> +	struct pbias_regulator_data *data = rdev_get_drvdata(dev);
>> +	const struct pbias_bit_map *bmap = data->bmap;
>> +	int ret, vmode;
>> +
>> +	if (min_uV <= 1800000)
>> +		vmode = 0;
>> +	else if (min_uV > 1800000)
>> +		vmode = bmap->vmode;
>> +
>> +	ret = regmap_update_bits(data->syscon, data->pbias_reg,
>> +						bmap->vmode, vmode);
>> +	data->voltage = min_uV;
>
>> +static int pbias_regulator_get_voltage(struct regulator_dev *rdev)
>> +{
>> +	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
>> +
>> +	return data->voltage;
>> +}
>
> These don't match up with each other - the get and set voltage calls
> should reflect what the hardware state is, not what was requested by the
> caller.  You should be able to use the regmap helpers I think.
>
Hi,

get_voltage returns the min_uV, saved in set_voltage since pbias
only need to programmed if the voltage supply in for pbias cell is less than
or greater than 1.8V, so vmode bit will be set for 3V and also for 3.3V too.

>> +static int pbias_regulator_enable(struct regulator_dev *rdev)
>> +{
>> +	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
>> +	const struct pbias_bit_map *bmap = data->bmap;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(data->syscon, data->pbias_reg,
>> +					bmap->enable_mask, bmap->enable);
>
> regulator_enable_regmap() and similarly for disable() and is_enabled().
>

I don't think regmap helper can be used here, to enable pbias cells
I need reset a bit field (to bring pbias out of high impedence mode)
and also set a bit (to bring it out of power down mode)

>> +	supply_name = initdata->constraints.name;
>> +
>> +	of_property_read_u32(np, "startup-delay-us", &startup_delay);
>> +	ret = of_property_read_u32(np, "pbias-reg-offset",
>> +				   &drvdata->pbias_reg);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "no pbias-reg-offset property set\n");
>> +		return ret;
>> +	}
>
> This looks like it should be added as a standard property for overridig
> the regulator delay if it can't be set based on the compatible string
> alone due to board dependencies.  Do something like what's done for
> regulator-ramp-delay.
>
>> +err_regulator:
>> +	kfree(drvdata->desc.name);
>> +	return ret;
>
> devm_kzalloc().
>

Will assign desc name statically

>> +static int __init pbias_regulator_init(void)
>> +{
>> +	return platform_driver_register(&pbias_regulator_driver);
>> +}
>> +subsys_initcall(pbias_regulator_init);
>
> module_platform_driver().

OK

