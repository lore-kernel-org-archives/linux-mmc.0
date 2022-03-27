Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9F2C433FE
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Mar 2022 19:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiC0T2E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Mar 2022 15:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC0T2D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Mar 2022 15:28:03 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481F74FC54;
        Sun, 27 Mar 2022 12:26:23 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1700417wme.5;
        Sun, 27 Mar 2022 12:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3QD6ZpwAjHhu9Cg8+tAjiF0wBOXuxBwFvAYXKqVnCP8=;
        b=bqBAmROjaj6dp1fKAP+uUDKg9r3C7iKcN/YybJFDqYLvL7uPnWZBJXjp2PnLdoyVyz
         5+BH6hj3J6mcdT5O7iqnLAW2YThMVSwV2PuFTIjcSM7jDBLdVg6P4os17Q5druAXgRx5
         N2tcapLIioODdMUnQy2P8RitxwfDSkuVYSoZIgQjQ28XyQnx7elpM5xV9uS452229vk1
         SibNx431lHCB/cNwkgmkuOqTbfAe/NowWosgF2v82tie3bYGEfM2Yj3ad8f8aQpYYfoN
         xqAnT0eng/vRMcaqAhUSDoEQoyTMW4KsKG3mMOk5VFJ4ac0hGpAivegn9uAk7IFPVrIX
         YbvA==
X-Gm-Message-State: AOAM533coegxavtQRTXmmZcQPTX2jWHR06bJXHEKQWRg5FAp37nRHPju
        TE11Hh3FDe1f/88s1Wlyv8U=
X-Google-Smtp-Source: ABdhPJx4oXRvNQH0bPygBY3AD1ZODz5GvySPKM3zK8vf/TlTM3Q4YMHaCKde0o7vkYtw+/VZ2BImXA==
X-Received: by 2002:a05:600c:1987:b0:38c:beb2:7e2b with SMTP id t7-20020a05600c198700b0038cbeb27e2bmr21009128wmq.1.1648409181776;
        Sun, 27 Mar 2022 12:26:21 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm16819662wry.72.2022.03.27.12.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:26:21 -0700 (PDT)
Message-ID: <aaed94ae-047d-b16c-3d9b-7e431a212b82@kernel.org>
Date:   Sun, 27 Mar 2022 21:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/5] dt-bindings: mmc: imx-esdhc: Update compatible
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
References: <20220327123835.28329-1-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220327123835.28329-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/03/2022 14:38, Adam Ford wrote:
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
> V2:  Added suggested-by note and imx8qxp updates.
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml   | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

YAML and logic looks good, although I did not check the actual hardware
properties.
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
