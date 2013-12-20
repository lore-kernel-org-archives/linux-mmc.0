From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v6 3/7] regulator: add pbias regulator support
Date: Fri, 20 Dec 2013 15:17:59 +0530
Message-ID: <52B4124F.8010903@ti.com>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com> <1387456720-7202-1-git-send-email-balajitk@ti.com> <1387456720-7202-4-git-send-email-balajitk@ti.com> <20131219163300.GK27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34225 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755718Ab3LTJsI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Dec 2013 04:48:08 -0500
In-Reply-To: <20131219163300.GK27438@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org

On Thursday 19 December 2013 10:03 PM, Tony Lindgren wrote:
> Looks good to me, just few minor comments below.
>
> * Balaji T K <balajitk@ti.com> [131219 04:40]:
>> --- /dev/null
>> +++ b/drivers/regulator/pbias-regulator.c
>> @@ -0,0 +1,255 @@
>> +/*
>> + * pbias-regulator.c
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
>> + * Author: Balaji T K <balajitk@ti.com>
>
> Maybe use 2013 here instead?

yes

>
>> +static int pbias_regulator_enable(struct regulator_dev *rdev)
>> +{
>> +	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
>> +	const struct pbias_reg_info *info = data->info;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(data->syscon, data->pbias_reg,
>> +					info->enable_mask, info->enable);
>> +
>> +	return ret;
>> +}
>
> Do we need need to check the values after enable here? AFAIK setting
> the PBIAS voltage change can also fail and that's probably why it has

failure due to mismatch in input voltage, should to be avoided and should
be taken care in s/w by the caller before pbias regulator set voltage/enable.

> also the interrupt available.
>

But interrupt was never used/tested AFAIK, there is some settling time
before the generated interrupt status is truely valid, so pbias interrupt is not
reliable.

>> +static const struct pbias_reg_info pbias_mmc_omap3 = {
>> +	.enable = BIT(1),
>> +	.enable_mask = BIT(1),
>> +	.vmode = BIT(0),
>> +	.name = "pbias_mmc_omap3"
>> +};
>> +
>> +static const struct pbias_reg_info pbias_sim_omap3 = {
>> +	.enable = BIT(9),
>> +	.enable_mask = BIT(9),
>> +	.vmode = BIT(8),
>> +	.name = "pbias_sim_omap3"
>> +};
>> +
>> +static const struct pbias_reg_info pbias_mmc_omap4 = {
>> +	.enable = BIT(26) | BIT(22),
>> +	.enable_mask = BIT(26) | BIT(25) | BIT(22),
>> +	.vmode = BIT(21),
>> +	.name = "pbias_mmc_omap4"
>> +};
>> +
>> +static const struct pbias_reg_info pbias_mmc_omap5 = {
>> +	.enable = BIT(27) | BIT(26),
>> +	.enable_mask = BIT(27) | BIT(25) | BIT(26),
>> +	.vmode = BIT(21),
>> +	.name = "pbias_mmc_omap5"
>> +};
>>
>> +static struct of_regulator_match pbias_matches[] = {
>> +	{ .name = "pbias_mmc_omap3", .driver_data = (void *)&pbias_mmc_omap3},
>> +	{ .name = "pbias_sim_omap3", .driver_data = (void *)&pbias_sim_omap3},
>> +	{ .name = "pbias_mmc_omap4", .driver_data = (void *)&pbias_mmc_omap4},
>> +	{ .name = "pbias_mmc_omap5", .driver_data = (void *)&pbias_mmc_omap5},
>> +};
>
> We probably need also pbias_mmc_omap2430 as that regiter mapping is
> separate from omap3?
>

between omap2430 and omap3430, 3460 pbias register address are different,
other than that enable,enable_mask and vmode are
one and the same, so re-used "pbias_mmc_omap3" name and struct pbias_reg_info pbias_mmc_omap3
for omap2430 too, save one entry in of_regulator_match!

If separate name is needed for omap2430, I can add one for 2430,
and reuse the "const struct pbias_reg_info pbias_mmc_omap3" of omap3
since the bit map for enable/disable and voltage configuration will be same.
Then pbias_matches will look like.

 >> +static struct of_regulator_match pbias_matches[] = {
 >> +	{ .name = "pbias_mmc_omap2430", .driver_data = (void *)&pbias_mmc_omap3},
 >> +	{ .name = "pbias_mmc_omap3", .driver_data = (void *)&pbias_mmc_omap3},
 >> +	{ .name = "pbias_sim_omap3", .driver_data = (void *)&pbias_sim_omap3},
 >> +	{ .name = "pbias_mmc_omap4", .driver_data = (void *)&pbias_mmc_omap4},
 >> +	{ .name = "pbias_mmc_omap5", .driver_data = (void *)&pbias_mmc_omap5},
 >> +};

Let me know if you still think that separate regulator name is needed for 2430,
I can respin this series.

> Other than that, good to see this finally happen. This should allow us to
> get rid of most of the platform data callbacks for omap_hsmmc.c driver.
>
> Regards,
>
> Tony
>
