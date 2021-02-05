Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F2C433DB
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 18:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405BA64F19
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 18:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhBEREb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Feb 2021 12:04:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:27726 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233719AbhBERB1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Feb 2021 12:01:27 -0500
IronPort-SDR: w8Z0cBMJJDsKPS4DDWlRTXx9HTkKARRfghNcWDe2sMzeK8XXTvn/YB3U4TFfPLIVv+JjbDiqFf
 6yGMmXiSBLlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181537266"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="181537266"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 10:43:10 -0800
IronPort-SDR: Q2LLkeL2CXHCPzqY8eW2S/QyhOm5+7Xw5DMsNzxHWO3d09gzEz58S0hIrUd+tF+OO3fRP/qX+A
 kFzp0btcoZDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="583877176"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by fmsmga005.fm.intel.com with ESMTP; 05 Feb 2021 10:43:08 -0800
Subject: Re: [PATCH] sdhci: stop poking into swiotlb internals
To:     Christoph Hellwig <hch@lst.de>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
References: <20210205162346.2847165-1-hch@lst.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <195d7168-3be0-91ea-1c5b-e850d5c12582@intel.com>
Date:   Fri, 5 Feb 2021 20:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210205162346.2847165-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Jiri Slaby <jslaby@suse.cz>

On 5/02/21 6:23 pm, Christoph Hellwig wrote:
> Use the proper API to query the max mapping size instead of guessing
> it based on swiotlb internals.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mmc/host/sdhci.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 646823ddd31715..2d73407ee52ec7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -20,7 +20,6 @@
>  #include <linux/slab.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sizes.h>
> -#include <linux/swiotlb.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> @@ -4582,12 +4581,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		mmc->max_segs = SDHCI_MAX_SEGS;
>  	} else if (host->flags & SDHCI_USE_SDMA) {
>  		mmc->max_segs = 1;
> -		if (swiotlb_max_segment()) {
> -			unsigned int max_req_size = (1 << IO_TLB_SHIFT) *
> -						IO_TLB_SEGSIZE;
> -			mmc->max_req_size = min(mmc->max_req_size,
> -						max_req_size);
> -		}
> +		mmc->max_req_size = min_t(size_t, mmc->max_req_size,
> +					  dma_max_mapping_size(mmc_dev(mmc)));
>  	} else { /* PIO */
>  		mmc->max_segs = SDHCI_MAX_SEGS;
>  	}
> 

