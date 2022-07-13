Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F21CCCA482
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 10:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiGMKzr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jul 2022 06:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiGMKzq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2022 06:55:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C34FF59D
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:55:44 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id p13so6466681ilq.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPUdREpbw8JAiS9jCqv+xu5MRPBqr5k1QOevzsiVdPA=;
        b=GZJ2j65ooL2vm/ClFW7TDdwZ8UvOCJmMZZjaYrM2is1LqH4gvKPpwOv+uqtWI8HhcZ
         nPaQ2paJ3D34RKzrNIFzuqVCsxzNIXU2UdJNcNAiVZYnB5aDEyl+wtxdUWlq2hYcxMEW
         kcq2lxN8dPryf6aG4qoj6lTG1QLYaCyynJc4ujcpPXtOebmHM7Zt4kWut1IiVYnooZTB
         h4WyK20SVYF1CDvjGV97PQQ7kF2AzQhfeH3lRvII+zLsYhOSakWt6Hy2p0+0+d+6Hdee
         LncP9LkbUbLbJQZEanyB0evuUqhGC9t5Y65Exfruf6LlLlMuBYmItZ1hPZuMhbXz6XE7
         3PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPUdREpbw8JAiS9jCqv+xu5MRPBqr5k1QOevzsiVdPA=;
        b=iYXwgty40MeBoTCSguC/eJ4L6EHsaj8IuhRzMTvtmx/reJy0PVc4TEraiTvQrUDmNJ
         DMZi4FiDNkJn8ifsmByrj+fh2DtOmCL1oufap03kDp2d1kgCOkubb7Fg6UleYHnM/cu5
         B2NKfflm7jlsHR2Gw1glFmYfJyrr8i0wLNxq3Fk3yMad4sxxRzJQDIF1Rfw2i+ZbQ62Z
         JafhbpyCK92MsgMpHZGpU4OUttIr9n52jocsuEwZE+JOF9qMxGFMx8HuUGyMFGqwPn/1
         THuIyjP2WZQrA9ojj/ekSd1+bGk4/3pVkTiHsf0TjDn6nb8pdYMvEdu3o2NpxKQarW5x
         tyGQ==
X-Gm-Message-State: AJIora+MpPXBMjgpI67g3RMogey+hZgLKJ3UH3bONAdWhju3TlpATz9Y
        MS8rHQEtoJlVL/HIZO39tTtfEEX5MmyWTDxfg+nHOg==
X-Google-Smtp-Source: AGRyM1ugvM25nvYOzTXapKjUz8eqVEY534DWQ5YVZ++DDVKh3PSw2RNl9abOZWVefXRP9v8YYXkQP92bj/8QCKVyZJU=
X-Received: by 2002:a05:6e02:158a:b0:2d3:f198:9f39 with SMTP id
 m10-20020a056e02158a00b002d3f1989f39mr1556308ilu.206.1657709744036; Wed, 13
 Jul 2022 03:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org> <20220712144245.17417-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712144245.17417-3-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 12:55:07 +0200
Message-ID: <CAPDyKFoC+4JrknqyLHn=rUa1ZPzksZ-zePcEc=pyb0Aj+xAtww@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names
 per variants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 12 Jul 2022 at 16:43, Krzysztof Kozlowski
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
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes since v2:
> 1. Fix commit title typo.
> 2. Add Rb tag.
>
> Changes since v1:
> 1. Rework the patch based on Doug's feedback.
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
>  1 file changed, 38 insertions(+), 23 deletions(-)
>
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
> +
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.34.1
>
