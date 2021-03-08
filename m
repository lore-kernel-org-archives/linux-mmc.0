Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D134C433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15EC65257
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCHVnV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:43:21 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:41043 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHVmt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 16:42:49 -0500
Received: by mail-io1-f42.google.com with SMTP id z13so11636773iox.8;
        Mon, 08 Mar 2021 13:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHaDCIFSJ/WaA+1UndQODdn6YA7l7EOGWs12tpJYWwc=;
        b=aKTR1SwFX/R1dpQ/Og56vAJKlXsFp8j/j9HwMNgmZ8DdfqrA0eB9MRWMQ+7ktDJ+lQ
         uAqSwiVWYR11zXyPuOxIvmcvPptygAcfRYxcOjWQ04GyUOtALYQdgg34+nItKdZgCt3C
         BY5LZf99I8qzGLR6lTjCrKqjZzKVE9ryQh5j3BGVGHAxYFx4jBXyuzMfPyWV1gBBia66
         Xn1KrDfF2m3AquIsQI2VuaZTllZRY9frCErmzcLIoW2eM5P/IQTkcrj1kuDsA/g/H8tu
         tZ5GY7NI+1mtjaR+egnSbmtnsuEZUMdMINc0GR359GVRHM2mvlG00uKT01RudjX0hIMQ
         Q4Yg==
X-Gm-Message-State: AOAM5310uV+FG9P/dydTOWHqbTupD13HvVTQV8+rYxg7ZCrhcdu4B5VK
        urXaTFoUOxlGII+mFD0zSPN3IOxUBA==
X-Google-Smtp-Source: ABdhPJxM035frlT4oHWfpTCS3AKMyqbXOwdLygiLPvLj+LFEYJyvL6l/HOkEc2Ks/pXPGvbugX4PBQ==
X-Received: by 2002:a5d:81c8:: with SMTP id t8mr20788383iol.38.1615239768523;
        Mon, 08 Mar 2021 13:42:48 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u14sm6528028ilv.0.2021.03.08.13.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:42:47 -0800 (PST)
Received: (nullmailer pid 3004894 invoked by uid 1000);
        Mon, 08 Mar 2021 21:42:45 -0000
Date:   Mon, 8 Mar 2021 14:42:45 -0700
From:   Rob Herring <robh@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Convert to
 yaml file
Message-ID: <20210308214245.GA2999684@robh.at.kernel.org>
References: <1614909262-205658-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614909262-205658-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Mar 05, 2021 at 09:54:20AM +0800, Shawn Lin wrote:
> This patch converts sdhci-of-dwcmshc.txt to sdhci-of-dwcmshc.yaml
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/mmc/sdhci-of-dwcmshc.txt   | 20 -------
>  .../devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml  | 63 ++++++++++++++++++++++

Use the compatible string for filename.

>  2 files changed, 63 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
>  create mode 100755 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> deleted file mode 100644
> index ee4253b..0000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -* Synopsys DesignWare Cores Mobile Storage Host Controller
> -
> -Required properties:
> -- compatible: should be one of the following:
> -    "snps,dwcmshc-sdhci"
> -- reg: offset and length of the register set for the device.
> -- interrupts: a single interrupt specifier.
> -- clocks: Array of clocks required for SDHCI; requires at least one for
> -    core clock.
> -- clock-names: Array of names corresponding to clocks property; shall be
> -    "core" for core clock and "bus" for optional bus clock.
> -
> -Example:
> -	sdhci2: sdhci@aa0000 {
> -		compatible = "snps,dwcmshc-sdhci";
> -		reg = <0xaa0000 0x1000>;
> -		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&emmcclk>;
> -		bus-width = <8>;
> -	}
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
> new file mode 100755
> index 0000000..9d717a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sdhci-of-dwcmshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys Designware Mobile Storage Host Controller Binding
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +  - Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - snps,dwcmshc-sdhci
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 3

You need to define what each entry is.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Handle to "core" for core clock and "bus" for optional bus clock.

minItems: 1
items:
  - description: core clock
  - description: bus clock

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2

Don't need maxItems here (implied by 'items' length).

> +    items:
> +      - const: core
> +      - const: bus
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc@aa0000 {
> +      compatible = "snps,dwcmshc-sdhci";
> +      reg = <0xaa000 0x1000>;
> +      interrupts = <0 25 0x4>;
> +      clocks = <&cru 17>, <&cru 18>;
> +      clock-names = "core", "bus";
> +      bus-width = <8>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 
> 
> 
