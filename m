Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C84C636CC
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 11:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjBPLOy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 06:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBPLOw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 06:14:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB32A6D1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 03:14:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id r17so1212287pff.9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 03:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Avjd1bSEYKBQwiRvP4rk5Jz5oyYwjLMshH18syYNq5w=;
        b=q1uY/Gu9ekbGw6hR893QCGaPMNAg9e6rZrsqIVmLBZPMPvMv1e7cvQZnW7ll67JAv9
         qrekBncHqxl/kpnyJY3U1H6RK0ju6WQi+/nbWjntgoHbij22DP6/9r42E5eLJj1tCh9v
         HE/L16XXH2eunjWebl76ACP0flcFcAJRlzHaxtgbyUle7Nc896L3sZ5YrIGNj3sB3kMb
         WLEjWF270rOLYzJAEihSGF4l4kxHZ4pFtkJ3+4Q0+TVWbhJGwO+qfYrbCFHkE57/XzPU
         CgJoLKFrEyAaiXKUcsuSiBR9AMDkmHWNHjN2W6XMwautll89kBNvNG04Yyxab0mYTIPn
         Qy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Avjd1bSEYKBQwiRvP4rk5Jz5oyYwjLMshH18syYNq5w=;
        b=WEARNbrbw1+qi+dRGdrncEKGM+P50Zhvjp9WCrTDgO9iFooO+9ZpzLfblC0I7MrCx6
         OQz4rduCFX2eJJuL1pvfKrxIz2IjHhyjft8S9p75qbFWljJC8Be4khRwcPukfsd+3JYq
         nIg5DG62qadoj8CocgvVpFHWgFDexMHKXeuwFHS0mfQfQq/plCL6BlFSl7Ja+pWooH9b
         hTH/2obGeXDJ9pKsfcAUIudqxZhzSgDc7Bj4pbQYpZ6OB0whEbI3R6AEKGUC6MaNYMWW
         TcQeGPxtttBosT+kZoO2eFBR/h+r0YXmrSxb5fIKW4l24RX/2vqXeqawYnS1073vXKdS
         Etlw==
X-Gm-Message-State: AO0yUKW5K7ajcgWcWzJm6AbHmskGbK+s2B27kDonU2UEbIWycLR+/sYZ
        essHBMSuUri6uGqfQ3swhxCMG8JHGjJ1x+aI7YmOFg==
X-Google-Smtp-Source: AK7set9jfIQb4YfFa1aI3LxnksHzAibjPxuDbZDPL2EwpTo+AnXmUsqWbePsGPMjqBdeGZEbrI+E1selRjGfj2UlJzE=
X-Received: by 2002:a05:6a02:28c:b0:4f1:cd3a:3e83 with SMTP id
 bk12-20020a056a02028c00b004f1cd3a3e83mr233413pgb.3.1676546089229; Thu, 16 Feb
 2023 03:14:49 -0800 (PST)
MIME-Version: 1.0
References: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
 <CAPDyKFroB-TULOeia4OyXBW6rWMs7e3_Fp4Uw878Q8Gt=TDfag@mail.gmail.com> <48b4a87a-c5e9-c3ec-2492-bb2afb495398@linaro.org>
In-Reply-To: <48b4a87a-c5e9-c3ec-2492-bb2afb495398@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Feb 2023 12:14:13 +0100
Message-ID: <CAPDyKFoWyPHV2_EgxLrDu8EPVsS1gtTfdd4=QnsEuMr9wvGeJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: support setting card detect interrupt from
 drivers and use it in meson-gx
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Feb 2023 at 10:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/02/2023 13:48, Ulf Hansson wrote:
> > On Tue, 14 Feb 2023 at 22:39, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On certain platforms like Amlogic Meson gpiod_to_irq() isn't supported
> >> due to the design of gpio / interrupt controller. Therefore provide an
> >> option for drivers to pass the card detect interrupt number
> >> (retrieved e.g. from device tree) to mmc core.
> >>
> >> v2:
> >> - use another mechanism for passing and storing the cd interrupt
> >> - add patch 2
> >>
> >> Heiner Kallweit (3):
> >>   mmc: core: support setting card detect interrupt from drivers
> >>   dt-bindings: mmc: meson-gx: support specifying cd interrupt
> >>   mmc: meson-gx: support platform interrupt as card detect interrupt
> >>
> >>  .../bindings/mmc/amlogic,meson-gx-mmc.yaml      |  2 +-
> >>  drivers/mmc/core/slot-gpio.c                    | 17 ++++++++++++++++-
> >>  drivers/mmc/host/meson-gx-mmc.c                 |  5 ++++-
> >>  include/linux/mmc/slot-gpio.h                   |  1 +
> >>  4 files changed, 22 insertions(+), 3 deletions(-)
> >>
> >
> > Applied for next, thanks!
>
> A bit too fast. Binding is incorrect - suggests ABI break and makes
> interrupts not described enough.

Sorry! Thanks for pointing this out. Heiner is fixing this with an
incremental patch on top, please help to review.

Kind regards
Uffe
