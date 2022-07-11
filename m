Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88403C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 15:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiGKPLr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiGKPLq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 11:11:46 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC605A2E2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 08:11:45 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r76so5166924iod.10
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xninKA70EtexcdYCbdfuTinCaP7pxcUur1I8bK0NPTw=;
        b=OKNN2Re5+g4wHUiVyzepFDVWZOXbvcZGQio3rTb0i4xibe7JSuEzbHrs4S05ZN6i78
         sgkq6ZFhZVQQkc5t3f0VvdAB31FviPnkCYj3b5bH0gdYLrYCm00hqvh4HCRUj2dy9Ap5
         Q02/02O/jxHXt17YhY2tvweobdiXpz005KJ8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xninKA70EtexcdYCbdfuTinCaP7pxcUur1I8bK0NPTw=;
        b=UU3SFqckowDydgeplBiFkGfqiQdkXI1h7vBNHQoP8o43C5MEWmShAzcS2/GcWmPBbA
         25e3twWsshX+nga9EMJ7gtcDAYvtEBz9Vut1MRYv+xxpvfsZboAmex2lR0WgNIN0HQVV
         UCl3mJENg2fEoggf5SSnllJWi6mAuI8p/6VlGRUFQm0fDXl2HlW6PAv109mGfx5wLgaV
         bLQwy37GUT0hXS2wBEPJX0d+E6ikh8B3BJDkrw8FJE5v6+330duF6Qwf+dCS3+p8C48C
         qiSPEfxLozny4xpnIUxJwGsnlfENGonRrpJBH+i+LWtlYwDQka3FscbTdZsCPgidmZhy
         CnTw==
X-Gm-Message-State: AJIora9bJBALTKMukSySHmgvLIQf9h/UZOJP+X5I6842Spdr6m/LfcZf
        UxbkR0WkQO5JFudOO5eeSOgbKU/oursQ8+pZ9Jc=
X-Google-Smtp-Source: AGRyM1toOn0yqn2MFlEcem2L9YbwvlWOdeERJGKXaRKPq2mnua2yPEpKtA988jHPTRpOnECKmuLM4Q==
X-Received: by 2002:a05:6638:1a13:b0:33f:1f32:6248 with SMTP id cd19-20020a0566381a1300b0033f1f326248mr10350183jab.53.1657552304455;
        Mon, 11 Jul 2022 08:11:44 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id y36-20020a029527000000b0033f347c26basm3000856jah.62.2022.07.11.08.11.43
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 08:11:43 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id p128so5206868iof.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 08:11:43 -0700 (PDT)
X-Received: by 2002:a05:6602:2d48:b0:67b:73f5:7e74 with SMTP id
 d8-20020a0566022d4800b0067b73f57e74mr8746907iow.154.1657552303271; Mon, 11
 Jul 2022 08:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
 <20220711082940.39539-3-krzysztof.kozlowski@linaro.org> <CAD=FV=WUCPzzZHAPqoz-vhmcVxzYDxkKQs=+1tLZvsQjWe4q3Q@mail.gmail.com>
 <f8744ff8-15a0-bf31-c49f-b1bb35ba5cdd@linaro.org>
In-Reply-To: <f8744ff8-15a0-bf31-c49f-b1bb35ba5cdd@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 08:11:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2ZfwwDO_hSSN35ObfvBbBbPjMoSB4GvS7m0yJieNg3Q@mail.gmail.com>
Message-ID: <CAD=FV=X2ZfwwDO_hSSN35ObfvBbBbPjMoSB4GvS7m0yJieNg3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names
 perp variants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 7:53 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/07/2022 16:52, Doug Anderson wrote:
> > Hi
> >
> > On Mon, Jul 11, 2022 at 1:29 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> The entries in arrays must have fixed order, so the bindings and Linux
> >> driver expecting various combinations of 'reg' addresses was never
> >> actually conforming to guidelines.
> >>
> >> The 'core' reg entry is valid only for SDCC v4 and lower, so disallow it
> >> in SDCC v5.  SDCC v4 supports CQE and ICE, so allow them, even though
> >> the qcom,sdhci-msm-v4 compatible is used also for earlier SoCs with SDCC
> >> v2 or v3, so it is not entirely accurate.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes since v1:
> >> 1. Rework the patch based on Doug's feedback.
> >> ---
> >>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
> >>  1 file changed, 38 insertions(+), 23 deletions(-)
> >
> > In the ${SUBJECT} I'm not sure what a "perp variant" is. Is that a
> > typo or just a phrase I'm not aware of?
>
> Should be:
> "per variants"
>
> >
> >
> >> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >> index fc6e5221985a..2f0fdd65e908 100644
> >> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >> @@ -49,33 +49,11 @@ properties:
> >>
> >>    reg:
> >>      minItems: 1
> >> -    items:
> >> -      - description: Host controller register map
> >> -      - description: SD Core register map
> >> -      - description: CQE register map
> >> -      - description: Inline Crypto Engine register map
> >> +    maxItems: 4
> >>
> >>    reg-names:
> >>      minItems: 1
> >>      maxItems: 4
> >> -    oneOf:
> >> -      - items:
> >> -          - const: hc
> >> -      - items:
> >> -          - const: hc
> >> -          - const: core
> >> -      - items:
> >> -          - const: hc
> >> -          - const: cqhci
> >> -      - items:
> >> -          - const: hc
> >> -          - const: cqhci
> >> -          - const: ice
> >> -      - items:
> >> -          - const: hc
> >> -          - const: core
> >> -          - const: cqhci
> >> -          - const: ice
> >>
> >>    clocks:
> >>      minItems: 3
> >> @@ -177,6 +155,43 @@ required:
> >>  allOf:
> >>    - $ref: mmc-controller.yaml#
> >>
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - qcom,sdhci-msm-v4
> >> +    then:
> >> +      properties:
> >> +        reg:
> >> +          minItems: 2
> >> +          items:
> >> +            - description: Host controller register map
> >> +            - description: SD Core register map
> >> +            - description: CQE register map
> >> +            - description: Inline Crypto Engine register map
> >> +        reg-names:
> >> +          minItems: 2
> >> +          items:
> >> +            - const: hc
> >> +            - const: core
> >> +            - const: cqhci
> >> +            - const: ice
> >> +    else:
> >> +      properties:
> >> +        reg:
> >> +          minItems: 1
> >> +          items:
> >> +            - description: Host controller register map
> >> +            - description: CQE register map
> >> +            - description: Inline Crypto Engine register map
> >> +        reg-names:
> >> +          minItems: 1
> >> +          items:
> >> +            - const: hc
> >> +            - const: cqhci
> >> +            - const: ice
> >
> > Do you need to set "maxItems" here? If you don't then will it inherit
> > the maxItems of 4 from above?
>
> No, items determine the size instead.

Can you just remove the "maxItems" from above then? Does it buy us anything?

In any case, with the ${SUBJECT} fixed:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
