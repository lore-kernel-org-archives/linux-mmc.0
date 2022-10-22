Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A9BECDFA1
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Oct 2022 16:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJVQaF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Oct 2022 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJVQaE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2022 12:30:04 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A550519
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2022 09:30:02 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1324e7a1284so7201761fac.10
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2022 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7SWOvXweDZtmkeWSuLz6l3o0fM/vaQf8Gw102I5GRQ=;
        b=G2k9jjkJCEai5xU0b1yIXA4xPlcxeZUesmGr2osHTA4IYYE1IgDDkYsqRAUVIVtdgk
         GLIIvHgw2c70Ey9XB5CESFoq93sozsyh5IXwS43rGyMW/cohocxhwjsEmwf58/kfF56/
         SVDqL53QkervbiVMC8cpiF1QJAMOdItMguNSgl/3CeUHnH8+4SSn7AZYjvmhsiWRRSih
         sLdN2h931hAUNtB/wWk4l8YptO9JLY31oRbfU8ERFMSh+yn2+PCmH7cinlQ0JCxK4oR8
         XmG2g1DuFJoE1me8OZ0ZHWpfQP9FLI7Y9qtdzVX5TvNyY2dJtK6E5XIrwZT2cX7xZ9d4
         NN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7SWOvXweDZtmkeWSuLz6l3o0fM/vaQf8Gw102I5GRQ=;
        b=OsIgAjD2MAXXpmf5cuikbEbTFVcQBjH9Eza5QNNOCwzOZCQwowiG7neZ/k0PQ4+faM
         BGY0gdCMz1r6yCnb88a1197NApbrikL8BR4XxQBn6ijFBE4orTGYqIEz3j5XGLHVuJlT
         gdwLq+feFE7XSX6vSYF2HSusn30Kzq8UD0V73q09cNRwTnmEQsXDwIy5qxh+OwZ7XnMY
         aGYrfWS4GKQG0f29Yg239bXSTiMIWUpZ4UoD0u+PSwscKmPyLkuGcIMgsJHYVblzkVF0
         BHLxZHw2NJaoFfwj9sk/2oMXTJe/jvLP932p+CGAR9lVetv+Eok2JvOxaB5faEFWMUMz
         CaqQ==
X-Gm-Message-State: ACrzQf3AU8IM1oYyuetXQvV0Kgh/HltOdbSxFK8t4reHb0ycu12EWs/j
        Q5385Rw02Tigoa723FRdF8E7+A==
X-Google-Smtp-Source: AMsMyM6xS8BBgTyJDXX7TcLvYtSmpPPTRH/GpaUvPLRo7YA24xOp6Qq1yrXugxI5WF50ALMLGn+ljg==
X-Received: by 2002:a05:6870:56a7:b0:136:74fb:e6df with SMTP id p39-20020a05687056a700b0013674fbe6dfmr14877673oao.37.1666456201795;
        Sat, 22 Oct 2022 09:30:01 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870418300b0011f400edb17sm11796775oac.4.2022.10.22.09.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:30:00 -0700 (PDT)
Message-ID: <0c88ae58-2841-f0f3-f103-f3030c5cf704@linaro.org>
Date:   Sat, 22 Oct 2022 12:29:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 5/5] dt-bindings: mmc: mtk-sd: add mt7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221022090530.16265-1-linux@fw-web.de>
 <20221022090530.16265-6-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022090530.16265-6-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/10/2022 05:05, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add SoC specific section for defining clock configuration.
> 
> Add compatible in "not" section to avoid override the settings again.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index c7bcf0c3dd5d..9df63c461f1f 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -229,6 +229,33 @@ allOf:
>              - const: hclk
>              - const: source_cg
>              - const: bus_clk

Blank line

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt7986-mmc
> +    then:
> +      properties:
> +        assigned-clock-parents:
> +          maxItems: 2
> +        assigned-clocks:
> +          maxItems: 2

Define these two only if they are required for the hardware to operate
and only such setup (two assigned parents) is allowed. Otherwise you put
some constraints on board design.

> +        clocks:
> +          minItems: 3

Best regards,
Krzysztof

