From: <subhashj@codeaurora.org>
Subject: RE: [PATCH v2 08/12] mmc: sd: report correct speed and capacity of uhs cards
Date: Thu, 10 Mar 2011 17:18:21 +0530
Message-ID: <001801cbdf19$10c9d3f0$325d7bd0$@org>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com> <1299238369-1768-9-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:16537 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab1CJLs0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 06:48:26 -0500
In-Reply-To: <1299238369-1768-9-git-send-email-arindam.nath@amd.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Arindam Nath' <arindam.nath@amd.com>, cjb@laptop.org
Cc: zhangfei.gao@gmail.com, prakity@marvell.com, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Arindam Nath
> Sent: Friday, March 04, 2011 5:03 PM
> To: cjb@laptop.org
> Cc: zhangfei.gao@gmail.com; prakity@marvell.com;
> subhashj@codeaurora.org; linux-mmc@vger.kernel.org; henry.su@amd.com;
> aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
> Subject: [PATCH v2 08/12] mmc: sd: report correct speed and capacity of
> uhs cards
> 
> Since only UHS-I cards respond with S18A set in response to ACMD41,
> we set the card as ultra-high-speed after successfull initialization.
> We can have SDHC or SDXC UHS-I cards, so we need to decide based on
> C_SIZE field of CSDv2.0 register. According to Physical Layer spec
> v3.01, the minimum value of C_SIZE for SDXC card is 00FFFFh.
> 
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> ---
>  drivers/mmc/core/bus.c   |   11 ++++++++---
>  drivers/mmc/core/sd.c    |   10 +++++++++-
>  include/linux/mmc/card.h |    7 +++++++
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 63667a8..ceeefa4 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -274,8 +274,12 @@ int mmc_add_card(struct mmc_card *card)
>  		break;
>  	case MMC_TYPE_SD:
>  		type = "SD";
> -		if (mmc_card_blockaddr(card))
> -			type = "SDHC";
> +		if (mmc_card_blockaddr(card)) {
> +			if (mmc_card_ext_capacity(card))
> +				type = "SDXC";
> +			else
> +				type = "SDHC";
> +		}
>  		break;
>  	case MMC_TYPE_SDIO:
>  		type = "SDIO";
> @@ -298,7 +302,8 @@ int mmc_add_card(struct mmc_card *card)
>  	} else {
>  		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
>  			mmc_hostname(card->host),
> -			mmc_card_highspeed(card) ? "high speed " : "",
> +			mmc_card_ultrahighspeed(card) ? "ultra high speed "
:

we should use "sd" prefix before ultrahighspeed. Also can't we use name as
ush instead of ultrahighspeed? What about mmc_card_sd_ush().
Also with the USH, SD card's DDR50 mode also falls under UHS mode. And we
have DDR mode for MMC card as well (mmc_card_ddr_mode()). 
 
> +			(mmc_card_highspeed(card) ? "high speed " : ""),
>  			mmc_card_ddr_mode(card) ? "DDR " : "",
>  			type, card->rca);
>  	}
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index df98a2c..be01397 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -129,7 +129,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>  		break;
>  	case 1:
>  		/*
> -		 * This is a block-addressed SDHC card. Most
> +		 * This is a block-addressed SDHC or SDXC card. Most
>  		 * interesting fields are unused and have fixed
>  		 * values. To avoid getting tripped by buggy cards,
>  		 * we assume those fixed values ourselves.
> @@ -143,6 +143,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>  		e = UNSTUFF_BITS(resp, 96, 3);
>  		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
>  		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
> +		csd->c_size	  = UNSTUFF_BITS(resp, 48, 22);
> 
>  		m = UNSTUFF_BITS(resp, 48, 22);
>  		csd->capacity     = (1 + m) << 10;
> @@ -922,6 +923,13 @@ static int mmc_sd_init_card(struct mmc_host *host,
> u32 ocr,
>  		err = mmc_sd_init_uhs_card(card);
>  		if (err)
>  			goto free_card;
> +
> +		/* Card is an ultra-high-speed card */
> +		mmc_card_set_ultrahighspeed(card);
> +
> +		/* SDXC cards have a minimum C_SIZE of 0x00FFFF */
> +		if (card->csd.c_size >= 0xFFFF)
> +			mmc_card_set_ext_capacity(card);
>  	} else {
>  		/*
>  		 * Attempt to change to high-speed (if supported)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index a6811ae..61459aa 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -29,6 +29,7 @@ struct mmc_csd {
>  	unsigned short		cmdclass;
>  	unsigned short		tacc_clks;
>  	unsigned int		tacc_ns;
> +	unsigned int		c_size;
>  	unsigned int		r2w_factor;
>  	unsigned int		max_dtr;
>  	unsigned int		erase_size;		/* In sectors */
> @@ -151,6 +152,8 @@ struct mmc_card {
>  #define MMC_STATE_HIGHSPEED	(1<<2)		/* card is in high
> speed mode */
>  #define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-
> addressing */
>  #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high
> speed mode */
> +#define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra
> high speed mode */
> +#define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
>  	unsigned int		quirks; 	/* card quirks */
>  #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0
> writes outside of the VS CCCR range */
>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func-
> >cur_blksize */
> @@ -193,12 +196,16 @@ struct mmc_card {
>  #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
>  #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
>  #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
> +#define mmc_card_ultrahighspeed(c) ((c)->state &
> MMC_STATE_ULTRAHIGHSPEED)
> +#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
> 
>  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>  #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
>  #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
>  #define mmc_card_set_ddr_mode(c) ((c)->state |=
> MMC_STATE_HIGHSPEED_DDR)
> +#define mmc_card_set_ultrahighspeed(c) ((c)->state |=
> MMC_STATE_ULTRAHIGHSPEED)
> +#define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
> 
>  static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
>  {
> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

