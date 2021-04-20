Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF113C433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F926103E
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 14:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhDTODA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 10:03:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:28162 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232084AbhDTOC4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Apr 2021 10:02:56 -0400
IronPort-SDR: yPWiq2Ch54vflu0twO1++Njofd48FzmkgmjBiQYpJRUH4fEU5KtClulX03NNeSeH026Kz+N/I1
 N/fNWzfMdZlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="183002489"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="183002489"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:02:23 -0700
IronPort-SDR: rmuYi02cPO8DIqxg9EH3EnvOlzTJGHrHUHSq1yqb9uEr5iave4FLzf9rHZkUSRkxlyouh9nFvr
 M/rLvosxxovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="445520075"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2021 07:02:21 -0700
Subject: Re: [PATCH v4 1/2] mmc: block: Issue flush only if allowed
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Brendan Peter <bpeter@lytx.com>
References: <20210420134641.57343-1-avri.altman@wdc.com>
 <20210420134641.57343-2-avri.altman@wdc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d583dc7e-b9c7-7288-ef7d-23ce7e9a7fc9@intel.com>
Date:   Tue, 20 Apr 2021 17:02:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420134641.57343-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/04/21 4:46 pm, Avri Altman wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/block.c   | 9 +++++++++
>  drivers/mmc/core/mmc.c     | 2 +-
>  drivers/mmc/core/mmc_ops.h | 5 +++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8bfd4d95b386..24e1ecbdd510 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2186,6 +2186,11 @@ static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
>  	return mmc_blk_rw_wait(mq, NULL);
>  }
>  
> +static bool mmc_blk_cache_disabled(struct mmc_card *card)
> +{
> +	return mmc_card_mmc(card) && !mmc_flush_allowed(card);
> +}
> +
>  enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>  {
>  	struct mmc_blk_data *md = mq->blkdata;
> @@ -2225,6 +2230,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>  	case MMC_ISSUE_ASYNC:
>  		switch (req_op(req)) {
>  		case REQ_OP_FLUSH:
> +			if (mmc_blk_cache_disabled(mq->card)) {
> +				blk_mq_end_request(req, BLK_STS_OK);
> +				return MMC_REQ_FINISHED;
> +			}
>  			ret = mmc_blk_cqe_issue_flush(mq, req);
>  			break;
>  		case REQ_OP_READ:
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

