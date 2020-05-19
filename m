Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DD6C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFF820709
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 08:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkpDFV96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgESIS7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgESIS7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 04:18:59 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64645C061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 01:18:59 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e10so7262140vsp.12
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyMVA1/tYTbGILCIVObrfNnFMvCyRjjoDpGEMnTbO5g=;
        b=HkpDFV96ugJfk14srT01g6ietxU42N+axhgdOdYnuQuHMoPWXzufIsqfASyUdl2fF8
         K1vPvdq0P9f+i/77kIRpLHM9C44GE0XGbJj05SDkjh7N5KXqZ/8vyJioN3vo7lYkSH0t
         60Y6pIqs/kIrNZ8vp5o6S8rZFyZz8PcglVKNt8fpWA3wrNp9dEH38dHhw9QXYc/HD18a
         QWQUgncHEwaY7yhRqH741P57EMYYktb+CGBxepmzMTyQVS+xStEgfCkHHlq0OGb8vhaN
         uxwPmqGC/BLsib/358O5hhzK/BL/fxkMCnZyKmhT5ABY6rfJn2THZRpBmKGEU26kn4Tp
         jXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyMVA1/tYTbGILCIVObrfNnFMvCyRjjoDpGEMnTbO5g=;
        b=MwD7ein2wEFeVcNTJj577bTePKgpxtnxWKLYp6dCR9OHwaOtAT0r1X217btc1trGrY
         e9n+h/wLKOHnkpJHj1lvFH7ppSUJx+uIk3h752z3iYAC005C7wSwRSk5+81kKBQK5R86
         /VK3S9u4G5doJIm2xgCN5Afrn9AkQlY0mncXBLrb84QbnC3cDe82SSRKo4Ftx1I0dVWQ
         x2Bl3CY90LtbPwuJHaWzkyQMVWID6k4+7qUVP8HY02jpxI+nTzydCW4DJFp69m4Z1eLI
         x4GgUhVG0vQC2OWjdDMyGe17CY3n0KzJCQu4Rn10RWcnfWMhOxxBDfJ5le7pQURRxbWY
         HtBw==
X-Gm-Message-State: AOAM5327q11gvgm9L762Lev+mFM7XOnjAvhThmMMOTYUofooUx2HdEyG
        CHOn5HlOBaEEcYWyS9jDHhhhlhCIqMuNHpEXjVfiSg==
X-Google-Smtp-Source: ABdhPJwiDDiJh2oR4zUVYxoWRLD1UVHvXSoAZcdXHVkLdrnOsNcmQLiVs75eJf/wD97WapxEAjvSq9kmhaO1QHyLO5Q=
X-Received: by 2002:a05:6102:82a:: with SMTP id k10mr5944635vsb.200.1589876338412;
 Tue, 19 May 2020 01:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140459.15273-1-ulf.hansson@linaro.org> <CAMuHMdWscejrUbfx0-C=WFC6-vECA9HTkKs0=osWGUPBY6yPxA@mail.gmail.com>
In-Reply-To: <CAMuHMdWscejrUbfx0-C=WFC6-vECA9HTkKs0=osWGUPBY6yPxA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 May 2020 10:18:21 +0200
Message-ID: <CAPDyKFrTfVAj4WbpdAvOxW_rKej=BxTqu8nn1_K985=cHacpXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 May 2020 at 23:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, May 15, 2020 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > If the tmio device is attached to a genpd (PM domain), that genpd may have
> > ->start|stop() callback assigned to it. To make sure the device is
> > accessible during ->probe(), genpd's ->start() callback must be invoked,
> > which is currently managed by tmio_mmc_host_probe(). This is very likely to
> > be too late for some cases, as registers may be read and written way before
> > that.
> >
> > To fix this behaviour, let's drop the call to dev_pm_domain_start() from
> > tmio_mmc_host_probe() - and let the tmio clients manage this instead.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> So this moves the call to dev_pm_domain_start(). No new calls are added.
> If I get it right, dev_pm_domain_start() just calls into
> genpd_dev_pm_start() through a function pointer, and starts the device
> through the system-specific PM Domain handler.  On R-Car SoCs, that
> is pm_clk_resume(), i.e. enabling the module clock through the clock
> domain.

Correct.

>
> I have two questions there:
>   1. What if the device is already started?
>      There seems to be no reference counting involved.

The device can't be started as runtime PM hasn't been enabled yet for
the device - and this is controlled by the tmio/renesas driver.

>   2. Who stops the device again?

Beyond this point there are two main cases to consider.

1. The driver is probed successfully and thus up and running. Then,
when the device becomes runtime suspended (because of request
inactivity, for example), the device will be "stopped" through genpd.

2. The driver failed to probe or the ->remove() callback is invoked
for the device. This will trigger the platform bus to call
dev_pm_domain_detach(). In this path, genpd invokes the
genpd->detach_dev() callback for the device, which allows the genpd
provider to deal with the clean up. In this particular case, I assume
pm_clk_destroy() is going to be called for the device.

>
> I always thought the PM Domain was powered on (if still off), and the
> device started, by calling pm_runtime_get_sync().

Correct.

However, deploying that kind of pattern in a driver can be a bit
messy, while considering that CONFIG_PM may be set or unset and the
driver should work in both configurations. In principle, it leads to
boilerplate code in drivers, especially if the driver has runtime PM
callbacks assigned to it as shown in commit 1b32999e205b ("mmc: tmio:
Avoid boilerplate code in ->runtime_suspend()").

Does it make sense?

[...]

Kind regards
Uffe
