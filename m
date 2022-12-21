Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D8C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Dec 2022 14:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiLUOUQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 09:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUOUP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 09:20:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C64186B7
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671632414; x=1703168414;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tdn3g4+Xmvz1V+xmIhb1tTmIXJ2QBpjTwd61PQHNSgU=;
  b=FrDRZmGN/v/qpOPx2f4ovXdNyaGoez+ry2O7A/zoQgYzZA8jQLmCElWm
   BcdsPXvY23MlmhW8gA3mcu7kPEnmmc3HnuIkhCteDSIJJoKfpZeyRM2tF
   a8+AdS7exkQif/1DJ3aIqThsn6AIuXlO8Umt6mVy5jO4pSVVAmKDPkkbp
   SSj/D0W4sqCuuLkOA3PPnccfbSkCpVdGYdYYlrfq7Z+s8A1WhxZOZGJFH
   +V6BxKe/LAGeXTbzrFJI/bil7tlp0wfPUVf9pMDgmGrZ+XmZLtq3W2hu4
   YKdFxyHT2KgEPFNGQpNPFimt/JbKyJNLKvZJGXOagPkfssjBfBRrGW6ZM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="321791010"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="321791010"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 06:20:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="601500389"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="601500389"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.206])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 06:20:09 -0800
Message-ID: <e5ea9e85-9d84-18e2-b6f4-0af14b00c5f0@intel.com>
Date:   Wed, 21 Dec 2022 16:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/3] mmc: let the host side can find card type during
 card init process
To:     haibo.chen@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, ulf.hansson@linaro.org
References: <20221221112853.789675-1-haibo.chen@nxp.com>
 <20221221112853.789675-3-haibo.chen@nxp.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221221112853.789675-3-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/12/22 13:28, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> During the card init, the host side sometimes may need to distinguish
> the card type to handle accordingly. So need to give host->card value
> earlier.

Did you consider making use of the ->init_card() host op?

> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/core/mmc.c  |  9 +++++----
>  drivers/mmc/core/sd.c   |  7 +++++--
>  drivers/mmc/core/sdio.c | 10 ++++++----
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89cd48fcec79..63de76a51be3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1658,6 +1658,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  			goto err;
>  		}
>  
> +		host->card = card;
> +
>  		card->ocr = ocr;
>  		card->type = MMC_TYPE_MMC;
>  		card->rca = 1;
> @@ -1926,14 +1928,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  		goto free_card;
>  	}
>  
> -	if (!oldcard)
> -		host->card = card;
> -
>  	return 0;
>  
>  free_card:
> -	if (!oldcard)
> +	if (!oldcard) {
>  		mmc_remove_card(card);
> +		host->card = NULL;
> +	}
>  err:
>  	return err;
>  }
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 72b664ed90cf..147b188b916e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1431,6 +1431,8 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  		if (IS_ERR(card))
>  			return PTR_ERR(card);
>  
> +		host->card = card;
> +
>  		card->ocr = ocr;
>  		card->type = MMC_TYPE_SD;
>  		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
> @@ -1563,12 +1565,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  		goto free_card;
>  	}
>  
> -	host->card = card;
>  	return 0;
>  
>  free_card:
> -	if (!oldcard)
> +	if (!oldcard) {
>  		mmc_remove_card(card);
> +		host->card = NULL;
> +	}
>  
>  	return err;
>  }
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index f64b9ac76a5c..5bcf4ada4738 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -699,6 +699,9 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>  	if (IS_ERR(card))
>  		return PTR_ERR(card);
>  
> +	if (!oldcard)
> +		host->card = card;
> +
>  	if ((rocr & R4_MEMORY_PRESENT) &&
>  	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
>  		card->type = MMC_TYPE_SD_COMBO;
> @@ -800,8 +803,6 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>  
>  		if (oldcard)
>  			mmc_remove_card(card);
> -		else
> -			host->card = card;
>  
>  		return 0;
>  	}
> @@ -898,14 +899,15 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>  		goto remove;
>  	}
>  
> -	host->card = card;
>  	return 0;
>  
>  mismatch:
>  	pr_debug("%s: Perhaps the card was replaced\n", mmc_hostname(host));
>  remove:
> -	if (oldcard != card)
> +	if (oldcard != card) {
>  		mmc_remove_card(card);
> +		host->card = NULL;
> +	}
>  	return err;
>  }
>  

