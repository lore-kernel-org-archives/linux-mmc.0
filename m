Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74483C2D0DB
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A53B206D4
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMt+j992"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbgAXLjL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:39:11 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39237 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403928AbgAXL0P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2020 06:26:15 -0500
Received: by mail-vk1-f193.google.com with SMTP id t129so429058vkg.6
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2020 03:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhg5LKBD7QqP7L8f8b2Xy3d0hKq+TkhFgCzJNOaA1Vk=;
        b=vMt+j992PLNMNf5CCzOWOKSrjHXqJOdgAuxvSUUx/OPkATipTFsFmsEhLwounpaOb6
         EexUJYS72x5zZyTaXJxOSbXRVLMJM+m3ZhNSqY6Xt0c0mSuBqp4r6Ac/OQmjp1dGDmZR
         2TFSRl5wTGYJ0ksAIFo4YJHL9+L92+GueN/hlNG1v5rcGJGRlhLilSViXadjgufUbCE1
         xzFWozsIsqpDIKStd2pyZMhN2Je34c3QMLTagr5O4eWyTeOmkvdy2gmvx9Jx0rW5CD9z
         lcWsuqGYrEow41EVVKb21NgUp669E1ibuXLzhjoE3IKYRE868bq6+1Y9db4Pmld3w5nv
         oSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhg5LKBD7QqP7L8f8b2Xy3d0hKq+TkhFgCzJNOaA1Vk=;
        b=LJw6AHgAugUkaEWp8JqCjdQWcm1Wh0YTP6ovzdIs28U+9gWR6ct19uI1WYLMhJ2O8T
         suoq1K0ZKMBlM4gQ5gH+NUx4Qo1Yi9fxxQ7zRba/lKtM+xNdRM1CCZ8OvrAZbJlhVZA8
         Bs14M7TwH9s1bRpvv6aLqySj5u7hXpoGtfFTFIZQu/23/bJUMWwmN9uwUU9lv1/j1jmq
         Fp/1cYeTnPcYlVV1hurcwqudH8yZRjl8CO2YQ1mSrldk4fYgL0ceMWb1pmt/c7E2pBQC
         mcII9tbRu9JRjnqG2+IIYZvs6RzaG7pGYT/qDsquwh9GGzQAuLpWDSwkhI3JmDcHhAv4
         lRvA==
X-Gm-Message-State: APjAAAVHL5NmNp3nQGyeN0s4xmvmkkXxMzYAV4TDQnhEREI194wuiic/
        d8H9FDneghrcf9WH2R5hLy1bB5n6NSfJiyCZROpfGqYx
X-Google-Smtp-Source: APXvYqyj/dOsOUj1PCM9o59eWRxZo3P0Ak21GfT7+VlsR4zIn1NMqGbrZMiW7JjVZETY8kGXRu7j0xq7dMvlRH5bReY=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr1516055vka.59.1579865173856;
 Fri, 24 Jan 2020 03:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
In-Reply-To: <20200122142747.5690-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 12:25:37 +0100
Message-ID: <CAPDyKFq7+7cDZuT45O7F3Vy+i134PB4KqEH9J075PeCF9h4m2Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: core: Update timeouts for __mmc_switch()
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Jan 2020 at 15:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This small series updates timeouts used when sending CMD6 for eMMC, through the
> __mmc_switch() function.
>
> Ulf Hansson (3):
>   mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
>   mmc: block: Use generic_cmd6_time when modifying
>     INAND_CMD38_ARG_EXT_CSD
>   mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
>
>  drivers/mmc/core/block.c   |  6 +++---
>  drivers/mmc/core/mmc_ops.c | 34 +++++++++++++++++-----------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> --
> 2.17.1
>

To widen the test cases, I have queued up this for next, also by
amending patch3 for fixing some spelling mistakes in the changelog.

Please tell if you see any problems with this and feel free to provide
tested by tags.

Kind regards
Uffe
