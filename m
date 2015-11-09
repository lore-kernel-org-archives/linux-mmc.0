From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: set bus voltage before enabling bus power
Date: Mon, 9 Nov 2015 14:23:05 +0100
Message-ID: <20151109132305.GC15706@odux.rfo.atmel.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
 <1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:25098 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbKINXb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 08:23:31 -0500
Content-Disposition: inline
In-Reply-To: <1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pierre.samat@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

On Fri, Nov 06, 2015 at 04:59:29PM +0100, Ludovic Desroches wrote:
> When there is a vmmc regulator, only SD Bus Power is set to 1 in the
> Power Control Register. It means SD Bus Voltage Select field is set to 0
> that is a reserved value. The SD Host Controller specification says:
> 'SD Bus Power: Before setting this bit, the SD Host Driver shall set SD
> Bus Voltage Select.' and 'If the Host Driver selects an unsupported
> voltage in the SD B?us Voltage Select field, the Host Controller may
> ignore writes to SD Bus Power and keep its value at zero."
> 
> Having an external regulator means the SD Bus Voltage Select is useless
> but if the Host Controller strictly follows the specification then we
> need to set a valid value.

Ulf,

What is your opinion about this patch?

If the 'no regulator found' message is turned in debug message, I can get
rid of my vmmc regulator but I really think that writing only
SDHCI_POWER_ON is opposite to the sdhci spec. I would say that not
setting the bus voltage is a quirk!

Regards

Ludovic

> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mmc/host/sdhci.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac97b46..0cfd7b2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1278,13 +1278,6 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  		spin_unlock_irq(&host->lock);
>  		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  		spin_lock_irq(&host->lock);
> -
> -		if (mode != MMC_POWER_OFF)
> -			sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
> -		else
> -			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> -
> -		return;
>  	}
>  
>  	if (mode != MMC_POWER_OFF) {
> -- 
> 2.5.0
> 
