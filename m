Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F3CC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36CC64E2B
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhBQFrm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 00:47:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:33725 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhBQFrl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Feb 2021 00:47:41 -0500
IronPort-SDR: 3n9NNd0n43PN78i0TMntCKOGPHAB0HLUuXzDi4Zc95zIy6h2MWm3XpFOcNryli1JJ1sq9lGSCT
 HfgfQh12YuFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="183240869"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="183240869"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 21:47:00 -0800
IronPort-SDR: ud/keKpLGbgL5aGlJAIoxTmzJj+x2hg4aaCz4SH7RtiWEyB636m0BaEsv9XXQJxG1GMgl7I+P8
 cxATzZ6c0nbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="439234342"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2021 21:46:55 -0800
Subject: Re: [PATCH 2/2] mmc: core: Add no single read retries
To:     DooHyun Hwang <dh0421.hwang@samsung.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, axboe@kernel.dk, satyat@google.com,
        ebiggers@google.com, gustavoars@kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com
References: <20210217052239.13780-1-dh0421.hwang@samsung.com>
 <CGME20210217053521epcas1p2aa80cae5d52f30c8c8882f44abe8045c@epcas1p2.samsung.com>
 <20210217052239.13780-3-dh0421.hwang@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4035139d-7850-8460-f069-06fc61d13039@intel.com>
Date:   Wed, 17 Feb 2021 07:46:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210217052239.13780-3-dh0421.hwang@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/02/21 7:22 am, DooHyun Hwang wrote:
> This makes to handle read errors faster by not retrying
> multiple block read(CMD18) errors with single block reads(CMD17).
> 
> On some bad SD Cards that have problem with read operations,
> it is not helpful to retry multiple block read errors with
> several single block reads, and it is delayed to treat read
> operations as I/O error as much as retrying single block reads.

If the issue is that it takes too long, then maybe it would be better to get
mmc_blk_read_single() to give up after a certain amount of time.

> 
> Signed-off-by: DooHyun Hwang <dh0421.hwang@samsung.com>
> ---
>  drivers/mmc/core/block.c | 3 ++-
>  drivers/mmc/core/host.c  | 6 ++++++
>  include/linux/mmc/host.h | 3 +++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index d666e24fbe0e..e25aaf8fca34 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1809,7 +1809,8 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
>  
>  	/* FIXME: Missing single sector read for large sector size */
>  	if (!mmc_large_sector(card) && rq_data_dir(req) == READ &&
> -	    brq->data.blocks > 1) {
> +	    brq->data.blocks > 1 &&
> +	    !card->host->no_single_read_retry) {
>  		/* Read one sector at a time */
>  		mmc_blk_read_single(mq, req);
>  		return;
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 9b89a91b6b47..3bf5b2fc111b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -352,6 +352,12 @@ int mmc_of_parse(struct mmc_host *host)
>  	if (device_property_read_bool(dev, "no-mmc"))
>  		host->caps2 |= MMC_CAP2_NO_MMC;
>  
> +	if (device_property_read_bool(dev, "no-single-read-retry")) {
> +		dev_info(host->parent,
> +			"Single block read retrying is not supported\n");
> +		host->no_single_read_retry = true;
> +	}
> +
>  	/* Must be after "non-removable" check */
>  	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
>  		if (host->caps & MMC_CAP_NONREMOVABLE)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 26a3c7bc29ae..faec55035a63 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -502,6 +502,9 @@ struct mmc_host {
>  	/* Host Software Queue support */
>  	bool			hsq_enabled;
>  
> +	/* Do not retry multi block read as single block read */
> +	bool			no_single_read_retry;
> +
>  	unsigned long		private[] ____cacheline_aligned;
>  };
>  
> 

