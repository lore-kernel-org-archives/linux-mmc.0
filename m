Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A582C43334
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 23:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiGCXYT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 19:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiGCXYS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 19:24:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68552722
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 16:24:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e28so11096653wra.0
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SrqIW34AjFbZmMaYUREgVew+EkjbRkWGdQzlKX5pYM=;
        b=LtX4h8J6Zs44uTrB55u4wk7Bv0k+Fu8IQesnHE/LJDVzldiS1rLasN8CFxMk3rheJn
         dJJewgoCajXoXyPZcAZ7VZJ0o8zbgmxRlv1CTD+Z6u0avrH+CYwhY+NqdbT1bHyR398l
         dMXmiZ0DYmQ7KfjahfnncgOX2dZHhjnVK2tkwRDSIGD2PYACdL1PlGO1CEdRKQPXmiLj
         W8ncmw/ItuytTnhNuOSWwbt4OSfG3ILNrg6lQ3DJGDJTQCKOSwOizxPOzwhoxxbp9G5n
         hgfNlKiGcox8q8afEB0rRMX+jH163vwqDzHdUNdMcwr2zjcYvKRaa/gX9l1jbm58XKX5
         aygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SrqIW34AjFbZmMaYUREgVew+EkjbRkWGdQzlKX5pYM=;
        b=YdaXkaHhfUnfoiNQ1jO8WTmCjBosAwvAqlYFDXoEEEkc9njOfVKr+anum3hWER1k9J
         0fqjjvLjccVich1oG8vuEHngq/NRYkaknHRjuYms43U0MwhCqRHT7+7RmJowJesPCu5e
         zPHQGUR6nP8inbqZemJ0tqIiL3IXNQdkYvTfizqw4M776033ccUeV5A9v8pkugeHSQtl
         rlGYQD2sv1KK3uhE5tf3C6+hoF4NP6m83UukZCmQ+SPkFM2WLAvDVwWh90pQLJvPk90a
         2qrPVCxjIMGmDYF21RwqEQDiW7H6RbH0U/QlJXwBdObmLX/z/FwfVQiHXHyXX6n6G5S2
         Njag==
X-Gm-Message-State: AJIora+rWwtQMBX33q2sUstGKJlKf8438CoMWCE55OdJRPWVkgMil7L1
        1cnUComTHoMpB8ZNKvAiUb1frWan6dkmE+jx0bPYNQ==
X-Google-Smtp-Source: AGRyM1ukXmbDBTUmgfEPfq4g0fSzjZCODNwoenxaj+ZuQ6nSFKMHhpapVUul8KEv56TfB2SshRb0iwtzlnz8MQ5zEAU=
X-Received: by 2002:a05:6000:192:b0:21a:3c91:df05 with SMTP id
 p18-20020a056000019200b0021a3c91df05mr25306379wrx.655.1656890656277; Sun, 03
 Jul 2022 16:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-16-brad@pensando.io>
 <20220614213428.GA2684278-robh@kernel.org>
In-Reply-To: <20220614213428.GA2684278-robh@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:24:05 -0700
Message-ID: <CAK9rFnzy6GTg+DYicrSzgXpRCO3XgFtVDP1Fjg=oiUgZusNn_Q@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] reset: elbasr: Add AMD Pensando Elba SR Reset Controller
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rob,

On Tue, Jun 14, 2022 at 2:34 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:56:58PM -0700, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > This patch adds the reset controller functionality for the
> > AMD Pensando Elba System Resource Chip.
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  drivers/reset/Kconfig                         |  9 ++
> >  drivers/reset/Makefile                        |  1 +
> >  drivers/reset/reset-elbasr.c                  | 94 +++++++++++++++++++
> >  .../reset/amd,pensando-elba-reset.h           | 11 +++
>
> This goes with the binding patch

I must have misinterpreted an earlier request to put the bindings
separately up front in the patch set.  For a new driver the binding
and driver should be in one patch which I'll change for the next version.

> ...
> > --- /dev/null
> > +++ b/drivers/reset/reset-elbasr.c
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> Kernel code is GPL-2.0-only generally.

Did something change versus earlier request for dual license?

> Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
> - by Rob Herring @ 2021-10-27 21:37 UTC [8%]

> > +// SPDX-License-Identifier: GPL-2.0

> Do you care about using with non-GPL OS? Dual license is preferred.

Regards,
Brad
