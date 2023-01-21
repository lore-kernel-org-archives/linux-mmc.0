Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002B0C004D4
	for <linux-mmc@archiver.kernel.org>; Sat, 21 Jan 2023 18:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAUS5K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 21 Jan 2023 13:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAUS5J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Jan 2023 13:57:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0161140E0
        for <linux-mmc@vger.kernel.org>; Sat, 21 Jan 2023 10:57:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r2so7478542wrv.7
        for <linux-mmc@vger.kernel.org>; Sat, 21 Jan 2023 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFIsuTdWlrwQOTf1CbRte8ztz1IctUB0UWMATDFDLyI=;
        b=oGiUtj0aoYKHqpNz/tW/5M8TsTMmxVCCkEDnzXKPh5oYB6WS6LSY4/rf6jzugCyCeV
         Vw9/GzvHPpaqB6tvXmysPjVt2V/BB10I4sr95wgflIDiWugUZf9TqvXdfw+X7rYQx0M7
         bj8Hc8rqwvtF3q0QpKaB/sfrCe9vXadAnEmAbo+KEX9GSb8Zt8PYw/Xq0xtoy1775sgX
         qCZxfOFNiNX3KgaWY9TB/30BoXgltCdl7Cm+6NJcwHNnwKHLWcYj4lQ7W6VTTQrCea/K
         +2pl6nUxX5tYjeF55XoCu1G/YrT5u55sRXTnIhmpTf0/1QHh7VrSLd3OZv1waxHLX3wL
         scEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFIsuTdWlrwQOTf1CbRte8ztz1IctUB0UWMATDFDLyI=;
        b=WGAskf4L0qlkAy517IwO3Mj5tcsE5xAHoA5E3a6Ue1iTnwuU9x7x85lfXrzTEOU3gS
         8pWkT0X07DTsRM8mdiWvNjgD7+WPheVjt6tS85ekRpreAxFNBg6Sw/G2MVuwPCJHIdqI
         49f0cFVlIzm9Fxf30uXyx2jE8C48THrCT1DHT4sCnGOahgtXaCM8O+Q/JBs4KHHvd7+K
         +jfDvcF9VtxH7qHrePYVwKATStD/lXNxEXe3tM3Ebe0aXuQiypLrpy21Iqnw+9JFmLk/
         k7SaRpaozloAhGhu6UGPS9nvYJECjIeG9JaLPVM+5y1VSjxprt8q2JW+mtKfCEwdku1N
         syfw==
X-Gm-Message-State: AFqh2kqSz3bSCWDy38UaoY1R8zOm5eaqwZu1QHkif7X/cvN0KK5hFLfo
        iY59adgCH+azZ14EytYGq8UJ3Q==
X-Google-Smtp-Source: AMrXdXt1q1YuvTu5Dd5G/0qnIktkSIElMwkz4o/ZEZWuTZR8ntFo9qnXoeVZYpjkshqeHeUknS2jxg==
X-Received: by 2002:adf:e70a:0:b0:2b5:90e:cfa5 with SMTP id c10-20020adfe70a000000b002b5090ecfa5mr16667862wrm.29.1674327426596;
        Sat, 21 Jan 2023 10:57:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600011ca00b002bf94527b9esm3365260wrx.85.2023.01.21.10.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 10:57:06 -0800 (PST)
Message-ID: <f3ec87a3-1a67-9d65-e470-eb527ffd6e0b@linaro.org>
Date:   Sat, 21 Jan 2023 19:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>
Cc:     adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, broonie@kernel.org,
        catalin.marinas@arm.com, davidgow@google.com,
        devicetree@vger.kernel.org, fancer.lancer@gmail.com,
        gerg@linux-m68k.org, gsomlo@gmail.com, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        lee@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, p.yadav@ti.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, rdunlap@infradead.org, robh+dt@kernel.org,
        samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, yamada.masahiro@socionext.com
References: <f85cdf27-7ea0-14a8-10b0-7a9ac137a040@linaro.org>
 <20230121011004.38654-1-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121011004.38654-1-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/01/2023 02:10, Brad Larson wrote:
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
>  
> +allOf:
> +  - $ref: mmc-controller.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-sd4hc
> +    then:
> +      required:
> +        - reset-names
> +        - resets

Looks correct, just put required: after properties: below.

> +      properties:
> +        reg:
> +          minItems: 2
> +    else:

Best regards,
Krzysztof

