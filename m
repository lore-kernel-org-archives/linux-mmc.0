From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 2/3] mmc: use regulator_can_change_voltage() instead of
 regulator_count_voltages() hacks
Date: Fri, 01 Feb 2013 15:39:45 +0100
Message-ID: <510BD3B1.3040601@samsung.com>
References: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
 <1354629663-29091-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:26376 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab3BAOjt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Feb 2013 09:39:49 -0500
In-reply-to: <1354629663-29091-3-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, Kevin Liu <keyuan.liu@gmail.com>

Hello,

On 12/4/2012 3:01 PM, Marek Szyprowski wrote:
> mmc_regulator_set_ocr() depends on the ability of regulator to change the
> voltage value. When regulator cannot change its voltage output, some code is
> skipped to avoid reporting false errors on some boards, which use MMC hosts
> with fixed regulators (example: Samsung Goni and UniversalC210 boards).
>
> This patch replaces a hacky workaround based on regulator_count_voltages()
> value with the correct call to recently introduced
> regulator_can_change_voltage() function in regulators core.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Any chance to get this patch scheduled for v3.9?

> ---
>   drivers/mmc/core/core.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index aaed768..f5a0493 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1137,7 +1137,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>   		 */
>   		voltage = regulator_get_voltage(supply);
>   
> -		if (regulator_count_voltages(supply) == 1)
> +		if (!regulator_can_change_voltage(supply))
>   			min_uV = max_uV = voltage;
>   
>   		if (voltage < 0)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


