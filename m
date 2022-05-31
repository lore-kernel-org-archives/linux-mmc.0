Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96681C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 May 2022 13:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiEaNjS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 May 2022 09:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbiEaNjP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2022 09:39:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B08FF95
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:39:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 1so14701801ljp.8
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MU8AOeNM0UJsOQCvvfsrp6blLjd6ery6FOHTJsKqmQ=;
        b=C00OOTf+T0prvir95rinw5NOYb41i+50ujzCI6JGgg0/ZNPUwZLikh8PJi9cPgIjz/
         0VcQ81X110z2LOJC1/WQm5THL2OnTByI8HPfE9BOfOY2XN4IUqtCywLRb66rb6aRP4Vp
         6ZoAsN6CVoKa5BIS6ZGnb4gjY/a798pSLVdbUV4fLI1vZY4J0ZNh/CIsbO2KU1Twy+6O
         YUHb8I3AZFFll66yMCWp+USkFNvh+XJcLu57z4MPTZauaVzY/VMNJixpi17v4XmhlHUi
         iexJLzAj+nmOsyxwZEw/mE+ZdX3LYG0zntpgIs7ZSYrZAcoo0uE/jF79v8QD/codMlvw
         uFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MU8AOeNM0UJsOQCvvfsrp6blLjd6ery6FOHTJsKqmQ=;
        b=XUXV0LAEO85+nIiBZ0ICi+bUbGKa0Bty1Dv27RQN+0jvKrBXMYEOAMN01BDpWWv5VX
         nao9piiLLi8elcrjhzq0wyrMLvbRcc8n6ta/Q+7gWmWxleHQqc9SpjbCGmWwnSGqHXAw
         kuAyzj/bN4NGUJn7Pg2ylAKtV5IHWamUZC1nLYwpT3xbIyJb6VlSmLvqlEVrUQ1bPh7+
         2gN4IYIh5jkE+6dvkMn88XA2VDLGJvdqnPgoWn5TrB6fiWGgTJQCrp9mcnS8rIqdYcre
         bid4Xa35AsqZRZtBSQicRYW696nPDD1hJt/vtOY+W88258hikn6i2Op4XKrPzXemmxnU
         /cRw==
X-Gm-Message-State: AOAM5311w9kPZg8QNXJodhzw5sp/sRWerUwYdH75LpDK4opRlIbecexF
        /z252hFz/Q/t2rgxiyc7xks8S6GSI5qJjyf3E643fQ==
X-Google-Smtp-Source: ABdhPJzfxPBr1Pl55mbXLZavP23t6aFW7yYp8/aJ7Txnm0dobZrjHVwcsIneHw2JefVXX07NEzTgOsJhGiICzZ1Ay7o=
X-Received: by 2002:a2e:a286:0:b0:253:bff6:ed52 with SMTP id
 k6-20020a2ea286000000b00253bff6ed52mr37140754lja.229.1654004350751; Tue, 31
 May 2022 06:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220514220116.1008254-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220514220116.1008254-1-bhupesh.sharma@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 May 2022 15:38:34 +0200
Message-ID: <CAPDyKFpR6kzU4SAZp5DyqSxJ6CfjwZCDMvZ-XGKk__k_8=VdGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        bjorn.andersson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 15 May 2022 at 00:01, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Rob pointed some remaining issues in the sdhci-msm yaml
> bindings (via [1]).
>
> Fix the same by first using the 'mmc-controller.yaml' as
> 'ref' and thereafter also fix the issues reported by
> 'make dtbs_check' check.
>
> [1]. https://lore.kernel.org/linux-arm-msm/YnLmNCwNfoqZln12@robh.at.kernel.org/
>
> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to yaml")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
> -> This patch uses the dts changes sent (here: https://lore.kernel.org/linux-arm-msm/20220514215424.1007718-1-bhupesh.sharma@linaro.org/), for fixing the dtbs_check errors.
> -> This patch is rebased on 'linux-next/master'
>
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 52 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index e4236334e748..31a3ce208e1a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -17,6 +17,9 @@ description:
>  properties:
>    compatible:
>      oneOf:
> +      - enum:
> +          - qcom,sdhci-msm-v4
> +        deprecated: true
>        - items:
>            - enum:
>                - qcom,apq8084-sdhci
> @@ -27,6 +30,9 @@ properties:
>                - qcom,msm8992-sdhci
>                - qcom,msm8994-sdhci
>                - qcom,msm8996-sdhci
> +          - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
> +      - items:
> +          - enum:
>                - qcom,qcs404-sdhci
>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
> @@ -38,12 +44,7 @@ properties:
>                - qcom,sm6350-sdhci
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
> -          - enum:
> -              - qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
> -              - qcom,sdhci-msm-v5 # for sdcc version 5.0
> -      - items:
> -          - const: qcom,sdhci-msm-v4 # Deprecated (only for backward compatibility)
> -                                     # for sdcc versions less than 5.0
> +          - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
>    reg:
>      minItems: 1
> @@ -53,6 +54,28 @@ properties:
>        - description: CQE register map
>        - description: Inline Crypto Engine register map
>
> +  reg-names:
> +    minItems: 1
> +    maxItems: 4
> +    oneOf:
> +      - items:
> +          - const: hc_mem
> +      - items:
> +          - const: hc_mem
> +          - const: core_mem
> +      - items:
> +          - const: hc_mem
> +          - const: cqe_mem
> +      - items:
> +          - const: hc_mem
> +          - const: cqe_mem
> +          - const: ice_mem
> +      - items:
> +          - const: hc_mem
> +          - const: core_mem
> +          - const: cqe_mem
> +          - const: ice_mem
> +
>    clocks:
>      minItems: 3
>      items:
> @@ -121,6 +144,16 @@ properties:
>      description: A phandle to sdhci power domain node
>      maxItems: 1
>
> +  mmc-ddr-1_8v: true
> +
> +  mmc-hs200-1_8v: true
> +
> +  mmc-hs400-1_8v: true
> +
> +  bus-width: true
> +
> +  max-frequency: true
> +
>  patternProperties:
>    '^opp-table(-[a-z0-9]+)?$':
>      if:
> @@ -140,7 +173,10 @@ required:
>    - clock-names
>    - interrupts
>
> -additionalProperties: true
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +unevaluatedProperties: false
>
>  examples:
>    - |
> @@ -149,7 +185,7 @@ examples:
>      #include <dt-bindings/clock/qcom,rpmh.h>
>      #include <dt-bindings/power/qcom-rpmpd.h>
>
> -    sdhc_2: sdhci@8804000 {
> +    sdhc_2: mmc@8804000 {
>        compatible = "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5";
>        reg = <0 0x08804000 0 0x1000>;
>
> --
> 2.35.3
>
