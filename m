Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3A9C433FE
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 18:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347055AbiDGS76 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiDGS75 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 14:59:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A30522AC75
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 11:57:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ot30so12695437ejb.12
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SStO+Hy5++Lfb3g3WM6HTmeRTlehAMSfC5x1LN925d0=;
        b=pffEq134LMK9q44k1NUZbvtMIapNh/q3WfROiHVN7L1cCwp0gRQ+TZf4GzSrwo/pLu
         xPNdVOA64orFoZADlNoWj5XOmMg7MBio+VcQP0/mh1EDb/hC8AtZrj0HkvehddY2q8oq
         7+IggfWRxtVuyLLHYu+xrBkJIH3lL4VrQURDL9VB12d7dpxCA5kUz0x03/VYaKp5303Y
         x9P75BYq3A60VyyoHrmtdnKfvzizdSdDtH6YGyyMPWK6sfIjAAgkMFznRWaAhVRZAOmf
         mo7Hihy5sVzOTOVsRpKXy6Y4kRYOC8BW5jXz8eHJI4MLJgdwD/8hcg4bPl76oK06Dqtp
         Ilrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SStO+Hy5++Lfb3g3WM6HTmeRTlehAMSfC5x1LN925d0=;
        b=FHLiMVLMvd2mfnAOVdAzQQbAmQdRs5dgMSPtxSTdXvUN+ZIH8MR6VpfirZfoWoUjsq
         2PmOvCAY+BArMN6wqGtvK4V3prssMn23rjhaFjS8gWbZJUgEZ7ztMZwzwThXZ6SMkDgZ
         sSeHK8KgpJHilCVuae5dlmgANDq4UKVPN3NQWDirvJ4YZcA5LFvyrcFxsHKSh+Y6ekjH
         Ucx9m5ZPaXeDMy2Js4edmBhffgozPp+codiAQdGiVBymFu5oPWxHsw7m3VD4ckBYCAKI
         KHTEAyK39DzlkFCezXyoSafGDCKnsIQChyGHdI6iBixbw2LxKYt7E/cWPGUMP9A07BD5
         QJAw==
X-Gm-Message-State: AOAM533p+fhsvoEDAfewvl2Ounj0pbwUcBqHwtsaXB4qZqd7dDrRMzpd
        J1YwYpP6Jl5ucGDgHqLKj4fTpg==
X-Google-Smtp-Source: ABdhPJxLu1ldArMYGdKSMNZ+//fBUb3UGN+WRJC1fJrCRxdzP/spu3u2wXjkYdcG6b+VzwcYx5d1Jg==
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id rl15-20020a170907216f00b006ced85f35cfmr15416379ejb.517.1649357875010;
        Thu, 07 Apr 2022 11:57:55 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709064f9200b006e7f229b332sm4692136eju.36.2022.04.07.11.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:57:54 -0700 (PDT)
Message-ID: <888c0f62-7845-715e-12a1-7b16f84d2ae9@linaro.org>
Date:   Thu, 7 Apr 2022 20:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-4-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-4-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables resulting in an additional
> reg property resource.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Change from elba-emmc to elba-sd4hc to match file convention
> - Use minItems: 1 and maxItems: 2 to pass schema check
> 
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 4207fed62dfe..278a71b27488 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -19,10 +19,12 @@ properties:
>        - enum:
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
> +          - pensando,elba-sd4hc

Put your entry in alphabetical order.

>        - const: cdns,sd4hc
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

This needs allOf:if:then: which sets constraint on number of items per
different compatible.

>  
>    interrupts:
>      maxItems: 1


Best regards,
Krzysztof
