Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F7C433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62C9619A0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 18:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCVR7x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 13:59:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:25948 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhCVR7v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 13:59:51 -0400
IronPort-SDR: xvk7sYD/qsvS2Thd09+oLQfikzgIkWAR3sg+eDEjtD6/nWYQdrsti5JGXtuulYGSnr5SjJHnfp
 7mMqkPLb3wyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189722300"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="189722300"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 10:59:50 -0700
IronPort-SDR: mAz3amYDh3HKIIJHrUx/MuDWbIDqisqn4/5jmkHGwmQD4D2HmKnIRW8vOjLc7bQD1z7+7MU9Qb
 yIUBBnBekqnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="407931760"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2021 10:59:48 -0700
Subject: Re: [PATCH 1/2] mmc: block: Issue flush only if allowed
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Brendan Peter <bpeter@lytx.com>
References: <20210322133645.4901-1-avri.altman@wdc.com>
 <20210322133645.4901-2-avri.altman@wdc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <546a878b-f19a-ab6d-369c-aebf2941f024@intel.com>
Date:   Mon, 22 Mar 2021 20:00:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322133645.4901-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/03/21 3:36 pm, Avri Altman wrote:
> The cache may be flushed to the nonvolatile storage by writing to
> FLUSH_CACHE byte (EXT_CSD byte [32]). When in command queueing mode, the
> cache may be flushed by issuing a CMDQ_TASK_ DEV_MGMT (CMD48) with a
> FLUSH_CACHE op-code.  Either way, verify that The cache function is
> turned ON before doing so.
> 
> fixes: 1e8e55b67030 (mmc: block: Add CQE support)
> 
> Reported-by: Brendan Peter <bpeter@lytx.com>
> Tested-by: Brendan Peter <bpeter@lytx.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c   | 3 +++
>  drivers/mmc/core/mmc_ops.c | 4 +---
>  drivers/mmc/core/mmc_ops.h | 5 +++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 42e27a298218..a93c66aa91db 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1473,6 +1473,9 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
>  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>  	struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq, req);
>  
> +	if (mmc_card_mmc(mq->card) && !mmc_flush_allowed(mq->card))
> +		return 0;

Returning 0 means the flush was issued successfully. i.e. it is in
flight.

Instead, a call to blk_mq_end_request(req, BLK_STS_OK) is needed,
and mmc_blk_mq_issue_rq() must be amended so that it will return
MMC_REQ_DONE for this case.

> +
>  	mrq->cmd->opcode = MMC_SWITCH;
>  	mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>  			(EXT_CSD_FLUSH_CACHE << 16) |
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index baa6314f69b4..b8a0c9ac8a20 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -988,9 +988,7 @@ int mmc_flush_cache(struct mmc_card *card)
>  {
>  	int err = 0;
>  
> -	if (mmc_card_mmc(card) &&
> -			(card->ext_csd.cache_size > 0) &&
> -			(card->ext_csd.cache_ctrl & 1)) {
> +	if (mmc_card_mmc(card) && mmc_flush_allowed(card)) {
>  		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  				 EXT_CSD_FLUSH_CACHE, 1,
>  				 MMC_CACHE_FLUSH_TIMEOUT_MS);
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 632009260e51..bf2b315addd7 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -19,6 +19,11 @@ enum mmc_busy_cmd {
>  struct mmc_host;
>  struct mmc_card;
>  
> +static inline bool mmc_flush_allowed(struct mmc_card *card)
> +{
> +	return card->ext_csd.cache_size > 0 && (card->ext_csd.cache_ctrl & 1);
> +}
> +
>  int mmc_select_card(struct mmc_card *card);
>  int mmc_deselect_cards(struct mmc_host *host);
>  int mmc_set_dsr(struct mmc_host *host);
> 

