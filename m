Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3763C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 04:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F0361373
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 04:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhHYEqj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 00:46:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:49692 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHYEqj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Aug 2021 00:46:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204581671"
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="204581671"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 21:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="473718717"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2021 21:45:50 -0700
Subject: Re: [PATCH] mmc: queue: Remove unused parameters(request_queue)
To:     Chanwoo Lee <cw9316.lee@samsung.com>, ulf.hansson@linaro.org,
        colyli@suse.de, axboe@kernel.dk, ebiggers@google.com,
        pcc@google.com, porzio@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
References: <CGME20210825004043epcas1p33ca4a682a765e1270258bba083fe66d6@epcas1p3.samsung.com>
 <20210825003318.31574-1-cw9316.lee@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2e292b9c-9b1e-dc3e-45f9-06beb31d79b6@intel.com>
Date:   Wed, 25 Aug 2021 07:46:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825003318.31574-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/08/21 3:33 am, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> In function mmc_exit_request, the request_queue structure(*q) is not used.
> I remove the unnecessary code related to the request_queue structure.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
> ---
>  drivers/mmc/core/queue.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index cc3261777637..b742385361e4 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -219,7 +219,7 @@ static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
>  	return 0;
>  }
>  
> -static void mmc_exit_request(struct request_queue *q, struct request *req)
> +static void mmc_exit_request(struct request *req)
>  {
>  	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
>  
> @@ -236,9 +236,7 @@ static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
>  static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
>  				unsigned int hctx_idx)
>  {
> -	struct mmc_queue *mq = set->driver_data;
> -
> -	mmc_exit_request(mq->queue, req);
> +	mmc_exit_request(req);

It seems this is the only caller of mmc_exit_request().  It is probably
leftover from before the switch to blk-mq.  However we might as well get rid
of it and just put the code directly into mmc_mq_exit_request().

The same applies to mmc_mq_init_request() and __mmc_init_request(), so might
as well tidy up those also.

>  }
>  
>  static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> 

