Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EED0C61DA4
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 12:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBPMwP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 07:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBPMwO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 07:52:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E41BC5
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 04:52:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id hg24-20020a05600c539800b003e1f5f2a29cso4074467wmb.4
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 04:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3fURNFwbiEdBhrpBfrsEhNqdNbbdKyGMjFWCZrl9ICw=;
        b=MJSZe0XdE7hWpZfFDi3EAkuzdy7c8YEweCJMwKpcADEai0u15DFqmcOkoDvjExQTNa
         PGvJhh9XBhw+UlOIjzHld3Z4O/lHXZ9C8pFO+ro0isFF2RQ5zY2K/WpESSPUOPNeCjoq
         qgabMPLc1NtSucZ27e1l/6zEIEtkMJxo7xgmEVyh87W4Gcljm/psyRzfY6g0ThJdTlI5
         7LuIoRsBmosiX4RMdTXEMoOTJ3whb/qzFnzNk+EwuL7NeeecTUc9SdpT9iiAEXlYrp5Y
         CZhO2/lEDx4zE4tyB8FjuUYCICQHMS+dWFhicTSx3izpzO2TnpSdIfK2Dj//V1eslWid
         ooxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fURNFwbiEdBhrpBfrsEhNqdNbbdKyGMjFWCZrl9ICw=;
        b=PKTrm3MJm6LmRqUB5lc47g0IuLEmPD01pNrS6eqWET38wS+fo4pMzT3vN1GxPIGFGM
         eokbpq1z7lgCpBnP+KQ+sZcIW+fhW/2UV0mcvcSR7mVE+TKXsfANtLxsbBcb/2DW6Cjs
         +4FevN8+nBSciLI8NWV/RGnq2iBCiIZRG+AAddFZEFqnlR9WTuc30PAsNjtq71GJ6cb1
         9BU+uDPPZiBDkfiFK052oXEBQMQj9dM6/ce3QFvkqZo3HB5SvFNsyLxhLdUTiMjE0eEs
         QAmFVYofDuFeS+vetFmBIkxCA5tZTMq31l+l05mEC177tmu3AS9BPP9KihomID/tixIs
         ZSEg==
X-Gm-Message-State: AO0yUKVCFLnpZM+SftKL1NSTwbEbRG2APfpeqnlN4BEaqvZpmqZ1RBGy
        FmVyRnDD1ngN+jBKtAVZx2Hryw==
X-Google-Smtp-Source: AK7set94rPRKvqc3t74D75F2PTN7qeKsoMoOgT33uDhuTptxL7rcZglfbf8sW5s9AoblSSdXHQpAGg==
X-Received: by 2002:a05:600c:4b29:b0:3e2:147f:ac1a with SMTP id i41-20020a05600c4b2900b003e2147fac1amr1256780wmp.21.1676551932009;
        Thu, 16 Feb 2023 04:52:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:13e4:d5bc:1ce7:c1b6? ([2a01:e0a:982:cbb0:13e4:d5bc:1ce7:c1b6])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c348400b003df5be8987esm5308945wmq.20.2023.02.16.04.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 04:52:11 -0800 (PST)
Message-ID: <21ae5f5f-2336-db5b-f98a-f83391e1becd@linaro.org>
Date:   Thu, 16 Feb 2023 13:52:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: mmc: meson-gx: fix interrupt binding
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <d5542f6e-920e-93cf-a453-b0601d03f48d@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <d5542f6e-920e-93cf-a453-b0601d03f48d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/02/2023 12:49, Heiner Kallweit wrote:
> Reflect in the binding that the cd interrupt is optional,
> and add a description of the interrupts.
> 
> Fixes: 09b31a610328 ("dt-bindings: mmc: meson-gx: support specifying cd interrupt")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   .../devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml         | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index c8c30300d..cd3f75821 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -28,7 +28,11 @@ properties:
>       maxItems: 1
>   
>     interrupts:
> +    minItems: 1
>       maxItems: 2
> +    description:
> +      mmc controller instance interrupt
> +      optional card detect interrupt

I would instead write:

interrupts:
   minItems: 1
   items:
     - description: mmc controller instance
     - description: card detect

and drop maxItems.

Neil
>   
>     clocks:
>       maxItems: 3

