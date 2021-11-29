Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E788C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Nov 2021 01:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhK2Bmz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 28 Nov 2021 20:42:55 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36459 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbhK2Bky (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2021 20:40:54 -0500
Received: by mail-ot1-f54.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so23293746otl.3;
        Sun, 28 Nov 2021 17:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/DoGnFVXvUt4WNy+s27fV+fbXXzvgs3f3dRsIX/quo=;
        b=cdGD1S7zfJBZ2kFk8TrY9U1zNb1ZVfBEMEKHzrxtHjYHmLgFBgn+meD4Jcp+KJLmQF
         W9PxMdtDU/z59YjRyZ0Z0N2xiwdVpB3Co7by+oL6d+jH7HORiE40qxdyqBjTiHhss92T
         Bzz9W27bBdCKB50mZQyuEfYh+fNUKCcegqoLXbbnBIecIeok0jDX/VncLOw32i4BqWTo
         fOFLIwPLZpKTj4kQmTCEJBLtscR/RUM8RK/+GmI2Gkpc0DbuIrgv8hKEoeAI5lg8AI3L
         l43jwmtoaYd5OmyvwZeEZuBhQfc95Sl0Bj1BKShLyeHwm1A4hDMqaNV822/fD5qR6F5c
         /WDg==
X-Gm-Message-State: AOAM5312ntn/AKoUKjF0EM88tHmVXVSRFYO8zlsNlJSD6yGCBRpZe5uq
        b/hWjW85oa8skw0d9AMB+w==
X-Google-Smtp-Source: ABdhPJz8N4i1i720AnWSvmpIPpitKT1ahalUiueonhjgbSnFQWF+yoota1k0duiIouJLZ/ETmGDyQw==
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr42150047oto.189.1638149857357;
        Sun, 28 Nov 2021 17:37:37 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id f20sm2715812oiw.48.2021.11.28.17.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:37:36 -0800 (PST)
Received: (nullmailer pid 2987524 invoked by uid 1000);
        Mon, 29 Nov 2021 01:37:33 -0000
Date:   Sun, 28 Nov 2021 19:37:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, daniel.thompson@linaro.org,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH v2 2/2] devicetree bindings mmc Add bindings doc for
 Sunplus SP7021
Message-ID: <YaQu3dCQD4FG7ete@robh.at.kernel.org>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-3-git-send-email-lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636444705-17883-3-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 09, 2021 at 03:58:25PM +0800, LH.Kuo wrote:
> Add devicetree bindings mmc Add bindings doc for Sunplus SP7021
> 
> Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
> ---
> Changes in v2:
>  - Addressed all comments from Mr. Philipp Zabel
>  - Modified the structure and register access method.
>  - Modifiedthe path about MAINTAINERS. ( wrong messages PATH in v1).
> 
>  .../devicetree/bindings/mmc/sunplus-sd2.yaml       | 82 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
> new file mode 100644
> index 0000000..95dc0bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus-sd2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SD/SDIO controller
> +
> +maintainers:
> +  - lh.kuo <lh.kuo@sunplus.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-card1
> +      - sunplus,sp7021-sdio

What's the difference between these 2 blocks?

> +
> +  reg:
> +    items:
> +      - description: Base address and length of the SD/SDIO registers

Just 'maxItems: 1' is sufficient.

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
> +  pinctrl-names:
> +    description:
> +      A pinctrl state named "default" must be defined.
> +    const: default
> +
> +  pinctrl-0:
> +    description:
> +      A phandle to the default pinctrl state.
> +
> +  max-frequency: true
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - pinctrl-names
> +  - pinctrl-0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sp-sp7021.h>
> +    #include <dt-bindings/reset/sp-sp7021.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mmc1: mmc@9C003e80 {

Use lower case hex.

> +       compatible = "sunplus,sp7021-card1";
> +       reg = <0x9c003e80 0x280>;
> +       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clkc CARD_CTL1>;
> +       resets = <&rstc RST_CARD_CTL1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
> +       max-frequency = <52000000>;
> +    };
> +    sdio: mmc@9C008400 {

Use lower case hex.

> +       compatible = "sunplus,sp7021-sdio";
> +       reg = <0x9c008400 0x280>;
> +       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clkc CARD_CTL1>;
> +       resets = <&rstc RST_CARD_CTL1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pins_sdio>;
> +       max-frequency = <52000000>;
> +    };   
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2746084..e653a1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18193,6 +18193,7 @@ SUNPLUS SD/SDIO HOST CONTROLLER INTERFACE DRIVER
>  M:	LH Kuo <lh.kuo@sunplus.com>
>  L:	linux-mmc@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
>  F:	drivers/mmc/host/sunplus_sd2.*
>  
>  SUPERH
> -- 
> 2.7.4
> 
> 
