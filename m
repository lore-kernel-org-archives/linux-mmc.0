Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3687BC433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 03:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E192A23888
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 03:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbhAVDhT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 22:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbhAVDhR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 22:37:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8ABC06174A;
        Thu, 21 Jan 2021 19:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=M3pOp5kptZ6YgzfG0S1o6cFzqzbA+kUwayqUm25hHcM=; b=LvfVrjVA/4jzbyfI6AIhmS7+di
        aMB4ehdbvNADYyYINdG1nIbN8D8R5RIP2mIJhBgCEPa3B33AqGUIHDvX1WjwhprtQFKtdGZLmAhJp
        JTGUsZCgdWt+MVJ3UhpUahOJrIxZXM3d190SGF5Q7ORdrpbXMKCmABvLa+YnsrYzm3oMD3ejpbJIP
        12y83YrPLjX+YGZc0ZSXykJyHVD9pQLy0NMy8cOxosLO1D5MyCAjebN7Ma1EZjU86hu9+7XSFv06x
        5CkPaS4Kxe+isBaELueIr8pvwvSPpMjx3hJarXCauM6wcT4ddhgBRnbZ+CK1oJ8sUtrfEID9CnjG9
        9Ivb9mZg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2nFQ-00041g-Rz; Fri, 22 Jan 2021 03:36:33 +0000
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: Fix kunit-related build error
To:     Andrew Jeffery <andrew@aj.id.au>, linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com
References: <20210122032334.3663056-1-andrew@aj.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fd80b74e-c6a0-9b84-1370-db0c0814dca6@infradead.org>
Date:   Thu, 21 Jan 2021 19:36:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210122032334.3663056-1-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/21/21 7:23 PM, Andrew Jeffery wrote:
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

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/mmc/host/sdhci-of-aspeed-test.c |  9 ++++++++-
>  drivers/mmc/host/sdhci-of-aspeed.c      | 27 ++++++++++++++++++++-----
>  2 files changed, 30 insertions(+), 6 deletions(-)


-- 
~Randy
RFC: Features and documentation: http://lwn.net/Articles/260136/
