Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E74C433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828EA61458
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 11:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhEGLiM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 07:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhEGLiM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 07:38:12 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0F6C061574
        for <linux-mmc@vger.kernel.org>; Fri,  7 May 2021 04:37:12 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a12so2721037uak.6
        for <linux-mmc@vger.kernel.org>; Fri, 07 May 2021 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyChXpuA/kSLwdeCBlyI+kJA5Xo8psj95tLmSt5tQDQ=;
        b=v5LbZlXrh9EJ5XAwnkJG0BVtwXwBQGUaSCAF+FfH1jOKQjup501XDXXvWCO2XAJe1X
         JJ36tUfHaSW4sfJ/GjtCqBdLb0nrFbvyx0dKp6uiY1UCVYjJFM2phclXesBeW/CPFkmP
         q1UJQbEVwrL12Dxk7IZ0wsRH/YXp10GcQZs6kSjn9UiYs68rR+ZvgC741d1KaWXdgAMy
         5oDzR/M77Mz60nKOhWL394U1o6gUQbbeodN1RojHtm9Ur8YQBYJj2f7kWJH5K6t+lumY
         6xhv4BRa/n2Ao+Fgg09kxwX8gpJp4OVmLFDMNEuxnWRkGEsuo6snXxubI3Gfo9WyDJdc
         oelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyChXpuA/kSLwdeCBlyI+kJA5Xo8psj95tLmSt5tQDQ=;
        b=Ko0AMKDlrbvjYc7cOur58af2s7BPBqgXPh5F5/X1HO7oMfgLTTz6gS+sTkw1aMkJXB
         GZCC1ugf9sbpWDTaZk8e5wIgi5HNW+EMwrzzL7Id2yaBkkjWkdMtrXMkHiiNL2ySLCWj
         zxQJTN4auz6nrwIgp+43MUwLBMxqsBn5NebNdSRhdJSZGlVmLumUrXH7sFIFHPto+0mD
         Eg94kO3prNvRREaB048jQlY89R/SW/zw44XU2MyYNAFROGTDU3bylV6aVKKTGdHFJebm
         7acsIpSLd/2R8bAEVUzt0WJq1m+JtvIPu+h51nm+zgygf0b3I7uNjPVeyGKCJoRfFzDe
         zzug==
X-Gm-Message-State: AOAM53215WNysQqzlhUwlPfkw2v3zV60KOKFlvW7Xo7b1vrKqtsOVyBo
        1hHxDgBksIkyEcOCpZ87DVvpBNA6e300PVDMcFee6A==
X-Google-Smtp-Source: ABdhPJwv8zOe31Be3NCYiFdqIeS6UkgQw+8Blad7NIo8x5T24NV9F1KesqSySUVg6Cq8XsJJezltksCfFV9siriNGjY=
X-Received: by 2002:ab0:7002:: with SMTP id k2mr8193127ual.104.1620387431887;
 Fri, 07 May 2021 04:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-10-ulf.hansson@linaro.org> <1a4227c1-4d55-b55f-2fc6-9f9562ef02e5@rock-chips.com>
 <CAPDyKFqVuuVnntRHQ-8hWjyJ5Kzj9DzkjQ=mknQxzRTH1og+xw@mail.gmail.com> <dc1d03ed-c8ab-468c-e602-938e92322fa8@rock-chips.com>
In-Reply-To: <dc1d03ed-c8ab-468c-e602-938e92322fa8@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 May 2021 13:36:35 +0200
Message-ID: <CAPDyKFogv5j-UR=20nKVdSpCDSNb0tkH2shPrLcd1tFdOno6BA@mail.gmail.com>
Subject: Re: [PATCH 09/11] mmc: core: Read the SD function extension registers
 for power management
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 7 May 2021 at 09:48, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> On 2021/5/7 15:27, Ulf Hansson wrote:
> > On Fri, 7 May 2021 at 04:06, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> >>
> >>
> >> On 2021/5/5 0:12, Ulf Hansson wrote:
> >>> In SD spec v4.x the SD function extension registers were introduced. A
> >>
> >> I have a v4.0 spec and it doesn't state that v4.0 suppports reading
> >> extension registers but just says TBD instead.  So I guess v4.x doesn't
> >> include v4.0 ?
> >
> > Good question. The v4.0 spec introduces the CMD48/49 and CMD58/59,
> > while in v4.10 the spec adds the power management extensions.
> >
> > I can update the commit message to better reflect this, if you prefer!?
>
> It would be better.

Sure, let me amend the change when applying.

>
> And I downloaded the latest v8.00 spec, checked carefully with the new
> features there to make sure we don't make any misinterpretations at
> first.
>
> For patch 9 -11 as well,
>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.con>

Thanks!

[...]

Kind regards
Uffe
