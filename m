From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: enable Enhance Strobe for HS400.
Date: Thu, 04 Jun 2015 20:44:54 +0900
Message-ID: <55703A36.2080309@samsung.com>
References: <1433412938-1761-1-git-send-email-yi.y.sun@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59053 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbFDLo4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 07:44:56 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NPF006RV4MU8DA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 04 Jun 2015 20:44:54 +0900 (KST)
In-reply-to: <1433412938-1761-1-git-send-email-yi.y.sun@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yi Sun <yi.y.sun@intel.com>, linux-mmc@vger.kernel.org

Hi,

On 06/04/2015 07:15 PM, Yi Sun wrote:
> Enhance Strobe is defined in v5.1 eMMC spec. This commit
> is to implement it.

I know what enhance strobe is.
I think good that there is more information for enhance strobe into commit message.

> 
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> ---
>  drivers/mmc/core/mmc.c   |   61 ++++++++++++++++++++++++++++++++++++++++++----
>  include/linux/mmc/card.h |    1 +
>  include/linux/mmc/mmc.h  |    2 ++
>  3 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e519e31..c9ef2de 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -585,6 +585,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  		card->ext_csd.ffu_capable =
>  			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
>  			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
> +
> +		/* Enhance Strobe is supported since v5.1 which rev should be
> +		 * 8 but some eMMC devices can support it with rev 7. So handle
> +		 * Enhance Strobe here.
> +		 */

Fix the comment style.

> +		card->ext_csd.strobe_support = ext_csd[EXT_CSD_STROBE_SUPPORT];
>  	}
>  out:
>  	return err;
> @@ -1049,9 +1055,28 @@ static int mmc_select_hs400(struct mmc_card *card)
>  	/*
>  	 * HS400 mode requires 8-bit bus width
>  	 */
> -	if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> -	      host->ios.bus_width == MMC_BUS_WIDTH_8))
> -		return 0;

Why do you remove these? Can be remained?

> +	if (card->ext_csd.strobe_support) {
> +		if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> +		    host->caps & MMC_CAP_8_BIT_DATA))
> +			return 0;

What's difference between (host->ios.bus_width == MMC_BUS_WIDTH_8) and (host->caps & MMC_CAP_8_BIT_DATA)?

> +
> +		/* For Enhance Strobe flow. For non Enhance Strobe, signal
> +		 * voltage will not be set.
> +		 */
> +		if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
> +			err = __mmc_set_signal_voltage(host,
> +					MMC_SIGNAL_VOLTAGE_120);
> +
> +		if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
> +			err = __mmc_set_signal_voltage(host,
> +					MMC_SIGNAL_VOLTAGE_180);
> +		if (err)
> +			return err;

Doesn't need to return here?

> +	} else {
> +		if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> +		    host->ios.bus_width == MMC_BUS_WIDTH_8))
> +			return 0;
> +	}
>  
>  	/*
>  	 * Before switching to dual data rate operation for HS400,
> @@ -1072,15 +1097,36 @@ static int mmc_select_hs400(struct mmc_card *card)
>  		return err;
>  	}
>  
> +	val = EXT_CSD_DDR_BUS_WIDTH_8;
> +	if (card->ext_csd.strobe_support)
> +		val |= EXT_CSD_BUS_WIDTH_STROBE;
>  	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  			 EXT_CSD_BUS_WIDTH,
> -			 EXT_CSD_DDR_BUS_WIDTH_8,
> +			 val,
>  			 card->ext_csd.generic_cmd6_time);
>  	if (err) {
>  		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
>  			mmc_hostname(host), err);
>  		return err;
>  	}
> +	if (card->ext_csd.strobe_support) {
> +		mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
> +		/*
> +		 * If controller can't handle bus width test,
> +		 * compare ext_csd previously read in 1 bit mode
> +		 * against ext_csd at new bus width
> +		 */
> +		if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
> +			err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
> +		else
> +			err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
> +
> +		if (err) {
> +			pr_warn("%s: switch to bus width %d failed\n",
> +				mmc_hostname(host), MMC_BUS_WIDTH_8);
> +			return err;
> +		}
> +	}
>  
>  	val = EXT_CSD_TIMING_HS400 |
>  	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
> @@ -1263,7 +1309,12 @@ static int mmc_select_timing(struct mmc_card *card)
>  	if (!mmc_can_ext_csd(card))
>  		goto bus_speed;
>  
> -	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
> +	/* For Enhance Strobe HS400 flow */
> +	if (card->ext_csd.strobe_support &&
> +	    card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> +	    card->host->caps & MMC_CAP_8_BIT_DATA)

Could you modify more readable?

> +		err = mmc_select_hs400(card);
> +	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>  		err = mmc_select_hs200(card);
>  	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>  		err = mmc_select_hs(card);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4d3776d..b793b61 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -95,6 +95,7 @@ struct mmc_ext_csd {
>  	u8			raw_partition_support;	/* 160 */
>  	u8			raw_rpmb_size_mult;	/* 168 */
>  	u8			raw_erased_mem_count;	/* 181 */
> +	u8			strobe_support;		/* 184 */
>  	u8			raw_ext_csd_structure;	/* 194 */
>  	u8			raw_card_type;		/* 196 */
>  	u8			raw_driver_strength;	/* 197 */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 15f2c4a..a1bb32c 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -297,6 +297,7 @@ struct _mmc_csd {
>  #define EXT_CSD_PART_CONFIG		179	/* R/W */
>  #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
>  #define EXT_CSD_BUS_WIDTH		183	/* R/W */
> +#define EXT_CSD_STROBE_SUPPORT		184	/* RO */
>  #define EXT_CSD_HS_TIMING		185	/* R/W */
>  #define EXT_CSD_POWER_CLASS		187	/* R/W */
>  #define EXT_CSD_REV			192	/* RO */
> @@ -386,6 +387,7 @@ struct _mmc_csd {
>  #define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
>  #define EXT_CSD_DDR_BUS_WIDTH_4	5	/* Card is in 4 bit DDR mode */
>  #define EXT_CSD_DDR_BUS_WIDTH_8	6	/* Card is in 8 bit DDR mode */
> +#define EXT_CSD_BUS_WIDTH_STROBE	0x80	/* Card is in 8 bit DDR mode */

Is Comment right? it's enhanced strobe bit.

Best Regards,
Jaehoon Chung

>  
>  #define EXT_CSD_TIMING_BC	0	/* Backwards compatility */
>  #define EXT_CSD_TIMING_HS	1	/* High speed */
> 

