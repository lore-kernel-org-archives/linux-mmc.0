Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B851C432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 07:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074F960240
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 07:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhHaHht (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:37:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:47765 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231537AbhHaHht (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 31 Aug 2021 03:37:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="215293391"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="215293391"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 00:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="498161336"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2021 00:36:48 -0700
Subject: Re: [PATCH] mmc: sdhci: Change the code to check auto_cmd23
To:     Chanwoo Lee <cw9316.lee@samsung.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
References: <CGME20210825094127epcas1p26709a5004dacdb2066e7f21dc1c997f5@epcas1p2.samsung.com>
 <20210825093345.14706-1-cw9316.lee@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bcdf7aff-0537-357c-ba29-4fb5d1cfa605@intel.com>
Date:   Tue, 31 Aug 2021 10:37:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825093345.14706-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/08/21 12:33 pm, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> It is replaced with a function that is already declared.
> //[1/5] mmc: sdhci: Add helpers for the auto-CMD23 flag
> //20200412090349.1607-2-adrian.hunter@intel.com
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 36f15f81a6af..5782650ddf7d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3232,7 +3232,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  			  -ETIMEDOUT :
>  			  -EILSEQ;
>  
> -		if (mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
> +		if (sdhci_auto_cmd23(host, mrq)) {
>  			mrq->sbc->error = err;
>  			__sdhci_finish_mrq(host, mrq);
>  			return;
> 

