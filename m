Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C2EC6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 13:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCLNfI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCLNfH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 09:35:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D59538E8E
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 06:35:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r15so11438047edq.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678628103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEy15IgizVlf+Q9dGMMXqxj6sA+dHE7lG7Ni6ZtT2Pc=;
        b=bDN6UFd5fT779GvI34v6sFk1xxdXz7Ymq4Z9/UOvQkPtG70Nju0M9LsSjp5qI+7Mmp
         HheEbCkZvDLcgiqkBlHbjEXc8OXxeC4FtldN2FqqrhmBVDO5OQ6dcD1UK18Vj5Z4Z23V
         0gSp4900kovZVtObjg2WjSl/flE8LGhDS/WZlYi6lVb/yq3nHh0WARy5257ykkLLWUJS
         VJkrqagUn46UhcUmQoi920jMsyZMHowP1vRvbGRn3Jv7seDJbcLkYbVhewGZyIHmj0Ap
         wi/kht0sFjfqytBI7a9FbdppaXch6bv8D38PzpN9dFZQ1XFiQ0/wOY1FwLpi7lVypO7g
         283Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678628103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEy15IgizVlf+Q9dGMMXqxj6sA+dHE7lG7Ni6ZtT2Pc=;
        b=PrF+zm7fvqRonP+PccDn+08WOG7OItwlqERSER99k2Vimxm2an+JwvKBWD7O0g36cq
         w6MSwomYEbaR7G1YIJZlrRRrDaylamKVWWHwEXznRJjlE6wB9e+eFMtsf5IVmUYl94LZ
         zQ8/lTWnJLtar0oRbeaYOy27j/iHL404gvbpiWoZBhPCZgy2TRGAJyo6y9zfjOasL/u5
         oSMGfbqUsSTaDOgoc/M1l2hiqXJKAIObs1jdq+MbiW2XMelNl2YPhizUrwEHImy5Hx6f
         DlLDP9lh8BcBy+7nCjDDNtXn73orm4EYOr7bzw2DjyokJjmWnkIaV3qE/Fc9/yTa5rf7
         1GRA==
X-Gm-Message-State: AO0yUKWysqEfKYIiGoFQa03mRIILH25XKsCtvkaSRmtT9+vqT51O+CGB
        mLVZVXQpWw7dnt6WPRBxptx1Bw==
X-Google-Smtp-Source: AK7set94c7O8E3yeBV2VwX+Bv8RrZog7eK5S2Y+9NomVsxXX/RZr2+U9wHBQ7yZGizKO6TlRl9dM3Q==
X-Received: by 2002:a05:6402:334:b0:4b0:f559:ed48 with SMTP id q20-20020a056402033400b004b0f559ed48mr30780565edw.22.1678628102791;
        Sun, 12 Mar 2023 06:35:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id v21-20020a50d595000000b004f9ca99cf5csm2055373edi.92.2023.03.12.06.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 06:35:02 -0700 (PDT)
Message-ID: <c9f8d89e-7420-a049-907c-60e3fa551548@linaro.org>
Date:   Sun, 12 Mar 2023 14:35:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1678626510.1783316-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678626510.1783316-1-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 14:03, Sergey Lisov wrote:
> Some Samsung Exynos boards using the arm64 architecture have DW MMC
> controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
> systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
> 
> Add two new compatible strings, "samsung,exynos78xx-dw-mshc" and
> "samsung,exynos78xx-dw-mshc-smu" respectively, to denote exynos78xx
> boards that need this quirk. But it's very possible that all
> "samsung,exynos7-dw-mshc" boards are actually affected.
> ---
>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml         | 2 ++
>  arch/arm64/boot/dts/exynos/exynos7885.dtsi                      | 2 +-

Bindings and DTS (and driver) are always separate.

>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> index fdaa18481..a72a67792 100644
> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> @@ -22,6 +22,8 @@ properties:
>        - samsung,exynos5420-dw-mshc-smu
>        - samsung,exynos7-dw-mshc
>        - samsung,exynos7-dw-mshc-smu
> +      - samsung,exynos78xx-dw-mshc
> +      - samsung,exynos78xx-dw-mshc-smu

Compatibles must be specific.

There is also no fallback, but I assume that's intentional - you say
these are not compatible?

>        - axis,artpec8-dw-mshc
>  
>    reg:
> diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> index 23c2e0bb0..4b94ac9da 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> @@ -294,7 +294,7 @@ pmu_system_controller: system-controller@11c80000 {
>  		};
>  
>  		mmc_0: mmc@13500000 {
> -			compatible = "samsung,exynos7-dw-mshc-smu";
> +			compatible = "samsung,exynos78xx-dw-mshc-smu";

That's non-bisectable change (also breaking other users of DTS), so you
need to explain in commit msg rationale - devices were never compatible
and using exynos7 does not work in certain cases.



Best regards,
Krzysztof

