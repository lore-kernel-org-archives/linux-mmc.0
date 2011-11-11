From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Fix setting power notify state variable for
 non eMMC
Date: Fri, 11 Nov 2011 14:32:44 +0100
Message-ID: <4EBD23FC.3070203@stericsson.com>
References: <1320403967-2940-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:37034 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757487Ab1KKNdC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 08:33:02 -0500
In-Reply-To: <1320403967-2940-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "patches@linaro.org" <patches@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Girish K S wrote:
> This patch skips the setting of the power notify state variable
> for non eMMC 4.5 devices. Also fixes the problem of omap_hsmmc
> noisy/broken for suspend resume reported by kevin Hilman.
> 
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
>  drivers/mmc/core/mmc.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3627044..4db73a9 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -882,10 +882,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  				 card->ext_csd.generic_cmd6_time);
>  		if (err && err != -EBADMSG)
>  			goto free_card;
> -	}
>  
> -	if (!err)
> -		card->poweroff_notify_state = MMC_POWERED_ON;
> +		/*
> +		 * The err can be -EBADMSG or 0,
> +		 * so check for success and update the flag
> +		 */
> +		if (!err)
> +			card->poweroff_notify_state = MMC_POWERED_ON;
> +	}
>  
>  	/*
>  	 * Activate high speed (if supported)


I encountered similar problems as for omap_hsmmc for the mmci driver 
(although with some ST-Ericsson internal pm_runtime patches). This patch 
fixed the problem. Great!

Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>

