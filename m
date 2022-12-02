Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B56C47088
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 09:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiLBJNN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 04:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiLBJNI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 04:13:08 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F98B38B
        for <linux-mmc@vger.kernel.org>; Fri,  2 Dec 2022 01:13:07 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q7so4713457ljp.9
        for <linux-mmc@vger.kernel.org>; Fri, 02 Dec 2022 01:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnQ1J46FiwBYtKU7zH12QVEBJPCE0Tjehtfy7gIEcdw=;
        b=sC12q5E2PDgDLP8Ug8Su4tn6KYelxaurzGmTcFeXNcdu6K7BrgDoaCdaoJc+K46XDj
         zF9y54wX87Wtx7bRlb1yPnRwbcndKZR3mbp5wAG5BKmRKgIJXU/T43gZ+PMdP98Uy9bH
         ewspssXxiO6BKU+RPZQfCNlAoZSfG98faax7cIPxNOAp0ouHIbY4FTJG/ytmzjhE3f5i
         kegJZLtsdhYl2zYhz3VmXsSreq9NCIaWZsG4aPbxcIkbDUz8ugTLGoLEF+3TdHf/10jj
         f7cymOs2xQlXTEoNKyqFQD3tMlJTTEN2aoErtrIuEL5fWNHebWzL0pl9w0gBJXODGDXJ
         csOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnQ1J46FiwBYtKU7zH12QVEBJPCE0Tjehtfy7gIEcdw=;
        b=Kz/Ir0+CtcRgWj2NeRK/H8rcc/wkU9+d/nYQszAxOPGxaSagVedmW7sUOFyLqxfZV0
         vRrQkJOrlRezaVq+1p90duCLAEJfPfQm/lrrOHTKThQ4ANwO913G8xrBkKWw6iFNgMZo
         wEsO2eKCl5MF3Wq0uZe6TeGIT0BJghcP/l1l38drLeaLNjBeH1AIbGIA4rSDYc8dS3Td
         0mMBHIEK9TcVq7/K787Eu441gHZoXd0eTVXbJSfdjwWGHYQZ056AOUk3i2Gs3twPvhun
         8GHLrNLm1Y1uQMEjiTMZLDRHaiBxVw74WEE3YRUQbtP2FtSSqYgG70oulX4IMDfu0Wjw
         HZkw==
X-Gm-Message-State: ANoB5pmtUidzB8YLk2qVPrOYMBuvw2I5Qm+/kk7iTiYbSZ4HQLYsFbq/
        u0PJtiGalUn+4NcmKZu4httS7g==
X-Google-Smtp-Source: AA0mqf6j44t2/tAuKm204ZDNVhGactgDyNNZVUVSAmM4NiMFKFWIctwA5pD1gDDueCMQM3c4qKCZRQ==
X-Received: by 2002:a2e:8750:0:b0:279:9466:9355 with SMTP id q16-20020a2e8750000000b0027994669355mr10870629ljj.253.1669972385698;
        Fri, 02 Dec 2022 01:13:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f3-20020ac25083000000b0049c29389b98sm950454lfm.151.2022.12.02.01.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 01:13:04 -0800 (PST)
Message-ID: <42d9ccbf-1539-b595-40b4-56ff786193ec@linaro.org>
Date:   Fri, 2 Dec 2022 10:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221202031330.94130-1-doug@schmorgal.com>
 <20221202031330.94130-9-doug@schmorgal.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202031330.94130-9-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 02/12/2022 04:13, Doug Brown wrote:
> Add a compatible for the pxav1 controller in the PXA168, along with
> optional pinctrl properties to use for an errata workaround.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> index 1c87f4218e18..8bb0eca506e5 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Marvell PXA SDHCI v2/v3 bindings
> +title: Marvell PXA SDHCI v1/v2/v3 bindings

While changing this, drop "bindings". Will save me effort in my cleanup
series.

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
> @@ -61,6 +62,22 @@ properties:
>        - const: io
>        - const: core
>  
> +  pinctrl-names:
> +    description:
> +      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between SDIO CMD and

The line is a bit more than 80 and there is no benefit in this. Wrap it
like coding style asks - 80.

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

