Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC8FC07E96
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCE061580
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 12:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhGHMPE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhGHMPD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2021 08:15:03 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD4C061574
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jul 2021 05:12:21 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id e9so1956887vsk.13
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jul 2021 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74IJmH2QOykPmJGuffsoKEUZ/+2Y969fvLtQrP2crS8=;
        b=qsUzl9LuVVs31f2p2N+5FDKJIVdBSGTKmilQcBklUBWzcfLxem9wLrc5JqbrUk8ItT
         ia5nwKG5PLcGSh1vFhOE3SJGs4l4jRSUjlrPmKuSJoT3UFUghN3OS5U3+NOuFufDnQD9
         Rvo/Y7GwXNgACHTD0Rd0VpOZthsXsvi8/MSZe9A9Xw+4T9UOppfwzi2qdbQ/EtAxBxW6
         0fcHXGKYP+wP+Di4elb5VFNdAL+cZoP7Zd4xCvGw1ctVhUnOmXdbcd1+gve2ZgFeilNW
         d84Jbdb059jMbfBs6+ZCXn/XPouW9sjUNt0zy2bHtzjmruzkxSYKJQkXsIPgSjC2gS2J
         L2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74IJmH2QOykPmJGuffsoKEUZ/+2Y969fvLtQrP2crS8=;
        b=KSW65H6Z2sxtoo2trr4hCOqrzytA0VEjG5f5Yl5jNCjsJqmw4ZwkEXVL4nTf2r61aJ
         yDbHqAnvsDTUXi+anWpiiS+NZhvZ739hgjxozzfmL045R5S3zuWIlzEt02DlTirc/aZJ
         KDImKC+96WaOXDgn7Y5Pn1Sas4NQuDrhOmbeC0PLJvlsUv2Kvjoun48lflYyk/C+KzKP
         iyUsL2zBkealhIPsFLGOIWWFNwX5ZCax0eYpqROvy0Vx2lUzPIeQ2EsiA1cIShac7y1N
         7iWPrI2B2dWsb4TGBTTFb45iN+2/j+q3ODGzwgm+r/27eBAlKg8TFZbAIXl1h4baoqYb
         isKA==
X-Gm-Message-State: AOAM533HNmD0zmWQbCYXRf9foUEAtQKVEj3bIDmgYkLMSraoSKEn1EQS
        NYy4d62gd5qbVf+7P5zeRXgtTe7xntA8Uf617xddCA==
X-Google-Smtp-Source: ABdhPJz5qXBkYjOlV4N1RGqbTLijRshQKc1z2Yw7EU94BW5+ZsEbGwsZEibUUF8kltbRyJggYBt0M7qyOrdXOwn24dc=
X-Received: by 2002:a67:ee54:: with SMTP id g20mr27453162vsp.55.1625746340485;
 Thu, 08 Jul 2021 05:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210623075002.1746924-1-swboyd@chromium.org>
In-Reply-To: <20210623075002.1746924-1-swboyd@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jul 2021 14:11:44 +0200
Message-ID: <CAPDyKFozrrtwOEzBeKctD5fRM=D0dg9N=kFsvdXXDO-zD51Diw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Two mmc fixes for IDA and KASAN issues
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Jun 2021 at 09:50, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Here's a followup to a thread I sent a couple months ago[1]. They're only
> marginally related to each other, but I have bundled them here into one
> series to make it easier to track. Resending to restart the discussion.
>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Sujit Kautkar <sujitka@chromium.org>
> Cc: Zubin Mithra <zsm@chromium.org>
>
> [1] https://lore.kernel.org/r/20210413003621.1403300-1-swboyd@chromium.org
>
> Stephen Boyd (2):
>   mmc: block: Use kref in place of struct mmc_blk_data::usage
>   mmc: core: Don't allocate IDA for OF aliases
>
>  drivers/mmc/core/block.c | 35 +++++++++++++++++++++--------------
>  drivers/mmc/core/host.c  | 20 ++++++++++----------
>  2 files changed, 31 insertions(+), 24 deletions(-)
>

My apologies for the delay! The changes look very good to me, thanks
for helping out!

FYI, I did some more thorough analysis of how the block device
reference counting/locking should be managed, from a generic point of
view. Your change in patch1 fixes the immediate problem with the KASAN
splat I reported, but also moves the code in the right direction.

However, there are lots of additional improvements that deserve to be
made (another possible KASAN splat) for this related mmc code. I am
looking into this and will keep you posted. :-)

So, this series is applied for fixes and stable tags added for both
patches. Again, thanks for helping out!

Kind regards
Uffe
