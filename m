Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B5C43381
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 18:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE6123AA1
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbhAVSQ6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbhAVRYH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 12:24:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59486C06174A;
        Fri, 22 Jan 2021 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/1OGUuSh8UTx2h39ipHbvJAcdb29iqtzaaFfOzJpWBw=; b=RO/x/RV5jTG78QmHWtQlBG20gp
        ZqwEdo8lONzmuAiGidQusdA8sq3W+YGFl8SuNvBGH31iPg6tz/lerRjZopvE7zEuUqCN+Xe+DgUyP
        Nr3v1wFNvah06wJtgmvEe2itJg5sdFOjSKvo2i4EpCY4Jrjp6/grhdTSV2PdYXYlmKLtFPv8Y+3mE
        mNfzX+Q4rRBH0PfKacJf+ovfim35xemVvVAkr4FRE3sLqJdkv0UNcXoahP5r4xOgAo1PkufxRZJOF
        pM9F/+gwhecuJt7fnNODh8MBfpH3orJfykRo3T/hPF0/XPh1T/x4zgcD7Sf+5RqDJ06jz8vF+dLHD
        SXfIhUfg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l309X-00039n-GX; Fri, 22 Jan 2021 17:23:19 +0000
Subject: Re: [PATCH v2] mmc: sdhci-of-aspeed: Fix kunit-related build error
To:     Andrew Jeffery <andrew@aj.id.au>, linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com
References: <20210122114852.3790565-1-andrew@aj.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bef54bf0-7c9e-09ce-9f37-ab9498959ba1@infradead.org>
Date:   Fri, 22 Jan 2021 09:23:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210122114852.3790565-1-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/22/21 3:48 AM, Andrew Jeffery wrote:
> Randy found that with the following Kconfig settings we have duplicate
> definitions (e.g. __inittest()) in sdhci-of-aspeed due to competing
> module_init()/module_exit() calls from kunit and driver the itself.
> 
> ```
> CONFIG_MMC_SDHCI_OF_ASPEED=m
> CONFIG_MMC_SDHCI_OF_ASPEED_TEST=y
> ```
> 
> Conditionally open-code the kunit initialisation to avoid the error.
> 
> Fixes: 7efa02a981d6 ("mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> 
> v2:
> * Collapse the #ifdef-ery
> 
>  drivers/mmc/host/sdhci-of-aspeed-test.c |  9 +++++-
>  drivers/mmc/host/sdhci-of-aspeed.c      | 42 ++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 6 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.


-- 
~Randy

