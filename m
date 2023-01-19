Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1AEC00A5A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 07:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjASH6m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Jan 2023 02:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjASH6i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2023 02:58:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A0485AE
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 23:58:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b7so998486wrt.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 23:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A87f+K2WTXdoCGceYD+AGSAQsZPXfl/8rp/UashgG5g=;
        b=by1JYrCEzb+SkL+NHJgJJhXT8ouDNyJoXeJezsN/J/O/QQBXAMmoQxAt/GMyOadOLR
         5AhLXz+SIqectds76zxXx40lNcHsySoQv3AdXXsUw/k+zIk0s8+hjfUNmC932Feo2k+F
         07zgqKmtSTU8nGJd0drOK7ho+En9d4PqCt0NvzkIbcDUpzmJRDxeMgjgl3qymbI+hUwc
         uoctMwTA3/c18LbJ4a0CqhT8JC7/eQfHHLN7sxdyyvwfhG1o9YIwWX9rWHOzsAXPy3w6
         0EXkgMUvmdoQ4qJDmtoxb/pWRyBVp3cBZhjVJgTGFfjIe+fDwXWb+471jZZVR54FY6NZ
         ZuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A87f+K2WTXdoCGceYD+AGSAQsZPXfl/8rp/UashgG5g=;
        b=JQdio+60qzKKwz7r9Ysn0WPegAqF8l05yQHBncoUEn+SkZYVQaCIsbgUBCdsb7zd3Z
         tg2exLxcUYZzDqdaNJCmC2o0KX6rHSUmvbTkdDIiIqGW0BBggEwrtwIkbS27l7U7sLvV
         S30Gx6j7uUEPkaUhZbg85ecr3+vnxV8Jvq1hFZjJKfgj/YBVWqwAfgPdWnC4dYI5k84C
         ldqsnoQXC4mkFPLBAzCEiRQ940iwXP9z49lbmQ37WGZq5V3jl3mAcMLVgBuaLFiDRXSf
         Y4azW83P1Vl8N5XhPytB3s2GPfi2qxieICzc9gkiIuO7CuG+IMzpp+cCqZ8PpC/kA2kB
         SUHA==
X-Gm-Message-State: AFqh2koAtZy0yuhKE+xNaHGYAcj5nuudjxKxQMFsdFvJlJ83BWI0x6WL
        6eiWRl3AgsTSJHA0LnK0Pvqcg8tATdYdzB4W
X-Google-Smtp-Source: AMrXdXtYyXNI2A4TAo+RnQGc+R4Oq+uuNR4IxX1jxGb8yGdFRYTyCEGKPbY/pXAejVIOOSaI4O7YrA==
X-Received: by 2002:adf:dc81:0:b0:2bc:7f99:f2a with SMTP id r1-20020adfdc81000000b002bc7f990f2amr8931253wrj.54.1674115113319;
        Wed, 18 Jan 2023 23:58:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm32722039wrx.21.2023.01.18.23.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:58:32 -0800 (PST)
Message-ID: <a3c4feaf-c98d-5507-11f1-3dd1129f7360@linaro.org>
Date:   Thu, 19 Jan 2023 08:58:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando System Resource chip
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230119035136.21603-1-blarson@amd.com>
 <20230119035136.21603-7-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119035136.21603-7-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/01/2023 04:51, Brad Larson wrote:
> Add support for the AMD Pensando SoC System Resource chip using the
> SPI interface.  The device functions are accessed using four
> chip-selects.  This device is present for all Pensando SoC designs.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> Changes since v6:
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
>  .../bindings/spi/amd,pensando-sr.yaml         | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
> new file mode 100644
> index 000000000000..8504652f6e19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/amd,pensando-sr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando SoC Resource Controller
> +
> +description: |
> +  AMD Pensando SoC Resource Controller is a set of
> +  control/status registers accessed on four chip-selects.
> +  This device is present in all Pensando SoC based designs.
> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +properties:
> +  compatible:
> +    contains:

That's not correct syntax. Please start from existing schema or
example-schema. Drop contains.

> +      enum:
> +        - amd,pensando-sr
> +
> +  reg:
> +    minItems: 1

maxItems. Which example or existing schema pointed you to use minItems?

> +
> +  cs:
> +    minItems: 1
> +    maxItems: 4
> +    description:
> +      Device chip select

Drop entire property. Isn't reg for this on SPI bus?

> +
> +  '#reset-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency: true

Drop. Missing reference to spi-peripheral-props.

> +
> +required:
> +  - compatible
> +  - cs
> +  - spi-max-frequency
> +  - '#reset-cells'
> +
> +unevaluatedProperties: false

This does not make sense on its own. It works with additional ref. When
you add ref to spi props, it will be fine. But without it you should use
additionalProperties: false.


Best regards,
Krzysztof

