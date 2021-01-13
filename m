Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FDFC433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 10:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C97233FB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 10:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbhAMKnz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:43:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:12551 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbhAMKnz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 13 Jan 2021 05:43:55 -0500
IronPort-SDR: sy+I4wRJcXMrkkOL1Z1nLkNt1rHoyfO0bLPCTTJsEqDJTyh00sThydvZmWUre3GrYo2pA87pvO
 i5ZOuI2OeyvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="262971533"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="262971533"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 02:43:13 -0800
IronPort-SDR: jS2HDWtL1g9o7vtiLgwRfhL8xflugn1a/DNEvVhhGDDITmBtMM/6y1ZP3RYgZOAixhzTiJ3JKy
 khnfQA+e4RuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="499228778"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2021 02:43:11 -0800
Subject: Re: [PATCH] mmc: core: don't initialize block size from ext_csd if
 not present
To:     Peter Collingbourne <pcc@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
References: <20210112210944.605953-1-pcc@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <34278e68-d69f-0440-858e-b2079b8ac7bb@intel.com>
Date:   Wed, 13 Jan 2021 12:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210112210944.605953-1-pcc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/01/21 11:09 pm, Peter Collingbourne wrote:
> If extended CSD was not available, the eMMC driver would incorrectly
> set the block size to 0, as the data_sector_size field of ext_csd
> was never initialized. This issue was exposed by commit 817046ecddbc
> ("block: Align max_hw_sectors to logical blocksize") which caused
> max_sectors and max_hw_sectors to be set to 0 after setting the block
> size to 0, resulting in a kernel panic in bio_split when attempting
> to read from the device. Fix it by only reading the block size from
> ext_csd if it is available.
> 
> Fixes: 817046ecddbc ("block: Align max_hw_sectors to logical blocksize")

I would go with the original commit i.e.

Fixes: a5075eb94837 ("mmc: block: Allow disabling 512B sector size emulation")

> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/If244d178da4d86b52034459438fec295b02d6e60
> ---
>  drivers/mmc/core/queue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index de7cb0369c30..735cdbf1145c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -20,6 +20,7 @@
>  #include "core.h"
>  #include "card.h"
>  #include "host.h"
> +#include "mmc_ops.h"
>  
>  #define MMC_DMA_MAP_MERGE_SEGMENTS	512
>  
> @@ -384,7 +385,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  		     "merging was advertised but not possible");
>  	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
>  
> -	if (mmc_card_mmc(card))
> +	if (mmc_card_mmc(card) && mmc_can_ext_csd(card))
>  		block_size = card->ext_csd.data_sector_size;

Might as well be:

	if (mmc_card_mmc(card) && card->ext_csd.data_sector_size)
  		block_size = card->ext_csd.data_sector_size;



>  
>  	blk_queue_logical_block_size(mq->queue, block_size);
> 

