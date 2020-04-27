Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC33C54EEB
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 19:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE39C21835
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 19:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VAfe08Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD0TbT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD0TbT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 15:31:19 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3193C0610D5;
        Mon, 27 Apr 2020 12:31:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s10so14423924edy.9;
        Mon, 27 Apr 2020 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCBHygv2Dz+zd+RKARK5K2miMNYjk565u4hnFpBMvlI=;
        b=VAfe08BfrA1Ts8YeU6qdFauAw/FLbzlElIcsPCrEesK+v/47PeU9ndhqzfCOU4c8zb
         SOMm+seRIfUVRMnBGCmDHKbdUhEcs2KIsIoKsTg//vmAWez0476KZQFd3qulfSbq1/a2
         hYkWJxzov7yXvJYiu/B3x0MdHd5peO36/Qf1O246U5YG2AUtymDGxGNcGCLSdn1az12B
         urZzNVEDGuTXRUDhHqgGvkAxOfR1ZmNVc5YWUSQQ48UZNFUbUlmiyiD1LjE6S9RoYtye
         5jON7spJZUBz5mxVGGUEQfh0hfXLY6gWQnFi18XZkz4Pqsj9cd+sino6Zd3YAqJOkT9t
         Kk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCBHygv2Dz+zd+RKARK5K2miMNYjk565u4hnFpBMvlI=;
        b=GGtQXlODO2qA6QJeqJrP1WEGHvgeANpczx5jNKrMWS6ACJVivikDvGvQVamyzSqQL2
         WH9R3L821+8r38uK/4/XcEEgd5RZl+jpJTCDDTFH6hi4SVxTT048Kd2Mw85ZTCYexzBa
         VUsv/bSOGv0zte1IItFK/0mCK9L7y1uHY8haj3TPKFtvoqJ5hiCSHRZZkGuDXaL7vAs2
         afaHPWoK+qvM5Al5l9+bN3+EdCUzFfokDM3bW+avw3HeCJD9+cKUVg/ofZZDW5to8WW6
         Q8vDcBAPvYODky9l61DC/cVPtDzlCPwhb54evz4QnNbR9/TC1tF/NXUdQ623hZNd/QEq
         b3vA==
X-Gm-Message-State: AGi0PuZj5lLd4XykvMZ+36OdIosvaUR3B7n2FbvBSpBZliUUtoyP78aB
        q6akexrjojBAOasNTNI5n4u8TuLQnty5B2iSeUY=
X-Google-Smtp-Source: APiQypIJfTQsCgvehtZ278338B1P8XoCCOZdJgf9HibFmV04ATXeExxGGygEU3y4vpwfiwUWn6qtGWILmY7bDmXM+XU=
X-Received: by 2002:a05:6402:1d15:: with SMTP id dg21mr20520944edb.13.1588015877271;
 Mon, 27 Apr 2020 12:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
 <1jblnd2tp3.fsf@starbuckisacylon.baylibre.com> <CAFBinCDzNw6nV3oBJs6C0sssW61GERBXq39DCM22BT9zS8M31A@mail.gmail.com>
 <1j8sig3mi3.fsf@starbuckisacylon.baylibre.com> <CAPDyKFrYNmCtX3KHaE1vw4rT45WdsUWKqOaJ43rJCKwsnY4PCQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrYNmCtX3KHaE1vw4rT45WdsUWKqOaJ43rJCKwsnY4PCQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Apr 2020 21:31:06 +0200
Message-ID: <CAFBinCDPkdRF4RJ+AL0TvjKzxJ4YP_D4XmGg1dp4LmtRyL-o8A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Amlogic 32-bit Meson SoC SDHC MMC controller driver
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
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

Hi Ulf, Jerome,

On Mon, Apr 27, 2020 at 8:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Jerome, Martin,
>
> On Mon, 27 Apr 2020 at 18:46, Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> >
> > On Mon 27 Apr 2020 at 18:23, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
> >
> > > Hi Jerome,
> > >
> > > On Mon, Apr 27, 2020 at 10:56 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > [...]
> > >> > Changes since v3 at [3]:
> > >> > - split the clock bits into a separate clock controller driver because
> > >> >   of two reasons: 1) it keeps the MMC controller driver mostly clean of
> > >> >   the clock bits
> > >>
> > >> If the register is in the MMC controller register space and the MMC
> > >> driver is the driver using these clocks, it is where the clocks belong.
> > >> I don't get why it could be an issue ?
> > >>
> > >> Is the clock block is shared with another device, like on the Gx family ?
> > > no, it is not shared with another device (to my knowledge).
> > >
> > >> > 2) the pure clock controller can use
> > >> >   devm_clk_hw_register() (instead of devm_clk_register(), which is
> > >> >   deprecated) and the MMC controller can act as a pure clock consumer.
> > >>
> > >> Why can't you use devm_clk_hw_register in an MMC driver ?
> > >> Unless I missed something, it is provided by clk-provider.h, which can be
> > >> included by any driver.
> > > indeed, I could use devm_clk_hw_register in the MMC driver.
> > > Ulfs concern was that a lot of code was needed for managing the clocks
> > > and I agree with him. so this is my way of keeping those details away
> > > from the MMC driver and have two separate drivers which are better to
> > > understand overall.
> >
> > Martin, Ulf,
> >
> > I understand that CCF code might seems verbose and I'm happy to help
> > review it if necessary but I don't think every driver out there should
> > register some kind of fake clock controller driver everytime they wish
> > to use CCF API.
> >
> > Yes the it might make the driver code cleaner but the overall
> > architecture is harder to follow.
> >
> > CCF was made so driver from any subsystem *may* use it. Creating a
> > controller for a single register is overkill. The HW architecture of
> > this particular device does not justify it.
>
> I fully understand your point and I agree with it.
>
> If I recall correctly, my point in the earlier review phase was that I
> wanted the driver to be nicely split into a clock provider part and
> into a mmc host driver part. I also raised the point of using
> devm_clk_hw_register() rather than the deprecated devm_clk_register().
> I still think this makes sense.
>
> That said, perhaps a reasonable split could be to have two separate
> c-files (one for clock provider and one for mmc host), but both in the
> mmc subsystem.
I'm fine with that - I'll do that in the next patch version
I believe the amount of changes will be small because the clock driver
already uses devm_clk_hw_register()


Martin
