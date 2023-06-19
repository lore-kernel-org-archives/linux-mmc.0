Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9D4EB64DB
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jun 2023 12:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjFSMYT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jun 2023 08:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjFSMYN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 08:24:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF6FE64
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 05:23:35 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b4790ff688so13344561fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687177409; x=1689769409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSP20PRjLfEjEczhmjfYNlia/vcSKNLRdUGUz9NHLWk=;
        b=yo+Z+f5JTD4zf+O3aNYVki4aAyWmqo9AGYDhyQXjeCuyotDVx5sjiU3lNnxu5dNF4r
         gWi9toGSJ0qggbyNgYt83JM5CmBlAoJk5Na/Rxh8xLCneHmgrQHJfo4EZMKUq4J4gT8m
         vbfLwDA9/sMvcAtiqOLpM/80FvrFBsls1lOpQ92tmXK1Q5X0Z/fsxjv7zSQ2OAoLAvNq
         1q8VrWtJYjZ/Qt4qyeuEQd6R2iNvsUpfKcPYu1ed0Yrlpxl6aP5/5XC3ABwl0vH3UMRz
         6dyS1XvJNUMU1084BqEMdAcA04kzQS4pxZc79NCW3EtIZoZ7rL1l4XfIBUMcJEUtdO5z
         R7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687177409; x=1689769409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSP20PRjLfEjEczhmjfYNlia/vcSKNLRdUGUz9NHLWk=;
        b=XEEwv8rTe21KZYrC0MqqEvxeMsOl5rG8rxfnm97iEWZWp/RGA9Ivfj85qTuisYwokx
         Rl5EBRbIRe/u/d9cYesSFowy5uydD24q7iFLKTKdzNBnPblW9fxtW5eQe9VyctfCHs5o
         9QtR68yXVaYkLjtPo6a1NZfcZwVdm0OKPtrwK5kVF2UD4ViRKjA4EIP/r1i6Dx0OqDC3
         flGYdWNE4/TQSMNRS3y/HjgorB8tBpIaHITywKsdD0G5xMAfEEdB21tRL5aFcxtLumYx
         Oqg1xZFQvOYBZHzh96aZMnr9+O9z+ZnQazHfQOphIIT3v5tc7/fawSQP5UMZQykfvDaH
         Yw4g==
X-Gm-Message-State: AC+VfDyAoI8V1S2uONglonGCEDRypr+fzdoHgMkepH9gkRc4q4LsdQwv
        q4e8ejbJNe0KWMo/kEpIL8wx5A==
X-Google-Smtp-Source: ACHHUZ55Tp1NaWXP5nJ6mewhwTdXY+WArg4PWOHSlyIXMGE3IKFjWZen5h93Q5FJPTwyw1f8IXcyAA==
X-Received: by 2002:a2e:a401:0:b0:2b4:809a:1c7c with SMTP id p1-20020a2ea401000000b002b4809a1c7cmr933619ljn.19.1687177408953;
        Mon, 19 Jun 2023 05:23:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k27-20020a17090646db00b00988be3c1d87sm1123119ejs.116.2023.06.19.05.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 05:23:28 -0700 (PDT)
Message-ID: <598c14f9-395c-d218-4af9-31bba022dcf6@linaro.org>
Date:   Mon, 19 Jun 2023 14:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2
 compatible
Content-Language: en-US
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230619115120.64474-1-yann.gautier@foss.st.com>
 <20230619115120.64474-2-yann.gautier@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230619115120.64474-2-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/06/2023 13:51, Yann Gautier wrote:
> For STM32MP25, we'll need to distinguish how is managed the delay block.
> This is done through a new comptible dedicated for this SoC, as the
> delay block registers are located in SYSCFG peripheral.
> 
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
> Changes in v2:
> - update dt-bindings file (remove bootloader reference and use enum)
> 
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 1c96da04f0e53..2459a55ed540b 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -53,10 +53,11 @@ properties:
>          items:
>            - const: arm,pl18x
>            - const: arm,primecell
> -      - description: Entry for STMicroelectronics variant of PL18x.
> -          This dedicated compatible is used by bootloaders.
> +      - description: Entries for STMicroelectronics variant of PL18x.
>          items:
> -          - const: st,stm32-sdmmc2
> +          - enum:
> +              - st,stm32-sdmmc2
> +              - st,stm32mp25-sdmmc2

It's nicely visible that old stm32 entry was family-generic, not
device-specific, thus not really correct. :( I hope we can learn from
this for future stm submissions.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

