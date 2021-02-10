Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6DC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 07:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A87E64E42
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 07:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhBJHni (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:43:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232574AbhBJHnh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Feb 2021 02:43:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B94A64E3B;
        Wed, 10 Feb 2021 07:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612942976;
        bh=x+8Y5c1Rbxky5hUvHsUBJC29R07ZR3qffWikVpUst2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maB3/B/RUFizOIKu1XEDBWRJhE4700dWzuDbDVY0psKsOyQd9zWu7w4pELzMvhxyz
         ZJcXtiZY6hfyHGa1U0E7OSdcJ8Ep6NG5NpFPqbrDN7LsQ1+BlstcOSolYc0iXOHKpT
         zO83DTCzJ9l1mNhKDsxpMiLwEN3xmV3oXAgZnuDSDPKpZ+KhLFN6aSC3ls7q+LXrtx
         WhQJcdcEwNQ56S9ryJGbO3XQWgImMgpU6kNKMO9Ym/wfzE8CI3hr6ghd4HJ+T2hY9C
         eJkeRSWKLHsmCo9FcDDEIMkhKCoi/+3BNpY2CWrAkBcGywoiEHAEnaT4hZ2/VFRcX1
         j+7ZZKp+OunEg==
Date:   Tue, 9 Feb 2021 23:42:54 -0800
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
Subject: Re: [PATCH v2 1/2] mmc: mediatek: add Inline Crypto Engine support
Message-ID: <YCOOfp6KGK6nO+RD@sol.localdomain>
References: <20210129070825.12304-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129070825.12304-1-peng.zhou@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

One more comment:

On Fri, Jan 29, 2021 at 03:08:25PM +0800, Peng Zhou wrote:
> +	if (mmc->caps2 & MMC_CAP2_CRYPTO) {
> +		host->crypto_clk = devm_clk_get(&pdev->dev, "crypto_clk");
> +		if (IS_ERR(host->crypto_clk))
> +			host->crypto_clk = NULL;
> +	}

I think that clock names aren't supposed to end in "_clk", as this is implied.
Just call it "crypto".

- Eric
