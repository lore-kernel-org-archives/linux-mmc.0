Return-Path: <SRS0=RpB2=DG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D7BC4727C
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Sep 2020 20:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7E920774
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Sep 2020 20:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601409944;
	bh=Oe+nOvmp2DKUd/UwCX10LCZiem8qzh1HVDWlWGvZu3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kqhHXJu+cb13akRevu4gWhhUIB/rmGo2rT7dJVY4oavdLLeZt38EbJxZ95zneGej7
	 MglcPEviVK8FqERuMPAiC2XE/qpsKNfK2xrejQY+kDZGYkGR4xLOBM/3lfxxbI3d/k
	 gDu5+nj95kKXuLJ2YZSrlzTtntr+/0aXTkQLQRNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgI2UFo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:05:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38157 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2UFn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2020 16:05:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id y5so5720845otg.5;
        Tue, 29 Sep 2020 13:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5O6/yiKa9W0am9X4z8PvdhY0AeOo2G7Nxi3IcgMPrLY=;
        b=OxHo/fSsoUbHghjgnAYx+1rlJlmwNtfCMnFFH/fJ0LUTJqSKlTeAIgChEqr9hQ8Btw
         EbBp1A/7EjWXN6nFNKi4Fd4b9Xdug/Rpb83PaH9lQBVcawSK1opFsouoUsmxnljdy9gk
         HY5bSooRJVfsTELWMNqwnSFhxtOy4KJt1gIjXl5OXPS+9qvFPjQiMDnl6ezn7VXWp0MI
         W4UZFdC1bSuG8+ehyxFjfhfzqLu0f96lNK0Ym7FQiNehX1D/PRcX1oos1U1Orx4HUojT
         Ny0/Re5nX2bU0cY1L8b4I/EqF+bCj6+GkMImUnHiClZcuwkkMsoSYkDg0FsE0kWGIDjT
         j2FA==
X-Gm-Message-State: AOAM530ebpm4JgAPSyVl3Xs+ti4fPJ8kOx1kgohGwx/CnA7Oteev6WUY
        YtOoY2aIiMlgtCzqiwiWw0MKXXwIEZ+z
X-Google-Smtp-Source: ABdhPJztlT0j0a0jN6wipAi/qH4SpcVId83VVM6XK0PrviV73T9QkjU0nkO3vjApRAX8/kAkuw79xQ==
X-Received: by 2002:a05:6830:196:: with SMTP id q22mr3762671ota.221.1601409942312;
        Tue, 29 Sep 2020 13:05:42 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w125sm1222799oia.57.2020.09.29.13.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:05:41 -0700 (PDT)
Received: (nullmailer pid 1073610 invoked by uid 1000);
        Tue, 29 Sep 2020 20:05:40 -0000
Date:   Tue, 29 Sep 2020 15:05:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: Convert mtk-sd to json-schema
Message-ID: <20200929200540.GA1051185@bogus>
References: <20200928130918.32326-1-wenbin.mei@mediatek.com>
 <20200928130918.32326-2-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928130918.32326-2-wenbin.mei@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 28, 2020 at 09:09:15PM +0800, Wenbin Mei wrote:
> Convert the mtk-sd binding to DT schema format using json-schema.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.txt        |  75 --------
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 165 ++++++++++++++++++
>  2 files changed, 165 insertions(+), 75 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.yaml


> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> new file mode 100644
> index 000000000000..2d5ab1411cd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -0,0 +1,165 @@
> +# MTK-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mtk-sd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MTK MSDC Storage Host Controller Binding
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>

Usually this is the h/w block owner, not a subsystem maintainer.

> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt8135-mmc
> +      - const: mediatek,mt8173-mmc
> +      - const: mediatek,mt8183-mmc
> +      - const: mediatek,mt8516-mmc
> +      - const: mediatek,mt6779-mmc
> +      - const: mediatek,mt2701-mmc
> +      - const: mediatek,mt2712-mmc
> +      - const: mediatek,mt7622-mmc

All these can be an enum. And sort please.

> +      - items:
> +        - const: mediatek,mt7623-mmc
> +        - const: mediatek,mt2701-mmc
> +      - const: mediatek,mt7620-mmc
> +
> +  reg:
> +    description:
> +      physical base address of the controller and length.

Drop this.

> +    minItems: 1
> +    maxItems: 2

If more than 1, need to say what each entry is:

items:
  - description: ...
  - description: ...

> +
> +  interrupts:
> +    description:
> +      Should contain MSDC interrupt number.

Drop.

> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Should contain phandle for the clock feeding the MMC controller.
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - description: source clock (required).
> +      - description: HCLK which used for host (required).
> +      - description: independent source clock gate (required for MT2712).
> +      - description: bus clock used for internal register access (required for MT2712 MSDC0/3).
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - const: source
> +      - const: hclk
> +      - const: source_cg
> +      - const: bus_clk
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: state_uhs
> +
> +  pinctrl-0:
> +    description:
> +      should contain default/high speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    description:
> +      should contain uhs mode pin ctrl.
> +    maxItems: 1
> +
> +  vmmc-supply:
> +    description:
> +      power to the Core.
> +
> +  vqmmc-supply:
> +    description:
> +      power to the IO.
> +
> +  assigned-clocks:
> +    description:
> +      PLL of the source clock.

How many (maxItems)?

> +
> +  assigned-clock-parents:
> +    description:
> +      parent of source clock, used for HS400 mode to get 400Mhz source clock.
> +
> +  hs400-ds-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS400 DS delay setting.
> +
> +  mediatek,hs200-cmd-int-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS200 command internal delay setting.
> +      This field has total 32 stages.
> +      The value is an integer from 0 to 31.

minimum: 0
maximum: 31

Add any constraints on other properties too.

> +
> +  mediatek,hs400-cmd-int-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS400 command internal delay setting.
> +      This field has total 32 stages.
> +      The value is an integer from 0 to 31.
> +
> +  mediatek,hs400-cmd-resp-sel-rising:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      HS400 command response sample selection.
> +      If present, HS400 command responses are sampled on rising edges.
> +      If not present, HS400 command responses are sampled on falling edges.
> +
> +  mediatek,latch-ck:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some SoCs do not support enhance_rx, need set correct latch-ck to avoid
> +      data crc error caused by stop clock(fifo full) Valid range = [0:0x7].
> +      if not present, default value is 0.
> +      applied to compatible "mediatek,mt2701-mmc".
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: hrst
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    mmc0: mmc@11230000 {
> +        compatible = "mediatek,mt8173-mmc";
> +        reg = <0x11230000 0x1000>;
> +        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
> +        vmmc-supply = <&mt6397_vemc_3v3_reg>;
> +        vqmmc-supply = <&mt6397_vio18_reg>;
> +        clocks = <&pericfg CLK_PERI_MSDC30_0>,
> +                 <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
> +        clock-names = "source", "hclk";
> +        pinctrl-names = "default", "state_uhs";
> +        pinctrl-0 = <&mmc0_pins_default>;
> +        pinctrl-1 = <&mmc0_pins_uhs>;
> +        assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
> +        assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
> +        hs400-ds-delay = <0x14015>;
> +        mediatek,hs200-cmd-int-delay = <26>;
> +        mediatek,hs400-cmd-int-delay = <14>;
> +        mediatek,hs400-cmd-resp-sel-rising;
> +    };
> +
> +...
> -- 
> 2.18.0
