Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D361CC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 25 May 2022 15:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245293AbiEYPtk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiEYPtj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 11:49:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EE0A76E4
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 08:49:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l30so2116311wrb.8
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UydJpbLrcWgMt1c84uBS/iZ7u4bglmQySLbHThAhvv8=;
        b=QTIaIlC6V+Y2TEijOedrdXkH8QV+VA1NdYAe/JUsY/KqEV4KGfYALljT8Ye0foBG5B
         dTA0i9pp7RX3unhE/gwPaK8q/pGfNpq6+LR1lyueCO//cqlXM0cUPJmzh1xXDxPC/LFl
         M3SNs+wrvCsyVMvQKrpBq4lNQB/8AM1UX1Y5ejUxfM4CFfI9Fccnmm9M8s1bCJDzsgMk
         7BZnK1FCAahe6Lajc3N5cR92/GbKUi8l8L02gryb7sQLkitwTt2LF/WxGkxN6BGjq6aV
         HRF+JdZ6z14+N89qBM3euzQrkLxEOMRT02YFCOXK9yGxd11lFPzNj1pyO0nzO3hKlOOq
         rEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UydJpbLrcWgMt1c84uBS/iZ7u4bglmQySLbHThAhvv8=;
        b=TocfaWEgusXXtsXTT6QvyMiXbJbEk+nfFBYxzuFI0M+XecjOT0h4qNpJiCAXTlNSJV
         kDxt3TFxp4+9fowf5tvTyl6+tdAstoNtB/twR65gWTqRAHCT5p3tpOoylF/jOqAOFWUU
         jQMih90Zxt2xkmC6J3u8haA4IAlvghISXJoThs77iIQEE6XLFDmBTt5H4mf9FHIe1dtY
         3mz3/opaOY+uQHZx/st7LYlnf3I622PZ/ziPkj0VpDWS7M1W7ehT4gk2ONNruC0K/1qq
         i/Tn/ojAGkORLbO0G262Af3EcacsPXoNiMyJcYGM8KYd0+rDW1JwpCw2y6Fw/YHI2VSJ
         INnw==
X-Gm-Message-State: AOAM531OC56H1S8JL5+yjq1hXI6jEss47m9PsrxUnwOZfkalTZjUX0ux
        tqAKQJQhr82rFdthC2P6upn6/55UAaKXrlssTZT9tw==
X-Google-Smtp-Source: ABdhPJxW3P7y/3hZmf3oJarDJb+f5mlGntOYXlpyGBbZxJl9sr6o1mQ35VINtAjKqesywtLHaI2VaL5MCQvFW0dkMfE=
X-Received: by 2002:a05:6000:1f89:b0:20e:5db3:febf with SMTP id
 bw9-20020a0560001f8900b0020e5db3febfmr27632896wrb.685.1653493776647; Wed, 25
 May 2022 08:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-4-brad@pensando.io>
 <888c0f62-7845-715e-12a1-7b16f84d2ae9@linaro.org>
In-Reply-To: <888c0f62-7845-715e-12a1-7b16f84d2ae9@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 08:49:25 -0700
Message-ID: <CAK9rFnyUwdqcpn0y7h-S1DbXDG3QOw+kaBBKPq=4wVHDvznzBg@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Krzysztof,

On Thu, Apr 7, 2022 at 11:57 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 01:36, Brad Larson wrote:
> >
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -19,10 +19,12 @@ properties:
> >        - enum:
> >            - microchip,mpfs-sd4hc
> >            - socionext,uniphier-sd4hc
> > +          - pensando,elba-sd4hc
>
> Put your entry in alphabetical order.

Yes, will order alphabetical.

> >        - const: cdns,sd4hc
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
>
> This needs allOf:if:then: which sets constraint on number of items per
> different compatible.
>
> >
> >    interrupts:
> >      maxItems: 1

Thanks for the recommendation.  Changing to this approach as the
second item is only for Elba SoC.

Regards,
Brad
