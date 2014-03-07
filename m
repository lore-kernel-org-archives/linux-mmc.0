From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 1/3] regulator: pbias: Fix is_enabled callback implementation
Date: Fri, 7 Mar 2014 22:18:59 +0530
Message-ID: <5319F87B.8080400@ti.com>
References: <1394206897.17867.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56886 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbaCGQtJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Mar 2014 11:49:09 -0500
In-Reply-To: <1394206897.17867.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Stefan Roese <sr@denx.de>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Friday 07 March 2014 09:11 PM, Axel Lin wrote:
> The is_enabled implementation is wrong in some cases:
> e.g. for pbias_mmc_omap5: emable_mask is : BIT(27) | BIT(25) | BIT(26)
Hi Axel,

s/emable_mask/enable_mask

> However, pbias_regulator_enable() only sets BIT(26) | BIT(22) bits.

You mixed up enable_mask of omap5 with .enable of omap4 :-)
above comment should be
"However, pbias_regulator_enable() only sets BIT(27) | BIT(26) bits"
Other than that
Acked-by: Balaji T K <balajitk@ti.com>

> So is_enabled callback will always return false in this case.
> Fix the logic to compare the register value with info->enable rather than
> info->enable_mask.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/pbias-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
> index ded3b35..d89a1d8 100644
> --- a/drivers/regulator/pbias-regulator.c
> +++ b/drivers/regulator/pbias-regulator.c
> @@ -108,7 +108,7 @@ static int pbias_regulator_is_enable(struct regulator_dev *rdev)
>
>   	regmap_read(data->syscon, data->pbias_reg, &value);
>
> -	return (value & info->enable_mask) == info->enable_mask;
> +	return (value & info->enable_mask) == info->enable;
>   }
>
>   static struct regulator_ops pbias_regulator_voltage_ops = {
>

