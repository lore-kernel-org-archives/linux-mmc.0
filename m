Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C4C38142
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 07:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjASHvQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Jan 2023 02:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjASHuO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2023 02:50:14 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676168431
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 23:48:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l8so808044wms.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2023 23:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PC9kS18Wll2AIQihxyRmnUEmQXzt8UktjRNi3JOWYos=;
        b=xzNjd2p0KKya2Qvs4jDOJHV/p2qR0PS9AbOSQ3eoeFqiAFXsgR3iRWNx+icJztnBs4
         uWLg6VpEikIUqhaL2yQapXVVaphDxGuXCZ6CMCxkLp1LL7VhHoP+gqrX0jAbzxttrT0/
         7lygOb2g2ShrwBvChxrlQU4OdM4PetPUFSOztpnziiF/wNog9GFA+tSpVcWBlfC7DnkN
         lpFd+YCfbL9ll47bEG1TiuoXM8/0D1NLb6TUAinD83KAFANMjkf1wtZ7XNrS2KiIO1af
         vle1nBkvAYiQwx7BxNZyehMILbJZ2I8Y1zQF03m9KBXkLR3Qyg0+vmtmbQdy8hwQ9UnS
         okMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PC9kS18Wll2AIQihxyRmnUEmQXzt8UktjRNi3JOWYos=;
        b=msNgkl2Ri8J3Q16lP4x3Yyg89iptVQHLuX3GIwM0GI1STvKEk5Ggt41aXCMsuEUPqG
         iLZoXHL+XJTQis6a0hqS5dzmw0XKl+OwatrC7gMcEDxBgUfKapbhNIgr72ZhhzV7Nm95
         rIO/RJLwhyBArff33kyitYtzIBQHgC/ccBGX7oEUdi5n9ph5cSNKR7gNs8gp4K2AG4eF
         z9SByO8nRF3VBcjg7AanX02cC0dRI6tYiIgIhPYIW2zOf9wfeaDpNnN7L0vkl2iIBIsk
         vQh4XQ69MFYh49y184LK245Mam797tC/U+V0/Af0SU5qc5KTvggFsHDvfjiF+gn1Ncg7
         S2Cg==
X-Gm-Message-State: AFqh2kqRJc4KBjVdPc8mc7+MzeTGvxHrxeMx5ORefdFayJFEqfPdIKV0
        ck2hEGYJ2kq1RTd+mVmiNuT/VQ==
X-Google-Smtp-Source: AMrXdXsT2dEW8VN8N4NTKGUY5keJk+HFf0/azc5a5xF6GRkvFOqTu6YpbOqPWBM8626gv9nyhQTeIA==
X-Received: by 2002:a05:600c:3c8a:b0:3da:2a78:d7a4 with SMTP id bg10-20020a05600c3c8a00b003da2a78d7a4mr9182200wmb.21.1674114486962;
        Wed, 18 Jan 2023 23:48:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003db11dfc687sm3947109wmc.36.2023.01.18.23.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:48:06 -0800 (PST)
Message-ID: <06ed53f8-42eb-4b14-a867-64086e8b9998@linaro.org>
Date:   Thu, 19 Jan 2023 08:48:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
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
 <20230119035136.21603-3-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119035136.21603-3-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/01/2023 04:51, Brad Larson wrote:
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> 
> ---
> 
> Changes since v6:
> - Add reset-names and resets properties
> - Add if/then on property amd,pensando-elba-sd4hc to set reg property
>   values for minItems and maxItems
> 
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8b1a0fdcb5e3..f7dd6f990f96 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -16,12 +16,14 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - amd,pensando-elba-sd4hc
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    interrupts:
>      maxItems: 1
> @@ -111,12 +113,36 @@ properties:
>      minimum: 0
>      maximum: 0x7f
>  
> +  reset-names:
> +    items:
> +      - const: hw
> +
> +  resets:
> +    description:
> +      optional. phandle to the system reset controller with line index
> +      for mmc hw reset line if exists.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
>  
> +if:
> +  properties:
> +    compatible:
> +      const: amd,pensando-elba-sd4hc

BTW, this probably won't even work and that's the answer why you added
fake maxItems: 2... This should make you think about the bug. You must
use contains.

Best regards,
Krzysztof

