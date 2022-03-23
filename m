Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183FFC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Mar 2022 13:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbiCWN6E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbiCWN5p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2022 09:57:45 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7367E093;
        Wed, 23 Mar 2022 06:56:13 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id bg10so3015865ejb.4;
        Wed, 23 Mar 2022 06:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LgxEY+6i7DBi0QCATscb+PqLhssZ8pZuQTgH8K5W7oI=;
        b=fHEpGolXFOv/h9Qkg8QGnMTVG1nYYsQpskV3ydeo4ywQ5oPVNCsE6s9clim2ipyqWM
         DD++vqCAQqAZ/roUDuzuvARySRA/HtGTWxVLep5zOYjlvw8NbL+Aoq70w7jRDmnNbqQC
         /wUBJEhBZREqCmzDgAmta6ZHmXgpZkDwyrKtE7jYOFRtKK2kNywuiumkLr+LbUUWayit
         hlAJWsp8EUfE2QqCdnlyXW3AxMe32nLFEkLs+IhKLoF3wUic6/UW3zUVqdB9IA2BxKrZ
         5SYwb5mJUvW7VBe5FE5SAJYUOgL4SJSudJnvQ7JbVoWMzpIH1uMJirGhqM6H2ezBGiCI
         cM/w==
X-Gm-Message-State: AOAM532q9CWOXBR9QW+G8ewKv/lRrK139yZVk31tXybGMUCFkAo2KjHu
        VuqNKA3TDCoWF7goWxES754=
X-Google-Smtp-Source: ABdhPJw9Eynei4ofEeC4/p/ilfVwlcN3rcvmq7AcoMCsFVefpiyqNW90DE0Shl/2A8/GXEDN0+3nag==
X-Received: by 2002:a17:906:2403:b0:6d1:ca2:4da7 with SMTP id z3-20020a170906240300b006d10ca24da7mr9568eja.533.1648043771559;
        Wed, 23 Mar 2022 06:56:11 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id d1-20020a50fe81000000b004197f2ecdc2sm686499edt.89.2022.03.23.06.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 06:56:10 -0700 (PDT)
Message-ID: <35f58894-ed6d-0af0-e483-7a161ad6625a@kernel.org>
Date:   Wed, 23 Mar 2022 14:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: mmc: imx-esdhc: Change imx8mn and imx8mp
 compatible fallback
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323134019.3796178-1-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220323134019.3796178-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/03/2022 14:40, Adam Ford wrote:
> The SDHC controller in the imx8mn and imx8mp have the same controller
> as the imx8mm which is slightly different than that of the imx7d.
> Using the fallback of the imx8mm enables the controllers to support
> HS400-ES which is not available on the imx7d.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 7dbbcae9485c..d6ea73d76bdd 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -39,14 +39,14 @@ properties:
>        - items:
>            - enum:
>                - fsl,imx8mm-usdhc

Your change looks reasonable, but why imx8mm is compatible with imx7d?

> -              - fsl,imx8mn-usdhc
> -              - fsl,imx8mp-usdhc
>                - fsl,imx8mq-usdhc
>                - fsl,imx8qm-usdhc
>                - fsl,imx8qxp-usdhc
>            - const: fsl,imx7d-usdhc
>        - items:
>            - enum:
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
>                - fsl,imx93-usdhc
>                - fsl,imx8ulp-usdhc
>            - const: fsl,imx8mm-usdhc


Best regards,
Krzysztof
