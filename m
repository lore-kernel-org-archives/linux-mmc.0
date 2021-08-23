Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8BC4320E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9546A611C8
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhHWBJI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhHWBJH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 21:09:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C11C06175F
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:08:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me10so5060414ejb.11
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Onm3235BQ8G4xdJbhVwVgJsf95u/nu5c22LJ3fnjjLA=;
        b=DiTtMR16QYQmfTecipM6RDF834D/bmbcX4DapAdcIcu6Q/wfzgm82DKNdYM7wbsQbA
         vvag4OT1ymGCwo5x9paI9ijTy8hY+LOKndK6mWagcyFXwUsbZ2OaPJL3M50Ri9E5x1QG
         h4d0rF6Jl5e5cFOOKryRLH6VqjP+Ec/OLqEYBBTxMStlqdTkbf/aCcZY4vGJwtctx8Wd
         i9/ig+y9ZUs07AP4e7EeLbPJGs4kIoAqQ7UUGKv4dKfCMn5IcOvM6kXYaSUNVm6nXOyF
         xf1SyarAYZoGdRvEpQDn+ilx6PZguy1Ci1gwD2eeiZ56IiT0k1VHEpvdnuAggCR2Z+33
         uOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Onm3235BQ8G4xdJbhVwVgJsf95u/nu5c22LJ3fnjjLA=;
        b=eJa+5VJXITEFAkjNe8GxWNYJnDKNCjB5Tx8Kd/kp/k6J8YC6H7nq8BL/dxJGEIOEqr
         MZ1ZXuZIoHt3licKXD6XyoqPhYWZeef8bUF0DiBDzjQwuSk1bOGPC474TeeRP9T3sloK
         sNN2/oLM7Tr2h13PfSQWqwUydNl/U2sT5e6E/uGeznD8wzyKCGAztnHQb8aq1z12zQgu
         B7glOs6Jdaj1av78mALZ7ASGcab7yyrzB8LB+WNFmgFb67ebie+LqBxoeekdD3kJr9Vh
         fCod+cNclNe4YFE7qQydYIkG3N/Iod2Z/kdUK4MposZt76XiWJMMZw0NykKoW5hyGCQT
         wOSQ==
X-Gm-Message-State: AOAM530IwfP/1lpaakfqDFu5+GIqsv9dJnIPtUGa6XI5Xp2TyuAz2H49
        7zKBmtJDwKnWwBf/njHT8UUbadtna6h1sSB0Xko/eQ==
X-Google-Smtp-Source: ABdhPJwUksQwzIHDsLD7LRr+16pz/HRfywN70Z6+uiOne1u+om1H3sBmuAFlzPeVw4ciw87Ev3lfR9WxvyDDmZNA4cw=
X-Received: by 2002:a17:906:cb11:: with SMTP id lk17mr32433898ejb.271.1629680903812;
 Sun, 22 Aug 2021 18:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAMuHMdUsFb-qpssVXkxv0gV8qpi6mUNx+3o+ZUhc5UMCKppzrQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUsFb-qpssVXkxv0gV8qpi6mUNx+3o+ZUhc5UMCKppzrQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:08:13 -0700
Message-ID: <CAK9rFnwAiKgb-RJGipVCqSZmeCvKfUA+zQxG9TPDXV6CkTvs6Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Geert,

On Fri, Mar 5, 2021 at 5:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Brad,
>
> On Thu, Mar 4, 2021 at 4:59 AM Brad Larson <brad@pensando.io> wrote:
> > This GPIO driver is for the Pensando Elba SoC which
> > provides control of four chip selects on two SPI busses.
[...]
> > +config GPIO_ELBA_SPICS
> > +       bool "Pensando Elba SPI chip-select"
> > +       depends on ARCH_PENSANDO_ELBA_SOC
>
> Any specific reason this can't be "... || COMPILE_TEST"?

Added COMPILE_TEST

Regards,
Brad
