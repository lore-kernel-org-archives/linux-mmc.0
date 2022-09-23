Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E3C04A95
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Sep 2022 17:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiIWRt0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiIWRt0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Sep 2022 13:49:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB75122072
        for <linux-mmc@vger.kernel.org>; Fri, 23 Sep 2022 10:49:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i26so1378772lfp.11
        for <linux-mmc@vger.kernel.org>; Fri, 23 Sep 2022 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HdvrftlRyQqTQoTlDeBTdBmMcZfxBFXOHDyKHrW5BYo=;
        b=gEbo9/6Ij4ZqttNQUIKlqqcit/PgIMUSwwYj9Gn1owZSH3635JkSkfvBkRro5AHsgu
         0vafFE4rhOHyLPgUGGZCHjWJa/IvHPn+M1TBiT3pagA4U92lm9V+mqLjP59R9BCNSoOA
         wuiudFiEQZdf41trVSTP/0eMDO1wA0m/Z2UyYxB56yr2/7rB0QzoWhCFbOseuaGOAZvS
         P8TCLzSTVwitVbSrpUIoNlbnoaU4cklnxJ6myXAxVGXE6EwJEznopZ7tF/LZPqqoZ8Nx
         OJ+jJNVO0yY8/yRn/1n0eT3ddZ9CacZmAjUNRO7SnSj2J2uQMOQPKesFVLzDLNaGBV5C
         OoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HdvrftlRyQqTQoTlDeBTdBmMcZfxBFXOHDyKHrW5BYo=;
        b=xDzWzyickH/gLNPjQGCe8QtKxyOxKYVHcPbw1rKhN6C9wgu0gRO0Jf3Lu5hMBBQ8yv
         Nz6tBrXP1/oBpATrYG65nmq4zVBBmf50Pz5J642bA5huHCOyBQ7ZIsjzeefKdE0aZ3D0
         jYAOqUJtyIg3dbCv3Ik3fylX1xTFSwiRbSrFBfbbmdvzsBvHhcCbx7OfVh+1uxd/xFJ9
         aNvLOcfC9VcNIdyNGv3Jgj7Yxr1eyKBtVPOIeUaUm2sO3I+xh0oeQU8OEvlZWZHNf1b8
         DNK9oMTA2gPofwDArcmODQoR1gjiMiuRgOWvovRxy9CTvfqQQYsyrpEmMfZgdLkVmRFH
         ID8A==
X-Gm-Message-State: ACrzQf2s5PIklt/PbrCu3hxpjCGzEoD4sz/CHh4b+F5buEQjRz0Omx/k
        4VN86qpy+ZGJ8rSMlxvqx+zkhg==
X-Google-Smtp-Source: AMsMyM6fZ4WmmpIgtCAsa/zZUpZ4zWz5j4kJhqdHx6NUyFzaAoYpQPSOKNeOTiJWV0RMcGh/h7uEsw==
X-Received: by 2002:a05:6512:3e14:b0:499:1f71:1680 with SMTP id i20-20020a0565123e1400b004991f711680mr3737503lfv.114.1663955363194;
        Fri, 23 Sep 2022 10:49:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a8-20020a05651c010800b0026c3975f488sm1479001ljb.26.2022.09.23.10.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:49:22 -0700 (PDT)
Message-ID: <966b46f5-ed3b-9daa-4cfb-602a534a8bfc@linaro.org>
Date:   Fri, 23 Sep 2022 19:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv2 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220922220308.609422-1-dinguyen@kernel.org>
 <20220922220308.609422-2-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922220308.609422-2-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/09/2022 00:03, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

Thank you for your patch. There is something to discuss/improve.

> ---
> v2: added
> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index ae6d6fca79e2..aece6a337262 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -38,6 +38,18 @@ properties:
>        - const: biu
>        - const: ciu
>  
> +  altr,sysmgr-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the sysmgr node
> +          - description: register offset that controls the SDMMC clock phase
> +    description:
> +      Contains the phandle to System Manager block that contains
> +      the SDMMC clock-phase control register. The first value is the pointer
> +      to the sysmgr and the 2nd value is the register offset for the SDMMC
> +      clock phase register.

You need to restrict it per variant (altera). Move the allOf from top of
the file to place above unevaluatedProperties and add if:then: making it
false for other variants.

Best regards,
Krzysztof

