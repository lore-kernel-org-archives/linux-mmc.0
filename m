Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAAAC43334
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jul 2022 18:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGES25 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Jul 2022 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGES2t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2022 14:28:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583361EEC2
        for <linux-mmc@vger.kernel.org>; Tue,  5 Jul 2022 11:28:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so4062401wrx.12
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jul 2022 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9k/+Uy5gv2PwrBOPSWl6WfKzfQjFC1FlW0/HaLsKvWU=;
        b=Ad9KuxJ93xIfVpPWWDBLUBldo4Hbaz+s+qVOb6jcG2ew4dXMSIrYT5caIHj2dTj/XL
         l7zK2mgyOky9viuWMHGoLSpy38DRT3LqhGMT4ZMCICL7/j6RqKuRRHXEvEAjL94Ijeyw
         qBH4g+TTFNMnqPUS19LLMGSolayXJkKOuifmhh4dw0JXUOh198Z1m64nkJhA+f7Kvz2i
         5XMimEDXhZNBQmvvvtj5z9JfOgc9M+FL/wqlIuG1N9YKPFtDgRgSWAF/ExFqd0RoX0bJ
         sWm0mlrzNikOfnv2LzPSBu6dfGotPkVgwwmyA7qfLz6Ba/m0+rbxfKOkC+uo2SJ7rYUI
         xm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9k/+Uy5gv2PwrBOPSWl6WfKzfQjFC1FlW0/HaLsKvWU=;
        b=tzm1jIwq2IIeg9GJRIT+QmKowJTOmfuxL3YeTlZigYImdMn2ts4ZSxjdf4J4imRV5i
         T3YpAJgjrG2vgphfvYi9Cj2k3CvFLb7v+aOe/8FXLcAM+A/Z17QIttBBjOeFSWX/rxQW
         0tT4NfVey3V6v475wXLnCmhbk1pPBNVFSLLR8AnMlXcuxee0vtrFklvSTUZzJUhkNHst
         XXldrbDO18kITP1+vA4eYu1E7TnU5ADupqCfyR3fcv7NDc0RU5awzc9bDisuIcYSY3wi
         DOcv0PMT70iQ/036Bdxwawe+671odhqFX5grf8djXuDu5b3qEU0pfel1FEXZQkHfq5Pk
         eFbA==
X-Gm-Message-State: AJIora+vfiuB3SLadB89Rjn6PSqwaZWzE5UlbZVidORd/5bfvBES1QBT
        +EJiG7NkaKiAu+SgLmTtd/z2Bd9c8g9RGIiMjcCNsg==
X-Google-Smtp-Source: AGRyM1vlwsMCrFY5zIP4L9aRehYUA+yzd3Q8yGz7fWKQEi0MiKAE7oCYE2ebmTrutqhdfXEeIao4xTvx2rFDBYcHvIY=
X-Received: by 2002:a05:6000:192:b0:21a:3c91:df05 with SMTP id
 p18-20020a056000019200b0021a3c91df05mr35030207wrx.655.1657045720822; Tue, 05
 Jul 2022 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-8-brad@pensando.io>
 <eac223c5-a3d4-65e5-3753-1bd4033513f2@linaro.org> <CAK9rFnyRgj26MaurS_u83wnzgmq+18=UdZT_FLLZc3jnWD4uFQ@mail.gmail.com>
 <db82fe69-8caf-f142-0714-ff73ea6f65ec@linaro.org>
In-Reply-To: <db82fe69-8caf-f142-0714-ff73ea6f65ec@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Tue, 5 Jul 2022 11:28:30 -0700
Message-ID: <CAK9rFny-PWvwY8K6mpzhx8deX3w8q5gFp1nmwq9QsiOUF4m+bg@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] dt-bindings: reset: amd,pensando-elbasr-reset:
 Add AMD Pensando SR Reset Controller bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
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

Hi Krzysztof,

On Sun, Jul 3, 2022 at 11:41 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/07/2022 01:50, Brad Larson wrote:
> >> Missing file:
> >> ls: cannot access 'include/dt-bindings/reset/amd,pensando-elba-reset.h':
> >> No such file or directory
> >>
> >>
> >> Send complete bindings, not parts of it. Did you test it? I am pretty
> >> sure that this did not happen. :(
> >
> > Its in patch v5-0015 with the driver
>
> Header is part of bindings, not driver.

That's the reason, the header was not with the bindings.

> ...
> So how this test could pass if there is no header file included in the
> example here? Are you sure you tested each commit separately (like it
> will be included in the kernel)?

and I had applied the patchset before running the checks.  I'll check
each commit separately for next version.

Regards,
Brad
