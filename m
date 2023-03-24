Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B0C6FD20
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Mar 2023 11:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCXLoW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Mar 2023 07:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXLoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2023 07:44:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5EE1EBC6
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2023 04:44:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t10so6722298edd.12
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2023 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679658259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PV2+Kw1a03u71xTK7xlUl8ktkm/tkiAy9Sd4SYFg1Rk=;
        b=cNztfJT4Q0pg5oSGiUiysyzduJeJzDrxx40EM08fZ8w3PTJ6s7P2TaHId5+BlvZLuM
         6vR2Jrkh7CllN1Adk+KasNy88E5xwQ+I6KdtPnIx7KfjbRW5vA1PembcnnKIQHnF5A9P
         rTfs/EC0ai7aVjK+1rf3BrLMe/KbBOAfMeJNZCb4oWQsPw3BPwVQsEOd+Jp2Lhn2Zey9
         uHMeGOkWrQtZ8zX2V6ftMX8YEMPH2t3YyqsdgyRDYifrRHNYLmlpv6sU9SJC6J4xfsm6
         LVr0/Z6EbBF2kaodNVbmJzG/Ii2/WiIiC2ep45ho5SfcJUFbPiPXFUfWksKnH0A3qiBd
         O4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679658259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PV2+Kw1a03u71xTK7xlUl8ktkm/tkiAy9Sd4SYFg1Rk=;
        b=Uz4tGqx70XU9JIPBuoECYnVdlKkewv6qDFam2KVixGoW+oSgJJSD8+M0uSycT1lSaG
         SWL2ggxAwjXRkp5oGHM6g9RH2UxEzVIxQpUSy47DvVqw4pBg5ktsctuB1kSSR194uL7k
         TsMiMPa7mjdQufINM1/TOmRfO36XOu+h+mcZGbjC58hBU27ptv0BWfjucV5ITFg9OR8q
         WHVfd4iv254pHez6bSrMkDa7uhVz5GR8cK6ftcYpjlllC3waN2KuF9EuCeQW9rVUFcSA
         E65MGy6oEO3OrFV5c8m7BxS5fuLg5bv2OsY91lWQxylEVRrwyXNIk6BcUhQT+lYuswFn
         xnpA==
X-Gm-Message-State: AAQBX9fGDDOS7gZWrNvFVwk8kJqkXF8DHmGM41aEf+PSUgaX6aFhl6Uo
        2LX8gKKl2IjOfq7BPZtAKGBrIw==
X-Google-Smtp-Source: AKy350buKiFs3pb8Ta8k+M1vUQPFJiD0NRH4RsXr+sOiOetVRFPCrydIpT3mNuyijixEkO/rO25gAA==
X-Received: by 2002:a05:6402:151:b0:4fc:5d56:f91d with SMTP id s17-20020a056402015100b004fc5d56f91dmr2316227edu.18.1679658258902;
        Fri, 24 Mar 2023 04:44:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3027:fb0b:ae08:588? ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id i28-20020a50871c000000b004fd204d180dsm10516512edb.64.2023.03.24.04.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 04:44:18 -0700 (PDT)
Message-ID: <d646d109-d0a6-aedb-a8b2-ac954336e628@linaro.org>
Date:   Fri, 24 Mar 2023 12:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
 compatible
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, saikrishna12468@gmail.com
References: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
 <20230324073630.3194724-2-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324073630.3194724-2-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/03/2023 08:36, Sai Krishna Potthuri wrote:
> Add Xilinx Versal Net compatible to support eMMC 5.1 PHY.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 8296c34cfa00..cf44a4b988a7 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -27,6 +27,7 @@ allOf:
>              enum:
>                - xlnx,zynqmp-8.9a
>                - xlnx,versal-8.9a
> +              - xlnx,versal-net-5.1-emmc

v5.1 is eMMC standard or Versal block version? If the first, it's not
suitable for compatibles.

Also, what's the difference from xlnx,versal-8.9a?

>      then:
>        properties:
>          clock-output-names:
> @@ -62,6 +63,11 @@ properties:
>          description:
>            For this device it is strongly suggested to include
>            clock-output-names and '#clock-cells'.
> +      - items:
> +          - const: xlnx,versal-net-5.1-emmc     # Versal Net eMMC PHY
> +        description:

Best regards,
Krzysztof

