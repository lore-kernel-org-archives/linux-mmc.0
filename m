Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837E9C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Apr 2022 11:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiDRLo0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Apr 2022 07:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiDRLoZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 07:44:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF2120AF
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:41:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v4so17147861edl.7
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fmqrWEaMLzdzM6tlfO27gc/5ZjxaVbLantgCWtrzxek=;
        b=euLeyub8VKd1us4OwhWIZzr3XV+POZ9D4tQLxC59vh85fmzN0/EVt8PiyZEOcOThP2
         SGipuK3/fFUQh4OIEj/tUPjKfgC4U1Vs1JR44X8fEktdAUef0FmXFVAl9yS7wlBCamz4
         1FNGh7HdJJdtqnUyE/EwU5nAlurUZzRIx+/YyEtGXFLtc7RrKS8kr6hBSnkxpVmQLGTB
         quVtKz+eAR+F22D8M88AXByTb73Ytb3RUid038sU3fozUZAFcsUs0QcL+n4RZla9hT+7
         br9Rd0/8aWonrhkRGsDF/ng25tJ4WSiZn7AJbj6hxM4rzWzfFznwcs1jpby8AxAizWLl
         9K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fmqrWEaMLzdzM6tlfO27gc/5ZjxaVbLantgCWtrzxek=;
        b=6FbSlSUsJujsLZM9JNbyFamn+Scs7xFcAQqp3z+6z+tLMvhumvKu09tZJu0IV5PQ2v
         Ldz92HnQy0bwO2Pk+UUkS5UIXeoF3QQ8XGOUvmWHcMX/I4pzdqGyfUxnu6tEk6J1M0pr
         QDBY3Nj40jXgaKWT6j29/72/YN/Sx1UAcRV3AOEt8G88KHsjP70Ul0AgDwXsib6vyAMq
         sfn9vSbczxE6ChoId90LUu8eNBwPrAJv2p/OYJoyp8feKMvgf4f/KGD5KJTjYNhiVsa2
         N8d1z3JpKM86mEZCaIluKMrTdMsweOfQ1KDIPNGQrpzxNpKxtdrvcVjyltbaGCaY2Gmx
         E5QA==
X-Gm-Message-State: AOAM531pKlCjnfNP91mo2DAN5fTzB/vnw0UZi7KRKeGfmybp2ErOexFB
        msBgL2/tA/qMR9AjXPZwgHiDmw==
X-Google-Smtp-Source: ABdhPJy5kGTGP7Apl58/+o1/q/TVZVuRIYgAiCuDaaJBGKYub7vpPI4igucgaDqIEtBRy96pV5HUgQ==
X-Received: by 2002:aa7:c68d:0:b0:41d:7b1c:7da0 with SMTP id n13-20020aa7c68d000000b0041d7b1c7da0mr11742036edq.175.1650282104090;
        Mon, 18 Apr 2022 04:41:44 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm4506051ejy.132.2022.04.18.04.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 04:41:43 -0700 (PDT)
Message-ID: <09df1d1f-71cf-a24f-2908-8e1630d9c536@linaro.org>
Date:   Mon, 18 Apr 2022 13:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] dt-bindings: mmc: convert orion-sdio to JSON schema
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz>
 <20220414230603.567049-4-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220414230603.567049-4-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/2022 01:06, Chris Packham wrote:
> Convert the orion-sdio binding to JSON schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../bindings/mmc/marvell,orion-sdio.yaml      | 43 +++++++++++++++++++
>  .../devicetree/bindings/mmc/orion-sdio.txt    | 16 -------
>  2 files changed, 43 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml b/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
> new file mode 100644
> index 000000000000..4fef53fc78ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/marvell,orion-sdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell orion-sdio controller
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>

This should be someone having taking care about this hardware, not
subsystem maintainer. If there is no dedicated person for Marvell MMC,
then maybe SoC maintainers?


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
