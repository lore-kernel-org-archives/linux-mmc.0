From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: sdhci: apply voltage range check only for non-fixed regulators
Date: Tue, 13 Nov 2012 07:45:07 -0500
Message-ID: <87fw4dn030.fsf@octavius.laptop.org>
References: <1352796533-12350-1-git-send-email-m.szyprowski@samsung.com>
	<1352796533-12350-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53852 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab2KMMpT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Nov 2012 07:45:19 -0500
In-Reply-To: <1352796533-12350-4-git-send-email-m.szyprowski@samsung.com>
	(Marek Szyprowski's message of "Tue, 13 Nov 2012 09:48:53 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>

Hi Marek,

On Tue, Nov 13 2012, Marek Szyprowski wrote:
> Fixed regulators cannot change their voltage, so disable all voltage range
> checking for them, otherwise the driver fails to operate with fixed
> regulators.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Perhaps it's a good idea to mention that the regulator API is changing
(being fixed) at the same time, and that's why this patch is necessary.

> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c7851c0..6f6534e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2923,7 +2923,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  		regulator_enable(host->vmmc);
>  
>  #ifdef CONFIG_REGULATOR
> -	if (host->vmmc) {
> +	if (host->vmmc && regulator_count_voltages(host->vmmc) > 1) {
>  		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
>  			3300000);
>  		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))

What about other occasions where is_supported_voltage() is used, like
this one -- is it necessary here too?

        else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
                regulator_enable(host->vqmmc);

Thanks,                

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
