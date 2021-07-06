Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C5DC07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 07:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F71C6196A
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 07:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGFHIC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 03:08:02 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:46414 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhGFHIC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 03:08:02 -0400
Received: from localhost (unknown [192.168.167.172])
        by regular1.263xmail.com (Postfix) with ESMTP id 0224F681;
        Tue,  6 Jul 2021 15:05:16 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31478T139654521145088S1625555114518632_;
        Tue, 06 Jul 2021 15:05:15 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b7d86f5378007744ff140b6568f87285>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <8d310df9-2139-e5ff-e0ee-205ffc1778a2@rock-chips.com>
Date:   Tue, 6 Jul 2021 15:05:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Cc:     shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Christian Lohle <CLoehle@hyperstone.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: core: Avoid hogging the CPU while polling for
 busy
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <20210702134229.357717-1-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210702134229.357717-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021/7/2 21:42, Ulf Hansson wrote:
> Step by step, code that have been dealing sending CMD13 to poll the card for
> busy, have been moved to use the common mmc_poll_for_busy() loop. This helps to
> avoid hogging the CPU, for example, as it inserts a small delay in between each
> polling attempt. Additionally, it avoids open coding.
> 
> This series takes the next and final step, by moving the mmc block device layer
> from its own busy polling loop, into using the common code.
> 
> Please test and review!

Hi Ulf,

This patch-set looks good,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Kind regards
> Uffe
> 
> Ulf Hansson (3):
>    mmc: core: Avoid hogging the CPU while polling for busy in the I/O err
>      path
>    mmc: core: Avoid hogging the CPU while polling for busy for mmc ioctls
>    mmc: core: Avoid hogging the CPU while polling for busy after I/O
>      writes
> 
>   drivers/mmc/core/block.c   | 74 +++++++++++++++++---------------------
>   drivers/mmc/core/mmc_ops.c |  5 ++-
>   drivers/mmc/core/mmc_ops.h |  1 +
>   3 files changed, 37 insertions(+), 43 deletions(-)
> 


