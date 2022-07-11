Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639BCCA481
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGKOwV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGKOwU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 10:52:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901186F7DF
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:52:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g1so6547163edb.12
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGTevPUwkzc81+3xxS7RaXwvxQl65M4pwfdwK/mf7M8=;
        b=Z4XNDNccxkqkkO69BxWuxx6IsFvM9Iy0/pO+RqiO8BrUoiKcx1R1xBCQ13TE/3t9Bw
         onK38E1qGpBYWskQ0GBgkh6x2n4S3k9KaSM3oMUWRo9sVHRiL40eS9WhzYfitS6df7IE
         vjbiZz9yu5MdyHrK0cs75bFs7cpF22uzW2PaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGTevPUwkzc81+3xxS7RaXwvxQl65M4pwfdwK/mf7M8=;
        b=WbYKLtBLNu+byxVEo0yIY1FBIFCtKQkHqaKeqYc5lRMV0RTsScbtW/fEsCKw/NH9Q6
         qesGwBfkEV2L03zQTtgjEshr1TzfRVGVDbK+XYsJABpuuKvfo8uUtn/ZX6olHFHuYw3s
         78s35KJSTc7vTYhDsH34p1TCA2K8FfCSYUqwp2sR+uSHl6G2QTgEfn2uwj2o2JZvAt5r
         WilHPJxymSUNigTAZ+GxFD+ViW6ZUPS7dGHEPomlZQiUtkUpvW4FEN7kPq17lUEjKkE+
         4rttrPbV4E/B46wnc8ACKt/HZoz0oPfM4LmtIKfRJAI8DeXAABRiUyY03DyuGOgFOy50
         H88A==
X-Gm-Message-State: AJIora+HMKqWnuKnhjl+SIE7WXW2OsqIPT+dKYIptQNPbwj+c+l/2mZ2
        MYkZXweFZFP3JHSfmNSC1hTQm8D9JNgd+YbJ
X-Google-Smtp-Source: AGRyM1v8HH/1MiIS1qEX4mp3jYJ6WZVvUyoY1S/FsJW9ketrHP0N/qGZ0jRYScTHdAmYXVCR1LqeBg==
X-Received: by 2002:a05:6402:2404:b0:437:d11f:b9c7 with SMTP id t4-20020a056402240400b00437d11fb9c7mr25633129eda.176.1657551137904;
        Mon, 11 Jul 2022 07:52:17 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id m6-20020aa7c486000000b0043a1255bc68sm4422625edq.94.2022.07.11.07.52.16
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:52:17 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id o4so7359614wrh.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:52:16 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr17639861wrr.617.1657551136373; Mon, 11
 Jul 2022 07:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org> <20220711082940.39539-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711082940.39539-3-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 07:52:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUCPzzZHAPqoz-vhmcVxzYDxkKQs=+1tLZvsQjWe4q3Q@mail.gmail.com>
Message-ID: <CAD=FV=WUCPzzZHAPqoz-vhmcVxzYDxkKQs=+1tLZvsQjWe4q3Q@mail.gmail.com>
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

Hi

On Mon, Jul 11, 2022 at 1:29 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The entries in arrays must have fixed order, so the bindings and Linux
> driver expecting various combinations of 'reg' addresses was never
> actually conforming to guidelines.
>
> The 'core' reg entry is valid only for SDCC v4 and lower, so disallow it
> in SDCC v5.  SDCC v4 supports CQE and ICE, so allow them, even though
> the qcom,sdhci-msm-v4 compatible is used also for earlier SoCs with SDCC
> v2 or v3, so it is not entirely accurate.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes since v1:
> 1. Rework the patch based on Doug's feedback.
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
>  1 file changed, 38 insertions(+), 23 deletions(-)

In the ${SUBJECT} I'm not sure what a "perp variant" is. Is that a
typo or just a phrase I'm not aware of?


> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index fc6e5221985a..2f0fdd65e908 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -49,33 +49,11 @@ properties:
>
>    reg:
>      minItems: 1
> -    items:
> -      - description: Host controller register map
> -      - description: SD Core register map
> -      - description: CQE register map
> -      - description: Inline Crypto Engine register map
> +    maxItems: 4
>
>    reg-names:
>      minItems: 1
>      maxItems: 4
> -    oneOf:
> -      - items:
> -          - const: hc
> -      - items:
> -          - const: hc
> -          - const: core
> -      - items:
> -          - const: hc
> -          - const: cqhci
> -      - items:
> -          - const: hc
> -          - const: cqhci
> -          - const: ice
> -      - items:
> -          - const: hc
> -          - const: core
> -          - const: cqhci
> -          - const: ice
>
>    clocks:
>      minItems: 3
> @@ -177,6 +155,43 @@ required:
>  allOf:
>    - $ref: mmc-controller.yaml#
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdhci-msm-v4
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          items:
> +            - description: Host controller register map
> +            - description: SD Core register map
> +            - description: CQE register map
> +            - description: Inline Crypto Engine register map
> +        reg-names:
> +          minItems: 2
> +          items:
> +            - const: hc
> +            - const: core
> +            - const: cqhci
> +            - const: ice
> +    else:
> +      properties:
> +        reg:
> +          minItems: 1
> +          items:
> +            - description: Host controller register map
> +            - description: CQE register map
> +            - description: Inline Crypto Engine register map
> +        reg-names:
> +          minItems: 1
> +          items:
> +            - const: hc
> +            - const: cqhci
> +            - const: ice

Do you need to set "maxItems" here? If you don't then will it inherit
the maxItems of 4 from above?

-Doug
