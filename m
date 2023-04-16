Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B4C77B73
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 11:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDPLQh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDPLQh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 07:16:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41D270B
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 04:16:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dm2so57095310ejc.8
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681643793; x=1684235793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfVOOEaR1vEEILlzOLNZUcE9zFL3fILNekQ/0O6xXvM=;
        b=g6r7+EFpcI5cEangCoj+RV9nJWwxPRqT32Z5oJ8BflwTmdCkungwDsmKoVrNvtNf9G
         zhUpT5Mf+puHRCfXkjgAO46etmpDUAwnOQOpFW59oO4/VT0cQKSL9QeLcNQ3N0e2U484
         BvM/yWdbt7vaxfYhs7zoIa0eiNr5TFk6Nkb2Dma9szg5ER3n183VhOtIr6yndKyJ49Wt
         zm6b/We/WxzIj5oqzTfKLdGGJGe/Q5hHZTu10IhBM4qgw56B5SrtLrhj1teCoe4V9X+T
         SBp803/hwiCJnZE0e7/0zt4iqxeCfXh2uFN+MCYAW9jbGsXypKe0aynLi5YlNYB/R3KK
         qjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681643793; x=1684235793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfVOOEaR1vEEILlzOLNZUcE9zFL3fILNekQ/0O6xXvM=;
        b=c/oPzIdRlaDdlIta4h6/YlGSscOzYwb/ms/UWujO2RvX98ENdafHCrSPrgMedhYvre
         FTyBERnVis4U4/zBuZ11B3mql75Axm49tP91Hos2Kku+FxPO7AISoxgU6tbsTlT0ZVAv
         LRn5Diaqojl0GRza03zlKgJ72NSWYt2857yKwKMEBeoGzJTtqe//y/CpKcEP28lbW6Cr
         Ci7mEkUSMc+smRKPNEtr47Ba6+RxhOX++NhNWGAFbctldHZ0JoGUAqFRK2Iq8R+NQdRV
         C+q85LN5PwW8qTsHAeKx44fq5qHk9PajDTL5CMf7KsxQcn/+GVHH5yly589A8Fp2sSe3
         b5sg==
X-Gm-Message-State: AAQBX9dzdXT4pSWN4Pnj4jbJV/KgOVVEFOrI7SyjCvyv7SCBqoaGzwX0
        hraN33PpRnTPnkCJoqkHBArdrQ==
X-Google-Smtp-Source: AKy350a+q7Rv5lebDWwLQHS5o9maCYQRBf4xVCpEYfCcw7ou5You6jkrcsk2TPhClGRuRF01J97R0A==
X-Received: by 2002:a17:906:2f95:b0:933:6ae6:374d with SMTP id w21-20020a1709062f9500b009336ae6374dmr3303868eji.73.1681643793413;
        Sun, 16 Apr 2023 04:16:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b008e54ac90de1sm4931131ejc.74.2023.04.16.04.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 04:16:33 -0700 (PDT)
Message-ID: <7cdf170f-1045-db73-df87-fd9da693da28@linaro.org>
Date:   Sun, 16 Apr 2023 13:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 4/4] dt-binding: mmc: histb-dw-mshc: Add
 Hi3798MV200 compatible string
Content-Language: en-US
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
 <20230415-mmc-hi3798mv200-v4-4-44096e187f53@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v4-4-44096e187f53@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/04/2023 11:19, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Add Hi3798MV200 compatible string and an extra clock for it.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/mmc/hisilicon,histb-dw-mshc.yaml      | 26 +++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
> index 301b6ad39c5af..2f8335fd2c965 100644
> --- a/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - hisilicon,hi3798cv200-dw-mshc
> +      - hisilicon,hi3798mv200-dw-mshc
>  
>    reg:
>      maxItems: 1
> @@ -27,14 +28,16 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 4

You miss now minItems. Are you sure you tested your bindings? This
should fail.

Anyway, wait with sending new versions of patches to give other people
chance to review. It's already second patchset today.

Best regards,
Krzysztof

