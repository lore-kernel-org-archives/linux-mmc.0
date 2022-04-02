Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC89C433F5
	for <linux-mmc@archiver.kernel.org>; Sat,  2 Apr 2022 20:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbiDBUOe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 2 Apr 2022 16:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbiDBUOe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Apr 2022 16:14:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C551017D2
        for <linux-mmc@vger.kernel.org>; Sat,  2 Apr 2022 13:12:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r64so3603439wmr.4
        for <linux-mmc@vger.kernel.org>; Sat, 02 Apr 2022 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=235ThmLY/OVM1F4sGmmgGyNEXw4TutBGz+wfTPM6Ezw=;
        b=Cas6JHBkmCdF0GwcUU5QKOb+Sux8akmYDZH6laNOP59TCjA0pxhAvURsbet2GknsEB
         0FylV/t4GYIz1vmY41D2vHCn3UzdxddfEveGTayYafYNRFwOmlAg73MnIZ1WoJ8p1J6M
         qmWhHwIgeBtEsq5UTufZH6+u9tARe1W2dMFu/3ofsFpGARJBhDFU6pBqIlUyn1AVfa8n
         DcAX9XeRxS89OjUS/fx/NlN+xRllNfMhPSjQDNu5MPwg2ppg+0wXJnUvKBDrJkUx8LxE
         lB+lTNiTWMF15TpY8bcAbCmRoLzlcesC1W7Z7GH6xY66f7zxFs4NuoSuxta8Klw3urbA
         zV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=235ThmLY/OVM1F4sGmmgGyNEXw4TutBGz+wfTPM6Ezw=;
        b=DNQg0Tsa9Poj3ll5v6UQLNCdrBtIutPW7z22jHM1XaMtghhSsyCHKEUaBYyhIEQNSe
         FsdPX5vSRtwrdi4qZibBrkok7m7MDIDn3CElh+IctWf3eVVlZN3Mn1EjdZZpS1IjTwYA
         uS4seTQScGbsAgdVTI+HZimo3GS8an7U5Xa0XAkF4FF0924JGxq91mY45jNnoFGXs/Mv
         30UqZ1zrZBISYW2CwQ/JHisKTbfVBs6l3l6cIpe7dxstJGijA/U4KoVKsx/NnVDNJevG
         Ew5FRj7g+VzSB8tydXMkZ30h9HhoBhLP5bfnu42S6qbHJot5rLxW6hf8bGLpyEcmRaio
         3sPg==
X-Gm-Message-State: AOAM531R39IXR/EoieQCfR8oMy+/xqhiz/o950XWAIlsyftJvxTvPMaO
        umcTxA7dTP5fHB9jMwcR3ljNpg==
X-Google-Smtp-Source: ABdhPJyVuEQmPjKz6+OoclhGClbXdqVtWWvLy2mu+DTaZ4xpHRVhCMsAwmv2SlZXnn0GLs1qmJVe+g==
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id f19-20020a7bcd13000000b0038bf39c1181mr13973422wmj.20.1648930360071;
        Sat, 02 Apr 2022 13:12:40 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm6675904wri.77.2022.04.02.13.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 13:12:39 -0700 (PDT)
Message-ID: <a66f17c6-cec6-3eb8-92df-9990d74dd122@linaro.org>
Date:   Sat, 2 Apr 2022 22:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: imx-esdhc: Update compatible
 fallbacks
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-mmc@vger.kernel.org
Cc:     haibo.chen@nxp.com, aford@beaconembedded.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220402193942.744737-1-aford173@gmail.com>
 <20220402193942.744737-2-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402193942.744737-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 02/04/2022 21:39, Adam Ford wrote:
> The SDHC controller in the imx8mn and imx8mp have the same controller
> as the imx8mm which is slightly different than that of the imx7d.
> Using the fallback of the imx8mm enables the controllers to support
> HS400-ES which is not available on the imx7d. After discussion with NXP,
> it turns out that the imx8qm should fall back to the imx8qxp, because
> those have some additional flags not present in the imx8mm.
> 
> Suggested-by: haibo.chen@nxp.com
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Marked the imx7d-usdhc as deprecated when there are better
>      fallback options or the fallback isn't needed.
>      Leave the deprecated fallback in the YAML to prevent errors
>      Remove Reviewed-by from Krzysztof Kozlowski due to the above
> 
> V2:  Update the table per recomendation from Haibo.
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 7dbbcae9485c..11f039320d79 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -34,23 +34,34 @@ properties:
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
> +          - fsl,imx8mm-usdhc
> +          - fsl,imx8qxp-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
>        - items:
>            - enum:
>                - fsl,imx8mm-usdhc
> +              - fsl,imx8mq-usdhc
> +            # fsl,imx7d-usdhc fallback is deprecated for imx8mm-usdhc
> +          - const: fsl,imx7d-usdhc

Instead of comment use (I think on the same level as items):

deprecated: true

> +      - items:
> +          - enum:
>                - fsl,imx8mn-usdhc
>                - fsl,imx8mp-usdhc

So if this is a deprecated list, where is a proper one? The list with
this enum + imx8mm?

IOW, you need to list here:
1. Old combinations with "deprecated: true"
2. New combinations.

> -              - fsl,imx8mq-usdhc
> -              - fsl,imx8qm-usdhc
> -              - fsl,imx8qxp-usdhc
> +          - const: fsl,imx8mm-usdhc
> +            # fsl,imx7d-usdhc fallback is deprecated
>            - const: fsl,imx7d-usdhc
>        - items:
>            - enum:
> -              - fsl,imx93-usdhc
>                - fsl,imx8ulp-usdhc
> +              - fsl,imx93-usdhc
>            - const: fsl,imx8mm-usdhc
> -
> +      - items:
> +          - enum:
> +              - fsl,imx8qm-usdhc
> +          - const: fsl,imx8qxp-usdhc
> +            # fsl,imx7d-usdhc fallback is deprecated
> +          - const: fsl,imx7d-usdhc
>    reg:
>      maxItems: 1
>  


Best regards,
Krzysztof
