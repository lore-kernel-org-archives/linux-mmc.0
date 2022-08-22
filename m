Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CF5C3F6B0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Aug 2022 18:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiHVSTf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHVSTe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2022 14:19:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9D43E70
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 11:19:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id l1so15907557lfk.8
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=IUUq+zBZLLg7nojFWalzeoFMBrQ1c6+AbxuzsjXnnkg=;
        b=qwv6CgAI+Xx/7UTpw6T/ZwxnK4PJa+dbt690i+fuM/1sif7ZADV/O9QXCEJRlnKjZE
         Ru3jeVaAfUzF7cF34EncOm3b6aFamhkKhhbZVgtwmURwlLh9YyNsAUphwo08z8XJt49e
         Z5LgmPb66CsA24nrNJN9alP/0l7nQyZII/eRhuQheF6Vod3YIeBhxfDPDKReQL8CZePc
         NwOulHDWQMcwsM2rvkoCfNu4RsQsAYfxVI7j/fejE4eZen/g3YIXTyFDo4UOv5XcJakH
         lT2L0ox1+PS016xsibOIxwnTk8AKkWPHlEs+8ZabMrvevqIeLvPMJ1CDPgKAuuSB8NRd
         y10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=IUUq+zBZLLg7nojFWalzeoFMBrQ1c6+AbxuzsjXnnkg=;
        b=N+fxCM69KbDxHO/Xu860W5Q8fdk6pO5umvc8kdbgPuTPnR9iK/PkAx89rAywEMOh2P
         OPzstLnZXdj8pZhmGpjYajQYzKEcnaT4VKQc1ik16ZfGV2/TtKbnGTxwXF7txNnDSFEi
         x9Jlt7aNXmMhf7ia55rvDSW6ItLIiQUiRzDJboDxbVjHt6DNvAR44L9IrNoTg73k8xA1
         v4VeIYL/dhBFAQXZvjspzr91qhU19CodeBHfIvU3+ICsi6ALx21jT14LsPl2dz4d1cnz
         4AlvrpyeAIOU/S5xp1KviySfM21W9K8RCe5RL2B78+MswfTwcZmURj272GEhtaM9uzrx
         DTGw==
X-Gm-Message-State: ACgBeo2hwerMiId8EwQTk+8v0Gv+uqxDJiSdZtTiV0CNLvrQAxTQNl6g
        KMgMl8Ayir2ZFYgOqFahWwlV/G+xr3+WoDzf
X-Google-Smtp-Source: AA6agR4NQSLOz5tBwgjn8bV1QR7qbJBs3EDjgJIHcoMa/jKzn+hSicxXOXpcYEVPQ7N2K9pjbl2zkg==
X-Received: by 2002:ac2:4d45:0:b0:492:d8a2:de61 with SMTP id 5-20020ac24d45000000b00492d8a2de61mr4449767lfp.313.1661192371259;
        Mon, 22 Aug 2022 11:19:31 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id t5-20020a195f05000000b00491734dcb89sm2028163lfb.196.2022.08.22.11.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:19:30 -0700 (PDT)
Message-ID: <ff2e2037-b1c6-8c0c-a0b1-41986522a2c8@linaro.org>
Date:   Mon, 22 Aug 2022 21:19:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
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
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-5-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220820195750.70861-5-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/08/2022 22:57, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml      | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 37c3c272407d..403d6416f7ac 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,15 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amd,pensando-elba-spi
> +    then:
> +      required:
> +        - amd,pensando-elba-syscon

There is no such property. You cannot make it required without first
defining it.

>  
>  properties:
>    compatible:
> @@ -75,6 +84,8 @@ properties:
>                - renesas,r9a06g032-spi # RZ/N1D
>                - renesas,r9a06g033-spi # RZ/N1S
>            - const: renesas,rzn1-spi   # RZ/N1
> +      - description: AMD Pensando Elba SoC SPI Controller
> +        const: amd,pensando-elba-spi

Don't add stuff at the end, but in some logical (usually alphabetical)
place. The order is already broken as everyone likes to add stuff in
conflict-style, so just add it before baikal, for example.


Best regards,
Krzysztof
