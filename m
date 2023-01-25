Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A156CC54E94
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Jan 2023 07:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjAYHYe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Jan 2023 02:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjAYHYd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2023 02:24:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3833E63C
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 23:24:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so12085497wrv.10
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 23:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHPk75UldZWFrK2zpIfxnby6zLxh86xUQwr4PeMFBWQ=;
        b=rw1f/4o4X5NlqumQcfT0f6wydIwHGUpxH8I8yGUp1kO6uWSAKUrOZd1qDwPm70zZMn
         xaxEzSUkIFOVg1K+AnqFhTtGjj7R2AH+iv3XWeC22XrEeWly9s2VfpiMxt1umkd4sP+z
         Oc9nXDN2mtVBSoSCPN/9xSUL5gdOyLmy1km8cd9Z0My46xYfypGt0OF+ori/Q4qcv6zi
         c4NvOgC+WitgnFl+HmL0xY/GIBAMUz/4ZVwXvyoG4rC0+ArydMfllOLsWfp2VQtooB2f
         Uv4DR3EluzXhhLA56emY+zG4r4RisX/yt6czQXziSP2jLAUMGmeVmtj40RwDJT3Gr8j6
         XyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHPk75UldZWFrK2zpIfxnby6zLxh86xUQwr4PeMFBWQ=;
        b=rIL29f8vx9OTHQ0/BCjKSm3NfloVAB+bb5/pqnEC8TpU323WcWALH3AZdWiJTM38XT
         0xqdLUlUj5M21GKFfPxtdvYQQgtZNleVbb35Hdk9gwMGD3gNqP3Flt5Ci9gDhKha65bS
         7jMZJXTMnOA4nYvuBSPb/r+ieYyWT1nJU5RCrd7NxpMv0VQrYE02UGvi+M8c+rVBG/rP
         JzLt0Is0+yT5uQnjhb00KcgwBpg2afp/VGZhCTxTQQ5wnrEGgWhn/olZwVEJ89TzWDyX
         3n+ZiHtIwPKOASws3hwMkm/QeGiymY+8Bu4L+jCWENczYO4jk7QLo8rUTyQ6JaJ8m7K4
         450g==
X-Gm-Message-State: AFqh2kr77cFurAp7+KrSZnVeyQIYplwPqqcZsFFHLPn4oTtV/JyV0TBX
        eWftk+Hd+NUXHEdfuKN5vR4W0w==
X-Google-Smtp-Source: AMrXdXvju59MOy/PeQz8aEmb8kiEVWSKtzfpztMk26/H14mopbHicF0Za+Fk+TXNM0CiFdfDGz6pNQ==
X-Received: by 2002:a5d:591b:0:b0:2bf:65ac:ebcc with SMTP id v27-20020a5d591b000000b002bf65acebccmr15954288wrd.17.1674631470385;
        Tue, 24 Jan 2023 23:24:30 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j26-20020a5d453a000000b002bdf3809f59sm3610748wra.38.2023.01.24.23.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:24:29 -0800 (PST)
Message-ID: <a8dd2e04-1baf-2c18-fc73-25e7117f10d2@linaro.org>
Date:   Wed, 25 Jan 2023 08:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/5] dt-bindings: mmc: uniphier-sd: Add
 socionext,syscon-uhs-mode property
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
 <20230125010201.28246-2-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125010201.28246-2-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/01/2023 02:01, Kunihiko Hayashi wrote:
> UHS mode control is included in the interface logic represented
> by syscon. To refer this, add new property "socionext,syscon-uhs-mode".
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/mmc/socionext,uniphier-sd.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml b/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
> index a586fad0a46b..313621d0d9f5 100644
> --- a/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
> @@ -55,6 +55,16 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  socionext,syscon-uhs-mode:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to syscon that configures uhs mode

s/uhs/UHS/

> +          - description: ID of SD instance
> +    description:
> +      A phandle to syscon with one argument that configures uhs mode.

s/uhs/UHS/


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

