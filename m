From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: mxcmmc: fix the default value for available
 voltages into mxcmci_probe
Date: Wed, 8 Oct 2014 08:46:52 +0200
Message-ID: <20141008064652.GZ4992@pengutronix.de>
References: <1412089178-21946-1-git-send-email-matteo.facchinetti@sirius-es.it>
 <1412089178-21946-3-git-send-email-matteo.facchinetti@sirius-es.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59039 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbaJHGrE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Oct 2014 02:47:04 -0400
Content-Disposition: inline
In-Reply-To: <1412089178-21946-3-git-send-email-matteo.facchinetti@sirius-es.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Cc: chris@printf.net, ulf.hansson@linaro.org, shc_work@mail.ru, peter.griffin@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linucppc-dev@lists.ozlabs.org, agust@denx.de, gsi@denx.de, sbabic@denx.de

On Tue, Sep 30, 2014 at 04:59:38PM +0200, Matteo Facchinetti wrote:
> From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> 
> If available voltages are not given, mmc_regulator_get_supply() function
> returns 0 and mxcmmc driver doesn't set a value for ocr_avail mask.
> 
> In accordance with the comment in platform_data/mmc-mxcmmc.h,
> fix it, assuming MMC_VDD_32_33 | MMC_VDD_33_34 as default value.
> 
> Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> ---
>  drivers/mmc/host/mxcmmc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 536a898..5350dc5 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1077,13 +1077,13 @@ static int mxcmci_probe(struct platform_device *pdev)
>  		dat3_card_detect = true;
>  
>  	ret = mmc_regulator_get_supply(mmc);

mmc_regulator_get_supply() sets mmc->ocr_avail based on the information
of the vmmc regulator if present...

> -	if (ret) {
> -		if (pdata && ret != -EPROBE_DEFER)
> -			mmc->ocr_avail = pdata->ocr_avail ? :
> -				MMC_VDD_32_33 | MMC_VDD_33_34;
> -		else
> -			goto out_free;
> -	}
> +	if (ret == -EPROBE_DEFER)
> +		goto out_free;
> +
> +	if (pdata && pdata->ocr_avail)
> +		mmc->ocr_avail = pdata->ocr_avail;
> +	else
> +		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;

... and here mmc->ocr_avail is overwritten unconditionally.

Unfortunately the return value of mmc_regulator_get_supply() doesn't
indicate if it was successful in setting a ocr_avail. So I think the best
you can do here is:

	if (!mmc->ocr_avail) {
		if (pdata && pdata->ocr_avail)
			mmc->ocr_avail = pdata->ocr_avail;
		else
			mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
	}

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
