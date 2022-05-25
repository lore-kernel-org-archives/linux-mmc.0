Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4328FC43219
	for <linux-mmc@archiver.kernel.org>; Wed, 25 May 2022 15:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiEYPqe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 11:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245279AbiEYPqb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 11:46:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5FAF323
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 08:46:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 206-20020a1c02d7000000b00397345f2c6fso915001wmc.4
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrTCiIB5+imBAeHHe5Yk2P2e1nFNoP+klKZAhqbPDdA=;
        b=MqPIurhFVqpa+pBM1vNQS6bUBZWcTHP2YxERwDnH+bQfrSJK2/72G3Xj7gT+UEioGy
         thWYm7nOuZQUFNxIv2huTTw/x+VekSpTufiYFUFRGkawxOrxefVaDTY1BSz5YzKXNb3N
         N68WwPk1+UqgTIjKN5dveLZ8D1OuV7Beewa2kxUojacU7Bp2iSArTdwBToEwZEZGd4Vj
         mNe2f/owRoeJLfYJRHYnmYyxZRT+hFbQiGMJHYcMVz4o5iqcWa+fTys9HDmTxnnRF79m
         YZdblvApQE3X8Sz+8/wuOXm/kqKvRy3tyjhXPvV2Tr51KqrC0DPWM7HLycywFd//eT++
         8jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrTCiIB5+imBAeHHe5Yk2P2e1nFNoP+klKZAhqbPDdA=;
        b=c8zDF8Lkx8LavlDgqLLtY7QEVahQN2Bgt13JXxvCURiAkltSt2zhdkaKXuc8C1Jrun
         SPELSC8KfQNGaMaGt/gnHbmhH+CRrstKw2FZ3krBKDPAa3BCX+D9jVWK4mcSxuOtfoM9
         m9S0ZaRVe1YDyVmelKeJhGkqfinTYxCXxkPwjCy0Un049Y04vx6/9vCFzEBBkbrjIXs6
         +5iDW3ldygWwzCdxO/xAJYA7L15u1VLJ1NNQJ2ZrhYtIYVzEHcyemy3Vs9L2F+eQANyG
         xeYuOeX1mFk5IhsfY6aaqbnnAyf4/IX66I6zrMKrheLa/gGSu3VGhN1t9FNS8rwVX/Yo
         Az2g==
X-Gm-Message-State: AOAM530AwbYZq7ZsA1rqGeO+7H7ypeh5Np4C0Ko5p27NiTlrzxjNvvdo
        5h2x9MKqJp0oRiWrtLBcew+wl63rhdipGgpGL5zSVwFNQUEJx/KJ
X-Google-Smtp-Source: ABdhPJwMCeE2M2oBeMoCYDG8p7UZtY8gBrM+hDCF+s5vsXn/s+B7NoTCVj2dK00lSgGxLjxe2HR3aykRV/KV+QWzz/s=
X-Received: by 2002:a1c:e903:0:b0:397:36b8:795a with SMTP id
 q3-20020a1ce903000000b0039736b8795amr9116951wmc.98.1653493586128; Wed, 25 May
 2022 08:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-4-brad@pensando.io>
 <CAK8P3a2wZwza=tUzxpHTHTnahf-bUS2-e80rW-wzN3aWodD1vQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2wZwza=tUzxpHTHTnahf-bUS2-e80rW-wzN3aWodD1vQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 08:46:15 -0700
Message-ID: <CAK9rFnwjeaGALTaDx-0k2OEktSv_UmJK9+uGuy=OFP8dnhNeOQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Arnd,

On Wed, Apr 6, 2022 at 11:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 7, 2022 at 1:36 AM Brad Larson <brad@pensando.io> wrote:
> >
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -19,10 +19,12 @@ properties:
> >        - enum:
> >            - microchip,mpfs-sd4hc
> >            - socionext,uniphier-sd4hc
> > +          - pensando,elba-sd4hc
> >        - const: cdns,sd4hc
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> >
>
> Shouldn't the binding describe what the register areas are? If there
> is only one of them, it is fairly clear, but when you have the choice
> between one and two, it gets ambiguous, and there is a risk that
> another SoC might have a different register area in the second entry,
> making it incompatible.

Thanks for the review.  Changing this to allOf:if:then in updated
patchset.  The second item is particular to Elba SoC.

Regards,
Brad
