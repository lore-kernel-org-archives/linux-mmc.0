Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA49C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 17:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4210C6108E
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhKHRTM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 12:19:12 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38525 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKHRTM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 12:19:12 -0500
Received: by mail-oi1-f180.google.com with SMTP id r26so7401985oiw.5;
        Mon, 08 Nov 2021 09:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vu4a84fjDFz0BFr7Vx+IRehX13Sklb9+xGncvU8UvU4=;
        b=35RvfEnb7+oxDwDhshcsxa9Urqa2iztHKoTOfn8yScULIAIIZ/aw1cYupoD97VIQpq
         kD9aRbo3uNjC1A5PrjaOfNBBiATH/wjRABI0zaZ2vY58MsjlDE1WtV/cV00AGW4TtLWJ
         mB58uWsKchAJp0/7m+GzqJVd/xuAcQXR9bc+FYvXpEwnaDiuUT2BreG2p+CtjKroAskQ
         RwwU+spHMPlFmLzdptGDL6bhJlpNQiuA1bPBUYDmNzviR/f+6FOh8X0Pi3TCrQ8UIoyu
         0uKW4c2POaPeH7t2+pcH7e2SOALnM7wgyyuyANZb2EfAq2Iqa2wzM14EGuQodT0IkMXN
         EoCw==
X-Gm-Message-State: AOAM532vIxevaCZLqJqevIEJyY2RbEfKWPEt/IHZYGRT4b9LOx9btbap
        3i8XilGmQHz5L3QTk8rA6Q==
X-Google-Smtp-Source: ABdhPJxE+F7n7nlSYLvkc9SOKSaGosIc69vBin/edtQ2MTe+QJ4tYvuoUVF1jdDRPNuRz7F07U6JAQ==
X-Received: by 2002:aca:1818:: with SMTP id h24mr38823599oih.76.1636391787109;
        Mon, 08 Nov 2021 09:16:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x92sm6713239ota.46.2021.11.08.09.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:16:25 -0800 (PST)
Received: (nullmailer pid 3601472 invoked by uid 1000);
        Mon, 08 Nov 2021 17:16:25 -0000
Date:   Mon, 8 Nov 2021 11:16:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Tony Huang <tony.huang@sunplus.com>
Subject: Re: [PATCH 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Message-ID: <YYlbaTyAXYMw8A5O@robh.at.kernel.org>
References: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
 <1636208598-18234-2-git-send-email-tony.huang@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636208598-18234-2-git-send-email-tony.huang@sunplus.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Nov 06, 2021 at 10:23:17PM +0800, Tony Huang wrote:
> Add mmc yaml file for Sunplus SP7021
> 
> Signed-off-by: Tony Huang <tony.huang@sunplus.com>
> ---
>  .../devicetree/bindings/mmc/sunplus-mmc.yaml       | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> new file mode 100644
> index 0000000..fc5a5f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: sunplus MMC controller
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - tony.huang <tony.huang@sunplus.com>

Please fix your name.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-emmc
> +      - sunplus,i143-emmc
> +      - sunplus,q645-emmc

blank line here.

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  resets:
> +    maxItems: 1
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
> +    #include <dt-bindings/clock/sp-sp7021.h>
> +    #include <dt-bindings/reset/sp-sp7021.h>
> +    mmc0: mmc@9c003b00 {
> +        compatible = "sunplus,sp7021-emmc";
> +        reg = <0x9c003b00 0x180>;
> +        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc CARD_CTL0>;
> +        resets = <&rstc RST_CARD_CTL0>;
> +        bus-width = <8>;
> +        max-frequency = <52000000>;
> +        non-removable;
> +        disable-wp;
> +        cap-mmc-highspeed;
> +        mmc-ddr-3_3v;
> +        no-sdio;
> +        no-sd;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd4..179e60a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS MMC DRIVER
> +M:	Tony Huang <tony.huang@sunplus.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mmc/sunplu-mmc.yaml
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> -- 
> 2.7.4
> 
> 
