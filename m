Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D7BC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611B820776
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnzFGD3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbgE1KPE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387765AbgE1KO6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:14:58 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E7EC08C5C5
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:14:57 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id a11so9454230uah.12
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdz9MWebLwQSND4D0Bm3yeIJXnZ0zEw1qUOEdEpzjzg=;
        b=MnzFGD3vnBMN60+yOn2FCarWkarrPbqQizY4U25FCU9cbPfhcWUpoHqzz7CmkjYz40
         LoCddUYYP1d/hMOrusgsmN0bn4/gTqTxkWWs01U5mV8TYu/v1LLGUfEpbGh8GeRYX95O
         9jk9IRtpm0233tnYvAJwhAO08c949xbJDyt6GqRY6k1nAd7GkekCy51DJ/zFIY0uFI6p
         tbkst+cRdjDMAjT3pJDx7o7ClyuWdTegFXPej+t1KB+yOcL6NVkoJiLNJyQvBj9Rdrap
         8QX5ykRB/9XhlMlYMaJQw/YjgtdjC8CzLlTnU52zaxHZszztzGoY1dip1g19KHJvIC0Z
         YLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdz9MWebLwQSND4D0Bm3yeIJXnZ0zEw1qUOEdEpzjzg=;
        b=rZuM8d0yskQCwlO/1kdDggwaTAR4su0A55zzOs97mvCRpLnO8nDwAk6UpCCb4Adr71
         mpEk2BDSEm6Pgj7yVgQtyIUVfyJ1XsRGKqG8NrJQlpDOEH/8vgkdzCReIVSUvArQBc87
         LoePC/uoWJQ1Um174C2MJUZVVloIwqYDDdCw7wVCq3HdQxD34u7BAndKbPcJL69MvNA1
         GBsP5wL2wQDGiBd7UyZ1IyYh4Nf1TuIKTm/Nhm3EKrGEw1TqrZPc1jgYUenU1Wu9a3UZ
         x3Yx7Vta0RnDWiUq/N//+cjSmoLWQhDsuXVbRNwLNwhGyF7fddCWYNg2pvfrsQdHLDTB
         qlrQ==
X-Gm-Message-State: AOAM533uNWXqqwhFUx0jxBtmMXjsG5U4PQLLXtrxHAzKkEpPaHjZQ/CA
        l6AMc8l03vstOqtvXeGb1fVFNiyYhRAeWg9f6XmkyQ==
X-Google-Smtp-Source: ABdhPJyXviAJaU0Syk8zmEh34oVnZlsPyEKZ18ZkNSCsO/FREdzCCyZRh6J0EnFvQIa47dVszDJwQxlQhwCSK7LoKfQ=
X-Received: by 2002:ab0:13f2:: with SMTP id n47mr1325466uae.129.1590660896762;
 Thu, 28 May 2020 03:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com> <20200526062758.17642-4-wan.ahmad.zainie.wan.mohamad@intel.com>
In-Reply-To: <20200526062758.17642-4-wan.ahmad.zainie.wan.mohamad@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:20 +0200
Message-ID: <CAPDyKFpZNKB=XmD8_qig9HUy9uktH7d7DSJKaW7dshabi5WCBw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: convert arasan sdhci bindings to yaml
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 May 2020 at 08:29, Wan Ahmad Zainie
<wan.ahmad.zainie.wan.mohamad@intel.com> wrote:
>
> Convert arasan,sdhci.txt file to yaml. The new file arasan,sdhci.yaml
> will inherit properties from mmc-controller.yaml. 'sdhci' is no longer
> a valid name for node and should be changed to 'mmc'.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

I didn't queue this one yet, as I am would appreciate some feedback
from Rob first.

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  | 192 ------------
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 293 ++++++++++++++++++
>  2 files changed, 293 insertions(+), 192 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> deleted file mode 100644
> index f29bf7dd2ece..000000000000
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ /dev/null
> @@ -1,192 +0,0 @@
> -Device Tree Bindings for the Arasan SDHCI Controller
> -
> -  The bindings follow the mmc[1], clock[2], interrupt[3] and phy[4] bindings.
> -  Only deviations are documented here.
> -
> -  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> -  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -  [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -  [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
> -
> -Required Properties:
> -  - compatible: Compatibility string.  One of:
> -    - "arasan,sdhci-8.9a": generic Arasan SDHCI 8.9a PHY
> -    - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
> -    - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
> -    - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
> -      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> -    - "xlnx,zynqmp-8.9a": ZynqMP SDHCI 8.9a PHY
> -      For this device it is strongly suggested to include clock-output-names and
> -      #clock-cells.
> -    - "xlnx,versal-8.9a": Versal SDHCI 8.9a PHY
> -      For this device it is strongly suggested to include clock-output-names and
> -      #clock-cells.
> -    - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
> -       Note: This binding has been deprecated and moved to [5].
> -    - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
> -      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> -    - "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1": Intel LGM SDXC PHY
> -      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> -    - "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel Keem Bay eMMC
> -      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> -    - "intel,keembay-sdhci-5.1-sd": Intel Keem Bay SD controller
> -      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> -    - "intel,keembay-sdhci-5.1-sdio": Intel Keem Bay SDIO controller
> -      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> -
> -  [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> -
> -  - reg: From mmc bindings: Register location and length.
> -  - clocks: From clock bindings: Handles to clock inputs.
> -  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> -  - interrupts: Interrupt specifier
> -
> -Required Properties for "arasan,sdhci-5.1":
> -  - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
> -  - phy-names:  MUST be "phy_arasan".
> -
> -Optional Properties:
> -  - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
> -    used to access core corecfg registers.  Offsets of registers in this
> -    syscon are determined based on the main compatible string for the device.
> -  - clock-output-names: If specified, this will be the name of the card clock
> -    which will be exposed by this device.  Required if #clock-cells is
> -    specified.
> -  - #clock-cells: If specified this should be the value <0> or <1>. With this
> -    property in place we will export one or two clocks representing the Card
> -    Clock. These clocks are expected to be consumed by our PHY.
> -  - xlnx,fails-without-test-cd: when present, the controller doesn't work when
> -    the CD line is not connected properly, and the line is not connected
> -    properly. Test mode can be used to force the controller to function.
> -  - xlnx,int-clock-stable-broken: when present, the controller always reports
> -    that the internal clock is stable even when it is not.
> -
> -  - xlnx,mio-bank: When specified, this will indicate the MIO bank number in
> -    which the command and data lines are configured. If not specified, driver
> -    will assume this as 0.
> -
> -Example:
> -       sdhci@e0100000 {
> -               compatible = "arasan,sdhci-8.9a";
> -               reg = <0xe0100000 0x1000>;
> -               clock-names = "clk_xin", "clk_ahb";
> -               clocks = <&clkc 21>, <&clkc 32>;
> -               interrupt-parent = <&gic>;
> -               interrupts = <0 24 4>;
> -       } ;
> -
> -       sdhci@e2800000 {
> -               compatible = "arasan,sdhci-5.1";
> -               reg = <0xe2800000 0x1000>;
> -               clock-names = "clk_xin", "clk_ahb";
> -               clocks = <&cru 8>, <&cru 18>;
> -               interrupt-parent = <&gic>;
> -               interrupts = <0 24 4>;
> -               phys = <&emmc_phy>;
> -               phy-names = "phy_arasan";
> -       } ;
> -
> -       sdhci: sdhci@fe330000 {
> -               compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> -               reg = <0x0 0xfe330000 0x0 0x10000>;
> -               interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> -               clock-names = "clk_xin", "clk_ahb";
> -               arasan,soc-ctl-syscon = <&grf>;
> -               assigned-clocks = <&cru SCLK_EMMC>;
> -               assigned-clock-rates = <200000000>;
> -               clock-output-names = "emmc_cardclock";
> -               phys = <&emmc_phy>;
> -               phy-names = "phy_arasan";
> -               #clock-cells = <0>;
> -       };
> -
> -       sdhci: mmc@ff160000 {
> -               compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
> -               interrupt-parent = <&gic>;
> -               interrupts = <0 48 4>;
> -               reg = <0x0 0xff160000 0x0 0x1000>;
> -               clocks = <&clk200>, <&clk200>;
> -               clock-names = "clk_xin", "clk_ahb";
> -               clock-output-names = "clk_out_sd0", "clk_in_sd0";
> -               #clock-cells = <1>;
> -               clk-phase-sd-hs = <63>, <72>;
> -       };
> -
> -       sdhci: mmc@f1040000 {
> -               compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
> -               interrupt-parent = <&gic>;
> -               interrupts = <0 126 4>;
> -               reg = <0x0 0xf1040000 0x0 0x10000>;
> -               clocks = <&clk200>, <&clk200>;
> -               clock-names = "clk_xin", "clk_ahb";
> -               clock-output-names = "clk_out_sd0", "clk_in_sd0";
> -               #clock-cells = <1>;
> -               clk-phase-sd-hs = <132>, <60>;
> -       };
> -
> -       emmc: sdhci@ec700000 {
> -               compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
> -               reg = <0xec700000 0x300>;
> -               interrupt-parent = <&ioapic1>;
> -               interrupts = <44 1>;
> -               clocks = <&cgu0 LGM_CLK_EMMC5>, <&cgu0 LGM_CLK_NGI>,
> -                        <&cgu0 LGM_GCLK_EMMC>;
> -               clock-names = "clk_xin", "clk_ahb", "gate";
> -               clock-output-names = "emmc_cardclock";
> -               #clock-cells = <0>;
> -               phys = <&emmc_phy>;
> -               phy-names = "phy_arasan";
> -               arasan,soc-ctl-syscon = <&sysconf>;
> -       };
> -
> -       sdxc: sdhci@ec600000 {
> -               compatible = "arasan,sdhci-5.1", "intel,lgm-sdhci-5.1-sdxc";
> -               reg = <0xec600000 0x300>;
> -               interrupt-parent = <&ioapic1>;
> -               interrupts = <43 1>;
> -               clocks = <&cgu0 LGM_CLK_SDIO>, <&cgu0 LGM_CLK_NGI>,
> -                        <&cgu0 LGM_GCLK_SDXC>;
> -               clock-names = "clk_xin", "clk_ahb", "gate";
> -               clock-output-names = "sdxc_cardclock";
> -               #clock-cells = <0>;
> -               phys = <&sdxc_phy>;
> -               phy-names = "phy_arasan";
> -               arasan,soc-ctl-syscon = <&sysconf>;
> -       };
> -
> -       mmc: mmc@33000000 {
> -               compatible = "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1";
> -               interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> -               reg = <0x0 0x33000000 0x0 0x300>;
> -               clock-names = "clk_xin", "clk_ahb";
> -               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>,
> -                        <&scmi_clk KEEM_BAY_PSS_EMMC>;
> -               phys = <&emmc_phy>;
> -               phy-names = "phy_arasan";
> -               assigned-clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>;
> -               assigned-clock-rates = <200000000>;
> -               clock-output-names = "emmc_cardclock";
> -               #clock-cells = <0>;
> -               arasan,soc-ctl-syscon = <&mmc_phy_syscon>;
> -       };
> -
> -       sd0: mmc@31000000 {
> -               compatible = "intel,keembay-sdhci-5.1-sd";
> -               interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> -               reg = <0x0 0x31000000 0x0 0x300>;
> -               clock-names = "clk_xin", "clk_ahb";
> -               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
> -                        <&scmi_clk KEEM_BAY_PSS_SD0>;
> -               arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
> -       };
> -
> -       sd1: mmc@32000000 {
> -               compatible = "intel,keembay-sdhci-5.1-sdio";
> -               interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> -               reg = <0x0 0x32000000 0x0 0x300>;
> -               clock-names = "clk_xin", "clk_ahb";
> -               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD1>,
> -                        <&scmi_clk KEEM_BAY_PSS_SD1>;
> -               arasan,soc-ctl-syscon = <&sd1_phy_syscon>;
> -       };
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
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - items:
> +          - const: xlnx,zynqmp-8.9a             # ZynqMP SDHCI 8.9a PHY
> +          - const: arasan,sdhci-8.9a
> +        description: |
> +          For this device it is strongly suggested to include
> +          clock-output-names and '#clock-cells'.
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
> --
> 2.17.1
>
