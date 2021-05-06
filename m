Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E27C433ED
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E36613C5
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhEFMva (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhEFMv3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 08:51:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E592C06138B
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 05:50:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 124so7621588lff.5
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ih4+p3zLbJgKbtyGHTBqIMZl1xrskHK8H9INh+Uv4Q=;
        b=tOVCF1VosorbmnojI82fLeeHSIKUGSQH/nyYU/9ksMYfnCNNk2WPdG6ay/mpoSJmoM
         LshYTzx//dMlid0bY/5z0+7Z7hG/1nZGsU1JgTerosNm2lPILJiPmxtQyBHTAK5K+1AU
         A74pBMjCDOnEpS6zXJLq5N9YkF6B4uk790O6cby6esqWbZS2qIihy0rgkg/oL8j5lk9E
         SERTcIDzkqSXuDPFC1z5cLQLpQYjgreb5Q4En7GoRGdQ4UnUpdKrZ8nmYj5yD6QA+fRQ
         lfATfeTiCPEZnx7QJrwGjflZxs9eOb4FVSEGGuxPImV0SOsOayxsGZAL81ftjfobmfUy
         LRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ih4+p3zLbJgKbtyGHTBqIMZl1xrskHK8H9INh+Uv4Q=;
        b=KRLsUgFVyBd7DytBzI2Dt5pIWqfy9qghkZ66IFcIQej/1omqHTdg/HmDbRW+kM53L6
         Qhe97IvNG7CPsO2oR+An6lfajK3GgGUlkuh+LtFKNWC9KQ9wsEQxCfLHAKy3Gmcw5OWr
         YUzJ3EvcWLeZJLv4vC6je3JOfwmz7RyQkKjxbbZtpNym6vrGk/4Gz05e/n8q3ZgEB2k/
         H4jBAfp/odaUKc969/ktNQnYl3saO6+27Wn+6/XM1l4xmvRsVfQtAcXkSGuph01pABef
         UgKuAHHdXJ2AXP+6AuDw+LCRAvqKbrCBj+N6z4fiYCWD/K9OFsovELG0J6VTogUaf9Hu
         tRVg==
X-Gm-Message-State: AOAM5304sF4ptOiVCbYCahtCmck8bojVaTOwm7X4rR0VBNJ1CHmUYgwy
        CHWprHPPkk9/YbvutjRqYhbURWN+gHVxDgt+B3Z6Ig==
X-Google-Smtp-Source: ABdhPJzE0Z+zj23Q02inSzPqU6dizoYqkz7PVA6JO3I+kCwKxDGAnYJLv5iu6gj3sJSx5oylXPN9Gz/3NPn+3xWHDF8=
X-Received: by 2002:a19:a418:: with SMTP id q24mr2665011lfc.649.1620305428769;
 Thu, 06 May 2021 05:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-2-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-2-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:50:17 +0200
Message-ID: <CACRpkdYbsfVDrTpMa6P8uia0McQD2KhSKQVA-jh84ZPwBS3C6Q@mail.gmail.com>
Subject: Re: [PATCH 01/11] mmc: core: Drop open coding when preparing commands
 with busy signaling
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Similar code for validating the host->max_busy_timeout towards the current
> command's busy timeout, exists in mmc_do_erase(), mmc_sleep() and
> __mmc_switch(). Let's move the common code into a helper function.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This is a really nice refactoring in its own right.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
