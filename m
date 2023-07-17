Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F5EB64DC
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Jul 2023 20:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGQUHB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGQUHA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jul 2023 16:07:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF9113
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2023 13:06:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98e39784a85so1288868066b.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2023 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689624417; x=1692216417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzEdZ0pB3DBUm8uGUbWktWX3tWqRhxkyCGVAClHZTkc=;
        b=Y8QzN/vBoa6MFURv3gbWbNuC+chDfsvCF9eYbP1B2jyop7AH/u5h3s0dR/Yumhamgk
         LFf7/AtU3ZHXMWMUez0aebW6FhEFlz5QBQ5UlCu6n11g03pLETd0AXtPGmXXaRpPbyl7
         jSsl1p0xt4Ajmwu7d0nMVPXOCIpUXCODG609JVgwW1gK7S/0k/V+p46Nyz6/g8z7wCZ7
         c70sToESVRzN4OJXhvgNa0JIKX2wCemM4aq8SCDva47BNB2PAkJVK3MeXFKbbV/9rOCP
         vxeZozHwEHjNPgG96isv5Q173jKPppuubBn8WCD7IXSvYpTjJt+GN+ilgIrpaBsjEaPZ
         J3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624417; x=1692216417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzEdZ0pB3DBUm8uGUbWktWX3tWqRhxkyCGVAClHZTkc=;
        b=LKTKnVTyhjFeH8lCAvYRsUsf6taniSEq1d4BLygFeED9XqgV/0uRF7JmNa2saW+lGE
         tfu4bLTv852STxV4dpidv5gcjvWSmWi8EEo3U9pb/nxYSnUWPWzm/+Qq9U3EdKbcjd4f
         7Czr+bDQYJOz2R+tXW/0OoV9cmEdALz6VLSAAQPTPrNLHZCqNvIP6z2dIuvTuFtlp21/
         irjbI4XCa9vyaPqALW2VTPV03S8cQrs5dRCbK55AcZ5ZgQZmbi3Dp5fmRi37EbC2Isc3
         pmebNQQNcFKRTuovEqFU2mQdErGH7x+jVcSyS58nTyPbhfzeMm96bNafwn0VuH+YhcPK
         Hxgw==
X-Gm-Message-State: ABy/qLZKa1mdG6irbeRsl6d4j1Nwv7zEdMFsCdIToxG7zNC6sSonTGBI
        FZR00zvXteHfa9LEwANCAJatgg==
X-Google-Smtp-Source: APBJJlGBvNflC4SgUGwnbsv/2UACX03vaJlIi1OjO7dSlQ/xFc+hwn7dJpGmRRyNdTwx09zLuWCe3w==
X-Received: by 2002:a17:906:68c9:b0:989:450:e565 with SMTP id y9-20020a17090668c900b009890450e565mr12035699ejr.23.1689624416963;
        Mon, 17 Jul 2023 13:06:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id lu11-20020a170906facb00b00982a352f078sm97674ejb.124.2023.07.17.13.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:06:56 -0700 (PDT)
Message-ID: <6dda9ec3-72ef-0367-4914-8c63ce6d07a4@linaro.org>
Date:   Mon, 17 Jul 2023 22:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20230717125146.16791-1-pmalgujar@marvell.com>
 <20230717125146.16791-6-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717125146.16791-6-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/07/2023 14:51, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add support for SD6 controller on Marvell CN10K series SOCs. The
> existing sd4hc is not compatible with the SD6 changes.
> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 52 ++++++++++++++++---
>  1 file changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 6c40611405a08717520f4ce3a78a9cb8dd9aac69..51f44c00a50505684c7c7c49c59c1ebd8d85d5d0 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -4,19 +4,23 @@
>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
>  
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - amd,pensando-elba-sd4hc
> -          - microchip,mpfs-sd4hc
> -          - socionext,uniphier-sd4hc
> -      - const: cdns,sd4hc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amd,pensando-elba-sd4hc
> +              - microchip,mpfs-sd4hc
> +              - socionext,uniphier-sd4hc
> +          - const: cdns,sd4hc
> +
> +      - items:
> +          - const: marvell,cdns-sd6hc

Except what Conor said (that's not a correct compatible, because cdns is
vendor prefix, not device name), you do not have multiple items here, so
drop "items".

>  
>    reg:
>      minItems: 1
> @@ -139,6 +143,40 @@ allOf:
>          reg:
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,cdns-sd6hc
> +
> +    then:
> +      properties:
> +        marvell,iocell-input-delay-ps:
> +          description: Delay in ps across the input IO cells

Properties should be defined in top-level properties. Require/disallow
them per variant.

Best regards,
Krzysztof

