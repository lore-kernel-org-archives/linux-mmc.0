Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFCCC43334
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 21:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGCVJS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGCVJR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 17:09:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BD2627
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 14:09:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so6428553wmc.1
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJikOAGFfDOpaBAb8R9M4tTzS49h3/owJMg980ZRk/E=;
        b=HPOrwTANUSSTyUglOWfmqx3TAqE59f1wu5TsnpCDbHlYvitgr1ZYre1PF8zwpEk8bR
         7UVh+tTk79uqQRVgs7gBfdpxq1GreddUhZgX0R7RwKdk1qvKIjYI0Jk/OsW8mGXeDqdc
         bjJ/CDRVHPT9FVve0A6AvaQBdGHEBYPr7EwQp5jQeX2drM0MLNY+QZCYA21abBAmPK1R
         n2S8xHUeO6ndniVe8n0+bXjfC9c5jF3el+RkuFqchYHEOSmWfjmXe9syHn0g3zXpGTzD
         05l2Lv9lChwU5sXvfiOpnCTIcdCtNjy+vrlzShYwBTf6f/ISAn+zwKtguJ7v+eIg/i99
         uwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJikOAGFfDOpaBAb8R9M4tTzS49h3/owJMg980ZRk/E=;
        b=bnZ1d4Sc9u0T2AST6H5/Zd4i7lxdhKrkgkyeqpsqJhSDPkxFIOXUfeB1YV2AM1GbCM
         WtsUQ50dzGlmg/1ingoNISzjwq3Kk2f62W7Sh34uqqneg8PjRNYbyT/yfnhD3KViB9jg
         xCy3yZlj8jkgzIfgXUDI1dNJRTFuU4WawO92jZAUXRRYrJ93JwyEtPUPEzvfpnKniLq8
         J7oR14KDRbG0Fa6vfPU+OLRHfRRWcgXlJpjzEN6ACQTghkYp7nhN5w7BvvEte0G7qXSk
         E+82BBOMSBzg9tvJENDCiQnXorlrkvnlgoaLhUhLW9+cNPxK2mpNKO0HwfpKYxQvO2nb
         qfog==
X-Gm-Message-State: AJIora9hFZX/ivbuJbweFbCZja5ecfnRMJFmzdiBS20V89QzSkQvaHj3
        uG1rA1wS06FFuHXFfg9Uzq94+9faY1FM9JK/+5ZNZQ==
X-Google-Smtp-Source: AGRyM1vOEFsk6GxoOvERE6U0eWZvAYgZwMy1flCmqTZIailGzmdOzuiBfuHPrbNr3nr7glQpb5XbCjfw5CdVvGxO4yc=
X-Received: by 2002:a05:600c:3505:b0:3a1:9fbb:4d59 with SMTP id
 h5-20020a05600c350500b003a19fbb4d59mr4089664wmq.165.1656882554615; Sun, 03
 Jul 2022 14:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-12-brad@pensando.io>
 <Yqh4fO/OFW6DKmyX@sirena.org.uk>
In-Reply-To: <Yqh4fO/OFW6DKmyX@sirena.org.uk>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 14:09:03 -0700
Message-ID: <CAK9rFnwfTza6dVehO6mmiae=9yKXdJFXUetjW3BuGtEasgp1-Q@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] spi: cadence-quadspi: Add compatible for AMD
 Pensando Elba SoC
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, alcooperx@gmail.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        p.zabel@pengutronix.de, Pratyush Yadav <p.yadav@ti.com>,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        Ulf Hansson <ulf.hansson@linaro.org>, will@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Mark,

On Tue, Jun 14, 2022 at 5:01 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:56:54PM -0700, Brad Larson wrote:
>
> > +     /*
> > +      * If a hazard exists between the APB and AHB interfaces, perform a
> > +      * dummy readback from the controller to ensure synchronization.
> > +      */
> > +     if (cqspi->apb_ahb_hazard)
> > +             (void)readl(reg_base + CQSPI_REG_INDIRECTWR);
>
> You shouldn't need the cast here.

Removed (void) cast

Regards,
Brad
