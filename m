Return-Path: <SRS0=LShN=7L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F74C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 29 May 2020 17:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630EA20C09
	for <linux-mmc@archiver.kernel.org>; Fri, 29 May 2020 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590773626;
	bh=SNQdh+5jaEJbxKMssUMOHcYvyouRlDUWYoRlEIQ3VBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=md/HMLLkndGB7SRy65NRw0NR/qxkmme6yG7ca04SOAvde9d14SFtRsOudI/2fvYRI
	 tWVM1hVnT8Ll5Mss/+E9ln7MDHTzHNEIEzIJfkmm9kBq5UBi6XYBJSH5AoLZUbQknU
	 jpLJWycii8mQp/6NfuTAY+IwTGK+axiKLsPVru/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgE2Rdm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 May 2020 13:33:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36417 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgE2Rdh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 May 2020 13:33:37 -0400
Received: by mail-io1-f68.google.com with SMTP id y18so210600iow.3;
        Fri, 29 May 2020 10:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mxo1EhLh2RKUw9w3a9nRk142aiL3zwZ50xn8LYVklNc=;
        b=CbdNyAcrea4vbj19qtXfhpkDF6+6kwqgxNpS7h2hrkkxyrFtkd9tgQ81gy2aYr4qFi
         G5w1gJtrnARhusNf/gaPWFUDtQh3p0EKk8WO7rTsQuu9mOP5DAF7DiJ/J58+JHpd7ITv
         xtEAnyrfen+EgI/OLQS65cHBVLl6DJWcYUaMoVO3NwzGegW7yUSkcS/FwNxvRoHx8GLf
         93hzYOKI94poJjP2+mJmR94QRFslP3AMgb+XbWaoTElG+XuIFPhpoWZfnRaEvZvjZCC0
         BQEF+XzfiEmUxmNx+Ehe+VNpxrvpaoGWIiZGyr5SOmgp73Afm1qdFJoJEHtQmOCXvoqi
         b2bg==
X-Gm-Message-State: AOAM532JrHDu2jKGvjnEgprzKBYuIsxLcR1CuPG59swsA/3OB5hNQH53
        V5ILh+RS3JbPq8gXgrpIgNOkAwY=
X-Google-Smtp-Source: ABdhPJx/8CcKqOLLXmoBOAMjRJrpH6bdYlzKC6RCrir4G+tnvo2SIc91w/yL2x3hIPJ6xQfOEMAJqA==
X-Received: by 2002:a92:400f:: with SMTP id n15mr2866542ila.135.1590773150563;
        Fri, 29 May 2020 10:25:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w29sm3344934ila.26.2020.05.29.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:25:49 -0700 (PDT)
Received: (nullmailer pid 2607846 invoked by uid 1000);
        Fri, 29 May 2020 17:25:47 -0000
Date:   Fri, 29 May 2020 11:25:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: convert arasan sdhci bindings
 to yaml
Message-ID: <20200529172547.GA2594494@bogus>
References: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200526062758.17642-4-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526062758.17642-4-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 26, 2020 at 02:27:58PM +0800, Wan Ahmad Zainie wrote:
> Convert arasan,sdhci.txt file to yaml. The new file arasan,sdhci.yaml
> will inherit properties from mmc-controller.yaml. 'sdhci' is no longer
> a valid name for node and should be changed to 'mmc'.
> 
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  | 192 ------------
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 293 ++++++++++++++++++
>  2 files changed, 293 insertions(+), 192 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml


> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> new file mode 100644
> index 000000000000..927e2f13958b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -0,0 +1,293 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mmc/arasan,sdhci.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Device Tree Bindings for the Arasan SDHCI Controller
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml#"
> +
> +maintainers:
> +  - Adrian Hunter <adrian.hunter@intel.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: arasan,sdhci-8.9a                # generic Arasan SDHCI 8.9a PHY
> +      - const: arasan,sdhci-4.9a                # generic Arasan SDHCI 4.9a PHY
> +      - const: arasan,sdhci-5.1                 # generic Arasan SDHCI 5.1 PHY
> +      - items:
> +          - const: rockchip,rk3399-sdhci-5.1    # rk3399 eMMC PHY
> +          - const: arasan,sdhci-5.1
> +        description: |

Can drop '|' as formatting isn't important.

> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - items:
> +          - const: xlnx,zynqmp-8.9a             # ZynqMP SDHCI 8.9a PHY
> +          - const: arasan,sdhci-8.9a
> +        description: |
> +          For this device it is strongly suggested to include
> +          clock-output-names and '#clock-cells'.

Sounds like a constraint. It's either optional or required though. There 
is no suggested.

> +      - items:
> +          - const: xlnx,versal-8.9a             # Versal SDHCI 8.9a PHY
> +          - const: arasan,sdhci-8.9a
> +        description: |
> +          For this device it is strongly suggested to include
> +          clock-output-names and '#clock-cells'.
> +      - items:
> +          - const: intel,lgm-sdhci-5.1-emmc     # Intel LGM eMMC PHY
> +          - const: arasan,sdhci-5.1
> +        description: |
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - items:
> +          - const: intel,lgm-sdhci-5.1-sdxc     # Intel LGM SDXC PHY
> +          - const: arasan,sdhci-5.1
> +        description: |
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - items:
> +          - const: intel,keembay-sdhci-5.1-emmc # Intel Keem Bay eMMC PHY
> +          - const: arasan,sdhci-5.1
> +        description: |
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - const: intel,keembay-sdhci-5.1-sd       # Intel Keem Bay SD controller
> +        description: |
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - const: intel,keembay-sdhci-5.1-sdio     # Intel Keem Bay SDIO controller
> +        description: |
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: clk_xin
> +      - const: clk_ahb
> +      - const: gate
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: phy_arasan
> +
> +  arasan,soc-ctl-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      A phandle to a syscon device (see ../mfd/syscon.txt) used to access
> +      core corecfg registers. Offsets of registers in this syscon are
> +      determined based on the main compatible string for the device.
> +
> +  clock-output-names:
> +    description: |
> +      If specified, this will be the name of the card clock which will
> +      be exposed by this device. Required if '#clock-cells' is specified.

The last sentence can be a 'dependencies' schema.

Are there defined names for this?

> +
> +  '#clock-cells':
> +    enum: [0, 1]
> +    description: |
> +      With this property in place we will export one or two clocks
> +      representing the Card Clock. These clocks are expected to be
> +      consumed by our PHY.
> +
> +  xlnx,fails-without-test-cd:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      When present, the controller doesn't work when the CD line is not
> +      connected properly, and the line is not connected properly.
> +      Test mode can be used to force the controller to function.
> +
> +  xlnx,int-clock-stable-broken:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      When present, the controller always reports that the internal clock
> +      is stable even when it is not.
> +
> +  xlnx,mio-bank:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      When specified, this will indicate the MIO bank number in which
> +      the command and data lines are configured. If not specified, driver
> +      will assume this as 0.

default: 0

Is there a range of valid values?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: arasan,sdhci-5.1
> +then:
> +  required:
> +    - phys
> +    - phy-names

Add: unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    mmc@e0100000 {
> +          compatible = "arasan,sdhci-8.9a";
> +          reg = <0xe0100000 0x1000>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clocks = <&clkc 21>, <&clkc 32>;
> +          interrupt-parent = <&gic>;
> +          interrupts = <0 24 4>;
> +    };
> +
> +  - |
> +    mmc@e2800000 {
> +          compatible = "arasan,sdhci-5.1";
> +          reg = <0xe2800000 0x1000>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clocks = <&cru 8>, <&cru 18>;
> +          interrupt-parent = <&gic>;
> +          interrupts = <0 24 4>;
> +          phys = <&emmc_phy>;
> +          phy-names = "phy_arasan";
> +    };
> +
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mmc@fe330000 {
> +          compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> +          reg = <0x0 0xfe330000 0x0 0x10000>;

Examples default to a single cell each for size and address.

> +          interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +          clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          arasan,soc-ctl-syscon = <&grf>;
> +          assigned-clocks = <&cru SCLK_EMMC>;
> +          assigned-clock-rates = <200000000>;
> +          clock-output-names = "emmc_cardclock";
> +          phys = <&emmc_phy>;
> +          phy-names = "phy_arasan";
> +          #clock-cells = <0>;
> +    };
> +
> +  - |
> +    mmc@ff160000 {
> +          compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
> +          interrupt-parent = <&gic>;
> +          interrupts = <0 48 4>;
> +          reg = <0x0 0xff160000 0x0 0x1000>;

Same here.

> +          clocks = <&clk200>, <&clk200>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clock-output-names = "clk_out_sd0", "clk_in_sd0";
> +          #clock-cells = <1>;
> +          clk-phase-sd-hs = <63 72>;
> +    };
> +
> +  - |
> +    mmc@f1040000 {
> +          compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
> +          interrupt-parent = <&gic>;
> +          interrupts = <0 126 4>;
> +          reg = <0x0 0xf1040000 0x0 0x10000>;
> +          clocks = <&clk200>, <&clk200>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clock-output-names = "clk_out_sd0", "clk_in_sd0";
> +          #clock-cells = <1>;
> +          clk-phase-sd-hs = <132>, <60>;
> +    };
> +
> +  - |
> +    #define LGM_CLK_EMMC5
> +    #define LGM_CLK_NGI
> +    #define LGM_GCLK_EMMC
> +    mmc@ec700000 {
> +          compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
> +          reg = <0xec700000 0x300>;
> +          interrupt-parent = <&ioapic1>;
> +          interrupts = <44 1>;
> +          clocks = <&cgu0 LGM_CLK_EMMC5>, <&cgu0 LGM_CLK_NGI>,
> +                   <&cgu0 LGM_GCLK_EMMC>;
> +          clock-names = "clk_xin", "clk_ahb", "gate";
> +          clock-output-names = "emmc_cardclock";
> +          #clock-cells = <0>;
> +          phys = <&emmc_phy>;
> +          phy-names = "phy_arasan";
> +          arasan,soc-ctl-syscon = <&sysconf>;
> +    };
> +
> +  - |
> +    #define LGM_CLK_SDIO
> +    #define LGM_GCLK_SDXC
> +    mmc@ec600000 {
> +          compatible = "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1";
> +          reg = <0xec600000 0x300>;
> +          interrupt-parent = <&ioapic1>;
> +          interrupts = <43 1>;
> +          clocks = <&cgu0 LGM_CLK_SDIO>, <&cgu0 LGM_CLK_NGI>,
> +                   <&cgu0 LGM_GCLK_SDXC>;
> +          clock-names = "clk_xin", "clk_ahb", "gate";
> +          clock-output-names = "sdxc_cardclock";
> +          #clock-cells = <0>;
> +          phys = <&sdxc_phy>;
> +          phy-names = "phy_arasan";
> +          arasan,soc-ctl-syscon = <&sysconf>;
> +    };
> +
> +  - |
> +    #define KEEM_BAY_PSS_AUX_EMMC
> +    #define KEEM_BAY_PSS_EMMC
> +    mmc@33000000 {
> +          compatible = "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1";
> +          interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +          reg = <0x0 0x33000000 0x0 0x300>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>,
> +                   <&scmi_clk KEEM_BAY_PSS_EMMC>;
> +          phys = <&emmc_phy>;
> +          phy-names = "phy_arasan";
> +          assigned-clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>;
> +          assigned-clock-rates = <200000000>;
> +          clock-output-names = "emmc_cardclock";
> +          #clock-cells = <0>;
> +          arasan,soc-ctl-syscon = <&mmc_phy_syscon>;
> +    };
> +
> +  - |
> +    #define KEEM_BAY_PSS_AUX_SD0
> +    #define KEEM_BAY_PSS_SD0
> +    mmc@31000000 {
> +          compatible = "intel,keembay-sdhci-5.1-sd";
> +          interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +          reg = <0x0 0x31000000 0x0 0x300>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
> +                   <&scmi_clk KEEM_BAY_PSS_SD0>;
> +          arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
> +    };
> +
> +  - |
> +    #define KEEM_BAY_PSS_AUX_SD1
> +    #define KEEM_BAY_PSS_SD1
> +    mmc@32000000 {
> +          compatible = "intel,keembay-sdhci-5.1-sdio";
> +          interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +          reg = <0x0 0x32000000 0x0 0x300>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD1>,
> +                   <&scmi_clk KEEM_BAY_PSS_SD1>;
> +          arasan,soc-ctl-syscon = <&sd1_phy_syscon>;
> +    };

Really need 3 Keem Bay examples?

> -- 
> 2.17.1
> 
