Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF6C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 21:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF01207DA
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 21:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pw5Xo2UH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHUV5d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgHUV5c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 17:57:32 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD0C061573
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 14:57:31 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e14so1567804vsa.9
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ea41IW4FRO1fiOOu+MNwgvHwUn7WCVWJ5tD03OQqvkM=;
        b=Pw5Xo2UHWDlSgrbQcxG+BrXhrL8Z7LLa8uwTq8y+Hb1n8SJqnVEDUsHacaTNt4Ydqh
         Yz3ur1h9GYoyAOKh/BX7HR7DSFCZbutB6vW8ua4cqQBj/FpQD59/tn5UVneBsUi0ReXK
         VqMRERyzHLqQqJtLROcsChQGNqGAXQYUelANpt01zRg1n5wSfIGaO97oV7/+/F0wc5qZ
         OMWTB+Ka45i+5TQE/MYqK22KlP/ApUJCjEKwh0cayaOCdZX3B9gCeHFfGPbIaXnc77hE
         vXiIeE2friHSLAONaBtMlTkqp1/nUiinZSMw9/CzpFRPYTAy5hcdpmN0rkwqj+7oaifE
         WoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ea41IW4FRO1fiOOu+MNwgvHwUn7WCVWJ5tD03OQqvkM=;
        b=f1cML9zSTTjy2gw1YZl+23+5E0yfaowPmontiPCoJaaGc4xsWg/G8W7Hw1DXLgeNyd
         lw6AnYJytUiIY5ZzfWY0rPM25/thz63wo3vRG+xaAvaDFAdTZDydqxit6Nmasl6TaLX8
         XSHDBc5RPbxx2lFkAEK3UCbUGhn2xZ4V627sAzBXD3nbD74q/oKw33ey01Nrtm9g7Gnm
         jWKxoCWdBDE1MyCfZQ+d+Kr4dS6bNHQV55OyizdaxKzEBJVnIf3IhiXRBkq+hzC/B2e6
         n4BmvQGdX/qOlw0OyYl8SYm2ZTlmWPj9z8eHIroizvYUlKLR49ILar13z0iCKzAiORQv
         m3yA==
X-Gm-Message-State: AOAM531ta17KayLdLppA+PweRSJLVm8JN3OptLgRs6anbkUh2v5H6pnM
        +uDxPGNTDf6ygvZwziz6ys3O4ylaWRl4tH3DuHMA2cL1aB8NIg==
X-Google-Smtp-Source: ABdhPJxIbsHfva0t8MC9x0VZDf4ULSJcLPSdTF7LyvZ5vYS9dGrRQdcNDwYmfpQUh9Z5N+rsDRn4F2T/8VDA3SYlu4c=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr3266310vso.165.1598047050532;
 Fri, 21 Aug 2020 14:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200819125832.v2.1.Ie8f0689ec9f449203328b37409d1cf06b565f331@changeid>
 <CANMq1KC3BC4bbh9YF1r3nfOAJgQp4mVZJ11_77cwFJY9fGK-Dg@mail.gmail.com>
 <CAPDyKFoHW=taANc4UZU7spGghn8ASo+2VOiEVPNRh9URdeyQpA@mail.gmail.com> <CAHQZ30BW4YMzK9KUOHP8wV49Yw0UG_PZY6UdaQZdQRdMYFjFwQ@mail.gmail.com>
In-Reply-To: <CAHQZ30BW4YMzK9KUOHP8wV49Yw0UG_PZY6UdaQZdQRdMYFjFwQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 23:56:54 +0200
Message-ID: <CAPDyKFqRNQaNVw5WL1jxKE5gnfcKbm1e_bzEgnP--arvNJezXg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Wang, Chris" <chris.wang@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 Aug 2020 at 16:31, Raul Rangel <rrangel@chromium.org> wrote:
>
> Oops, what was embarrassing! Thanks Ulf for removing it. Thanks Nick for caching that.

No worries, we all make mistakes. The important thing is that we take
good care of fixing them as soon as possible.

Kind regards
Uffe

>
> On Fri, Aug 21, 2020 at 3:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Fri, 21 Aug 2020 at 02:24, Nicolas Boichat <drinkcat@chromium.org> wrote:
>> >
>> > On Thu, Aug 20, 2020 at 3:00 AM Raul E Rangel <rrangel@chromium.org> wrote:
>> > >
>> > > The AMD eMMC Controller can only use the tuned clock while in HS200 and
>> > > HS400 mode. If we switch to a different mode, we need to disable the
>> > > tuned clock. If we have previously performed tuning and switch back to
>> > > HS200 or HS400, we can re-enable the tuned clock.
>> > >
>> > > Previously the tuned clock was not getting disabled when switching to
>> > > DDR52 which is part of the HS400 tuning sequence.
>> > >
>> > > Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
>> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>> > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Applied for fixes, by dropping the trace_printk below, thanks!
>>
>> Kind regards
>> Uffe
>>
>>
>> > > ---
>> > >
>> > > Changes in v2:
>> > > - Added static to amd_sdhci_execute_tuning
>> > >
>> > >  drivers/mmc/host/sdhci-acpi.c | 68 +++++++++++++++++++++++++++++------
>> > >  1 file changed, 58 insertions(+), 10 deletions(-)
>> > [snip]
>> > > +               /* DLL is only required for HS400 */
>> > > +               if (host->timing == MMC_TIMING_MMC_HS400 &&
>> > > +                   !amd_host->dll_enabled) {
>> > > +                       trace_printk("%s: Enabling DLL\n", __func__);
>> >
>> > Please do not use trace_printk in production code [1,2], it is only
>> > meant for debug use. Consider using dev_dbg.
>> >
>> > [1] https://elixir.bootlin.com/linux/v5.8/source/kernel/trace/trace.c#L3158
>> > [2] https://elixir.bootlin.com/linux/v5.8/source/include/linux/kernel.h#L766
>> >
>> > > +                       sdhci_acpi_amd_hs400_dll(host);
>> > > +                       amd_host->dll_enabled = true;
>> > > +               }
>> > >         }
