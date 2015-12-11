From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] mmc: sdhci: restore behavior when setting VDD via
 external regulator
Date: Fri, 11 Dec 2015 21:27:15 +0800
Message-ID: <20151211212715.6c6534eb@xhacker>
References: <1449839999-439-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61233 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361AbbLKNbM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2015 08:31:12 -0500
In-Reply-To: <1449839999-439-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 11 Dec 2015 21:19:59 +0800 Jisheng Zhang wrote:

> After commit 52221610dd84 ("mmc: sdhci: Improve external VDD regulator
> support"), for the VDD is supplied via external regulators, we ignore
> the code to convert a VDD voltage request into one of the standard
> SDHCI voltage levels, then program it in the SDHCI_POWER_CONTROL. This
> brings two issues:
> 
> 1. SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk isn't handled properly any
> more.
> 
> 2. What's more, some controllers such as the sdhci-pxav3 used in
> marvell berlin SoCs require the voltage levels programming in the
> SDHCI_POWER_CONTROL register, even the VDD is supplied by external
> regulator.

Actually, for this controller, once SDHCI_POWER_ON bit is set, the voltage
levels also must be correctly set even the VDD is supplied by external regulator.

so commit 52221610dd84 doesn't really introduce the regression, but commit
52221610dd84 and 3cbc6123a93d ("mmc: sdhci: Set SDHCI_POWER_ON with external
vmmc") would make the sdcard broken. 

Seems I also need to put these information into the commit msg. will submit
v2 soon.

Thank you,
Jisheng

> 
> This patch restores the behavior when setting VDD through external
> regulator by moving the call of mmc_regulator_set_ocr() to the end
> of sdhci_set_power() function.
> 
> After this patch, the sdcard on Marvell Berlin SoCs work again.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Fixes: 52221610dd84 ("mmc: sdhci: Improve external VDD ...")
> ---
>  drivers/mmc/host/sdhci.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b48565e..616aa90 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1274,19 +1274,6 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  	struct mmc_host *mmc = host->mmc;
>  	u8 pwr = 0;
>  
> -	if (!IS_ERR(mmc->supply.vmmc)) {
> -		spin_unlock_irq(&host->lock);
> -		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> -		spin_lock_irq(&host->lock);
> -
> -		if (mode != MMC_POWER_OFF)
> -			sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
> -		else
> -			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> -
> -		return;
> -	}
> -
>  	if (mode != MMC_POWER_OFF) {
>  		switch (1 << vdd) {
>  		case MMC_VDD_165_195:
> @@ -1345,6 +1332,12 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
>  			mdelay(10);
>  	}
> +
> +	if (!IS_ERR(mmc->supply.vmmc)) {
> +		spin_unlock_irq(&host->lock);
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +		spin_lock_irq(&host->lock);
> +	}
>  }
>  
>  /*****************************************************************************\

