From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [RFC/RFT] MMC: CORE: eMMC in Sleep mode before suspend
Date: Thu, 14 Jul 2011 19:35:17 +0530
Message-ID: <000001cc422f$120d2810$36277830$@org>
References: <1310567787-14697-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:55079 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab1GNOFY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 10:05:24 -0400
In-Reply-To: <1310567787-14697-1-git-send-email-balajitk@ti.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Balaji T K' <balajitk@ti.com>, linux-mmc@vger.kernel.org

Balaji,

Tried this patch along with disabling the eMMC VCC supply in suspend and it
works !!! Without this patch, if I disabled the VCC supply then after resume
I/O errors are seen. This change also complies with eMMC spec so am ok with
this change.

Regards,
Subhash

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Balaji T K
> Sent: Wednesday, July 13, 2011 8:06 PM
> To: linux-mmc@vger.kernel.org
> Cc: Balaji T K
> Subject: [RFC/RFT] MMC: CORE: eMMC in Sleep mode before suspend
> 
> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
> in the mmc suspend to minimize power consumption.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/core/mmc.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index afabdc3..e8dfcde 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -900,16 +900,20 @@ static void mmc_detect(struct mmc_host *host)
>   */
>  static int mmc_suspend(struct mmc_host *host)
>  {
> +	int err = 0;
> +
>  	BUG_ON(!host);
>  	BUG_ON(!host->card);
> 
>  	mmc_claim_host(host);
> -	if (!mmc_host_is_spi(host))
> +	if (mmc_card_can_sleep(host))
> +		err = mmc_card_sleep(host);
> +	else if (!mmc_host_is_spi(host))
>  		mmc_deselect_cards(host);
>  	host->card->state &= ~MMC_STATE_HIGHSPEED;
>  	mmc_release_host(host);
> 
> -	return 0;
> +	return err;
>  }
> 
>  /*
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

