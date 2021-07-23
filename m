Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FDC4320A
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Jul 2021 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36E560EBA
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Jul 2021 21:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhGWVQx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:16:53 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:43819 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGWVQx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jul 2021 17:16:53 -0400
Received: by mail-io1-f50.google.com with SMTP id 185so4217963iou.10;
        Fri, 23 Jul 2021 14:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JEUqBiM+J1m4N4wn58eOxCBVMhTaLoqag1E8zxGCL2g=;
        b=eo5Fa2CaarivrlRULRK6GjRjZCuxozVMcNZniq2HYQ5U0idsCdspAHyzMrxICLYR8j
         Y5kzxu0NQkMj7nw5ox48/+c8T4yCt43aKfPDP0iD4majDPFRaXVYQss9uFPb23EP5kw6
         griX1o/fRhXnCcTem9Kun3tSlKJFbcffG/ORCBfBrmhMeDFji9IEbbB3UY12q8Nu4ngg
         FxM+h/JEsQL6f7w6fQdZ869qVW1oKNeO1GQCgOHtT/LAr3jfEYZv/7phT4vmpKjWv0cW
         4tmTA7FVnVjugn2FpBc+cMNY3FxBMgs+PBGB7Pa61yRyYfdV3q7iPz78nN+I01Nfs+q1
         wGWw==
X-Gm-Message-State: AOAM532MhW+mQc+2zODryzOdcr+6S4H9oKpSC6TU0J4wdHWsNqsDylPo
        MoBTr/JntjRiSZXKA7xDYA==
X-Google-Smtp-Source: ABdhPJx+fnNzJ+JYB9ZFpqsmcNuQpBMv6W8e/ZeZZxUWJy94HixqyNW+fd80TUFM24EnnpxS1fJCMQ==
X-Received: by 2002:a6b:1642:: with SMTP id 63mr5543293iow.68.1627077446285;
        Fri, 23 Jul 2021 14:57:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 204sm18862881ioc.50.2021.07.23.14.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:57:25 -0700 (PDT)
Received: (nullmailer pid 2664673 invoked by uid 1000);
        Fri, 23 Jul 2021 21:57:24 -0000
Date:   Fri, 23 Jul 2021 15:57:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 25/54] dt-bindings: mmc: Convert MMC Card binding to a
 schema
Message-ID: <20210723215724.GA2661499@robh.at.kernel.org>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-26-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721140424.725744-26-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 21, 2021 at 04:03:55PM +0200, Maxime Ripard wrote:
> MMC Cards can have an optional Device Tree binding to add
> non-discoverable properties.
> 
> Now that we have the DT validation in place, let's convert the device
> tree bindings for that driver over to a YAML schema.
> 
> Some of these properties were already described in the MMC controller
> binding, even though they are not generic and do not apply to any
> device, so we took the occasion to fix this.
> 
> Cc: linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../devicetree/bindings/mmc/mmc-card.txt      | 30 ------------
>  .../devicetree/bindings/mmc/mmc-card.yaml     | 48 +++++++++++++++++++
>  .../bindings/mmc/mmc-controller.yaml          |  6 ---
>  3 files changed, 48 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> deleted file mode 100644
> index 8d2d71758907..000000000000
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -mmc-card / eMMC bindings
> -------------------------
> -
> -This documents describes the devicetree bindings for a mmc-host controller
> -child node describing a mmc-card / an eMMC, see "Use of Function subnodes"
> -in mmc.txt
> -
> -Required properties:
> --compatible : Must be "mmc-card"
> --reg        : Must be <0>
> -
> -Optional properties:
> --broken-hpi : Use this to indicate that the mmc-card has a broken hpi
> -              implementation, and that hpi should not be used
> -
> -Example:
> -
> -&mmc2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc2_pins_a>;
> -	vmmc-supply = <&reg_vcc3v3>;
> -	bus-width = <8>;
> -	non-removable;
> -
> -	mmccard: mmccard@0 {
> -		reg = <0>;
> -		compatible = "mmc-card";
> -		broken-hpi;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> new file mode 100644
> index 000000000000..aefdd8748b72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MMC Card / eMMC Generic Device Tree Bindings
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description: |
> +  This documents describes the devicetree bindings for a mmc-host controller
> +  child node describing a mmc-card / an eMMC.
> +
> +properties:
> +  compatible:
> +    const: mmc-card
> +
> +  reg:
> +    const: 0
> +
> +  broken-hpi:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Use this to indicate that the mmc-card has a broken hpi
> +      implementation, and that hpi should not be used.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true

Like what? If there's other properties, then there should really be a 
specific compatible.

> +
> +examples:
> +  - |
> +    mmc {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        card@0 {
> +            compatible = "mmc-card";
> +            reg = <0>;
> +            broken-hpi;
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 25ac8e200970..513f3c8758aa 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -333,12 +333,6 @@ patternProperties:
>                subnode describes. A value of 0 denotes the memory SD
>                function, values from 1 to 7 denote the SDIO functions.
>  
> -      broken-hpi:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          Use this to indicate that the mmc-card has a broken hpi
> -          implementation, and that hpi should not be used.
> -
>      required:
>        - reg
>  
> -- 
> 2.31.1
> 
> 
