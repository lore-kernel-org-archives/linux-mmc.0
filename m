Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529C9C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Mar 2022 16:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiC2Qvv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbiC2Qvu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2022 12:51:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35311A9A6
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2022 09:50:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pv16so36393691ejb.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2022 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3W39tC2e+e4XlENh3geReI/CxfG4scvOcsFNszfM2k4=;
        b=ySG+mixvItTpHny21aTnBnKz+TP6aGDVpHG5nZS5Rd0Tb52jAYKdBGgZaJDE0/8bXr
         FkmjdkptNzOvdefZvgAiIdDYcCPwMYf0P0BP0klpKVeoZ/zZoyVfbtIeq+3Cp7kgRKSE
         Pads40KqXEJvZ1Hx5Ul05VMlYoDrtSoRRWKhAcbP1qpGnKpZXO/HrsXV//iT6zsmogoE
         sARUk5j21HdviVg9F+ARHjnDqn5JBLx0/Ry/Mn0QGJnnBUToAQyri++1kLyz9x7ZGjEJ
         XmVJMXt234cCaIHxx0EHLEcC8TTMZmyiiiljhTLMewQQBEw1kVdyCyfXBaLZzam+cr18
         BsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3W39tC2e+e4XlENh3geReI/CxfG4scvOcsFNszfM2k4=;
        b=ol82F6e0OXVVtohNa2sDsh5gIQy1xt/SYbiS6h5o636EPsRHucU3X9571NuCpKWTRK
         84Bk8xjq9YW0YqS5WfUcC3QMp2a8+bNIpZ14cRfUiLzkMDxMDclUYeYfCGpsmdz3Ohhj
         YOZVe6yXPZjsi1qt05I+ibPGy3UZ+2R0j2KTz+60LPEL0FJw8GAmYt5mPdlX+k2RBl9W
         +Z6x5NAPG5vzRVVNVJyI//xA0PIX78vQrJWwCteeZjLdFbAZmU9N3n9q3Xwu3yyjILwy
         tuPI3535c0mgcW99jp785OgxNEfGanOgraEr63W6l3sMbVedjtimWC5HZaWvWI2gsrSC
         44TQ==
X-Gm-Message-State: AOAM530JaMVWh3XA+0sQrgbgCeHr83/KAbhMlcb9t3QRfb5Z0F3GIZhA
        1fdLsteUFqn+s8rD2MNKnTrJ7Q==
X-Google-Smtp-Source: ABdhPJyv5/j1KLCPW2EGMkODOgQaFZJ8INemE/1yDu/Q4K7LSfV1gStbxYZglireUgGSfjH+MeW7Pg==
X-Received: by 2002:a17:907:7f8b:b0:6e0:612b:38fd with SMTP id qk11-20020a1709077f8b00b006e0612b38fdmr35710600ejc.552.1648572604849;
        Tue, 29 Mar 2022 09:50:04 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm7237928ejk.119.2022.03.29.09.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 09:50:04 -0700 (PDT)
Message-ID: <85ed0e5b-0c6f-aea0-ea89-522591d85420@linaro.org>
Date:   Tue, 29 Mar 2022 18:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, lhjeff911@gmail.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com, lh.kuo@sunplus.com
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
 <abd34a74bf56e04050868c63d030552a9af210f4.1648551070.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <abd34a74bf56e04050868c63d030552a9af210f4.1648551070.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/03/2022 16:42, Tony Huang wrote:
> Add mmc yaml file for Sunplus SP7021

s/mmc/MMC/
s/yaml/YAML/
And a full stop.

Please rebase your changes on recent Linux kernel, because you skip
Cc-ing me all the time, so I assume you have some old Maintainers file.

> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v5:
>  - Addressed comments from Krzysztof.
> 
>  .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> new file mode 100644
> index 0000000..92537d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus MMC Controller
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  max-frequency: true

I think you do not need this.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc0: mmc@9c003b00 {
> +        compatible = "sunplus,mmc-v2";
> +        reg = <0x9c003b00 0x180>;
> +        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc 0x4e>;
> +        resets = <&rstc 0x3e>;
> +        bus-width = <8>;
> +        max-frequency = <52000000>;
> +        non-removable;
> +        disable-wp;
> +        cap-mmc-highspeed;
> +        mmc-ddr-3_3v;
> +        no-sdio;
> +        no-sd;
> +    };
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7..42498b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS MMC DRIVER
> +M:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +M:	Li-hao Kuo <lhjeff911@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mmc/sunplu,mmc.yaml

I pointed this already for your v4.

> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>


Best regards,
Krzysztof
