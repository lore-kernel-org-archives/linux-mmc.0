Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50C5C4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93F160F6F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhHDLfn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbhHDLfj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 07:35:39 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BEDC06179B
        for <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2021 04:35:26 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id b138so828258vsd.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2021 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InP9peXlbtO4mCujwrny7kM0O4CUejd3WqIqrBu9ksc=;
        b=o68yKhc9ieL+VmBlW63oQ8KmiqHu0FYv9FpbS6zYFsgRfcJQHcACeSJUOl4VAq9YOt
         YlSDDhs1zO5s9IPU1Fu9n5SZyw1yKJxmGljdQJIV+CJNfy6IcWx+azo2mN/rgB/B8CFI
         TpJufHSABZZjmLkERZAMy9Va8tjyxbbXpbzDibecxNtw8tmj5QCiNADDpGr1pXxJU0P8
         2jSNLnPqvadEU9Bk1GJjk8sIZbxiozy9Ic9E4O3um6zvJ2d12wod0bj/Pw/8w2k2HcUn
         TJf1lVXF3s9gFF8CNH/Uc7uPq5FWPto4cKMvAFpL5M1res+bquhtTUp98b/exyb3ctH+
         6Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InP9peXlbtO4mCujwrny7kM0O4CUejd3WqIqrBu9ksc=;
        b=jwb59ZNJmR7ShmrUsfHKLjVl8HOgPyE4A61rF4UnvSd6BBkWCFWGsypu/7Wgw5Mjr7
         fDESILF0pvEvN0cX1tq+eUGGhcpsDGFh//UeU0j2wvBWWQRzpDrIpWjMQQnES8qrzz45
         6A6Q/B6RRh7N49FQrMN7W+3oj2s8z3L6y6A5pmMhyPwsqTBINhdVAdaL69HumVgTf/fa
         N8vvo13bDLK2Fa0s1RoLdj1kjVG6CPqnGBygSaKf/nYtkvk5IjtaGvcpt8gfOZ/rRAhg
         ioxRiqmvfZum+3jmw7k9mxjtI3VO5j0aQ0sXZ5NAiL2dAcfaS+DfDYzEodTmZGcbWKVE
         TIeg==
X-Gm-Message-State: AOAM533QDAZESnifLM8A/n8thoNIvi+hzdUmW3zIq3UdkrgC6+T5Q4QX
        bDY6oVnGBJVGcCRJtLUMcAJ4YV34K3IAR2cjxk2yJZ7VuyjFPA==
X-Google-Smtp-Source: ABdhPJwjxMMu79egWeArYZVYGe8Sfh77udOSKtpAPVikzuZZeFQt/iS4OaDskliFjW1aRgdUNHIkNA27PrDj9G34X/E=
X-Received: by 2002:a67:7c11:: with SMTP id x17mr5354731vsc.55.1628076924623;
 Wed, 04 Aug 2021 04:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210702134229.357717-1-ulf.hansson@linaro.org>
In-Reply-To: <20210702134229.357717-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:34:47 +0200
Message-ID: <CAPDyKFo78aJgcajxL6fcPb7xB16R_S6VyuwEp7tG84+CPSkKTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: core: Avoid hogging the CPU while polling for busy
To:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christian Lohle <CLoehle@hyperstone.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Jul 2021 at 15:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Step by step, code that have been dealing sending CMD13 to poll the card for
> busy, have been moved to use the common mmc_poll_for_busy() loop. This helps to
> avoid hogging the CPU, for example, as it inserts a small delay in between each
> polling attempt. Additionally, it avoids open coding.
>
> This series takes the next and final step, by moving the mmc block device layer
> from its own busy polling loop, into using the common code.
>
> Please test and review!
>
> Kind regards
> Uffe
>
> Ulf Hansson (3):
>   mmc: core: Avoid hogging the CPU while polling for busy in the I/O err
>     path
>   mmc: core: Avoid hogging the CPU while polling for busy for mmc ioctls
>   mmc: core: Avoid hogging the CPU while polling for busy after I/O
>     writes
>
>  drivers/mmc/core/block.c   | 74 +++++++++++++++++---------------------
>  drivers/mmc/core/mmc_ops.c |  5 ++-
>  drivers/mmc/core/mmc_ops.h |  1 +
>  3 files changed, 37 insertions(+), 43 deletions(-)
>

This series has been applied for next. If you encounter any
regressions (performance related as well), please report them!

Kind regards
Uffe
