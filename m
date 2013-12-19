From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 3/7] regulator: add pbias regulator support
Date: Thu, 19 Dec 2013 08:33:01 -0800
Message-ID: <20131219163300.GK27438@atomide.com>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-1-git-send-email-balajitk@ti.com>
 <1387456720-7202-4-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34997 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab3LSQdH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 11:33:07 -0500
Content-Disposition: inline
In-Reply-To: <1387456720-7202-4-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org

Looks good to me, just few minor comments below.

* Balaji T K <balajitk@ti.com> [131219 04:40]:
> --- /dev/null
> +++ b/drivers/regulator/pbias-regulator.c
> @@ -0,0 +1,255 @@
> +/*
> + * pbias-regulator.c
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * Author: Balaji T K <balajitk@ti.com>

Maybe use 2013 here instead?

> +static int pbias_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
> +	const struct pbias_reg_info *info = data->info;
> +	int ret;
> +
> +	ret = regmap_update_bits(data->syscon, data->pbias_reg,
> +					info->enable_mask, info->enable);
> +
> +	return ret;
> +}

Do we need need to check the values after enable here? AFAIK setting
the PBIAS voltage change can also fail and that's probably why it has
also the interrupt available.

> +static const struct pbias_reg_info pbias_mmc_omap3 = {
> +	.enable = BIT(1),
> +	.enable_mask = BIT(1),
> +	.vmode = BIT(0),
> +	.name = "pbias_mmc_omap3"
> +};
> +
> +static const struct pbias_reg_info pbias_sim_omap3 = {
> +	.enable = BIT(9),
> +	.enable_mask = BIT(9),
> +	.vmode = BIT(8),
> +	.name = "pbias_sim_omap3"
> +};
> +
> +static const struct pbias_reg_info pbias_mmc_omap4 = {
> +	.enable = BIT(26) | BIT(22),
> +	.enable_mask = BIT(26) | BIT(25) | BIT(22),
> +	.vmode = BIT(21),
> +	.name = "pbias_mmc_omap4"
> +};
> +
> +static const struct pbias_reg_info pbias_mmc_omap5 = {
> +	.enable = BIT(27) | BIT(26),
> +	.enable_mask = BIT(27) | BIT(25) | BIT(26),
> +	.vmode = BIT(21),
> +	.name = "pbias_mmc_omap5"
> +};
>
> +static struct of_regulator_match pbias_matches[] = {
> +	{ .name = "pbias_mmc_omap3", .driver_data = (void *)&pbias_mmc_omap3},
> +	{ .name = "pbias_sim_omap3", .driver_data = (void *)&pbias_sim_omap3},
> +	{ .name = "pbias_mmc_omap4", .driver_data = (void *)&pbias_mmc_omap4},
> +	{ .name = "pbias_mmc_omap5", .driver_data = (void *)&pbias_mmc_omap5},
> +};

We probably need also pbias_mmc_omap2430 as that regiter mapping is
separate from omap3?

Other than that, good to see this finally happen. This should allow us to
get rid of most of the platform data callbacks for omap_hsmmc.c driver.

Regards,

Tony
