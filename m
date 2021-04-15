Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2AC433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 09:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5CA611AB
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 09:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhDOJmu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhDOJmu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Apr 2021 05:42:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2347160FD8;
        Thu, 15 Apr 2021 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618479747;
        bh=ji016J2CdUKZtTILjzt/X/tJBXFKy/pfmjOJgrMn5uU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MzkezCPEEo02FCqGzQvmsS1RV0bUj4FQJz6ZojcgCLn2cytBEaVJE9LjPsn1YTDPe
         Nr8faT6C6IyfkEMWwnCOVfm2MNYy7keuJufdoKL1UVKqlCZ7cCFFVhbnjMGCrwd2sQ
         5da/juQUDhApXiTXljwxyXzGG1hxWqqJ8o4ZTUnMm0cIKKXlNqP5fhG2F6kqkgqWnN
         UmYRAgle3f9yVT2ZXaOLULiXPfQ24K58hOrUZ94p9qgZZGuBddgCmnJeRz/s4BRCrg
         1FnwMfuHM6bYPCyLgcYhW6QGZkRTPk3LQukF709nFx9xlrLkMAvRumwUh4W39Xw12P
         JlH2MXFWiCStQ==
Subject: Re: [PATCH v2 3/3] mmc: sdhci-s3c: constify uses of driver/match data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
 <20210415084412.51125-3-krzysztof.kozlowski@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <bc8cb322-3f65-4387-2942-ed51d0eaca5d@kernel.org>
Date:   Thu, 15 Apr 2021 11:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415084412.51125-3-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 15.04.2021 10:44, Krzysztof Kozlowski wrote:
> The driver data (struct sdhci_s3c_drv_data) stored in of_device_id
> table is allocated as const and used only in const-way.  Skip
> unnecessary const-away casts and convert all users to work with pointer
> to const.  This is both more logical and safer.
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
