Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D7BFA373F
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 18:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJXSKC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiJXSJX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 14:09:23 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB801C20A3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 09:51:18 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f22so5953631qto.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUL2O9wbBAu6ztSDG3ElgZvx99nzcRnOeYgEYBuGPRA=;
        b=EEmIXtqXupNZGMQusrGu9cSwDxciaaGSv2LhhL0tX6byMmK28IsBk8c6ClWRq6lYkA
         5+dolwExw1XyN7N2ZUnUo6goPkhL7uOXaTIp+47CzWhPnD5qROzOOFZav4k7YHRwqMEH
         FUMPtqxOPxGTW4BVMVkUU5EW2Xr8k2N+TpV67Fm2aVZNsQK2YGa5ARYpVK2ZvjpFSstW
         5LGsb9+H93HpawF9AoNVTC4rjX5VhkPFm7zaO/rvKQjhCs45phjNvhnsoAZmagQcq/C/
         HnRdp7bCxBKgaIB0yVFB18J5KwAXnMljceuUkDgw1IMXcatnvOp8r7QAReZIeerM+SnW
         dxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUL2O9wbBAu6ztSDG3ElgZvx99nzcRnOeYgEYBuGPRA=;
        b=pAMSFFglsjxBGd1/nqr0/wGViFJ1MdB1MbMEFgWBqDLyaXC3a+/UjrrGChE/lDvmP/
         K/OkRrW/dTaRS6h2WYRoyIi4QqKpgZ7+P1kAIdvF5nMxJddazv0AY/eB91htLXlXiTX4
         goM3S+pF41oQMEu3zfXNGLusKt4d/rpCpIB/zJn3DFfFx2j5N1vb5g+Zn5jjbrG4vf/E
         7+qtjBvuqsLY7Jilye1gh8uZDM8yF7nJu9NaTz/K/wF4bqjgVP3QwjGDOQAwFIRDMAlG
         VhIChkUZWrHFGSBXItkvTb1lwD3TVNJvdC4+ZTFKGcW/XpDO4TaX6veiV83YkAu4Ne7G
         RCjw==
X-Gm-Message-State: ACrzQf2y56w970IDnmQupfM0FVeCSY5TTJK6sXKiDGD6p1fmiV7p/ySG
        aG7DfR0AB9/YKiKPWeuSTvaxkg==
X-Google-Smtp-Source: AMsMyM57TE1ja12+inLNwlTcq5BSzAd/+4nM91OaJJGzUPwVHrd3YNRlGWdmd5z78YjGbtZPGpbilw==
X-Received: by 2002:ac8:5c11:0:b0:39c:fd77:336d with SMTP id i17-20020ac85c11000000b0039cfd77336dmr24199445qti.479.1666630114992;
        Mon, 24 Oct 2022 09:48:34 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q8-20020a37f708000000b006ce0733caebsm279848qkj.14.2022.10.24.09.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:48:34 -0700 (PDT)
Message-ID: <0b9d7768-3f30-c084-9a14-f439cd49d643@linaro.org>
Date:   Mon, 24 Oct 2022 12:48:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Aw: Re: [PATCH v3 3/7] dt-bindings: mmc: mtk-sd: add mt7986
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221023091247.70586-1-linux@fw-web.de>
 <20221023091247.70586-4-linux@fw-web.de>
 <a0121e0a-9f62-8630-45c5-d32eaa91d46f@linaro.org>
 <trinity-95441a68-0025-49de-8c73-9730fb9cec42-1666623320110@3c-app-gmx-bap55>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-95441a68-0025-49de-8c73-9730fb9cec42-1666623320110@3c-app-gmx-bap55>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/10/2022 10:55, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Sonntag, 23. Oktober 2022 um 14:56 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> An: "Frank Wunderlich" <linux@fw-web.de>, linux-mediatek@lists.infradead.org
>> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Chaotian Jing" <chaotian.jing@mediatek.com>, "Ulf Hansson" <ulf.hansson@linaro.org>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Matthias Brugger" <matthias.bgg@gmail.com>, "Wenbin Mei" <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
>> Betreff: Re: [PATCH v3 3/7] dt-bindings: mmc: mtk-sd: add mt7986
>>
>> On 23/10/2022 05:12, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add SoC specific section for defining clock configuration.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi,
> 
> got another config from mtk which requires changing binding a bit
> 
>                        clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
>                                 <&infracfg CLK_INFRA_MSDC_HCK_CK>,
>                                 <&infracfg CLK_INFRA_MSDC_CK>,
>                                 <&infracfg CLK_INFRA_MSDC_133M_CK>,
>                                  <&infracfg CLK_INFRA_MSDC_66M_CK>;
>                        clock-names = "source", "hclk", "source_cg", "bus_clk",
>                                      "sys_cg";
> in binding:
> 
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -241,15 +241,17 @@ allOf:
>            items:
>              - description: source clock
>              - description: HCLK which used for host
> -            - description: AXI bus clock gate
> -            - description: AHB bus clock gate
> +            - description: independent source clock gate
> +            - description: bus clock used for internal register access (required for MSDC0/3).
> +            - description: msdc subsys clock gate
>          clock-names:
>            minItems: 3
>            items:
>              - const: source
>              - const: hclk
> -            - const: axi_cg
> -            - const: ahb_cg
> +            - const: "source_cg"
> +            - const: "bus_clk"
> +            - const: "sys_cg"
> 
> will send an updated v4...old version was working but i should use the new one.
> 
> @Krzysztof can i take your RB here or should i leave it as Patch was changed?

Please drop my tag, so I will re-review it.

Thanks!

Best regards,
Krzysztof

