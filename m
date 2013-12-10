From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v4 3/7] regulator: add pbias regulator support
Date: Tue, 10 Dec 2013 17:52:06 +0530
Message-ID: <52A7076E.3000505@ti.com>
References: <1385043627-30439-1-git-send-email-balajitk@ti.com> <1386670577-3530-1-git-send-email-balajitk@ti.com> <1386670577-3530-4-git-send-email-balajitk@ti.com> <20131210104005.GB29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45707 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215Ab3LJMWQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Dec 2013 07:22:16 -0500
In-Reply-To: <20131210104005.GB29268@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com

On Tuesday 10 December 2013 04:10 PM, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 03:46:13PM +0530, Balaji T K wrote:
>
>> +config REGULATOR_PBIAS
>> +	tristate "PBIAS OMAP regulator driver"
>> +	depends on ARCH_OMAP && MFD_SYSCON
>
> That should be (ARCH_OMAP || COMPILE_TEST) && MFD_SYSCON
>

Ok

>> +static int pbias_regulator_set_voltage(struct regulator_dev *dev,
>> +			int min_uV, int max_uV, unsigned *selector)
>> +{
>> +	struct pbias_regulator_data *data = rdev_get_drvdata(dev);
>> +	const struct pbias_reg_info *info = data->info;
>> +	int ret, vmode;
>> +
>> +	if (min_uV <= 1800000)
>> +		vmode = 0;
>> +	else if (min_uV > 1800000)
>> +		vmode = info->vmode;
>> +
>> +	ret = regmap_update_bits(data->syscon, data->pbias_reg,
>> +						info->vmode, vmode);
>> +	data->voltage = min_uV;
>
> This is exactly the same as it was the first time it was posted and is
> still buggy.  To repeat the get and set voltage functions should reflect
> the actual voltage set in the hardware.
>

my bad, will fix it.

>> +static int pbias_regulator_is_enable(struct regulator_dev *rdev)
>> +{
>> +	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
>> +	const struct pbias_reg_info *info = data->info;
>> +	int value;
>> +
>> +	regmap_read(data->syscon, data->pbias_reg, &value);
>> +
>> +	return value & info->enable_mask;
>> +}
>
> If the enable mask really can have multiple bits this won't do the right
> thing - it'll return true if any bits are set.  It needs to make sure
> all the bits are set.
>

True, will fix it.

>> +#if CONFIG_OF
>
> Why?

Driver is DT only, Will remove it.

>
>> +	drvdata->desc.n_voltages = 3;
>
> This doesn't match your implementation which can only set two voltages.
>

I considered power-off too, will make it 2 then.

Thanks and Regards,
Balaji T K
