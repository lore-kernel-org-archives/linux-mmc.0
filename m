From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: enable BKOPS for supported eMMC(4.41)
Date: Mon, 02 Sep 2013 15:24:49 +0900
Message-ID: <52242F31.4030103@samsung.com>
References: <loom.20130830T140917-496@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32728 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab3IBGYk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Sep 2013 02:24:40 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSH00BOCJ4G2GH0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 02 Sep 2013 15:24:33 +0900 (KST)
In-reply-to: <loom.20130830T140917-496@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi, Prasanna. 

Why do you use MMC_CAP2_BKOPS_EN?
Maybe we had discussed about this point. i know that we can enable the BKOPS with the mmc-util.
(Actually, This code had included into my first patch. but it's removed.)

Best Regards,
Jaehoon Chung

On 08/30/2013 09:09 PM, Prasanna NAVARATNA wrote:
>>From d596be94f87b86ccb372a4ae55ee478951524895 Mon Sep 17 00:00:00 2001
> From: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
> Date: Fri, 30 Aug 2013 17:18:32 +0530
> Subject: [PATCH] mmc: enable BKOPS for supported eMMC(4.41)
> 
> BKOPS feature is optional for eMMC 4.41. If an eMMC supports BKOPS
> and is of version 4.41 then BKOPS feature is ignored and not enabled.
> 
> Enable BKOPS for such eMMC. Also a capability is added to control
> the enabling of feature (only for eMMC 4.41, not valid for 4.5)
> 
> Signed-off-by: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
> ---
>  drivers/mmc/core/mmc.c   |   18 ++++++++++++++++++
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6d02012..fc44fd7 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1269,6 +1269,24 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	}
>  
>  	/*
> +	 * Enable BKOPS feature (if supported and not enabled)
> +	 */
> +	if (!card->ext_csd.bkops_en && (host->caps2 & MMC_CAP2_BKOPS_EN) &&
> +			(ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				EXT_CSD_BKOPS_EN, 1,
> +				card->ext_csd.generic_cmd6_time);
> +		if (err && err != -EBADMSG)
> +			goto free_card;
> +		if (err) {
> +			pr_warning("%s: Enabling BKOPS failed\n",
> +				   mmc_hostname(card->host));
> +			err = 0;
> +		} else
> +			card->ext_csd.bkops_en = 1;
> +	}
> +
> +	/*
>  	 * Enable HPI feature (if supported)
>  	 */
>  	if (card->ext_csd.hpi) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 3b0c33a..2c79487 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -281,6 +281,7 @@ struct mmc_host {
>  				 MMC_CAP2_PACKED_WR)
>  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
>  #define MMC_CAP2_SANITIZE	(1 << 15)		/* Support Sanitize */
> +#define MMC_CAP2_BKOPS_EN	(1 << 16)		/* Enable BKOPS */
>  
>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>  
> 

