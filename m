Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7805C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 19:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE80A64E0A
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhA2TBN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Jan 2021 14:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhA2TAx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 29 Jan 2021 14:00:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D295064E0A;
        Fri, 29 Jan 2021 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611946793;
        bh=kH+r5BM0XlyUqWsGOaJ5rHP31CbTjugp6JcE6uT5yog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuZZOhfq6e1MetpDMIMye9wWcM6ASdmDKZTexpyKkYB2Ny4gIWwaIMqzKEaF9lALt
         Fwjx+bx6S4ibY8bzi2yVWYG/M9winktZ+Ju4UGL/2I+lO40kulHk4yTq5SiYniO2Rn
         jzlLrSVniFYtsWC24C3UQJzfJr7ERS/eZj7/crMzx7HMNA8vTEu8mOeukAfuuE/7AQ
         5OOUxSi3ED/yZuR25lVxA3iTriJtKhYnLzgDm8s1Yd6b4BXqoEY7jTs6xaDz9AM627
         3XjWY6E7YAtd7S8KzlJIE6Yn/oHFzKWsMLX913iTPgptDV3mLHCOPlrGiGMNcZ7l2Z
         ECTSp0jzYXloA==
Date:   Fri, 29 Jan 2021 10:59:51 -0800
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
Message-ID: <YBRbJ5sGt75ndmvG@sol.localdomain>
References: <20210129070825.12304-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129070825.12304-1-peng.zhou@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jan 29, 2021 at 03:08:25PM +0800, Peng Zhou wrote:
> - add crypto clock control and ungate it before CQHCI init
> - set MMC_CAP2_CRYPTO property of eMMC
> 
> Change-Id: I3a28eaa3718eee73259b4d60867cce25525f9bba
> Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>

Please run scripts/checkpatch.pl on this patch (and the next one) and address
the warnings and errors.

> +	/* only eMMC has crypto property */
> +	if ((mmc->caps2 & MMC_CAP2_NO_SD) && (mmc->caps2 & MMC_CAP2_NO_SDIO))
> +		mmc->caps2 |= MMC_CAP2_CRYPTO;
> +
> +	if (mmc->caps2 & MMC_CAP2_CRYPTO) {
> +		host->crypto_clk = devm_clk_get(&pdev->dev, "crypto_clk");
> +		if (IS_ERR(host->crypto_clk))
> +			host->crypto_clk = NULL;
> +	}

Is this logic correct?  I'm wondering whether you want something more like:

	/* only eMMC has crypto property */
	if ((mmc->caps2 & MMC_CAP2_NO_SD) && (mmc->caps2 & MMC_CAP2_NO_SDIO))
		host->crypto_clk = devm_clk_get(&pdev->dev, "crypto_clk");
		if (IS_ERR(host->crypto_clk))
			host->crypto_clk = NULL;
		else
			mmc->caps2 |= MMC_CAP2_CRYPTO;
	}

I.e., is crypto only supported when crypto_clk is present?  Or can crypto be
supported without crypto_clk being present?

- Eric
