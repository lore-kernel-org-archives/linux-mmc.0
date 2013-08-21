From: walter harms <wharms@bfs.de>
Subject: Re: [patch] mmc: sdhci-bcm-kona: '|' vs '&' typo
Date: Wed, 21 Aug 2013 10:57:57 +0200
Message-ID: <52148115.3050703@bfs.de>
References: <20130821082423.GA5240@elgon.mountain>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx01-fr.bfs.de ([193.174.231.67]:43792 "EHLO mx01-fr.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab3HUJFt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Aug 2013 05:05:49 -0400
In-Reply-To: <20130821082423.GA5240@elgon.mountain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Christian Daudt <csd@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org



Am 21.08.2013 10:24, schrieb Dan Carpenter:
> The intent was to test if a flag was set.  In the current code the
> conditions are always true.

I guess that it worked before ...
That leaves the Question: are the tests needed at all ?

re,
 wh

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static checker stuff.  Untested.
> 
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 87175f9..9ffac0b 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -263,7 +263,7 @@ static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
>  		(mmc_gpio_get_cd(host->mmc) != -ENOSYS) ? 'Y' : 'N',
>  		(mmc_gpio_get_ro(host->mmc) != -ENOSYS) ? 'Y' : 'N');
>  
> -	if (host->mmc->caps | MMC_CAP_NONREMOVABLE)
> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>  
>  	dev_dbg(dev, "is_8bit=%c\n",
> @@ -282,7 +282,7 @@ static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
>  	}
>  
>  	/* if device is eMMC, emulate card insert right here */
> -	if (host->mmc->caps | MMC_CAP_NONREMOVABLE) {
> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
>  		ret = sdhci_bcm_kona_sd_card_emulate(host, 1);
>  		if (ret) {
>  			dev_err(dev,
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
