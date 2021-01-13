Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA053C4332D
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E31233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbhAML1o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbhAML1c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:27:32 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D50C061383
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:26:07 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id k30so909683vsp.6
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8jnevPejbGnXuRE1eNboLtO8z7zKZhz6Hgll9JoqIU=;
        b=XWSAUiVl6lGR7286jXBaM0GJdDCLgq6VJ1wRJAskOKaSoppFAT7jpkgJLupWkCdKfZ
         4OCU8lHhUHQruIBti0gbNY+NyUbKK52OIc6BPl+wqtmcux9JKT+cyJ37RX8tJlWl1EMs
         uJlL7uBqswk8jQTTgVhoOCp5UAECFvUD7MsYlAU9aJ7IJFmdLMmHR0lQP0wW3NVb0BLH
         Tjo9wSbdfAo80iCjE1QwZonmqTZPdyDR7aYhva8RHmMuKdj//riosEAqS7iOPUbLc7yb
         kpSqD6DuE5HsWz9LJS/DUdtDEWQddLlUXgQXwMZ5foMdYz21D0QiKaNGp28PHvR+nRP6
         HyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8jnevPejbGnXuRE1eNboLtO8z7zKZhz6Hgll9JoqIU=;
        b=FA0r5PyDS89yQNWrYsyW/fxmFaiimOTefWVn4ANKykeq1PHHLFNQpH2hGIUXymVOHt
         ipyrQYeFTOtHXXtEfqZR4n1nmTz4ck9wtSjeZbekyMikZSrH8ddUGnS5jJDxu2karbwo
         pRXn4nC8ynqAZiIKNsHOXpw19fQgArwzkC4oHBQrJpaNYMVy/NLfF94xwIQzR9Wj8Nfi
         2UL5DVWwgc5oYzyWWWVfZNgsVz31i2QNBfq/xMfTN7YrAAxw5214hg6WBh9COsZ8VF/3
         VMUpcCv//Vib1tyvVJb3whxQQ7JHeC6NOoOr9oa1zZXCorDq7A0hOB2konaTpdm436/E
         3wUg==
X-Gm-Message-State: AOAM530bNpaoQ7osuqMddrGiOU8FyqFSObWppg4mysPuxgxNYw5RKTR8
        lLHBeMP8iWCrSFb3y/dfppAVertXRyq8rymbrazR6w==
X-Google-Smtp-Source: ABdhPJzfrPTWrOSLWP09mVB/1TJ84tDQudEsx/cZCljfINMeLiuZZP5UnGxMGp6TAmFAKwKOodVhuHFUYtxQyLmU+D8=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr1189707vsr.19.1610537166735;
 Wed, 13 Jan 2021 03:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:30 +0100
Message-ID: <CAPDyKFrx3ZhHk_k7OOEUWVuW-+wwq-x47-ZCteEB1gDJEFDoWQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mmc: sdhci-of-arasan: Fixed kernel-doc format warning
To:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Jan 2021 at 16:51, Muhammad Husaini Zulkifli
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi,
>
> This patch series are to fix the kernel-doc format warning when using kernel-doc
> script tool and to change code style of mapping the syscon field for readability
> and consistency.
>
> Kindly help to review this patch set.
>
> Thanks.
>
> Muhammad Husaini Zulkifli (2):
>   mmc: sdhci-of-arasan: Fixed kernel-doc format warning
>   mmc: sdhci-of-arasan: Change code style of mapping the syscon field
>
>  drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
