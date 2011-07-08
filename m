From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V2] mmc: Bus width testing needs to handle suspend/resume
Date: Fri, 08 Jul 2011 10:18:37 +0900
Message-ID: <4E165AED.6090805@samsung.com>
References: <0281C9EE-5CAE-41B7-9A8D-4BE2F125EF2F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49137 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab1GHBSx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 21:18:53 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LNZ002EPQB2S0I0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 08 Jul 2011 10:18:41 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LNZ00LC3QB5J3@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 08 Jul 2011 10:18:41 +0900 (KST)
In-reply-to: <0281C9EE-5CAE-41B7-9A8D-4BE2F125EF2F@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Philip.

It's working well on my board.

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Best regards,
Jaehoon Chung

Philip Rakity wrote:
> V2
> ==
> Save the ext_csd information needed for bus width
> compare when we read the ext_csd the first time (in 1 bit mode).
> 
> On every pass we make re-reading the ext_csd compare
> the data against the saved ext_csd data.
> 
> note: unsubmitted diff (with printks) tested by
> Jaehoon Chung  <jh80.chung@samsung.com>
> 
> V1
> ==
> We need to read the ext_csd when doing bus width testing for
> old cards to ensure test is run correctly.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/core/mmc.c   |   75 ++++++++++++++++++++++++++++++----------------
>  include/linux/mmc/card.h |   13 ++++++++
>  2 files changed, 62 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 2a7e43b..afabdc3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -247,12 +247,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  		return 0;
>  
>  	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
> +	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
>  	if (card->csd.structure == 3) {
> -		int ext_csd_struct = ext_csd[EXT_CSD_STRUCTURE];
> -		if (ext_csd_struct > 2) {
> +		if (card->ext_csd.raw_ext_csd_structure > 2) {
>  			printk(KERN_ERR "%s: unrecognised EXT_CSD structure "
>  				"version %d\n", mmc_hostname(card->host),
> -					ext_csd_struct);
> +					card->ext_csd.raw_ext_csd_structure);
>  			err = -EINVAL;
>  			goto out;
>  		}
> @@ -266,6 +266,10 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  		goto out;
>  	}
>  
> +	card->ext_csd.raw_sectors[0] = ext_csd[EXT_CSD_SEC_CNT + 0];
> +	card->ext_csd.raw_sectors[1] = ext_csd[EXT_CSD_SEC_CNT + 1];
> +	card->ext_csd.raw_sectors[2] = ext_csd[EXT_CSD_SEC_CNT + 2];
> +	card->ext_csd.raw_sectors[3] = ext_csd[EXT_CSD_SEC_CNT + 3];
>  	if (card->ext_csd.rev >= 2) {
>  		card->ext_csd.sectors =
>  			ext_csd[EXT_CSD_SEC_CNT + 0] << 0 |
> @@ -277,7 +281,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  		if (card->ext_csd.sectors > (2u * 1024 * 1024 * 1024) / 512)
>  			mmc_card_set_blockaddr(card);
>  	}
> -
> +	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
>  	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
>  	case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
>  	     EXT_CSD_CARD_TYPE_26:
> @@ -307,6 +311,11 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  			mmc_hostname(card->host));
>  	}
>  
> +	card->ext_csd.raw_s_a_timeout = ext_csd[EXT_CSD_S_A_TIMEOUT];
> +	card->ext_csd.raw_erase_timeout_mult =
> +		ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
> +	card->ext_csd.raw_hc_erase_grp_size =
> +		ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
>  	if (card->ext_csd.rev >= 3) {
>  		u8 sa_shift = ext_csd[EXT_CSD_S_A_TIMEOUT];
>  		card->ext_csd.part_config = ext_csd[EXT_CSD_PART_CONFIG];
> @@ -334,6 +343,16 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  		card->ext_csd.boot_size = ext_csd[EXT_CSD_BOOT_MULT] << 17;
>  	}
>  
> +	card->ext_csd.raw_hc_erase_gap_size =
> +		ext_csd[EXT_CSD_PARTITION_ATTRIBUTE];
> +	card->ext_csd.raw_sec_trim_mult =
> +			ext_csd[EXT_CSD_SEC_TRIM_MULT];
> +	card->ext_csd.raw_sec_erase_mult =
> +			ext_csd[EXT_CSD_SEC_ERASE_MULT];
> +	card->ext_csd.raw_sec_feature_support =
> +			ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT];
> +	card->ext_csd.raw_trim_mult =
> +			ext_csd[EXT_CSD_TRIM_MULT];
>  	if (card->ext_csd.rev >= 4) {
>  		/*
>  		 * Enhanced area feature support -- check whether the eMMC
> @@ -401,17 +420,17 @@ static inline void mmc_free_ext_csd(u8 *ext_csd)
>  }
>  
>  
> -static int mmc_compare_ext_csds(struct mmc_card *card, u8 *ext_csd,
> -			unsigned bus_width)
> +static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
>  {
>  	u8 *bw_ext_csd;
>  	int err;
>  
> +	if (bus_width == MMC_BUS_WIDTH_1)
> +		return 0;
> +
>  	err = mmc_get_ext_csd(card, &bw_ext_csd);
> -	if (err)
> -		return err;
>  
> -	if ((ext_csd == NULL || bw_ext_csd == NULL)) {
> +	if (err || bw_ext_csd == NULL) {
>  		if (bus_width != MMC_BUS_WIDTH_1)
>  			err = -EINVAL;
>  		goto out;
> @@ -421,35 +440,40 @@ static int mmc_compare_ext_csds(struct mmc_card *card, u8 *ext_csd,
>  		goto out;
>  
>  	/* only compare read only fields */
> -	err = (!(ext_csd[EXT_CSD_PARTITION_SUPPORT] ==
> +	err = (!(card->ext_csd.raw_partition_support ==
>  			bw_ext_csd[EXT_CSD_PARTITION_SUPPORT]) &&
> -		(ext_csd[EXT_CSD_ERASED_MEM_CONT] ==
> +		(card->ext_csd.raw_erased_mem_count ==
>  			bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&
> -		(ext_csd[EXT_CSD_REV] ==
> +		(card->ext_csd.rev ==
>  			bw_ext_csd[EXT_CSD_REV]) &&
> -		(ext_csd[EXT_CSD_STRUCTURE] ==
> +		(card->ext_csd.raw_ext_csd_structure ==
>  			bw_ext_csd[EXT_CSD_STRUCTURE]) &&
> -		(ext_csd[EXT_CSD_CARD_TYPE] ==
> +		(card->ext_csd.raw_card_type ==
>  			bw_ext_csd[EXT_CSD_CARD_TYPE]) &&
> -		(ext_csd[EXT_CSD_S_A_TIMEOUT] ==
> +		(card->ext_csd.raw_s_a_timeout ==
>  			bw_ext_csd[EXT_CSD_S_A_TIMEOUT]) &&
> -		(ext_csd[EXT_CSD_HC_WP_GRP_SIZE] ==
> +		(card->ext_csd.raw_hc_erase_gap_size ==
>  			bw_ext_csd[EXT_CSD_HC_WP_GRP_SIZE]) &&
> -		(ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] ==
> +		(card->ext_csd.raw_erase_timeout_mult ==
>  			bw_ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT]) &&
> -		(ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] ==
> +		(card->ext_csd.raw_hc_erase_grp_size ==
>  			bw_ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE]) &&
> -		(ext_csd[EXT_CSD_SEC_TRIM_MULT] ==
> +		(card->ext_csd.raw_sec_trim_mult ==
>  			bw_ext_csd[EXT_CSD_SEC_TRIM_MULT]) &&
> -		(ext_csd[EXT_CSD_SEC_ERASE_MULT] ==
> +		(card->ext_csd.raw_sec_erase_mult ==
>  			bw_ext_csd[EXT_CSD_SEC_ERASE_MULT]) &&
> -		(ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] ==
> +		(card->ext_csd.raw_sec_feature_support ==
>  			bw_ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) &&
> -		(ext_csd[EXT_CSD_TRIM_MULT] ==
> +		(card->ext_csd.raw_trim_mult ==
>  			bw_ext_csd[EXT_CSD_TRIM_MULT]) &&
> -		memcmp(&ext_csd[EXT_CSD_SEC_CNT],
> -		       &bw_ext_csd[EXT_CSD_SEC_CNT],
> -		       4) != 0);
> +		(card->ext_csd.raw_sectors[0] ==
> +			bw_ext_csd[EXT_CSD_SEC_CNT + 0]) &&
> +		(card->ext_csd.raw_sectors[1] ==
> +			bw_ext_csd[EXT_CSD_SEC_CNT + 1]) &&
> +		(card->ext_csd.raw_sectors[2] ==
> +			bw_ext_csd[EXT_CSD_SEC_CNT + 2]) &&
> +		(card->ext_csd.raw_sectors[3] ==
> +			bw_ext_csd[EXT_CSD_SEC_CNT + 3]));
>  	if (err)
>  		err = -EINVAL;
>  
> @@ -770,7 +794,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  				 */
>  				if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
>  					err = mmc_compare_ext_csds(card,
> -						ext_csd,
>  						bus_width);
>  				else
>  					err = mmc_bus_test(card, bus_width);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 7b4fd7b..b460fc2 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -64,6 +64,19 @@ struct mmc_ext_csd {
>  	unsigned long long	enhanced_area_offset;	/* Units: Byte */
>  	unsigned int		enhanced_area_size;	/* Units: KB */
>  	unsigned int		boot_size;		/* in bytes */
> +	u8			raw_partition_support;	/* 160 */
> +	u8			raw_erased_mem_count;	/* 181 */
> +	u8			raw_ext_csd_structure;	/* 194 */
> +	u8			raw_card_type;		/* 196 */
> +	u8			raw_s_a_timeout;		/* 217 */
> +	u8			raw_hc_erase_gap_size;	/* 221 */
> +	u8			raw_erase_timeout_mult;	/* 223 */
> +	u8			raw_hc_erase_grp_size;	/* 224 */
> +	u8			raw_sec_trim_mult;	/* 229 */
> +	u8			raw_sec_erase_mult;	/* 230 */
> +	u8			raw_sec_feature_support;/* 231 */
> +	u8			raw_trim_mult;		/* 232 */
> +	u8			raw_sectors[4];		/* 212 - 4 bytes */
>  };
>  
>  struct sd_scr {

