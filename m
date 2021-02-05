Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25106C433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 06:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86BC64F9C
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Feb 2021 06:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhBEGds (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Feb 2021 01:33:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:29930 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230402AbhBEGdr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Feb 2021 01:33:47 -0500
IronPort-SDR: qnNaDrF8UB8RD7ZE6BLf1Rgftme2ELbStYCrQp/sllGShu67SIxdRZFbTSFzz8naTKSHbmzN5L
 6hzMHnQx5WQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="266215567"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="266215567"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 22:33:05 -0800
IronPort-SDR: 5QfnJPgBPwLYURmVJG9624ZfaSoOmSNsiNY3rSMbMcI1YTUQkNSOc2mWz/cFGjTYTCMeLbDRby
 buv6rtcVoL/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="357588302"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2021 22:33:01 -0800
Subject: Re: [PATCH 2/2] mmc: mmc_test: use erase_arg for mmc_erase command
To:     yann.gautier@foss.st.com, ulf.hansson@linaro.org
Cc:     linux@armlinux.org.uk, linus.walleij@linaro.org,
        ludovic.barre@foss.st.com, per.forlin@linaro.org,
        huyue2@yulong.com, wsa+renesas@sang-engineering.com,
        vbadigan@codeaurora.org, p.zabel@pengutronix.de, marex@denx.de,
        swboyd@chromium.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-3-yann.gautier@foss.st.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c1531549-29da-25dc-cada-f61edbc5f2fd@intel.com>
Date:   Fri, 5 Feb 2021 08:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210204120547.15381-3-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/02/21 2:05 pm, yann.gautier@foss.st.com wrote:
> From: Yann Gautier <yann.gautier@foss.st.com>
> 
> Since [1], the erase argument for mmc_erase() function is saved in
> erase_arg field of card structure. It is preferable to use it instead of
> hard-coded MMC_SECURE_ERASE_ARG, which from eMMC 4.51 spec is not
> recommended:
> "6.6.16 Secure Erase
> NOTE Secure Erase is included for backwards compatibility. New system
> level implementations (based on v4.51 devices and beyond) should use
> Erase combined with Sanitize instead of secure erase."
> 
>  [1] commit 01904ff77676 ("mmc: core: Calculate the discard arg only once")
> 

Did you experience an issue because of this?  You could add that to the
commit message.

There does not seem to be a need for secure erase, so:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  drivers/mmc/core/mmc_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 39a478874ca3..63524551a13a 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -2110,7 +2110,7 @@ static int mmc_test_rw_multiple(struct mmc_test_card *test,
>  	if (mmc_can_erase(test->card) &&
>  	    tdata->prepare & MMC_TEST_PREP_ERASE) {
>  		ret = mmc_erase(test->card, dev_addr,
> -				size / 512, MMC_SECURE_ERASE_ARG);
> +				size / 512, test->card->erase_arg);
>  		if (ret)
>  			ret = mmc_erase(test->card, dev_addr,
>  					size / 512, MMC_ERASE_ARG);
> 

