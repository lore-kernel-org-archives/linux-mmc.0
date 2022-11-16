Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF81C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 08:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiKPIpR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 03:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiKPIpQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 03:45:16 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F79312AEA
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 00:45:15 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id h12so20905224ljg.9
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 00:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+iZ9Fna1k9JTu41E/CJL59p01aqdTab86EiWpr+Hs8=;
        b=NWyQBhQ5u2rEeABsXwdwt7LqGOiCikfiCoJ3R8pTEWImHQCLiz4Hn0gc6Wa2+QusUk
         yyGZOlE9d3t3BiC+BTJ6xMWbrYx9F4dEJcGuBhEg6bfC3bz8gaEwznUtgFE6P9JG3QK6
         OIix7fVyRb89RQ6M0T1zZRe54a0AEljIj4EXHPv4kn4ieLQAOt2gaV2gFXWqL7DIL+gs
         oIoSgp6XM6isHBVhgCAOVw/dBLIKoqtddySVw1FOIWzG4JWzlNOpqqnIf0n6PW2+WTRO
         7caLfTc+bBMw3IUyAAnnPkVK2g2TQbJnskrOFkBCxmmYQN+aovslf2DT5h2fmhMJX1TM
         Mmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+iZ9Fna1k9JTu41E/CJL59p01aqdTab86EiWpr+Hs8=;
        b=XHSuvjCSYRYseVB0QYviJlxOUoem6oIAaMvtaH+yUAGtXYdtqL94E0lor98RZ/MWnu
         lUqnDMquc66ht3h9zGt7bxiAdcZQNUCN56LEJlzqJtFrJvB+YHrRQu1hOij1Ej5C1uOx
         61KYmYinP3neXZblLu0GpqyxEgZg6n00PmgpvcoFixDhGNW7bFN/I7fnbGNpLxr7BxYT
         OT+Ml6uCmpeilPQaK9SxlUOyjtMyf8C7EyZT7UTPCMorOoReG7R/5S4T2RotCRunyZEj
         BRHDCl9WI242ECH2N9VsW0xeaUnAzF8ZHyQbt0dDQGmHf7ze248DYfGWiEvHbHRnoASE
         IQwg==
X-Gm-Message-State: ANoB5pkaQ/YstWcg8Fi+yBgfbh12FhMQRCPxe/A3HSMEKgrqVMr8Suym
        RoWs4OTz4p8+hV3B5Ok2XZVUgg==
X-Google-Smtp-Source: AA0mqf4nuVIjUjDUHg+c2GqfGBZWTb+umYdG9+jW9at8cwgtMM0JmY9kjtvnWTWMGl/TNsYnLe82lg==
X-Received: by 2002:a2e:9c41:0:b0:278:eef5:8d13 with SMTP id t1-20020a2e9c41000000b00278eef58d13mr6488665ljj.56.1668588313614;
        Wed, 16 Nov 2022 00:45:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q23-20020a056512211700b0049e9122bd1bsm2499871lfr.164.2022.11.16.00.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:45:13 -0800 (PST)
Message-ID: <2ea394ba-ae15-f3b6-da9c-d16e2f92b3af@linaro.org>
Date:   Wed, 16 Nov 2022 09:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20221116010453.41320-1-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116010453.41320-1-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/11/2022 02:04, Brad Larson wrote:
> Add support for the AMD Pensando Elba SoC System Resource chip
> using the SPI interface.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v7:
>  - Use system-controller for the device with four chip-selects
>    connected over spi.
>  - Delete child by moving reset-controller into the parent.
>  - Updated and used dtschema-2022.11 and yamllint-1.28.0
> 
> v6:
>  - Expand description, rename nodes and change compatible usage
> 
> v5:
>  - Change to AMD Pensando instead of Pensando
> 
> v4:
>  - Change Maintained to Supported
> 
>  .../bindings/mfd/amd,pensando-elbasr.yaml     | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> new file mode 100644
> index 000000000000..ac44d7d0a91a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando Elba SoC Resource Controller bindings

Drop "bindings"

> +
> +description: |
> +  AMD Pensando Elba SoC Resource Controller functions are
> +  accessed with four chip-selects.  Reset control is on CS0.
> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +properties:
> +  compatible:
> +    items:

You have only one item, so no need for list. Drop "items".

> +      - enum:
> +          - amd,pensando-elbasr
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        num-cs = <4>;
> +        status = "okay";

Drop status.

> +
> +        rstc: system-controller@0 {

Drop label.

> +            compatible = "amd,pensando-elbasr";
> +            reg = <0>;
> +            spi-max-frequency = <12000000>;
> +            #reset-cells = <1>;
> +        };
> +
> +        system-controller@1 {
> +            compatible = "amd,pensando-elbasr";
> +            reg = <1>;
> +            spi-max-frequency = <12000000>;
> +        };
> +
> +        system-controller@2 {
> +            compatible = "amd,pensando-elbasr";
> +            reg = <2>;
> +            spi-max-frequency = <12000000>;
> +            interrupt-parent = <&porta>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;

Keep only one or two examples. All others are practically the same.

> +        };
> +
> +        system-controller@3 {
> +            compatible = "amd,pensando-elbasr";
> +            reg = <3>;
> +            spi-max-frequency = <12000000>;
> +        };
> +    };

Best regards,
Krzysztof

