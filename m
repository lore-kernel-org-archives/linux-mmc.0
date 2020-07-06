Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F90C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1B820722
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc14rbue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgGFOe7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgGFOe6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:34:58 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C81C061755
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:34:58 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id v26so5613218vkn.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOkRkaHPOBu7LSeV+lAf5sRmA37rj5DzvQh8xGyFGK8=;
        b=kc14rbuei6UanrDi1uQ+fSi/n4cAqoFUF3Fu9XjmSFDDwuSffXBQ4XtjeUELb948gN
         XQijFkN5qqumYxJLb0KHwqbNLjOuJ/O3723JY4zlyOruRS5F9xCOw4hqBbn189ENucko
         YgMOd8hlbdC9Ob2HmfUDvq98UXnEEwFRT/wxrGceDG8E2X1Ji0/GeeyoYINRn8jtyAbe
         4dG3jEMnUhERbgYWEtIHiO5zXXnHlET7b/DFpLH+CjUt+BQoC9KrmeN02tohKUzG9363
         cBf8NBvjjOFoGdg2ZM05+49kbv4ezxsV53ahnN1QexHh1BZP1ysIr/Cm+41V5ZjpdNMP
         JBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOkRkaHPOBu7LSeV+lAf5sRmA37rj5DzvQh8xGyFGK8=;
        b=CodffgiJIceVG3t2nqXg0oX2IH771zZLk4GvW17O6T6IGDRmt75ZnXTIWXmhGXg0lR
         BXxXFuSHrAZFhHcfbdpsCSaYblSYOGYW8f79Od0a7PUbVNvC2v3IrUPRpKcOwx9IHPNk
         E0UUZSm5XIXPbzWwDDecAEBqbdkt4+gj6LAVtH3QLapj2sCFmGhx3w3yDWyQl3C0WPNo
         dmZgZ3gfPfpYhz1sOY/pTcA1aYhp8ECgZqQE8UbFA4ZfxLvguNSqiMfwW80453nMhWjk
         GWYO9/T/eei9Ip/C8bPeRS+VNtAtzhHplhBYHAlwQMYP1iPVN6yS/pxcx93NEQp6CH0e
         WNOA==
X-Gm-Message-State: AOAM533lpKf6YaPV54IaOYW9IuFXjRa8uItivOFnHBJ3MO3ClBxP0xYJ
        9U+bvnLaTok0aBr9EVdfup8wqqWAKY7M/MhhxPdRgg==
X-Google-Smtp-Source: ABdhPJz85LzhtLMaZSddHqg+2TQE5OR9J6DFRXvoKpu+t+xJ3q0pc39q6dzuM+IoGEvwmmVfkIjPWh9pPH+FKkaect8=
X-Received: by 2002:a05:6122:12a8:: with SMTP id j8mr10434890vkp.43.1594046097298;
 Mon, 06 Jul 2020 07:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200701023346.3873-1-wan.ahmad.zainie.wan.mohamad@intel.com>
In-Reply-To: <20200701023346.3873-1-wan.ahmad.zainie.wan.mohamad@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:34:20 +0200
Message-ID: <CAPDyKFrHGDtXzcMcV=cxWOxiwN75X1czjhxnueUFJTHeRaFNYA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: convert arasan sdhci bindings to yaml
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Manish Narani <manish.narani@xilinx.com>,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 1 Jul 2020 at 04:35, Wan Ahmad Zainie
<wan.ahmad.zainie.wan.mohamad@intel.com> wrote:
>
> Convert arasan,sdhci.txt file to yaml. The new file arasan,sdhci.yaml
> will inherit properties from mmc-controller.yaml. 'sdhci' is no longer
> a valid name for node and should be changed to 'mmc'.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

Rob, I need your expert opinion on this, whenever you have some time of course.

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  | 192 -----------
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 299 ++++++++++++++++++
>  2 files changed, 299 insertions(+), 192 deletions(-)
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
> index 000000000000..5887c917d480
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -0,0 +1,299 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mmc/arasan,sdhci.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Device Tree Bindings for the Arasan SDHCI Controller
> +
> +maintainers:
> +  - Adrian Hunter <adrian.hunter@intel.com>
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: arasan,sdhci-5.1
> +    then:
> +      required:
> +        - phys
> +        - phy-names
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,zynqmp-8.9a
> +              - xlnx,versal-8.9a
> +    then:
> +      properties:
> +        clock-output-names:
> +          items:
> +            - const: clk_out_sd0
> +            - const: clk_in_sd0
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
> +        description:
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - items:
> +          - const: xlnx,zynqmp-8.9a             # ZynqMP SDHCI 8.9a PHY
> +          - const: arasan,sdhci-8.9a
> +        description:
> +          For this device it is strongly suggested to include
> +          clock-output-names and '#clock-cells'.
> +      - items:
> +          - const: xlnx,versal-8.9a             # Versal SDHCI 8.9a PHY
> +          - const: arasan,sdhci-8.9a
> +        description:
> +          For this device it is strongly suggested to include
> +          clock-output-names and '#clock-cells'.
> +      - items:
> +          - const: intel,lgm-sdhci-5.1-emmc     # Intel LGM eMMC PHY
> +          - const: arasan,sdhci-5.1
> +        description:
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - items:
> +          - const: intel,lgm-sdhci-5.1-sdxc     # Intel LGM SDXC PHY
> +          - const: arasan,sdhci-5.1
> +        description:
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - items:
> +          - const: intel,keembay-sdhci-5.1-emmc # Intel Keem Bay eMMC PHY
> +          - const: arasan,sdhci-5.1
> +        description:
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - const: intel,keembay-sdhci-5.1-sd       # Intel Keem Bay SD controller
> +        description:
> +          For this device it is strongly suggested to include
> +          arasan,soc-ctl-syscon.
> +      - const: intel,keembay-sdhci-5.1-sdio     # Intel Keem Bay SDIO controller
> +        description:
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
> +    description:
> +      A phandle to a syscon device (see ../mfd/syscon.txt) used to access
> +      core corecfg registers. Offsets of registers in this syscon are
> +      determined based on the main compatible string for the device.
> +
> +  clock-output-names:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Name of the card clock which will be exposed by this device.
> +
> +  '#clock-cells':
> +    enum: [0, 1]
> +    description:
> +      With this property in place we will export one or two clocks
> +      representing the Card Clock. These clocks are expected to be
> +      consumed by our PHY.
> +
> +  xlnx,fails-without-test-cd:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      When present, the controller doesn't work when the CD line is not
> +      connected properly, and the line is not connected properly.
> +      Test mode can be used to force the controller to function.
> +
> +  xlnx,int-clock-stable-broken:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      When present, the controller always reports that the internal clock
> +      is stable even when it is not.
> +
> +  xlnx,mio-bank:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 2]
> +    default: 0
> +    description:
> +      The MIO bank number in which the command and data lines are configured.
> +
> +dependencies:
> +  clock-output-names: [ '#clock-cells' ]
> +  '#clock-cells': [ clock-output-names ]
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
> +          reg = <0xfe330000 0x10000>;
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
> +          reg = <0xff160000 0x1000>;
> +          clocks = <&clk200>, <&clk200>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clock-output-names = "clk_out_sd0", "clk_in_sd0";
> +          #clock-cells = <1>;
> +          clk-phase-sd-hs = <63>, <72>;
> +    };
> +
> +  - |
> +    mmc@f1040000 {
> +          compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
> +          interrupt-parent = <&gic>;
> +          interrupts = <0 126 4>;
> +          reg = <0xf1040000 0x10000>;
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
> +          reg = <0x33000000 0x300>;
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
> +          reg = <0x31000000 0x300>;
> +          clock-names = "clk_xin", "clk_ahb";
> +          clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
> +                   <&scmi_clk KEEM_BAY_PSS_SD0>;
> +          arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
> +    };
> --
> 2.17.1
>
