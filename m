Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C604EC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AE06125F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhHXOeh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:34:37 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34564 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbhHXOeg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:34:36 -0400
Received: by mail-ot1-f45.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso41519367otp.1;
        Tue, 24 Aug 2021 07:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kldX5LSk1AeNzh82BbMV96MR54hwptzA7Wk7T/NXSI=;
        b=YqpdEhWcig/dLrK5TnvFjVJSV99L52WGXPkMbJxvpKX0TE7tmhKrFgcTNoYT4tcB5X
         Be55KHsWnE74vAjQKr1Mqpod1lBRcpS6Vk1qt3E05aZqzQuTaAbsccNs8gvWpaMp7lum
         +3H1qVm3bKHgejGQDGPkJyXUV1xs/49W/OJs7ejD36RmNoO0orJ3cY1wd9TmfwEfDefY
         MJkXsm/ZqlPaCESfnvo3Ob9axZhalnJLHQ2pYkVh9bszWOc4l16AH8SnGHFLqkGfq2ww
         xYwQl8B8Hf8d5GlPxgz6Ak0JSx17oCcJJsN2ow0qAS+exZ0czVH3bCo3qN3IwvrMkgSv
         /hIQ==
X-Gm-Message-State: AOAM531BQqw6YOI5uWtBjcPYTf+p80aR+ztniPAsrhQyYhOBtbkwlwoQ
        gvnqmxpbd+42v2NYehDPag==
X-Google-Smtp-Source: ABdhPJx7YaMi06Fse66vJ/pNEcdzY1UiZ22EuP9LQFco4+TJ7Jlv2NLgfPAmKdyaXBvYoPpG8oWoNA==
X-Received: by 2002:a9d:5548:: with SMTP id h8mr12471244oti.370.1629815631667;
        Tue, 24 Aug 2021 07:33:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b11sm4033809ooi.0.2021.08.24.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:33:50 -0700 (PDT)
Received: (nullmailer pid 398737 invoked by uid 1000);
        Tue, 24 Aug 2021 14:33:49 -0000
Date:   Tue, 24 Aug 2021 09:33:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/6] dt-bindings: mmc: cdns: match MPFS MMC/SDHCI
 controller
Message-ID: <YSUDTSuNlsOmu/G+@robh.at.kernel.org>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819154436.117798-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Aug 19, 2021 at 05:44:32PM +0200, Krzysztof Kozlowski wrote:
> The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller
> without any additional vendor compatible:

I think the lack of vendor compatible is the error here. Experience has 
shown that vendor specific compatibles are needed for licensed IP.

> 
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index af7442f73881..0489aa92cb54 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -15,9 +15,11 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - socionext,uniphier-sd4hc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - socionext,uniphier-sd4hc
> +          - const: cdns,sd4hc
>        - const: cdns,sd4hc
>  
>    reg:
> -- 
> 2.30.2
> 
> 
