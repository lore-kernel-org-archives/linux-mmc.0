From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 02/10] mmc: omap_hsmmc: make vcc and vcc_aux
 independent
Date: Wed, 12 Jun 2013 07:25:54 -0700
Message-ID: <20130612142553.GX8164@atomide.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-3-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33201 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab3FLOZ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 10:25:57 -0400
Content-Disposition: inline
In-Reply-To: <1370546059-24181-3-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org

* Balaji T K <balajitk@ti.com> [130606 12:20]:
> handle vcc and vcc_aux independently
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1865321..bda1a42 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -253,7 +253,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>  	 * If we don't see a Vcc regulator, assume it's a fixed
>  	 * voltage always-on regulator.
>  	 */
> -	if (!host->vcc)
> +	if (!host->vcc && !host->vcc_aux)
>  		return 0;
>  	/*
>  	 * With DT, never turn OFF the regulator for MMC1. This is because

Doesn't the above change break MMC for most boards that only pass
one regulator and no aux regulator?

Regards,

Tony

> @@ -280,11 +280,12 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>  	 * chips/cards need an interface voltage rail too.
>  	 */
>  	if (power_on) {
> -		ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
> +		if (host->vcc)
> +			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
>  		/* Enable interface voltage rail, if needed */
>  		if (ret == 0 && host->vcc_aux) {
>  			ret = regulator_enable(host->vcc_aux);
> -			if (ret < 0)
> +			if (ret < 0 && host->vcc)
>  				ret = mmc_regulator_set_ocr(host->mmc,
>  							host->vcc, 0);
>  		}
> @@ -292,7 +293,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>  		/* Shut down the rail */
>  		if (host->vcc_aux)
>  			ret = regulator_disable(host->vcc_aux);
> -		if (!ret) {
> +		if (host->vcc) {
>  			/* Then proceed to shut down the local regulator */
>  			ret = mmc_regulator_set_ocr(host->mmc,
>  						host->vcc, 0);
> -- 
> 1.7.5.4
> 
