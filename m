Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6360C678D4
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Mar 2023 08:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCFIf0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Mar 2023 03:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCFIfY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2023 03:35:24 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344B1989
        for <linux-mmc@vger.kernel.org>; Mon,  6 Mar 2023 00:35:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a25so35375895edb.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Mar 2023 00:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nN8hnlwfz8+ce8joyQQpCWO6wj7vGVxMm5Tglv40eos=;
        b=VnukSFaI2Jh72zC5zVTYj6OqsJ67u4W4GvYZ/+lo5hN0TleUBwKvBFgaAVpcCTOLWR
         IP1m0T99iQvIAJZ236u5NnPGzzmkYdZaoYy85U7LXRuTkzPH3UBsg9THLv4TteSMO1NM
         fd1Pje1dM4UHon3YSAIEQ9/GS8x6y7EsMNQckV3TYH6aHnWCcrGrvP9+qCDDDz99zHcM
         60Cxty8vHa96CaZIUMn0swff3BHCaIO4Daux7ub7VHS0eQpXJxIqc1K3Y3n4/pA3RbTY
         JS3ky6c5Aaesl9FuX0U77MQvc6jhwERWLZS5dTfYLP5UX7S929LgpWJnn5YAmDWQwYkS
         RJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nN8hnlwfz8+ce8joyQQpCWO6wj7vGVxMm5Tglv40eos=;
        b=8QnDeSJoYRUJxkofRr7bBCnHfkUQzxlFdbWbLG2luNk8t7uXTRbRoFR0FXlIv7BErZ
         TGSkNUuXe4CQqJcperHlvGC3gWNiiEaBWV5ZktQ7yLc4lnCoGEDQu2lHsi55QSO//lFj
         bPRPRqFq3eUXcJblInYVMe3W5cmz46iG57KtPZXtbQ23XoPIm3o5zjNYBK4QMR1Ccmo0
         V1uUCcIZT7PHLr+Uy3o05e2SzJouS1T/u7DQfSm0WCf12TOaLHwyNcy5zAf3qP147rKd
         mhwsksSXKCL3WabHHH2cnOhuFh4F/VIR40RiPoGv2tEV7oJxmBzW7ted7CMnh8uU96gX
         szdQ==
X-Gm-Message-State: AO0yUKXHQOIhPiir5cfDcj838Qh0k57AlplbjKy/K8ieRxnfvJ7Ox5ey
        6Ox6FYvwaf/dr0hrKwjLlCiR+g==
X-Google-Smtp-Source: AK7set81IcxNtGSCYERU2VMxJvO0ODonStu1WSmxu02pH8FU4qAFpYWL2Z4vNdL5gk5ykFDPS0q6qA==
X-Received: by 2002:aa7:c544:0:b0:4ab:cb8c:932b with SMTP id s4-20020aa7c544000000b004abcb8c932bmr8058861edr.40.1678091721188;
        Mon, 06 Mar 2023 00:35:21 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id k2-20020a50ce42000000b004bc59951d6fsm4761162edj.57.2023.03.06.00.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:35:20 -0800 (PST)
Message-ID: <52fb81e2-0d9b-600d-42af-1405fdd6509b@linaro.org>
Date:   Mon, 6 Mar 2023 09:35:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 05/15] dt-bindings: soc: amd: amd,pensando-elbasr: Add
 AMD Pensando SoC System Controller
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-6-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306040739.51488-6-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/03/2023 05:07, Brad Larson wrote:
> Support the AMD Pensando SoC Controller which is a SPI connected device
> providing a miscellaneous set of essential board control/status registers.
> This device is present in all Pensando SoC based designs.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v10 changes:
> - Property renamed to amd,pensando-ctrl
> - Driver is renamed and moved to soc/drivers/amd affecting binding
> - Delete cs property, driver handles device node creation from parent num-cs
>   fixing schema reg error in a different way
> 
> v9 changes:
> - Instead of four nodes, one per chip-select, a single
>   node is used with reset-cells in the parent.
> - No MFD API is used anymore in the driver so it made
>   sense to move this to drivers/spi.
> - This driver is common for all Pensando SoC based designs
>   so changed the name to pensando-sr.c to not make it Elba
>   SoC specific.
> - Added property cs for the chip-select number which is used
>   by the driver to create /dev/pensr0.<cs>
> 
> ---
>  .../bindings/soc/amd/amd,pensando-ctrl.yaml   | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
> new file mode 100644
> index 000000000000..36694077b2e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml

Your subject suggests this is pensando-elbasr but you write everywhere
pensando-ctrl. Confusing. Pick one.

> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/amd/amd,pensando-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando SoC Controller
> +
> +description: |

No need for |

> +  The AMD Pensando SoC Controller is a SPI connected device with essential
> +  control/status registers accessed on chip select 0.  This device is present
> +  in all Pensando SoC based designs.
> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +properties:
> +  compatible:
> +    contains:

Drop 'contains'. That's not a correct syntax here.

> +      enum:
> +        - amd,pensando-ctrl
> +
> +  reg:
> +    minItems: 1

maxItems instead

> +
> +  '#reset-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency: true

Drop, not needed.

> +
> +required:
> +  - compatible
> +  - spi-max-frequency
> +  - '#reset-cells'

allOf with ref to spi-peripheral-props.yaml

> +
> +unevaluatedProperties: false

This is not correct without allOf (should be additionalProperties if you
are not using allOf), which leads you to the missing allOf.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        num-cs = <4>;

Drop num-cs, not important in this context.

> +
> +        system-controller@0 {
> +            compatible = "amd,pensando-ctrl";
> +            reg = <0>;
> +            spi-max-frequency = <12000000>;
> +            interrupt-parent = <&porta>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +            #reset-cells = <1>;
> +        };
> +    };
> +
> +...

Best regards,
Krzysztof

