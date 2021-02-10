Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CECC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D89E64E2F
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 07:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhBJHpp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232860AbhBJHpl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Feb 2021 02:45:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 939DE64E3B;
        Wed, 10 Feb 2021 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612943100;
        bh=oN2MCU/WD/CaPshVsuvNdTABV6PVuFlB6o3ByF/QAWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuN2a8kFFiT129oRP90nhqOvgvtjNLVdf8pbc01/NMgJg141GA1Pf2D0KUw+7PCOH
         TOWvTuJnSoQwAIwzFW2y6JdenToBESm0580jJDYbuDgXNO5ls250I/kdm21htxXS6q
         SHOlz88SXvsG33eQ1xg7/q4bgYW5p7d45J/fT6+gPJ1JYhCE/G5EfCz+R9LrhFmYh3
         xjRu6H3S7GlTQyg7r8reik9J254/9ztDoJ5XBu9hzL7lctm6XpWKQrGTsU6HMgtziL
         yfQUUktxsqj6H3quYcyfj6i0bsTEcZScI9rLbUkHnG4N6smvntXtBAW0VzVlLK0weO
         AewlrBwANpSVQ==
Date:   Tue, 9 Feb 2021 23:44:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peng Zhou <peng.zhou@mediatek.com>
Cc:     linux-mmc@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH v2 2/2] mmc: mediatek: enable crypto hardware engine
Message-ID: <YCOO+xHC4JZoD1rX@sol.localdomain>
References: <20210129071107.9129-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129071107.9129-1-peng.zhou@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jan 29, 2021 at 03:11:07PM +0800, Peng Zhou wrote:
> @@ -2770,6 +2781,15 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>  
>  	msdc_ungate_clock(host);
>  	msdc_restore_reg(host);
> +
> +	/*
> +	 * 1: MSDC_AES_CTL_INIT
> +	 * 4: cap_id, no-meaning now
> +	 * 1: cfg_id, we choose the second cfg group
> +	 */
> +	if (mmc->caps2 & MMC_CAP2_CRYPTO)
> +		arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> +			1, 4, 1, 0, 0, 0, 0, &smccc_res);
>  	return 0;
>  }
>  

This part doesn't compile because there is no smccc_res variable.  It worked if
I added it as a local variable in this function.

- Eric
