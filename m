Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D737C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Apr 2022 17:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiDVRKQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Apr 2022 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiDVRKM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2022 13:10:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1E888E7
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2022 10:07:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l7so17653482ejn.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2022 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HuaHFmqvQqnIyK40h6V5f/iowB3mu3oIEkcjqTultSk=;
        b=WkxCwPEM5BKiLQpoW8yI3vRR/7oRMqP6IemLSS9GzlcAwzMQ5Uc47r38D3xAzU0Wh2
         cJJVFNI/OXUH+3o7c85aTCx37AUKEytfJL1t+DgF2z+yUy4fsGGt5rz+g6lDCEBpge9m
         7p4IGdGY41KivyiNIje7WbmTToHThzLh7gB153B2jGnJT4jXX3XCt2nRxz0KmQ4bWbMn
         FDtL0HU8jkpAxollLUl0zDQTk3RbFZdJ/SR59QS3YiIEgTu8mnkV25AWU8CEMihxInTC
         O/m2MkmIdW6c4C+FWZ6cWwndBei/t8CNN/+G1ECuEjZsXQUYBf4UWTi6yi+xkwfPc1eI
         u+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HuaHFmqvQqnIyK40h6V5f/iowB3mu3oIEkcjqTultSk=;
        b=qx9V70piuz7UaIBSq4uYJ9yxh4fZ2EavYui0ktZRWbTpi14HfTOR2lzazSrx/ouNpo
         umlviRpjP4tzvrNeSy/6xSBp/ePjr97hth5ohV+PgH/l49duI03NtaX4SqsXj5SEGXkt
         yhAENlQ4J5sEqyg8/FP+BlgFhihMlcRZt7o6HAGvGjkoPwcKOiy7sfC8e6zKhAbmcR7I
         wd5ACH1iTP3LeNjySi8gbEHMxq3oG6TIYdAX2L66gNjwgsmtqSzFlga656P+odbYYDKU
         qadYvCkaA5x/BUR0Id/9ouRO2m5o6Ok6fFZyC1JAT9SV7HyewL9BAHMIuzLbYsQZPFcU
         /3NQ==
X-Gm-Message-State: AOAM532534y2TKvKTJo3Lr7TmFIMZtT6BIm16LTwdg1J4p7UQ3bNYlKq
        WOshWqcQbrU6nngPiGUIY4dXcQ==
X-Google-Smtp-Source: ABdhPJw33mJXV5pnWAH2xVmAmR/b8XhX+8WpfcVcwaTudi+ZVFG9u+HRSB4xvm24l55uj1mv9DkVNg==
X-Received: by 2002:a17:907:9482:b0:6da:a24e:e767 with SMTP id dm2-20020a170907948200b006daa24ee767mr5000350ejc.479.1650647232087;
        Fri, 22 Apr 2022 10:07:12 -0700 (PDT)
Received: from [192.168.0.233] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id tk20-20020a170907c29400b006efc91707d8sm820399ejc.107.2022.04.22.10.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:07:11 -0700 (PDT)
Message-ID: <857e78dd-b8e8-d55e-3b3c-cbbfb7c98505@linaro.org>
Date:   Fri, 22 Apr 2022 19:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/5] dt-bindings: mmc: Add Broadcom optional sdio_freq
 clock
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
 <20220421182803.6495-5-kdasu.kdev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421182803.6495-5-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/04/2022 20:28, Kamal Dasu wrote:
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz.
> Optional "sdio_freq" clock is used to drive the bus clock if present
> optional property "clock-frequency" specifies a base clock frequency
> in Hz that overrides the base clock frequency in the CAPS registers.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 29 +++++++++++++++----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index dccd5ad96981..1b45a918400a 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -10,8 +10,6 @@ maintainers:
>    - Al Cooper <alcooperx@gmail.com>
>    - Florian Fainelli <f.fainelli@gmail.com>
>  
> -allOf:
> -  - $ref: mmc-controller.yaml#
>  
>  properties:
>    compatible:
> @@ -42,23 +40,44 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 1
> -    description:
> -      handle to core clock for the sdhci controller.
> +    minItems: 1
> +    items:
> +      - description: handle to core clock for the sdhci controller
> +      - description: improved 150Mhz clock for sdhci controller (Optional clock)
>  
>    clock-names:
> +    minItems: 1
>      items:
>        - const: sw_sdio
> +      - const: sdio_freq # Optional clock
> +
> +  clock-frequency:
> +    description: Should be the frequency (in Hz) of the base controller clock
> +    minimum: 400000
> +    maximum: 150000000

Why do you need this property? The mmc-controller.yaml already has
max-frequency, so maybe that suits your needs?


Best regards,
Krzysztof
