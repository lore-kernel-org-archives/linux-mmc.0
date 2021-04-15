Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC930C433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 09:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B834613A9
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 09:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhDOJkE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhDOJkD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Apr 2021 05:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6543C60FD8;
        Thu, 15 Apr 2021 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618479580;
        bh=fKRs3+t1uoeek/kZ5AB7b1RPFvkaRDIonjMnl74NQpY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XaoVXqSM1ly6MBbtzA2ot+K7OEvWVAXxXArxhFhqyOOodCcEaXKo6kT4B2jKXe/HY
         H1YjGlbWQikF/CLNXs0/X/Gv1RRWMosUa0b/HVT55oeuG/EXBcZmZxwLV8x4f7QYv1
         qDPd0zyhgzNcox/JiqOUY7lE05fHDqTWclia3iKFlFz/yTa7WyqVNKSq7qg1tT/4Ev
         rUxFr+eZSjxZu76Ha/Z7ejcieXe/NxQroL9nJr/ctYoEtzT3QTZaYyTpKL0DZU+gXq
         51ulykoDrI3NoRku9Wesivse3p77dh7TFlg609eqLez5gkYCBo3icAAl8+4cdWujST
         T6fYofFB9ZZ7g==
Subject: Re: [PATCH v2 1/3] mmc: sdhci-s3c: simplify getting of_device_id
 match data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <aae59b41-02da-cd93-3dea-2fe7161fcd57@kernel.org>
Date:   Thu, 15 Apr 2021 11:39:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 15.04.2021 10:44, Krzysztof Kozlowski wrote:
> Use of_device_get_match_data() to make the code slightly smaller and to
> remove the of_device_id table forward declaration.
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
