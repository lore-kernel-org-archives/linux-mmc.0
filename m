Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597BFC678D4
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Mar 2023 10:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCBKhh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Mar 2023 05:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCBKhh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Mar 2023 05:37:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B293B641
        for <linux-mmc@vger.kernel.org>; Thu,  2 Mar 2023 02:37:35 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p6so9526511pga.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Mar 2023 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DvH5++MlDywKUnWf+1loQwzv2jg1mWmFa8pnuwjqdM=;
        b=CArXlKRa5bv3qRQell+oUvTIEi+MvMAR9T9N3YQpRL12m7q0/lh+DQRBYtazTeLamN
         q7z8p5r31Dfjqp3wg350PMMy+EN5mx2LMQ40lZHYsWL9Md8HmIvksmp9QzpRoPA6tXJw
         +OGzhmJ/UBcbM3aHt/WTCtQGywfYhiGNJ8gVrSfBJfGWxSOepjgSyz9gtcJm9q22UUGn
         0B3n1KjzjWM4PkN21PNaE/ZHxsDqkwVaud1pRpF2o52WavI8OYG5qh3oV9tB+GXGW0XJ
         g5ZG3VWgzvRIzScqpqhOF9zm4PaOgC1lWUkq/Cr+GMsLPGRXJl7duV3TIFKTvXQWIyvF
         gImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DvH5++MlDywKUnWf+1loQwzv2jg1mWmFa8pnuwjqdM=;
        b=P2GU7PgrxOiiplu6gJGEYID3EUslyOmjrtu7dAKfHNcWWQUjyNx5rFtmKHZGUZgww1
         v/iizFDsdLvD/9EH/bDfz2zSe0wmGi+hFbRbplWrrI2xKQtp8wmZpRo6IaUWJNGXVHmg
         gnG59j8t2W+cJbJYtgXaUJslUWIhKyrXBeM1PRQjwS4rgZpsos70e3itVRkMTw0m8cR3
         QbqM73s+iM2Vi+YsYMJnLySUc0Xm2l7k4RsHgNJiT/xAA0mVU3ULvSxwgYw62KOhnR55
         cn1eN/3Z5bF9pxG19N1Qiz4QOk/eokmalABFUuK3t75CmpTWhbfP1MPJ9erW84/HqoFp
         7icA==
X-Gm-Message-State: AO0yUKWyW5uIV3BIAOSIHGBhHSbXYP3P1OmbwY9yxiWa3KIdzA86A1+K
        nY0D+0r5BbsdwAnPY0iXJpIMfuAKv7i9ciNrzdHksw==
X-Google-Smtp-Source: AK7set97u0zAstt60brd/DEvp8rkt1vEK1Zs7cBKJ8KNFM0kwIC9D72SwDaTRtCCYH7xz1TcI3XO17bEKAKts14WXxE=
X-Received: by 2002:a63:b21b:0:b0:503:a8:2792 with SMTP id x27-20020a63b21b000000b0050300a82792mr3273725pge.5.1677753454377;
 Thu, 02 Mar 2023 02:37:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2SC_Q3RWdeO9-mKDYC_TK8_vzefvGz_++O8StJer_h3Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU2SC_Q3RWdeO9-mKDYC_TK8_vzefvGz_++O8StJer_h3Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Mar 2023 11:36:58 +0100
Message-ID: <CAPDyKFq23_vCunapQ=OHFFGXs5a8_cr8w7hBUP=HQ5f2zaTBUg@mail.gmail.com>
Subject: Re: mmc: core: Disable card detect during shutdown
To:     Tim Harvey <tharvey@gateworks.com>,
        Robert Richter <rric@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Jan Glauber <jan.glauber@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Robert

On Thu, 2 Mar 2023 at 00:32, Tim Harvey <tharvey@gateworks.com> wrote:
>
> Greetings,
>
> I've encountered a hang on shutdown on octeontx (CN8030 SoC, THUNDERX
> architecture) that I bisected to commit 66c915d09b94 ("mmc: core:
> Disable card detect during shutdown").
>
> It looks like the OMP5 Pyra ran into this as well related to a
> malfunctioning driver [1]
>
> In the case of MMC_CAVIUM_THUNDERX the host controller supports
> multiple slots each having their own CMD signal but shared clk/data
> via the following dt:
>
> mmc@1,4 {
>         compatible = "cavium,thunder-8890-mmc";
>         reg = <0xc00 0x00 0x00 0x00 0x00>;
>         #address-cells = <0x01>;
>         #size-cells = <0x00>;
>         clocks = <0x0b>;
>
>         /* eMMC */
>         mmc-slot@0 {
>                 compatible = "mmc-slot";
>                 reg = <0>;
>                 vmmc-supply = <&mmc_supply_3v3>;
>                 max-frequency = <35000000>;
>                 no-1-8-v;
>                 bus-width = <8>;
>                 no-sdio;
>                 no-sd;
>                 mmc-ddr-3_3v;
>                 cap-mmc-highspeed;
>         };
>
>         /* microSD */
>         mmc-slot@1 {
>                 compatible = "mmc-slot";
>                 reg = <1>;
>                 vmmc-supply = <&mmc_supply_3v3>;
>                 max-frequency = <35000000>;
>                 no-1-8-v;
>                 broken-cd;
>                 bus-width = <4>;
>                 cap-sd-highspeed;
>         };
> };
>
> mmc_add_host is only called once for mmc0 and I can't see any printk

That looks wrong. There needs to be one mmc host registered per slot,
otherwise things will, for sure, not work.

I suggest you have a closer look to see what goes on in thunder_mmc_probe().

> debugging added to __mmc_stop_host (maybe because serial/console has
> been disabled by that point?).

The serial console should work fine at this point, at least on those
systems that I have tested this code with.

Perhaps you added the debug print too late in the function, if the
calls to disable_irq() or cancel_delayed_work_sync() are hanging?

>
> It appears that what causes this hang is the 'broken-cd' which enables
> the detect change polling on mmc1. I have the ability to flip the CMD
> signal routing thus making mmc0 the microSD and mmc1 the eMMC and when
> I do that there isn't an issue so I think what happens is in the case
> where mmc polling is enabled on mmc1 but not mmc0 (as above) the
> polling causes a hang after __mmc_stop_host() is called for mmc0.

The code in __mmc_stop_host() has been tested for both polling and
gpio card detections. That said, it looks to me that there is
something weird going on in the cavium mmc driver.

What makes this even tricker, is that it's uncommon and not
recommended to use more than one mmc slot per host instance.

>
> Any ideas?

I hope the above thoughts can point you in a direction to narrow down
this problem.

>
> Best Regards,
>
> Tim
>
> [1] https://lore.kernel.org/all/55A0788B-03E8-457E-B093-40FD93F1B9F3@goldelico.com/

Kind regards
Uffe
