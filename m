Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD012C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 17 May 2021 11:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FF561241
	for <linux-mmc@archiver.kernel.org>; Mon, 17 May 2021 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhEQLfd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 May 2021 07:35:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:3726 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236794AbhEQLfc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 17 May 2021 07:35:32 -0400
IronPort-SDR: BmjjH7dp4IHR5+KRNl64xDBTGdGonCyX8+XC5A0WeDG2V3Pwgdct3BQwF9SJN5wLmyhzg+DAtK
 7q1Vvq4bu9mg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200493694"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200493694"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 04:33:54 -0700
IronPort-SDR: VFr6HQrwbMaPoLxAFwMXKQD+OMMb2GHNC2equwDaOarMi8IaDFOoUPW7L65iioFGbMX7QJft4T
 a/cN2aeC3gmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="472363628"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2021 04:33:51 -0700
Subject: Re: [PATCH] Unnecessary code change in spin_lock section.
To:     Chanwoo Lee <cw9316.lee@samsung.com>, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
References: <CGME20210513023747epcas1p23502f390781d1a5a8f6512982af1fd65@epcas1p2.samsung.com>
 <20210513023307.12435-1-cw9316.lee@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3a0ca4cc-5d5c-1cb2-8942-7f90da06e854@intel.com>
Date:   Mon, 17 May 2021 14:34:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513023307.12435-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/05/21 5:33 am, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> This is the spin_lock section for cq_host, and mmc setting is unnecessary.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index 93b0432bb601..4d76c858d45f 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -1090,8 +1090,8 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
>  	spin_lock_irqsave(&cq_host->lock, flags);
>  	cq_host->qcnt = 0;
>  	cq_host->recovery_halt = false;
> -	mmc->cqe_on = false;
>  	spin_unlock_irqrestore(&cq_host->lock, flags);

No, we don't want anyone to see mmc->cqe_on == true and
cq_host->recovery_halt == false at this point.

> +	mmc->cqe_on = false;>  	/* Ensure all writes are done before interrupts are re-enabled */
>  	wmb();
> 

