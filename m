Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89CA48
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604793; cv=none; b=RjTvcwA2IStoscYMaakCA1cmJo4Z+wC5M+BKiF8VyaKzToxXpxIPSZ2favgt6/+LocGoCgjLLPP85S9y1ZALdNX56HloVN+AY991rcKscXp4x3Mq2OYFqSmfgwVkv335xkLjgVTudlQ9BZr6hCgpoTnp0jICUS7BiLVbAAjuPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604793; c=relaxed/simple;
	bh=DyMdFq7AUDs2MA2+Nuf1hwi2H3w1U9UsrFV/T33/BH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llYTH6gMbBmsHuGp6LrLYmQ+cZNxYeFBJetBE8veoGtLDGPUeAvqYcZrYrQCEjLNzzPNwyzg+5nU5HOYPhrYgeZ7/jBRev4l5ibZ9XD4LqeDqke/o2mq2U6+o2qYfvMcoj7BTD4v5Me1JanE5nP1g5YN7R43vp8DO9iMGbDf5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2ek6Gvw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2ek6Gvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725604792; x=1757140792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DyMdFq7AUDs2MA2+Nuf1hwi2H3w1U9UsrFV/T33/BH8=;
  b=H2ek6GvwVjYL5OqXutwAGmotQre2o1tEk4Ba3F6qUtpn2O6TrvqtJ9L0
   HI7U9fFL6Ok3kqQ/UDE4cV27nvn5KZ1rGnNrjRL2EWHjaWjXxVQ0eBUdm
   BX4fTKEGUCDxyiPaye75TBwS36532V2KWJ2XvEjx24uQsELPFs/LFM6hr
   rKk+Fjjz+luIVX4LaXCuXgyPIX7QUHyOAczsqURHT5ehN7OXQmBYLlUqK
   qKdkTblSsul5ohFOiOWTYeJfu6nSDVmu9wYE0tclJDZXFDCbQ5RSuZ5LE
   EmDgIUWOd1WVmaUCwbZIoD9lSLgZo7ySY2RfVV34rhhyAzyRyyiIJ3l6M
   g==;
X-CSE-ConnectionGUID: gU2+4Vi7SdaznDhbSyrPpQ==
X-CSE-MsgGUID: SoqFRCZgQCSeJYu71si9fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35502381"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="35502381"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 23:39:51 -0700
X-CSE-ConnectionGUID: cf+kfSsaRhOKBqXXAuVvHw==
X-CSE-MsgGUID: yvSXYKGmRDqYnEhEwSh6fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70794678"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 23:39:49 -0700
Message-ID: <d43f5407-fb88-437b-9f43-661de0245363@intel.com>
Date: Fri, 6 Sep 2024 09:39:44 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] mmc: sd: SDUC Support Recognition
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-2-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240904145256.3670679-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/09/24 17:52, Avri Altman wrote:
> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
> cards support capacity larger than 2TB and up to including 128TB.
> 
> ACMD41 was extended to support the host-card handshake during
> initialization.  The card expects that the HCS & HO2T bits to be set in
> the command argument, and sets the applicable bits in the R3 returned
> response.  On the contrary, if a SDUC card is inserted to a
> non-supporting host, it will never respond to this ACMD41 until
> eventually, the host will timed out and give up.
> 
> Also, add SD CSD version 3.0 - designated for SDUC, and properly parse
> the csd register as the c_size field got expanded to 28 bits.
> 
> Do not enable SDUC for now - leave it to the last patch in the series.
> 
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/bus.c   |  4 +++-
>  drivers/mmc/core/card.h  |  3 +++
>  drivers/mmc/core/sd.c    | 33 +++++++++++++++++++++------------
>  drivers/mmc/core/sd.h    |  2 +-
>  drivers/mmc/core/sdio.c  |  2 +-
>  include/linux/mmc/card.h |  2 +-
>  include/linux/mmc/sd.h   |  1 +
>  7 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 0ddaee0eae54..30763b342bd3 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -321,7 +321,9 @@ int mmc_add_card(struct mmc_card *card)
>  	case MMC_TYPE_SD:
>  		type = "SD";
>  		if (mmc_card_blockaddr(card)) {
> -			if (mmc_card_ext_capacity(card))
> +			if (mmc_card_ult_capacity(card))
> +				type = "SDUC";
> +			else if (mmc_card_ext_capacity(card))
>  				type = "SDXC";
>  			else
>  				type = "SDHC";
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index b7754a1b8d97..64dcb463a4f4 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -23,6 +23,7 @@
>  #define MMC_CARD_SDXC		(1<<3)		/* card is SDXC */
>  #define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
>  #define MMC_STATE_SUSPENDED	(1<<5)		/* card is suspended */
> +#define MMC_CARD_SDUC		(1<<6)		/* card is SDUC */
>  
>  #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
>  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
> @@ -30,11 +31,13 @@
>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>  #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
>  #define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
> +#define mmc_card_ult_capacity(c) ((c)->state & MMC_CARD_SDUC)
>  
>  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>  #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
> +#define mmc_card_set_ult_capacity(c) ((c)->state |= MMC_CARD_SDUC)
>  #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
>  #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
>  #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index ee37ad14e79e..eb9990d9db56 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -114,7 +114,7 @@ void mmc_decode_cid(struct mmc_card *card)
>  /*
>   * Given a 128-bit response, decode to our card CSD structure.
>   */
> -static int mmc_decode_csd(struct mmc_card *card)
> +static int mmc_decode_csd(struct mmc_card *card, bool is_sduc)
>  {
>  	struct mmc_csd *csd = &card->csd;
>  	unsigned int e, m, csd_struct;
> @@ -158,9 +158,10 @@ static int mmc_decode_csd(struct mmc_card *card)
>  			mmc_card_set_readonly(card);
>  		break;
>  	case 1:
> +	case 2:
>  		/*
> -		 * This is a block-addressed SDHC or SDXC card. Most
> -		 * interesting fields are unused and have fixed
> +		 * This is a block-addressed SDHC, SDXC or SDUC card.
> +		 * Most interesting fields are unused and have fixed
>  		 * values. To avoid getting tripped by buggy cards,
>  		 * we assume those fixed values ourselves.
>  		 */
> @@ -173,14 +174,19 @@ static int mmc_decode_csd(struct mmc_card *card)
>  		e = UNSTUFF_BITS(resp, 96, 3);
>  		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
>  		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
> -		csd->c_size	  = UNSTUFF_BITS(resp, 48, 22);
>  
> -		/* SDXC cards have a minimum C_SIZE of 0x00FFFF */
> -		if (csd->c_size >= 0xFFFF)
> +		if (csd_struct == 1)
> +			m = UNSTUFF_BITS(resp, 48, 22);
> +		else
> +			m = UNSTUFF_BITS(resp, 48, 28);
> +		csd->c_size = m;
> +
> +		if (csd->c_size >= 0x400000 && is_sduc)
> +			mmc_card_set_ult_capacity(card);
> +		else if (csd->c_size >= 0xFFFF)
>  			mmc_card_set_ext_capacity(card);
>  
> -		m = UNSTUFF_BITS(resp, 48, 22);
> -		csd->capacity     = (1 + m) << 10;
> +		csd->capacity     = (1 + (typeof(sector_t))m) << 10;
>  
>  		csd->read_blkbits = 9;
>  		csd->read_partial = 0;
> @@ -841,8 +847,11 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>  	 * block-addressed SDHC cards.
>  	 */
>  	err = mmc_send_if_cond(host, ocr);
> -	if (!err)
> +	if (!err) {
>  		ocr |= SD_OCR_CCS;
> +		/* Set HO2T as well - SDUC card won't respond otherwise */
> +		ocr |= SD_OCR_2T;

Wouldn't that be better to leave for the last patch.

> +	}
>  
>  	/*
>  	 * If the host supports one of UHS-I modes, request the card
> @@ -887,7 +896,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>  	return err;
>  }
>  
> -int mmc_sd_get_csd(struct mmc_card *card)
> +int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc)
>  {
>  	int err;
>  
> @@ -898,7 +907,7 @@ int mmc_sd_get_csd(struct mmc_card *card)
>  	if (err)
>  		return err;
>  
> -	err = mmc_decode_csd(card);
> +	err = mmc_decode_csd(card, is_sduc);
>  	if (err)
>  		return err;
>  
> @@ -1453,7 +1462,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  	}
>  
>  	if (!oldcard) {
> -		err = mmc_sd_get_csd(card);
> +		err = mmc_sd_get_csd(card, false);
>  		if (err)
>  			goto free_card;
>  

Also need to prevent Host Software Queue from enabling
for SDUC.  Something like:

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 8d77a49357aa..769cd8b9f49c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1578,7 +1578,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	if (host->cqe_ops && !host->cqe_enabled) {
+	if (!mmc_card_ult_capacity(card) && host->cqe_ops && !host->cqe_enabled) {
 		err = host->cqe_ops->cqe_enable(host, card);
 		if (!err) {
 			host->cqe_enabled = true;

Ideally try to get testing / feedback from HSQ users though.


> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> index fe6dd46927a4..7e8beface2ca 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -10,7 +10,7 @@ struct mmc_host;
>  struct mmc_card;
>  
>  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
> -int mmc_sd_get_csd(struct mmc_card *card);
> +int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc);
>  void mmc_decode_cid(struct mmc_card *card);
>  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>  	bool reinit);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 4fb247fde5c0..9566837c9848 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -769,7 +769,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>  	 * Read CSD, before selecting the card
>  	 */
>  	if (!oldcard && mmc_card_sd_combo(card)) {
> -		err = mmc_sd_get_csd(card);
> +		err = mmc_sd_get_csd(card, false);
>  		if (err)
>  			goto remove;
>  
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f34407cc2788..f39bce322365 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -35,7 +35,7 @@ struct mmc_csd {
>  	unsigned int		wp_grp_size;
>  	unsigned int		read_blkbits;
>  	unsigned int		write_blkbits;
> -	unsigned int		capacity;
> +	sector_t		capacity;
>  	unsigned int		read_partial:1,
>  				read_misalign:1,
>  				write_partial:1,
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 6727576a8755..865cc0ca8543 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -36,6 +36,7 @@
>  /* OCR bit definitions */
>  #define SD_OCR_S18R		(1 << 24)    /* 1.8V switching request */
>  #define SD_ROCR_S18A		SD_OCR_S18R  /* 1.8V switching accepted by card */
> +#define SD_OCR_2T		(1 << 27)    /* HO2T/CO2T - SDUC support */
>  #define SD_OCR_XPC		(1 << 28)    /* SDXC power control */
>  #define SD_OCR_CCS		(1 << 30)    /* Card Capacity Status */
>  

