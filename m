Return-Path: <SRS0=f1/V=DU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86B1C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 16:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533D0252F8
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602608142;
	bh=cpbvmbNxOsTJdHKwCuoioo75Lwit8Fv1xXENLkQbN7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A+ycRP56XbRmqzmwzXUV+E73oDPKsK5gx+wx2U9t4AHXMPJh9mfD2HynUj2b5XR0Y
	 l5uftdwP/oFnCj8cahmWq/3D+mU0HVkU6KkRwVdZNqyN2/BX/GrAOoxPyVcLNFgwg+
	 3ZVZAGbHDdtSzVBvZCG8qPnexakzpyZj4uvl18yY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgJMQzl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 12:55:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37359 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgJMQzl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 12:55:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id t77so105939oie.4;
        Tue, 13 Oct 2020 09:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Oz6Xfj76J5UebP7W/wnJQsjdJjBRc1UsbNsPfdE2SU=;
        b=bmEIFueiRr5MczqT5B+bVk4i0vSUHu1xnajvZZgT7JU6kqEClQR0B1WcN5VcWWpl+Q
         yBO5M/f5AsaRthVUuvYWmfTUNSmaNPbLrnAy1/0LwnIWAFODbJHnUmym/D2QJoOWnyAw
         d7SdmIJ+hwvWNt7DYKl5h6kyYBNKCoNlJ0VKUdiKavk93dELAZEUJMTby7Gn/BZffo29
         9f0uzgZ8totjq9kDGJD5IglzDaEg+p/CQOvaxO3VsaWWB5RH1Kf3W6wyvSR5BEPGNm2q
         ox/ItX7AGpFNRTOqoxWrONpL9WiQKulKdQKRF6hOJWVgy30+Pe+XKGPMhawRtpFeWOrU
         41Hg==
X-Gm-Message-State: AOAM5304YUITC3rllu8/sDWyQ/sBOB1O62GaBlVJe0Qqc3MAws6nJMj8
        Og2B5Evj3NKqcGQOuGuCYQ==
X-Google-Smtp-Source: ABdhPJybTuOcoxZ4SOf+C3/3IaOFYEcbMnTh6G+tmhKIT0Nm26q4BedGaMMNk77+QFkru5lJJlOl+A==
X-Received: by 2002:aca:afcc:: with SMTP id y195mr430066oie.30.1602608140255;
        Tue, 13 Oct 2020 09:55:40 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r80sm164332oor.31.2020.10.13.09.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 09:55:39 -0700 (PDT)
Received: (nullmailer pid 3684302 invoked by uid 1000);
        Tue, 13 Oct 2020 16:55:38 -0000
Date:   Tue, 13 Oct 2020 11:55:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v6 1/4] dt-bindings: mmc: Convert mtk-sd to json-schema
Message-ID: <20201013165538.GA3678156@bogus>
References: <20201012124547.16649-1-wenbin.mei@mediatek.com>
 <20201012124547.16649-2-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012124547.16649-2-wenbin.mei@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Oct 12, 2020 at 08:45:44PM +0800, Wenbin Mei wrote:
> Convert the mtk-sd binding to DT schema format using json-schema.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.txt        |  75 --------
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 163 ++++++++++++++++++
>  2 files changed, 163 insertions(+), 75 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> deleted file mode 100644
> index 26a8f320a156..000000000000
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -* MTK MMC controller
> -
> -The MTK  MSDC can act as a MMC controller
> -to support MMC, SD, and SDIO types of memory cards.
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the msdc driver.
> -
> -Required properties:
> -- compatible: value should be either of the following.
> -	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> -	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> -	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
> -	"mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
> -	"mediatek,mt6779-mmc": for mmc host ip compatible with mt6779
> -	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> -	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> -	"mediatek,mt7622-mmc": for MT7622 SoC
> -	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
> -	"mediatek,mt7620-mmc", for MT7621 SoC (and others)
> -
> -- reg: physical base address of the controller and length
> -- interrupts: Should contain MSDC interrupt number
> -- clocks: Should contain phandle for the clock feeding the MMC controller
> -- clock-names: Should contain the following:
> -	"source" - source clock (required)
> -	"hclk" - HCLK which used for host (required)
> -	"source_cg" - independent source clock gate (required for MT2712)
> -	"bus_clk" - bus clock used for internal register access (required for MT2712 MSDC0/3)
> -- pinctrl-names: should be "default", "state_uhs"
> -- pinctrl-0: should contain default/high speed pin ctrl
> -- pinctrl-1: should contain uhs mode pin ctrl
> -- vmmc-supply: power to the Core
> -- vqmmc-supply: power to the IO
> -
> -Optional properties:
> -- assigned-clocks: PLL of the source clock
> -- assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
> -- hs400-ds-delay: HS400 DS delay setting
> -- mediatek,hs200-cmd-int-delay: HS200 command internal delay setting.
> -				This field has total 32 stages.
> -				The value is an integer from 0 to 31.
> -- mediatek,hs400-cmd-int-delay: HS400 command internal delay setting
> -				This field has total 32 stages.
> -				The value is an integer from 0 to 31.
> -- mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
> -				       If present,HS400 command responses are sampled on rising edges.
> -				       If not present,HS400 command responses are sampled on falling edges.
> -- mediatek,latch-ck: Some SoCs do not support enhance_rx, need set correct latch-ck to avoid data crc
> -		     error caused by stop clock(fifo full)
> -		     Valid range = [0:0x7]. if not present, default value is 0.
> -		     applied to compatible "mediatek,mt2701-mmc".
> -- resets: Phandle and reset specifier pair to softreset line of MSDC IP.
> -- reset-names: Should be "hrst".
> -
> -Examples:
> -mmc0: mmc@11230000 {
> -	compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
> -	reg = <0 0x11230000 0 0x108>;
> -	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
> -	vmmc-supply = <&mt6397_vemc_3v3_reg>;
> -	vqmmc-supply = <&mt6397_vio18_reg>;
> -	clocks = <&pericfg CLK_PERI_MSDC30_0>,
> -	         <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
> -	clock-names = "source", "hclk";
> -	pinctrl-names = "default", "state_uhs";
> -	pinctrl-0 = <&mmc0_pins_default>;
> -	pinctrl-1 = <&mmc0_pins_uhs>;
> -	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
> -	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
> -	hs400-ds-delay = <0x14015>;
> -	mediatek,hs200-cmd-int-delay = <26>;
> -	mediatek,hs400-cmd-int-delay = <14>;
> -	mediatek,hs400-cmd-resp-sel-rising;
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> new file mode 100644
> index 000000000000..21a2fce5b7ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mtk-sd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MTK MSDC Storage Host Controller Binding
> +
> +maintainers:
> +  - Chaotian Jing <chaotian.jing@mediatek.com>
> +  - Wenbin Mei <wenbin.mei@mediatek.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +        - mediatek,mt2701-mmc
> +        - mediatek,mt2712-mmc
> +        - mediatek,mt6779-mmc
> +        - mediatek,mt7620-mmc
> +        - mediatek,mt7622-mmc
> +        - mediatek,mt8135-mmc
> +        - mediatek,mt8173-mmc
> +        - mediatek,mt8183-mmc
> +        - mediatek,mt8516-mmc
> +      - items:
> +        - const: mediatek,mt7623-mmc
> +        - const: mediatek,mt2701-mmc
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
> +  assigned-clocks:
> +    description:
> +      PLL of the source clock.
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    description:
> +      parent of source clock, used for HS400 mode to get 400Mhz source clock.
> +    maxItems: 1
> +
> +  hs400-ds-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS400 DS delay setting.
> +    minimum: 0
> +    maximum: 0xffffffff
> +
> +  mediatek,hs200-cmd-int-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS200 command internal delay setting.
> +      This field has total 32 stages.
> +      The value is an integer from 0 to 31.
> +    minimum: 0
> +    maximum: 31
> +
> +  mediatek,hs400-cmd-int-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS400 command internal delay setting.
> +      This field has total 32 stages.
> +      The value is an integer from 0 to 31.
> +    minimum: 0
> +    maximum: 31
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
> +    minimum: 0
> +    maximum: 7
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
> +  - pinctrl-names
> +  - pinctrl-0
> +  - pinctrl-1
> +  - vmmc-supply
> +  - vqmmc-supply

Add:

unevaluatedProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
