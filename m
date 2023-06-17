Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C4EB64D9
	for <linux-mmc@archiver.kernel.org>; Sat, 17 Jun 2023 08:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjFQIEP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 17 Jun 2023 04:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjFQIEN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Jun 2023 04:04:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA59C1737
        for <linux-mmc@vger.kernel.org>; Sat, 17 Jun 2023 01:04:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-982a0232bdcso233786066b.1
        for <linux-mmc@vger.kernel.org>; Sat, 17 Jun 2023 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686989050; x=1689581050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JskatFucMmAeLdfnFCEkpDxKlTgR0k+Wi7MQ3LzyqlE=;
        b=olYtqBvXhj2eKwZADpIRHO8dazWhRSBP/tCJtpoDYyDDVmhEDF0TB+NvCPLMGD4WHV
         7nvMuE66b4sIY5fkHjfyVyDw/sUoN7iUcwOPjQLHXUeiB5abyGuMZE69eZ7NKiFZCiT1
         XPHSFGYUkCNherRbPgj83LB77/wHo0Gc8G151opIYyhPNBp8VpNM0ISAf/4NYk7rX6/o
         Q80TEGfTdXJU1J4Ez9wqFGMIBNI7uVT9N6SG8jCGL7zjG2HsHjR5BcI8havwN1vUSLJg
         abiAh1Cgosi89RPA+CAQAIlynRtS2tFYFMvq0ReWWtBbidr13hRBc7gLQyB26Vu73/fq
         x2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686989050; x=1689581050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JskatFucMmAeLdfnFCEkpDxKlTgR0k+Wi7MQ3LzyqlE=;
        b=iiM2gCaNf6o1fSr1A6s0kYpPkwT498MrA+7kRCTgmkbJOXy/vbPlf7YmKLXCSETG4n
         FRYKdsI2mLWCfgNl0MtVtnJbXrDTlhddhsPuAUw70jW8ylKTEwvfCZnwyKNfstqZswqq
         P17d2bQ99u7oWXwmhEa3q0jCA9GgjEGAlpDx+EpSRSu6+QlyDJLy9u1vPBM6SFhUrnZf
         /O42gvMzL6S8AkJrwfxfsR0U6+YDYzSK9RalXqBRhwXdiovxRRlkZhuzm+menFkjAio6
         UejQz4G6RM9wgdsbd8bSDOD5mNNf+JDFW02ScwlTc5FdjPcxEU6T7gDh4iNnjCmVbWqq
         XKZQ==
X-Gm-Message-State: AC+VfDyqWLldpGxSObilUnSS37YwHaWNzKV/L1pRjI31hZklI06u/gL4
        mpFQvmgaumL01uWJfY4uMjoo8Q==
X-Google-Smtp-Source: ACHHUZ7kZqKBEMLNLGBMJ8yGHStlrG8Dg/LXVr7TO3CkwsYIX8auZF1/tEu6GqnbYv+WO0MdC2nQ6A==
X-Received: by 2002:a17:907:3188:b0:966:5a6c:752d with SMTP id xe8-20020a170907318800b009665a6c752dmr4045542ejb.20.1686989050183;
        Sat, 17 Jun 2023 01:04:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090655c800b009828bc469a4sm3813170ejp.103.2023.06.17.01.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:04:09 -0700 (PDT)
Message-ID: <fd07ea29-0b9d-4955-0f1b-2879c8b3442f@linaro.org>
Date:   Sat, 17 Jun 2023 10:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2
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
References: <20230615092001.1213132-1-yann.gautier@foss.st.com>
 <20230615092001.1213132-2-yann.gautier@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615092001.1213132-2-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/06/2023 11:19, Yann Gautier wrote:
> For STM32MP25, we'll need to distinguish how is managed the delay block.
> This is done through a new comptible dedicated for this SoC, as the
> delay block registers are located in SYSCFG peripheral.
> 
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 1c96da04f0e53..e47b3418b6c77 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -59,6 +59,12 @@ properties:
>            - const: st,stm32-sdmmc2
>            - const: arm,pl18x
>            - const: arm,primecell
> +      - description: Entry for STMicroelectronics variant of PL18x for
> +          STM32MP25. This dedicated compatible is used by bootloaders.
> +        items:
> +          - const: st,stm32mp25-sdmmc2

Except what's said, this looks like can be part of previous entry via enum.

Best regards,
Krzysztof

