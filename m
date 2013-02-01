From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/3] mmc: sdhci: check voltage range only on regulators
 aware of voltage value
Date: Fri, 01 Feb 2013 15:40:23 +0100
Message-ID: <510BD3D7.1090302@samsung.com>
References: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
 <1354629663-29091-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:26423 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab3BAOk0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Feb 2013 09:40:26 -0500
In-reply-to: <1354629663-29091-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, Kevin Liu <keyuan.liu@gmail.com>

Hello,

On 12/4/2012 3:01 PM, Marek Szyprowski wrote:
> Some regulators don't report any voltage values, so checking supported
> voltage range results in disabling all SDHCI_CAN_VDD_* flags and
> registration failure. This patch finally provides a correct fix for the
> registration of SDHCI driver with all possible voltage regulators:
> dummy, fixed and regulated without using regulator_count_voltages()
> hacks.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Any chance to get this patch scheduled for v3.9?

> ---
>   drivers/mmc/host/sdhci.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a9ad2cd..d244dc0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2930,7 +2930,11 @@ int sdhci_add_host(struct sdhci_host *host)
>   	}
>   
>   #ifdef CONFIG_REGULATOR
> -	if (host->vmmc && regulator_count_voltages(host->vmmc) > 1) {
> +	/*
> +	 * Voltage range check makes sense only if regulator reports
> +	 * any voltage value.
> +	 */
> +	if (host->vmmc && regulator_get_voltage(host->vmmc) > 0) {
>   		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
>   			3600000);
>   		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


