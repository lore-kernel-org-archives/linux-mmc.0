Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06622C433FE
	for <linux-mmc@archiver.kernel.org>; Sat,  9 Apr 2022 02:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiDICCs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Apr 2022 22:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiDICCh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2022 22:02:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9118BD2E1
        for <linux-mmc@vger.kernel.org>; Fri,  8 Apr 2022 19:00:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bg10so20544411ejb.4
        for <linux-mmc@vger.kernel.org>; Fri, 08 Apr 2022 19:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0rcGJnboGGVbRg2sFI+AuDUGawxAK6MV1vuJM0DxRw=;
        b=tGE1HuhzwXSMVbeSUYMnXc2zbkLuWbqQnrjJ7kjvfTR06nvfAQ2W+6qd4+n+cbPvcE
         jtJZrZ36bxxcfatWgFOuGAWEnwqRnp+Jsy78Jgzp+5f6puXjqwHjpLwNQ5mMufYjGr8I
         QJVdlOSd08tXJ6YYJY9mCt3sK0WFE9SCrSgZvw7IGi2QiiPJ+hImyKtBeG9f48KLYtG3
         ylraL9Hrnt6+7oESRirffVco49RGnQoZmnqyZ5vjMxnp2Ri1C6x8x8n6tQRtccIYmkcX
         z0SQ1rTIJwdnfVWOq+k21s7VqWT0sqzzQ5rWMy5zHJQIuGYimcTy3undqQpyT8yYWTXK
         3hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0rcGJnboGGVbRg2sFI+AuDUGawxAK6MV1vuJM0DxRw=;
        b=6QsLS7jOPfRj/425v/KcBksPXf5kKtzCG4PVaduHzyjYxVrDsfeQS6T7mvB7fEi02p
         P2dCiYQAewLV9y+nlDIwI7PUj2cmXWH41UH2GNj3OmO3AIMe6AwSxO/A0/XgwR07VNKG
         1JGL8eocwWqC0tNfvtDbeNpvTPeCC6+nEE7SPVFsPYFiz+PhNeNAfGpjmts0sQ9rP5Gg
         foq6Wofc4mRj2RxsPFe1DMl1I0PDcD14CuTkzbJ75puc9+sCBZlVyiAGUfzHKyn0kPlu
         K3d2oht/GNa/m3jM4G03KNC/nlUddyKqCpegTjeDTDKXL/Xf1dv2NLz3aOtozdHuHux9
         ahJQ==
X-Gm-Message-State: AOAM53206ABw2srq5Q04IDNluJKgdLkd3ZbmA1yiTTO0KR3B1qwk3vQU
        zW+VqXc4seK5h91NJreSwQVGa6kJnWr+/zggXI//fA==
X-Google-Smtp-Source: ABdhPJzVth0f36+BeTyV+oOehHk7jHOitDypzZKA7xyCz85+VI8/f7Tx9kxd2JsPCdFuw6wihMmOYr8BNzyTAPWqRIA=
X-Received: by 2002:a17:907:2a8b:b0:6e8:46b4:a955 with SMTP id
 fl11-20020a1709072a8b00b006e846b4a955mr6693018ejc.462.1649469629392; Fri, 08
 Apr 2022 19:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-3-brad@pensando.io>
 <b51086d6-00d4-cc8e-8f11-64c01afb8b3a@linaro.org>
In-Reply-To: <b51086d6-00d4-cc8e-8f11-64c01afb8b3a@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Fri, 8 Apr 2022 19:00:18 -0700
Message-ID: <CAK9rFnytvQx9KNJpCcHN1c01vJvdeE_SXbG8-HDA6FU2rwKHsw@mail.gmail.com>
Subject: Re: [PATCH 02/11] dt-bindings: Add vendor prefix for Pensando Systems
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

On Thu, Apr 7, 2022 at 11:43 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> > +  "^pensando,.*":
> > +    description: Pensando Systems Inc.
>
> List is ordered alphabetically, so this goes one further.
>
> >    "^pda,.*":
> >      description: Precision Design Associates, Inc.
> >    "^pericom,.*":

Hi Krzysztof,

Ahh yes, pda, pen, ... I was looking at the company name.  Moving it down one.

Best,
Brad
