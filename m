Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5159CC77B61
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 08:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjDPIzN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDPIzN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 04:55:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD01991
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 01:55:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94a34a0baf9so522630066b.1
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681635308; x=1684227308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pg6953tCPWmA6PZJp5D14eo4mPNGqutmBJkwLa5dsUk=;
        b=CobYjD5vknETNT4bPGz2Pi/w/5ocQBOFxXVFoTkj4ySM6RZu+shCwnOf006rXBYuZK
         IX/Aco3lY73lIvMwFCCyloieYtssgXKvkuXMo1wZ/TWBpF7SQ9uG5TIZbMcPj8QJXBxq
         FoWwywOqgxois+K2stLWZYbiUiue+x4bB4gAD0NQ3KOUiCy/jkyzYKE91pJMVHjlyMn7
         Eg/ZlM1bMSWRY4tfepT/N5YB9HV3wBUUZqinqfZnwG2/sGkY20CqYTeohR9x2+Afv7c/
         NAGlzTIr6hMl02JjF05B6r8A/qWrTv6gd5oo8FYPBLwNP+WT12AYzKRtuMkdkBBVTOns
         cRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635308; x=1684227308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg6953tCPWmA6PZJp5D14eo4mPNGqutmBJkwLa5dsUk=;
        b=kokrXlsQIuPPLZsrkPLCMgngd2rVOR80pAepUgikOCioApl+FvtiwhU+LbjbTKlv2D
         jrJI3aJQITrHIbxuFAWZHTlA7CwEUyE7DFeXJoBrFTzfIYP/5071xjV0qezPm/dCpgQQ
         w7PRZB/LAFZpN4w5J5P7/4hzJYGMxYfz7c3PzCLBNWETRE7IBIYBXt8S9ck6tUsRX7aX
         Z7BWUgymUtZ/xZ+GyBGlJpY0ozSLfekX7ZtD421ocX3l3aYkopaFpDqfK2N0NXowaJEu
         Sp03bIVtJS6goQgD6p8UuBi5Auq8tKpR0k80RIhTrdig7S1K3CAQULVdLZaHeIBTE2aX
         2x6g==
X-Gm-Message-State: AAQBX9dZxsk+V2W9OOlZR+SucKEoS5jpOBvjDAVG+nM1upG02QFzkuRN
        2BzaDiRUhTAPixHLwwmcBXWWvw==
X-Google-Smtp-Source: AKy350ZnYSDCTQ3LmTMg+Ln2LPy06L6LJBu235UK01i3de4KPcXULfb/EsShDcSUgY4efm4mzfBFnQ==
X-Received: by 2002:aa7:c3d5:0:b0:506:7c86:202 with SMTP id l21-20020aa7c3d5000000b005067c860202mr8382301edr.20.1681635308580;
        Sun, 16 Apr 2023 01:55:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id nd23-20020a170907629700b0094e9f87c6d4sm4765767ejc.192.2023.04.16.01.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 01:55:08 -0700 (PDT)
Message-ID: <060b0c6d-4058-46a9-4004-1dee135efec0@linaro.org>
Date:   Sun, 16 Apr 2023 10:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v3 4/4] dt-binding: mmc: histb-dw-mshc: Add
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
References: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
 <20230415-mmc-hi3798mv200-v3-4-00e2368c0709@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v3-4-00e2368c0709@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/04/2023 10:46, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Add Hi3798MV200 compatible string and an extra clock for it.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> index 4711ad293b9e8..bcc8ea393981f 100644
> --- a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - hisilicon,hi3798cv200-dw-mshc
> +      - hisilicon,hi3798mv200-dw-mshc
>  
>    reg:
>      maxItems: 1
> @@ -28,13 +29,16 @@ properties:
>  
>    clocks:
>      minItems: 4
> +    maxItems: 5
>  
>    clock-names:
> +    minItems: 4
>      items:
>        - const: ciu
>        - const: biu
>        - const: ciu-sample
>        - const: ciu-drive
> +      - const: sap-dll-mode
>  
>  unevaluatedProperties: false
>  
> @@ -47,6 +51,18 @@ required:
>  
>  allOf:
>    - $ref: synopsys-dw-mshc-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: hisilicon,hi3798mv200-dw-mshc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +
> +        clock-names:
> +          minItems: 5

else - maxItems: 4 for both


Best regards,
Krzysztof

