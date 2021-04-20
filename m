Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB95C43461
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635026139A
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhDTLU6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:20:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:11105 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhDTLUx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Apr 2021 07:20:53 -0400
IronPort-SDR: bUMuiejOobdeT6p0bpkTVEuMnb3w3Zj705ysIBwgJBCCWtEXrphLKV70JHTuJ1XOzWUROOvAna
 FHnmgVruqC1w==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="216076753"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="216076753"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 04:20:19 -0700
IronPort-SDR: 5AFkbkHfoktgcXQ8OkfPAaIJ9aTf4U/QmckPA2ECRvzI0WfMQAM5YHQ7EEsqqy9VRNsLQYDRTq
 0ZTLz8IdKWxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="445480041"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2021 04:20:15 -0700
Subject: Re: [PATCH v3 1/2] mmc: block: Issue flush only if allowed
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Brendan Peter <bpeter@lytx.com>
References: <20210420055306.4858-1-avri.altman@wdc.com>
 <20210420055306.4858-2-avri.altman@wdc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a55b7fe7-0d84-a9a6-8f64-6f1632cffcc4@intel.com>
Date:   Tue, 20 Apr 2021 14:20:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420055306.4858-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/04/21 8:53 am, Avri Altman wrote:
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
>  drivers/mmc/core/block.c   | 7 +++++++
>  drivers/mmc/core/mmc.c     | 2 +-
>  drivers/mmc/core/mmc_ops.h | 5 +++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8bfd4d95b386..5b6501fc9fb7 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1476,6 +1476,11 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
>  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>  	struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq, req);
>  
> +	if (mmc_card_mmc(mq->card) && !mmc_flush_allowed(mq->card)) {
> +		blk_mq_end_request(req, BLK_STS_OK);
> +		return -EPERM;
> +	}
> +
>  	mrq->cmd->opcode = MMC_SWITCH;
>  	mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>  			(EXT_CSD_FLUSH_CACHE << 16) |
> @@ -2226,6 +2231,8 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>  		switch (req_op(req)) {
>  		case REQ_OP_FLUSH:
>  			ret = mmc_blk_cqe_issue_flush(mq, req);
> +			if (ret == -EPERM)
> +				return MMC_REQ_FINISHED;

Using an error code for this case seems a little fragile.

How about something like:

 		case REQ_OP_FLUSH:
			if (mmc_blk_cache_disabled(mq->card)) {
				blk_mq_end_request(req, BLK_STS_OK);
				return MMC_REQ_FINISHED;
			}
 			ret = mmc_blk_cqe_issue_flush(mq, req);


static bool mmc_blk_cache_disabled(struct mmc_card *card)
{
	return mmc_card_mmc(mq->card) && !mmc_flush_allowed(card);
}

>  			break;
>  		case REQ_OP_READ:
>  		case REQ_OP_WRITE:
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9ad4aa537867..e3da62ffcb5e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2037,7 +2037,7 @@ static int _mmc_flush_cache(struct mmc_card *card)
>  {
>  	int err = 0;
>  
> -	if (card->ext_csd.cache_size > 0 && card->ext_csd.cache_ctrl & 1) {
> +	if (mmc_flush_allowed(card)) {
>  		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  				 EXT_CSD_FLUSH_CACHE, 1,
>  				 CACHE_FLUSH_TIMEOUT_MS);
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 5782fdf4e8e9..2682bf66708a 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -19,6 +19,11 @@ enum mmc_busy_cmd {
>  struct mmc_host;
>  struct mmc_card;
>  
> +static inline bool mmc_flush_allowed(struct mmc_card *card)
> +{
> +	return card->ext_csd.cache_size > 0 && card->ext_csd.cache_ctrl & 1;
> +}
> +
>  int mmc_select_card(struct mmc_card *card);
>  int mmc_deselect_cards(struct mmc_host *host);
>  int mmc_set_dsr(struct mmc_host *host);
> 

