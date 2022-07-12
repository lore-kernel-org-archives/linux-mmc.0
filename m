Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A39CCA47C
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 11:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiGLLJ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiGLLJt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 07:09:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C21AF76B
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:09:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n18so11638127lfq.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tdpS+5ubtJGGOPxmM+nq8jqWPaOVB3css9TAtAfGOI=;
        b=dteUqy18Cu6l5q1qpmyWbmh9SYyiDuauhyzK2n+Z2mGTQ4ORfsZunyy6Q+IBXc9Z8p
         MuFm4eDCr83xxUP9tEjS5YIsh2UsnX3GhgEVF5lrRLpuaqFVxBnWqLfXhnCtmasg01Xi
         JnXIgsdOWJrXt4cK2vMX7u9QjReHadYuuTBxKApN4Su2/yCB+IjKzXCN11TSQyuoxI84
         KABZGqlheVrcJ1HJdu+y2S+3VsWwVi+VCRw1y4UtbkXJpDycJ/VO3513W8eg3zpSyFZF
         pdQ1Ri80+whrgJ0Z1VdfRh2karl6cJzhPzUa9zMviVi0qHSyqjZXlCorlfX8ve1VT0XN
         7MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tdpS+5ubtJGGOPxmM+nq8jqWPaOVB3css9TAtAfGOI=;
        b=thA32i01LJAHH2+77LRJZudDgu6Awfzjj36+wWmB2CWg6UAFb2c3J5qJz1oZkSGRrH
         gjEbIRwbDjUBqfNwwRQuWGnzLpoaRf4H2z1FrEJHAgRp+lf21j54NVVMDG/GQ5LdoFhB
         6YKDJB2MbwclEvCjiuC+X7Fr13mmXSeegDALtBH4A2ACZwpr9ILVfQIuq0/sDgDMK7Db
         6IoFYHSufPXW/p3xjjkpy8Vwyk7j0XbK8VfvyOrLTKeUdaiC7Ihb4w3aGQCJVkPup+Es
         24D0WmEgRMBdZDfXq/zdraTQYE2vs5gLCvMn4TfUGUlQPKB74IjXOzZezZjZRPc8aVT0
         amjQ==
X-Gm-Message-State: AJIora9asPJPx7LIFnH7eeviFup98EomDAi2m4o5/qNwaMugZsmAXUhK
        /c+9aMPvtkgPxH6VwjK2x0f2u3ThSbxPUyRZzAxA8w==
X-Google-Smtp-Source: AGRyM1uFxb+BdqIl3tBJoT69LzidPBHC05qJXBK5HhG4NGNDzrGe14N2yRhxnWHlCAwRx8kw9OJIiWPSW1zrRwjYsHk=
X-Received: by 2002:a05:6512:3403:b0:481:60ae:7ebc with SMTP id
 i3-20020a056512340300b0048160ae7ebcmr15210209lfr.358.1657624185645; Tue, 12
 Jul 2022 04:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org> <20220626120342.38851-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220626120342.38851-6-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:09:08 +0200
Message-ID: <CAPDyKFqvkYEHLMV67an9=1iu0jwewZNA=Mj0Erg30oJ_CEmxMw@mail.gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: mmc: samsung,s3c6410-sdhci: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 26 Jun 2022 at 14:03, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Convert the Samsung SoC SDHCI Controller bindings to DT schema.
>
> The original bindings were quite old and incomplete, so add during
> conversion typical (already used) properties like reg, clocks,
> interrupts.
>
> The bindings were not precising the clocks, although the upstream DTS
> and Linux driver were expecting bus clocks in certain patterns in any
> order.  Document the status quo even though it is not a proper approach
> for bindings.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/samsung,s3c6410-sdhci.yaml   | 81 +++++++++++++++++++
>  .../devicetree/bindings/mmc/samsung-sdhci.txt | 32 --------
>  2 files changed, 81 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml b/Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
> new file mode 100644
> index 000000000000..5d873a60f650
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/samsung,s3c6410-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC SDHCI Controller
> +
> +maintainers:
> +  - Jaehoon Chung <jh80.chung@samsung.com>
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s3c6410-sdhci
> +      - samsung,exynos4210-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 5
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: hsmmc
> +      - pattern: "^mmc_busclk.[0-3]$"
> +      - pattern: "^mmc_busclk.[0-3]$"
> +      - pattern: "^mmc_busclk.[0-3]$"
> +      - pattern: "^mmc_busclk.[0-3]$"
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos4210-sdhci
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: hsmmc
> +            - const: mmc_busclk.2
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/exynos4.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mmc@12510000 {
> +        compatible = "samsung,exynos4210-sdhci";
> +        reg = <0x12510000 0x100>;
> +        interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clock CLK_SDMMC0>, <&clock CLK_SCLK_MMC0>;
> +        clock-names = "hsmmc", "mmc_busclk.2";
> +        bus-width = <4>;
> +        cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
> +        pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sdhci2_cd>;
> +        pinctrl-names = "default";
> +        vmmc-supply = <&ldo21_reg>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> deleted file mode 100644
> index 42e0a9afa100..000000000000
> --- a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -* Samsung's SDHCI Controller device tree bindings
> -
> -Samsung's SDHCI controller is used as a connectivity interface with external
> -MMC, SD and eMMC storage mediums. This file documents differences between the
> -core mmc properties described by mmc.txt and the properties used by the
> -Samsung implementation of the SDHCI controller.
> -
> -Required SoC Specific Properties:
> -- compatible: should be one of the following
> -  - "samsung,s3c6410-sdhci": For controllers compatible with s3c6410 sdhci
> -    controller.
> -  - "samsung,exynos4210-sdhci": For controllers compatible with Exynos4 sdhci
> -    controller.
> -
> -Required Board Specific Properties:
> -- pinctrl-0: Should specify pin control groups used for this controller.
> -- pinctrl-names: Should contain only one value - "default".
> -
> -Example:
> -       sdhci@12530000 {
> -               compatible = "samsung,exynos4210-sdhci";
> -               reg = <0x12530000 0x100>;
> -               interrupts = <0 75 0>;
> -               bus-width = <4>;
> -               cd-gpios = <&gpk2 2 0>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
> -       };
> -
> -       Note: This example shows both SoC specific and board specific properties
> -       in a single device node. The properties can be actually be separated
> -       into SoC specific node and board specific node.
> --
> 2.34.1
>
