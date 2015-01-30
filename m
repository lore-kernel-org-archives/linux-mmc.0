From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: Resolve BKOPS compatability issue
Date: Fri, 30 Jan 2015 16:26:47 +0900
Message-ID: <54CB3237.2050207@samsung.com>
References: <1422521383-11436-1-git-send-email-alexey.skidanov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21592 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127AbbA3H0t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jan 2015 02:26:49 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NIZ00EEVBCNBTC0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 Jan 2015 16:26:47 +0900 (KST)
In-reply-to: <1422521383-11436-1-git-send-email-alexey.skidanov@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexey Skidanov <alexey.skidanov@sandisk.com>, chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: alex.lemberg@sandisk.com

Hi, Alexey.

On 01/29/2015 05:49 PM, Alexey Skidanov wrote:
> This patch is coming to fix compatibility issue of BKOPS_EN  field of EXT_CSD.
> In eMMC-5.1, BKOPS_EN was changed, and now it has two operational bits:
> Bit 0 - MANUAL_EN
> Bit 1 - AUTO_EN
> In previous eMMC revisions, only Bit 0 was supported.

If "manual enable" is the same functionality with previous enable,
I think it doesn't need to change the name..
Just checking whether enable or not with Mask bit?

If need to add the auto enable, only add the bkops_auto_en in future.
This is just my preference..and i don't read the spec since i don't have eMMC5.1 spec.

If manual-enable is difference with previous enable, how about using bkops-manual-en?

Best Regards,
Jaehoon Chung
> 
> Signed-off-by: Alexey Skidanov <alexey.skidanov@sandisk.com>
> ---
>  drivers/mmc/core/core.c  |    2 +-
>  drivers/mmc/core/mmc.c   |    8 +++++---
>  include/linux/mmc/card.h |    3 ++-
>  include/linux/mmc/mmc.h  |    5 +++++
>  4 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1be7055..0dc64e6 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -275,7 +275,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>  
>  	BUG_ON(!card);
>  
> -	if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card))
> +	if (!card->ext_csd.man_bkops_en || mmc_card_doing_bkops(card))
>  		return;
>  
>  	err = mmc_read_bkops_status(card);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1fc48a2..1d41e85 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -483,11 +483,13 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  		/* check whether the eMMC card supports BKOPS */
>  		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>  			card->ext_csd.bkops = 1;
> -			card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
> +			card->ext_csd.man_bkops_en =
> +					(ext_csd[EXT_CSD_BKOPS_EN] &
> +						EXT_CSD_MANUAL_BKOPS_MASK);
>  			card->ext_csd.raw_bkops_status =
>  				ext_csd[EXT_CSD_BKOPS_STATUS];
> -			if (!card->ext_csd.bkops_en)
> -				pr_info("%s: BKOPS_EN bit is not set\n",
> +			if (!card->ext_csd.man_bkops_en)
> +				pr_info("%s: MAN_BKOPS_EN bit is not set\n",
>  					mmc_hostname(card->host));
>  		}
>  
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4d69c00..17378cb 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -83,7 +83,8 @@ struct mmc_ext_csd {
>  	bool			hpi;			/* HPI support bit */
>  	unsigned int		hpi_cmd;		/* cmd used as HPI */
>  	bool			bkops;		/* background support bit */
> -	bool			bkops_en;	/* background enable bit */
> +	bool			man_bkops_en;	/* manual background
> +						enable bit */
>  	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
>  	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>  	unsigned int		boot_ro_lock;		/* ro lock support */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index fb97b5c..124f562 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -428,6 +428,11 @@ struct _mmc_csd {
>  #define EXT_CSD_BKOPS_LEVEL_2		0x2
>  
>  /*
> + * BKOPS modes
> + */
> +#define EXT_CSD_MANUAL_BKOPS_MASK	0x01
> +
> +/*
>   * MMC_SWITCH access modes
>   */
>  
> 

