Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1496C7619A
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 08:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjDPIyt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 04:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDPIys (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 04:54:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA69189
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 01:54:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a34a0baf9so522619566b.1
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681635282; x=1684227282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kReI/819/yB/vM1HUutOlL4qW9U8KAxa88SG+rfE9L4=;
        b=F/6+Dty3bAxCtGCDEQ96qRFC6zDjLxXllYLtZ8WiZurnuOLvIj/5kZDlgNeD4Pspbg
         130X7HSbQbxQFocuImq+Pwg8Nc0jEZ/38SRXxer+JMOsoBINAsXybxCPchPSjt4FphED
         ReHFRFyrLGuDZDkxGWpomviDDsh49k0V/69nXJ9DAUai3yLkYvYuEE7feDaUwAoz/8bk
         RBtwBEHxJkQnb7PXvvUBhIcx5FPDn0bCOXLr7qngWS1NGtcqjvimU63RRbpmdw5lo998
         mtGnb7CMIrQ6XmiD2W9NNvLHuxWfO5Du/9RJ2mRTleykIlx0lE4On+BUSCAhO3GryMQu
         ianA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635282; x=1684227282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kReI/819/yB/vM1HUutOlL4qW9U8KAxa88SG+rfE9L4=;
        b=CJbhqjF4/cQRrP9cjv6n/0K15s2kJuw34IF4jiIAv72Br8U0eAP4/GEqI5cTzTZWNX
         kSDzHAmltW76XJAf8IbdBwbzC6GHfm1BTATCwECR5eESUeu1T9BGPq/Tzm3srlgL6G7x
         g8SGNBUVxkCxWdH8u5Aur3iLlEq90BuJQNHhdFjnzs7bEvjFOqFVhllk6BSHdHHeEvkD
         09gVnjcZakLMbeUPXCYTyzHPJ4XL/BOWBZbJouAiaVgqAmb7CQG5R7xqNttWlsN+cnLP
         Zf2cv+XAll3Jlxm82M1iULGkB0EDMyZJmW9uFtMqFS02htdKrUFnjSavgF/aHJxLOp9l
         lPZw==
X-Gm-Message-State: AAQBX9cf2gnX8ElwbdFkOk8laf+KtvA4jOJYPOJXpmgga/U0OpUDT45F
        OreI8Fa7TxNutvd0NYdTDMwmrO3Bf11/SfOOaKI=
X-Google-Smtp-Source: AKy350Z5YQ5fzcxuMlGdX2X1EV4THuwardyN36Q2KLb8uS1nXBYvDv25UDorobQHsxMJ2Ok1Wg41CA==
X-Received: by 2002:a05:6402:208:b0:4fe:97a2:4b86 with SMTP id t8-20020a056402020800b004fe97a24b86mr12758162edv.8.1681635282280;
        Sun, 16 Apr 2023 01:54:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id ay18-20020a056402203200b0050504648fc4sm4300860edb.80.2023.04.16.01.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 01:54:41 -0700 (PDT)
Message-ID: <9c301936-c066-3c2d-f5fc-56ec291f5941@linaro.org>
Date:   Sun, 16 Apr 2023 10:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v3 3/4] dt-binding: mmc: hi3798cv200-dw-mshc: convert
 to YAML and rename to histb-dw-mshc
Content-Language: en-US
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
 <20230415-mmc-hi3798mv200-v3-3-00e2368c0709@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v3-3-00e2368c0709@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/04/2023 10:46, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> The renaming is due to the fact that it is now supporting SoCs other
> than Hi3798CV200.

Thank you for your patch. There is something to discuss/improve.

> -	};
> diff --git a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> new file mode 100644
> index 0000000000000..4711ad293b9e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml

Missing vendor prefix.

> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license, unless you copied some part of GPL-2.0 code?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/histb-dw-mshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Hisilicon HiSTB SoC specific extensions to the Synopsys Designware Mobile
> +  Storage Host Controller
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@outlook.com>
> +
> +description:
> +  The Synopsys designware mobile storage host controller is used to interface a
> +  SoC with storage medium such as eMMC or SD/MMC cards.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,hi3798cv200-dw-mshc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 4

Instead:
maxItems: 4

> +
> +  clock-names:
> +    items:
> +      - const: ciu
> +      - const: biu
> +      - const: ciu-sample
> +      - const: ciu-drive
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#

The order is still different than what you can find in example-schema.
required, allOf then unevaluatedProperties.ds,
Krzysztof

