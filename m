From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [RFC PATCH] mmc: core: HS DDR switch, don't change timing before
 checking status
Date: Fri, 10 Mar 2017 15:33:40 +0100
Message-ID: <c00eda9a-e655-f97a-4578-56a4dd9b9329@microchip.com>
References: <98664253-9a68-fa59-7f17-438b0d522fe8@microchip.com>
 <20170310142117.6060-1-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exsmtp02.microchip.com ([198.175.253.38]:44490 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938121AbdCJOd3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2017 09:33:29 -0500
In-Reply-To: <20170310142117.6060-1-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Ludovic Desroches <ludovic.desroches@microchip.com>

Le 10/03/2017 à 15:21, Ludovic Desroches a écrit :
> From: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> The commit e173f8911f09 mmc: core: Update CMD13 polling policy when
> switch to HS DDR mode in addition to fix the management of CRC error,
> changes the place where the DDR52 timing is set.
> 
> Before this commit, the sequence was:
> - set width to 8 with MMC_HS timing
> - send the switch command
> - check the status
> - set width to 8 with MMC_DDR52 timing
> - send the switch command
> - check the status
> Now:
> - set width to 8 with MMC_HS timing
> - send the switch command
> - set width to 8 with MMC_DDR52 timing
> - check the status
> 
> It may lead to get an error when checking the status with some devices.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

If RFC is positive and regression confirmed here
are the tags the shall be added:
Fixes: e173f8911f09 ("mmc: core: Update CMD13 polling policy when switch to HS DDR mode")
Cc: <stable@vger.kernel.org> # v4.10+

> ---
>  drivers/mmc/core/mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0fccca0..b837148 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1062,7 +1062,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>  			   EXT_CSD_BUS_WIDTH,
>  			   ext_csd_bits,
>  			   card->ext_csd.generic_cmd6_time,
> -			   MMC_TIMING_MMC_DDR52,
> +			   0,
>  			   true, true, true);
>  	if (err) {
>  		pr_err("%s: switch to bus width %d ddr failed\n",
> @@ -1106,6 +1106,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>  	if (err)
>  		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
>  
> +	if (!err)
> +		mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> +
>  	return err;
>  }
>  
> 


-- 
Nicolas Ferre
