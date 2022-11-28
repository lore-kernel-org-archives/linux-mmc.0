Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5BFC4167D
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 08:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiK1I6x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiK1I6w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 03:58:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A8B7C8
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 00:58:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u27so5272562lfc.9
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 00:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRo2ZHW2qUWAOKV0aSxyjMp63OMVxWk6yROB450ZpOw=;
        b=msBknoyna+SQ3FnaZmRqOmEfz5UNjIIUvWP5e7DmwAqQZVMt8q6tlv7X+3uWxr8FNZ
         QchWu5NbnQXskIKbfSDs/IkNhk3niDpORomP9vULfSeL+94E3wkQiGLtSunICQFmctu7
         nKSEBxk3Bqkw0Jfz87L7Nr9vu66gehc0dI3ac0Y1mdZ57wVfn+rt/HffEZvhRGeFxUvX
         KyLrCuSH0bf8FlTEjjj9YYL2tB6CnPUq2c53Z5s5NOcXEzKaa2NXY8bOPPp86AQTrf+7
         mmiZloaV4a26NQ4v+X8cmvx0lPePbShzN6lsJm4lDgxJiTUJkobPtzs/DS+ENhbpQBt3
         1/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRo2ZHW2qUWAOKV0aSxyjMp63OMVxWk6yROB450ZpOw=;
        b=inZytcZ9ezYm2sj1E7rJe7HhaxE2GSVJeoZGa2A7BVvG/9XD5suoF7qyZ60jdzsrqx
         gK1XeWqXwN5/3lRkrGD5s2728LxFxMuUZJePMwS2OlMmIofJTnM7QmH0YTXdaU+K2hTi
         OFDm/4+4zvHvmsg9ifKzzu5SeQvQkWOfkbBWt+2M4Q0ciwNIZC0p+c31BaOJHIbmGYBs
         zgrXsxk1OyqAk73xe1ul3qyA510e0/QUd/OaxPzn+JIGyx1GCUfoy2hwG03V4aCWce3u
         lNYjDf7EnpU4MjsNTePk5NJik2tYlCZRZEJjqercXZ17lNO13kJ2o4dxvyYlM8LOONHd
         fEYw==
X-Gm-Message-State: ANoB5pmfhuA2qONRqqrGs6shl/0a+W0pnnQY5sQ2MrCMau7Z99FmoQn3
        z7qxnb0BySl2fusfxkFP/fRVsiSIFPibhPTU
X-Google-Smtp-Source: AA0mqf5g1lPF5MxCBmCbYqyXj/XvGS8lLCI+Rv/t1iuI5mdV3zuXl8rDOb4aRa8I8O+gLu73vFy3EQ==
X-Received: by 2002:a05:6512:3da4:b0:4a2:3924:de36 with SMTP id k36-20020a0565123da400b004a23924de36mr10381943lfv.663.1669625929396;
        Mon, 28 Nov 2022 00:58:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o1-20020a056512052100b004a44ffb1023sm1666009lfc.57.2022.11.28.00.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:58:49 -0800 (PST)
Message-ID: <263b5e29-f0b4-27b4-a753-592153edc3c3@linaro.org>
Date:   Mon, 28 Nov 2022 09:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221128024407.224393-1-doug@schmorgal.com>
 <20221128024407.224393-9-doug@schmorgal.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128024407.224393-9-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/11/2022 03:44, Doug Brown wrote:
> Add a compatible for the pxav1 controller in the PXA168, along with
> optional pinctrl properties to use for an errata workaround.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> index 1c87f4218e18..e3fb34853921 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Marvell PXA SDHCI v2/v3 bindings
> +title: Marvell PXA SDHCI v1/v2/v3 bindings
>  
>  maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
> @@ -34,6 +34,7 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - mrvl,pxav1-mmc
>        - mrvl,pxav2-mmc
>        - mrvl,pxav3-mmc
>        - marvell,armada-380-sdhci
> @@ -61,6 +62,25 @@ properties:
>        - const: io
>        - const: core
>  
> +  pinctrl-names:
> +    description:
> +      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between SDIO CMD and
> +      GPIO mode.
> +    minItems: 2

No need for minItems.

> +    items:
> +      - const: default
> +      - const: state_cmd_gpio
> +
> +  pinctrl-0:
> +    description:
> +      should contain default pinctrl.

Start with capital letter if this is a sentence with full stop. It's
anyway looking different then the rest of the file, right?

> +    maxItems: 1


Why maxItems: 1? What if one wants to add here more entries? Drop maxItems.

> +
> +  pinctrl-1:
> +    description:
> +      should switch CMD pin to GPIO mode as a high output.
> +    maxItems: 1

Ditto


> +
>    mrvl,clk-delay-cycles:
>      description: Specify a number of cycles to delay for tuning.
>      $ref: /schemas/types.yaml#/definitions/uint32

Best regards,
Krzysztof

