Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98730C433DB
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Feb 2021 07:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B24C64F5C
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Feb 2021 07:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhBCHhY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Feb 2021 02:37:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:51600 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231834AbhBCHhW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Feb 2021 02:37:22 -0500
IronPort-SDR: kDUqwn7elpv/X0bw4HIH+mskKF/d7c4jxWViRD8fThOpJSaS+rg6VVJkNYnl2BTtnjHmjcEIhV
 XWnBiCqrXPkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160760880"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="160760880"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 23:36:37 -0800
IronPort-SDR: peD/CeSohs1xq+wtPJu0LOIU0QocDFx1r3nTgnm4Rhg86dkhLSi9EbjKWQyTaW5Kjw87BP5BJr
 FVgvYz64HJKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="372282320"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2021 23:36:31 -0800
Subject: Re: [PATCH] mmc: queue: Remove unused define
To:     Chanwoo Lee <cw9316.lee@samsung.com>, ulf.hansson@linaro.org,
        baolin.wang@linaro.org, arnd@arndb.de, colyli@suse.de,
        lee.jones@linaro.org, sartgarg@codeaurora.org, pcc@google.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
References: <CGME20210203072341epcas1p186cca2cf8177a31d04f1ede4bb5f1ec7@epcas1p1.samsung.com>
 <20210203072014.30272-1-cw9316.lee@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f7984520-8239-24ae-0142-811f4c6d9d9f@intel.com>
Date:   Wed, 3 Feb 2021 09:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210203072014.30272-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/02/21 9:20 am, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> MMC_CQE_QUEUE_FULL is not set and is only cleared.
> Therefore, define is unnecessary.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Looks like a pre blk-mq remanent.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/queue.c | 2 --
>  drivers/mmc/core/queue.h | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 002426e3cf76..9f37a8b909e8 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -33,8 +33,6 @@ void mmc_cqe_check_busy(struct mmc_queue *mq)
>  {
>  	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
>  		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
> -
> -	mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
>  }
>  
>  static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index fd11491ced9f..57c59b6cb1b9 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -81,7 +81,6 @@ struct mmc_queue {
>  	int			in_flight[MMC_ISSUE_MAX];
>  	unsigned int		cqe_busy;
>  #define MMC_CQE_DCMD_BUSY	BIT(0)
> -#define MMC_CQE_QUEUE_FULL	BIT(1)
>  	bool			busy;
>  	bool			use_cqe;
>  	bool			recovery_needed;
> 

