From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v2 1/2] mmc: core: fix the decision of mmc card-type
Date: Wed, 25 Apr 2012 15:18:55 +0530
Message-ID: <000401cd22c8$a3da78e0$eb8f6aa0$@codeaurora.org>
References: <004b01cd22b3$7e08f8e0$7a1aeaa0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:29527 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167Ab2DYJtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Apr 2012 05:49:02 -0400
In-Reply-To: <004b01cd22b3$7e08f8e0$7a1aeaa0$%jun@samsung.com>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Seungwon Jeon' <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

Looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

Regards,
Subhash

> -----Original Message-----
> From: Seungwon Jeon [mailto:tgih.jun@samsung.com]
> Sent: Wednesday, April 25, 2012 12:48 PM
> To: linux-mmc@vger.kernel.org
> Cc: 'Chris Ball'; 'Subhash Jadavani'; 'Girish K S'
> Subject: [PATCH v2 1/2] mmc: core: fix the decision of mmc card-type
> 
> Current implementation decides the card type exclusively. Even though eMMC
> device can support both HS200 and DDR mode, card type will be set only for
> HS200. If the host doesn't support HS200 but has DDR capability, then DDR
> mode can't be selected.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/mmc.c   |   81 ++++++++++++++++++----------------------------
>  include/linux/mmc/card.h |    4 ++
>  include/linux/mmc/mmc.h  |   60 ----------------------------------
>  3 files changed, 36 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> 54df5ad..0477769 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -235,6 +235,36 @@ static int mmc_get_ext_csd(struct mmc_card *card,
> u8 **new_ext_csd)
>  	return err;
>  }
> 
> +static void mmc_select_card_type(struct mmc_card *card) {
> +	struct mmc_host *host = card->host;
> +	u8 card_type = card->ext_csd.raw_card_type &
> EXT_CSD_CARD_TYPE_MASK;
> +	unsigned int caps = host->caps, caps2 = host->caps2;
> +	unsigned int hs_max_dtr = 0;
> +
> +	if (card_type & EXT_CSD_CARD_TYPE_26)
> +		hs_max_dtr = MMC_HIGH_26_MAX_DTR;
> +
> +	if (caps & MMC_CAP_MMC_HIGHSPEED &&
> +			card_type & EXT_CSD_CARD_TYPE_52)
> +		hs_max_dtr = MMC_HIGH_52_MAX_DTR;
> +
> +	if ((caps & MMC_CAP_1_8V_DDR &&
> +			card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) ||
> +	    (caps & MMC_CAP_1_2V_DDR &&
> +			card_type & EXT_CSD_CARD_TYPE_DDR_1_2V))
> +		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
> +
> +	if ((caps2 & MMC_CAP2_HS200_1_8V_SDR &&
> +			card_type & EXT_CSD_CARD_TYPE_SDR_1_8V) ||
> +	    (caps2 & MMC_CAP2_HS200_1_2V_SDR &&
> +			card_type & EXT_CSD_CARD_TYPE_SDR_1_2V))
> +		hs_max_dtr = MMC_HS200_MAX_DTR;
> +
> +	card->ext_csd.hs_max_dtr = hs_max_dtr;
> +	card->ext_csd.card_type = card_type;
> +}
> +
>  /*
>   * Decode extended CSD.
>   */
> @@ -284,56 +314,9 @@ static int mmc_read_ext_csd(struct mmc_card *card,
> u8 *ext_csd)
>  		if (card->ext_csd.sectors > (2u * 1024 * 1024 * 1024) / 512)
>  			mmc_card_set_blockaddr(card);
>  	}
> +
>  	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
> -	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK)
> {
> -	case EXT_CSD_CARD_TYPE_SDR_ALL:
> -	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V:
> -	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V:
> -	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52:
> -		card->ext_csd.hs_max_dtr = 200000000;
> -		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_200;
> -		break;
> -	case EXT_CSD_CARD_TYPE_SDR_1_2V_ALL:
> -	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V:
> -	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V:
> -	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52:
> -		card->ext_csd.hs_max_dtr = 200000000;
> -		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_2V;
> -		break;
> -	case EXT_CSD_CARD_TYPE_SDR_1_8V_ALL:
> -	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V:
> -	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V:
> -	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52:
> -		card->ext_csd.hs_max_dtr = 200000000;
> -		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_8V;
> -		break;
> -	case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
> -	     EXT_CSD_CARD_TYPE_26:
> -		card->ext_csd.hs_max_dtr = 52000000;
> -		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_DDR_52;
> -		break;
> -	case EXT_CSD_CARD_TYPE_DDR_1_2V | EXT_CSD_CARD_TYPE_52 |
> -	     EXT_CSD_CARD_TYPE_26:
> -		card->ext_csd.hs_max_dtr = 52000000;
> -		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_DDR_1_2V;
> -		break;
> -	case EXT_CSD_CARD_TYPE_DDR_1_8V | EXT_CSD_CARD_TYPE_52 |
> -	     EXT_CSD_CARD_TYPE_26:
> -		card->ext_csd.hs_max_dtr = 52000000;
> -		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_DDR_1_8V;
> -		break;
> -	case EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> -		card->ext_csd.hs_max_dtr = 52000000;
> -		break;
> -	case EXT_CSD_CARD_TYPE_26:
> -		card->ext_csd.hs_max_dtr = 26000000;
> -		break;
> -	default:
> -		/* MMC v4 spec says this cannot happen */
> -		pr_warning("%s: card is mmc v4 but doesn't "
> -			"support any high-speed modes.\n",
> -			mmc_hostname(card->host));
> -	}
> +	mmc_select_card_type(card);
> 
>  	card->ext_csd.raw_s_a_timeout = ext_csd[EXT_CSD_S_A_TIMEOUT];
>  	card->ext_csd.raw_erase_timeout_mult = diff --git
> a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> 629b823..d76513b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -58,6 +58,10 @@ struct mmc_ext_csd {
>  	unsigned int		generic_cmd6_time;	/* Units: 10ms */
>  	unsigned int            power_off_longtime;     /* Units: ms */
>  	unsigned int		hs_max_dtr;
> +#define MMC_HIGH_26_MAX_DTR	26000000
> +#define MMC_HIGH_52_MAX_DTR	52000000
> +#define MMC_HIGH_DDR_MAX_DTR	52000000
> +#define MMC_HS200_MAX_DTR	200000000
>  	unsigned int		sectors;
>  	unsigned int		card_type;
>  	unsigned int		hc_erase_size;		/* In sectors */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index
> b822a2c..d425cab 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -354,66 +354,6 @@ struct _mmc_csd {
>  #define EXT_CSD_CARD_TYPE_SDR_1_2V	(1<<5)	/* Card can run at
> 200MHz */
>  						/* SDR mode @1.2V I/O */
> 
> -#define EXT_CSD_CARD_TYPE_SDR_200
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V | \
> -					 EXT_CSD_CARD_TYPE_SDR_1_2V)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_ALL
> 	(EXT_CSD_CARD_TYPE_SDR_200 | \
> -					 EXT_CSD_CARD_TYPE_52 | \
> -					 EXT_CSD_CARD_TYPE_26)
> -
> -#define	EXT_CSD_CARD_TYPE_SDR_1_2V_ALL
> 	(EXT_CSD_CARD_TYPE_SDR_1_2V | \
> -					 EXT_CSD_CARD_TYPE_52 | \
> -					 EXT_CSD_CARD_TYPE_26)
> -
> -#define	EXT_CSD_CARD_TYPE_SDR_1_8V_ALL
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V | \
> -					 EXT_CSD_CARD_TYPE_52 | \
> -					 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V
> 	(EXT_CSD_CARD_TYPE_SDR_1_2V | \
> -
> EXT_CSD_CARD_TYPE_DDR_1_8V | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V | \
> -
> EXT_CSD_CARD_TYPE_DDR_1_8V | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V
> 	(EXT_CSD_CARD_TYPE_SDR_1_2V | \
> -
> EXT_CSD_CARD_TYPE_DDR_1_2V | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V | \
> -
> EXT_CSD_CARD_TYPE_DDR_1_2V | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52
> 	(EXT_CSD_CARD_TYPE_SDR_1_2V | \
> -
> EXT_CSD_CARD_TYPE_DDR_52 | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V | \
> -
> EXT_CSD_CARD_TYPE_DDR_52 | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V
> 	(EXT_CSD_CARD_TYPE_SDR_200 | \
> -
> EXT_CSD_CARD_TYPE_DDR_1_8V | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V
> 	(EXT_CSD_CARD_TYPE_SDR_200 | \
> -
> EXT_CSD_CARD_TYPE_DDR_1_2V | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
> -#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52
> 	(EXT_CSD_CARD_TYPE_SDR_200 | \
> -
> EXT_CSD_CARD_TYPE_DDR_52 | \
> -						 EXT_CSD_CARD_TYPE_52 | \
> -						 EXT_CSD_CARD_TYPE_26)
> -
>  #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
>  #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
>  #define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
> --
> 1.7.0.4
> 


