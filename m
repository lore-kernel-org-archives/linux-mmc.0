Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE39EC43334
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 23:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiGCXL7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiGCXL6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 19:11:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6D22AE7
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 16:11:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso4672799wmq.4
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEvIt0W4jMtK0kOUq02n7cnRwL93Xyq1bjqkbvvw32k=;
        b=CiVuKlquo+4o/OdgU9j/J7SlhK5NNg9ng3XiM6R33Wpz8A0EthSdvb+5XdYtOgNvXw
         Fcp5vU/Qz8d0IloOisuZKpr20agYbvpa1ULksUY/MVfeZz2zzGtqLRvpRqRbLLIOasXn
         HjHT4bQ+heaVzhdmhyI8BOg4UgZlmVUb10kCbKeHDsQW6o+dX+BvHeeS6DKhJDx5v59p
         ffoQ+ciCarbX0nVB+G10lnWd8qDquSood14rlUxNo5mXaOFcmDjPByr5DgsSLw2mQvsp
         NYRGciH+asxSIDil2X8Pst5+/DMOVr6fTM127Qyl+6WxMAo5JTTwZYyENOPEBwJqMdlD
         vPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEvIt0W4jMtK0kOUq02n7cnRwL93Xyq1bjqkbvvw32k=;
        b=CaMibZHG7+GFsixBT/Fc/NYgTJSGm+D7SzK1uVP1I15qnkoIee4wavkpRVs+I4wbz5
         jFA7kRNrB4Kj4X36jK3sL9CAYZ+Hx3H3lxlGAKRtXBanUNoY1U/B9Q+pzlBhWZ4LszkB
         +fE4g9oOVey5i4fL98MoA2RaWPwFrB0WAugE+W9EYtHAj64WqWU3hCXwQdwLOkJ3Ghgd
         FIM5FsDhDeshKgRUj3k3sEPdif63N0wdgf6K2AEEFKVMVLyHP9v/6raKFewmYFqGKoTo
         r2Ua+dGlj6deZKK96jUcbdUR+DEuMrs8/FnNfgZOP3f7mpx4Asoj5c9yqsQUlgLHekd4
         t2PQ==
X-Gm-Message-State: AJIora8Ev1JnfFQoQrq5+QwWkAqeUbkPLK6hzbVS1c3XtjbMkB/vBcmb
        wSRztBaLSCKeyiESJb2FHB0xQkai+KgmB012kW3HQQ==
X-Google-Smtp-Source: AGRyM1v5SLIg8WZnDQdxcL0e+L2xOqK4GaB+5QbY5FlNGlEGYkSCm/VCy7BumOq8xzX0Maqdck28Oe3SLtxW20TxHWg=
X-Received: by 2002:a05:600c:4f42:b0:3a0:57ed:93a9 with SMTP id
 m2-20020a05600c4f4200b003a057ed93a9mr27714140wmq.143.1656889913254; Sun, 03
 Jul 2022 16:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-3-brad@pensando.io>
 <c3785da1-0142-5c4c-4f46-c569c8c06efa@linaro.org>
In-Reply-To: <c3785da1-0142-5c4c-4f46-c569c8c06efa@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:11:42 -0700
Message-ID: <CAK9rFnydaXSjDsZf1Bnv90tBVHpZ4rr+Zufd6Cr4rJjDeB=-jg@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC binding
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

On Mon, Jun 20, 2022 at 5:50 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/06/2022 21:56, Brad Larson wrote:
> ...
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -13,10 +13,24 @@ maintainers:
> >  allOf:
> >    - $ref: mmc-controller.yaml
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - amd,pensando-elba-sd4hc
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Cadence host controller registers
> > +            - description: Byte-lane control register
> > +          minItems: 2
> > +
>
> Except Rob's comment, the entire section now should be moved to bottom -
> just before unevaluated/additionalProperties:false

Yes, moved it to just before unevaluatedProperties

Regards,
Brad
