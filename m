From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v7 3/7] regulator: add pbias regulator support
Date: Tue, 24 Dec 2013 21:41:13 +0530
Message-ID: <52B9B221.40004@ti.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com> <1387560955-6547-4-git-send-email-balajitk@ti.com> <20131220184451.GD26054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53974 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3LXQLY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Dec 2013 11:11:24 -0500
In-Reply-To: <20131220184451.GD26054@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org

On Saturday 21 December 2013 05:09 AM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [131220 09:37]:
>> +static const struct pbias_reg_info pbias_mmc_omap2430 = {
>> +	.enable = BIT(1),
>> +	.enable_mask = BIT(1),
>> +	.vmode = BIT(0),
>> +	.enable_time = 100,
>> +	.name = "pbias_mmc_omap2430"
>> +};
>> +
>> +static const struct pbias_reg_info pbias_sim_omap3 = {
>> +	.enable = BIT(9),
>> +	.enable_mask = BIT(9),
>> +	.vmode = BIT(8),
>> +	.enable_time = 100,
>> +	.name = "pbias_sim_omap3"
>> +};
>> +
>> +static const struct pbias_reg_info pbias_mmc_omap4 = {
>> +	.enable = BIT(26) | BIT(22),
>> +	.enable_mask = BIT(26) | BIT(25) | BIT(22),
>> +	.vmode = BIT(21),
>> +	.enable_time = 10,
>> +	.name = "pbias_mmc_omap4"
>> +};
>> +
>> +static const struct pbias_reg_info pbias_mmc_omap5 = {
>> +	.enable = BIT(27) | BIT(26),
>> +	.enable_mask = BIT(27) | BIT(25) | BIT(26),
>> +	.vmode = BIT(21),
>> +	.enable_time = 100,
>> +	.name = "pbias_mmc_omap5"
>> +};
>
> Should the enable_time be 100 for omap4 like for the others?
>

enable_time of 10 is fine for omap4

> Other than that:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>

Thanks Tony
