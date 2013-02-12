From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/3 RESEND] mmc: sdhci: check voltage range only on
 regulators aware of voltage value
Date: Tue, 12 Feb 2013 23:10:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302122309470.14434@axis700.grange>
References: <87bobqrcb4.fsf@octavius.laptop.org>
 <1360656096-1671-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53100 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab3BLWKk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Feb 2013 17:10:40 -0500
In-Reply-To: <1360656096-1671-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, Kevin Liu <keyuan.liu@gmail.com>

Hi Marek

On Tue, 12 Feb 2013, Marek Szyprowski wrote:

> Some regulators don't report any voltage values, so checking supported
> voltage range results in disabling all SDHCI_CAN_VDD_* flags and
> registration failure. This patch finally provides a correct fix for the
> registration of SDHCI driver with all possible voltage regulators:
> dummy, fixed and regulated without using regulator_count_voltages()
> hacks.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mmc/host/sdhci.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ba586ae..735526b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2976,7 +2976,11 @@ int sdhci_add_host(struct sdhci_host *host)
>  	}
>  
>  #ifdef CONFIG_REGULATOR
> -	if (host->vmmc) {
> +	/*
> +	 * Voltage range check makes sense only if regulator reports
> +	 * any voltage value.
> +	 */
> +	if (host->vmmc && regulator_get_voltage(host->vmmc) > 0) {
>  		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
>  			3600000);

Wouldn't using mmc_regulator_get_ocrmask() be a better option?

Thanks
Guennadi

>  		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
