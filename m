Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B448DC4CECC
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 18:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C1720B1F
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 18:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXUgT4BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgD0SgE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgD0SgD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 14:36:03 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F684C03C1A7
        for <linux-mmc@vger.kernel.org>; Mon, 27 Apr 2020 11:36:03 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y10so18539205uao.8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Apr 2020 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xM9QjmpwYbkisRgg+9m3KKxSIRNSU7Z5AW0CFZxADU=;
        b=pXUgT4BBYjU7eXZo207JUZsU3pUdyE9dKL1mF7Do3uspZf/cO+6wRg05YOWJXZlkv/
         puy1OMkOOUYSmFDCdqg8foPpc57v7YjCzOt1JLFdijuOk+hddZ0gpu+qAh94YKsLoBx1
         R1n5j8CA7M5whL2MYKKdY2mOwGrpJ6wFY8fJtsQ7t7qY8VA3zRsXPKrpOc0XRZcC2SGH
         hjpbfKy036pJGTb35GPecBbKXrZ9f5pkpxEIbddKQokLimKOD0OF3GGUGwm1uShb4UhF
         jQcXmVBRDeVhh9kFLIEFicwnPvbC/YariFA5TYc3Di9PRAI1TtRiJj2V5UxgFusegIln
         x3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xM9QjmpwYbkisRgg+9m3KKxSIRNSU7Z5AW0CFZxADU=;
        b=rZwzJmQX0Ja9ewNMrfV552/DRUQr43/mye8bqfq79NpRuCs6UWYKBxUdWcV+GC/1A3
         oAJNCi06wD8Twqxj13H1hO2LTuBTL1LbDx7z9w1VmcVXMbMHkPn+4+oBgENWpBXBhbyR
         psVxsWK9If9mmWmU74z24q0AkODxB9x1pYkAmU9VMFI23SrdtyMOaZLdqCEFF5/wnFgb
         p/zFrp92ptDBbnQ4Uxkyuteyteqilc/RBfWIz7mFHfMobq1q5gPrXwVZFqPVpDwQeuU0
         a9LufREO1RSmX0JH8yU2hmvqfouBS/HVJJDytoPp9f1yGnjyAsx51OrYcFgeQwHtYTqb
         IotA==
X-Gm-Message-State: AGi0PubuPYw0VFX0dC0rG+CvYk5LOj8rnFlZEyJRl/dK145zN9Htx4M3
        1e1ecnrR8tZNtmB9HpJlneBilMfwVpTHRoRBOGSaUw==
X-Google-Smtp-Source: APiQypJNKdwylcthlxM+njJYVD9XtTTnPk4q1j17763v7R71x0bAw3EsHZ45/PbN0eX4zVscCJdVfvic8BQcRqzaqIM=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr18411294uam.100.1588012562614;
 Mon, 27 Apr 2020 11:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
 <1jblnd2tp3.fsf@starbuckisacylon.baylibre.com> <CAFBinCDzNw6nV3oBJs6C0sssW61GERBXq39DCM22BT9zS8M31A@mail.gmail.com>
 <1j8sig3mi3.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j8sig3mi3.fsf@starbuckisacylon.baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Apr 2020 20:35:26 +0200
Message-ID: <CAPDyKFrYNmCtX3KHaE1vw4rT45WdsUWKqOaJ43rJCKwsnY4PCQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Amlogic 32-bit Meson SoC SDHC MMC controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yinxin_1989@aliyun.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Jerome, Martin,

On Mon, 27 Apr 2020 at 18:46, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 27 Apr 2020 at 18:23, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > Hi Jerome,
> >
> > On Mon, Apr 27, 2020 at 10:56 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > [...]
> >> > Changes since v3 at [3]:
> >> > - split the clock bits into a separate clock controller driver because
> >> >   of two reasons: 1) it keeps the MMC controller driver mostly clean of
> >> >   the clock bits
> >>
> >> If the register is in the MMC controller register space and the MMC
> >> driver is the driver using these clocks, it is where the clocks belong.
> >> I don't get why it could be an issue ?
> >>
> >> Is the clock block is shared with another device, like on the Gx family ?
> > no, it is not shared with another device (to my knowledge).
> >
> >> > 2) the pure clock controller can use
> >> >   devm_clk_hw_register() (instead of devm_clk_register(), which is
> >> >   deprecated) and the MMC controller can act as a pure clock consumer.
> >>
> >> Why can't you use devm_clk_hw_register in an MMC driver ?
> >> Unless I missed something, it is provided by clk-provider.h, which can be
> >> included by any driver.
> > indeed, I could use devm_clk_hw_register in the MMC driver.
> > Ulfs concern was that a lot of code was needed for managing the clocks
> > and I agree with him. so this is my way of keeping those details away
> > from the MMC driver and have two separate drivers which are better to
> > understand overall.
>
> Martin, Ulf,
>
> I understand that CCF code might seems verbose and I'm happy to help
> review it if necessary but I don't think every driver out there should
> register some kind of fake clock controller driver everytime they wish
> to use CCF API.
>
> Yes the it might make the driver code cleaner but the overall
> architecture is harder to follow.
>
> CCF was made so driver from any subsystem *may* use it. Creating a
> controller for a single register is overkill. The HW architecture of
> this particular device does not justify it.

I fully understand your point and I agree with it.

If I recall correctly, my point in the earlier review phase was that I
wanted the driver to be nicely split into a clock provider part and
into a mmc host driver part. I also raised the point of using
devm_clk_hw_register() rather than the deprecated devm_clk_register().
I still think this makes sense.

That said, perhaps a reasonable split could be to have two separate
c-files (one for clock provider and one for mmc host), but both in the
mmc subsystem.

Kind regards
Uffe
