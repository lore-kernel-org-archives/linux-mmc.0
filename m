Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458FAC35242
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B8E206F0
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELgej1en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbgAXLZ6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:25:58 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37064 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403890AbgAXLZ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2020 06:25:57 -0500
Received: by mail-vs1-f67.google.com with SMTP id x18so991068vsq.4
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2020 03:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2jETx1K2QROvuqY65KaH9YzpqUlnDhQy9Jrb9ahM4g=;
        b=ELgej1eneLjocmxUcRdNNa2G/bM/1I8WD3QAC7JMAowuwaxD23XyMiM6P2ctm0FjCM
         0Zkx0NZGHUJPrpd5uzytEy7RI7KKVfJQRdVOkoOhZlwxht5LtvCu+mRqSW5ficRC+2uX
         Wtavp5xOUQaXM1LfU2NC/DShfBYWpt/YtZPwev53cop08KRrfwejMRwBrqGrR7eWdln0
         FYISyd7Hg94AGWvojH2V8gZ0H9taOIPnBnQaLCQ/28G+xpPAY8U1oeG/kWi/zBIkniaj
         0vxSaKnsgOYfJLoC0Xw0iTFldsHiXFpbFAfGk7Ru+GZhFm4DM9blzBfFFGl0L2bJoBVd
         Br1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2jETx1K2QROvuqY65KaH9YzpqUlnDhQy9Jrb9ahM4g=;
        b=rZeYQ9HBrfF1/2yy2XLMS/XnT2MVQokkYCivUyZv2zraKNvDB1rW0v7QPbdh8UkD+/
         ahjMI7k9iPTJ80ZLnmXqi2xhRGNfgVqv8L6nHJTbSwVg4lhUu+Tl89RuXCqRwP1tP5q2
         0qnJ3pAiVu0AHMNTgi2axngnselaaMPD5Vhz5uc04QQ7UDMoHZfo6mFQsM6HZvfau4+w
         Yk8Tz9XnmK3o0+g94Fy2fpU+d1xYiLr0sqgKpFX/aUdrUAzdYWnve605WRSOzMfnFY5M
         FnsS6JSe860INT5zL7ehtuFSI2xplozn9+WpradGzX6KpP32sEK3HkLhqFzmy7+nuIwF
         +ytg==
X-Gm-Message-State: APjAAAU6RS84oEjqWngWr4zERxMjyxuXqCSgkV+6HSmbHK0Z7J3L4xuX
        qzl58WviXune368wPwuB3fVMdhWK9p1age08Ec335A==
X-Google-Smtp-Source: APXvYqxM6zYamgN6EVeKj7kVi1fOSzFudc87cWzGYD3HJobgEqJgawyNx4yUZWp27wRfHgwmoNQU5Nvwm+RSd45hGqo=
X-Received: by 2002:a67:de15:: with SMTP id q21mr1800776vsk.165.1579865156235;
 Fri, 24 Jan 2020 03:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20200116152230.29831-1-jbx6244@gmail.com>
In-Reply-To: <20200116152230.29831-1-jbx6244@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 12:25:19 +0100
Message-ID: <CAPDyKFoGCs5ZoYfzPN1D6KZN+bQkuTa+iAWhwkan1noBdfu0CQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: convert synopsys dw-mshc
 bindings to yaml
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Jan 2020 at 16:22, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Current dts files with 'dwmmc' nodes are manually verified.
> In order to automate this process synopsys-dw-mshc.txt
> has to be converted to yaml. In the new setup
> synopsys-dw-mshc.yaml will inherit properties from
> mmc-controller.yaml and synopsys-dw-mshc-common.yaml.
> 'dwmmc' will no longer be a valid name for a node and
> should be changed to 'mmc'.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/synopsys-dw-mshc-common.yaml      |  68 ++++++++++
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 141 ---------------------
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |  70 ++++++++++
>  3 files changed, 138 insertions(+), 141 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> new file mode 100644
> index 000000000..890d47a87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/synopsys-dw-mshc-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys Designware Mobile Storage Host Controller Common Properties
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml#"
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +# Everything else is described in the common file
> +properties:
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: reset
> +
> +  clock-frequency:
> +    description:
> +      Should be the frequency (in Hz) of the ciu clock.  If this
> +      is specified and the ciu clock is specified then we'll try to set the ciu
> +      clock to this at probe time.
> +
> +  fifo-depth:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The maximum size of the tx/rx fifo's. If this property is not
> +      specified, the default value of the fifo size is determined from the
> +      controller registers.
> +
> +  card-detect-delay:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - default: 0
> +    description:
> +      Delay in milli-seconds before detecting card after card
> +      insert event. The default value is 0.
> +
> +  data-addr:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Override fifo address with value provided by DT. The default FIFO reg
> +      offset is assumed as 0x100 (version < 0x240A) and 0x200(version >= 0x240A)
> +      by driver. If the controller does not follow this rule, please use
> +      this property to set fifo address in device tree.
> +
> +  fifo-watermark-aligned:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Data done irq is expected if data length is less than
> +      watermark in PIO mode. But fifo watermark is requested to be aligned
> +      with data length in some SoC so that TX/RX irq can be generated with
> +      data done irq. Add this watermark quirk to mark this requirement and
> +      force fifo watermark setting accordingly.
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx-tx
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> deleted file mode 100644
> index 7e5e427a2..000000000
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ /dev/null
> @@ -1,141 +0,0 @@
> -* Synopsys Designware Mobile Storage Host Controller
> -
> -The Synopsys designware mobile storage host controller is used to interface
> -a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> -differences between the core mmc properties described by mmc.txt and the
> -properties used by the Synopsys Designware Mobile Storage Host Controller.
> -
> -Required Properties:
> -
> -* compatible: should be
> -       - snps,dw-mshc: for controllers compliant with synopsys dw-mshc.
> -* #address-cells: should be 1.
> -* #size-cells: should be 0.
> -
> -# Slots (DEPRECATED): The slot specific information are contained within
> -  child-nodes with each child-node representing a supported slot. There should
> -  be atleast one child node representing a card slot. The name of the child node
> -  representing the slot is recommended to be slot@n where n is the unique number
> -  of the slot connected to the controller. The following are optional properties
> -  which can be included in the slot child node.
> -
> -       * reg: specifies the physical slot number. The valid values of this
> -         property is 0 to (num-slots -1), where num-slots is the value
> -         specified by the num-slots property.
> -
> -       * bus-width: as documented in mmc core bindings.
> -
> -       * wp-gpios: specifies the write protect gpio line. The format of the
> -         gpio specifier depends on the gpio controller. If a GPIO is not used
> -         for write-protect, this property is optional.
> -
> -       * disable-wp: If the wp-gpios property isn't present then (by default)
> -         we'd assume that the write protect is hooked up directly to the
> -         controller's special purpose write protect line (accessible via
> -         the WRTPRT register).  However, it's possible that we simply don't
> -         want write protect.  In that case specify 'disable-wp'.
> -         NOTE: This property is not required for slots known to always
> -         connect to eMMC or SDIO cards.
> -
> -Optional properties:
> -
> -* resets: phandle + reset specifier pair, intended to represent hardware
> -  reset signal present internally in some host controller IC designs.
> -  See Documentation/devicetree/bindings/reset/reset.txt for details.
> -
> -* reset-names: request name for using "resets" property. Must be "reset".
> -       (It will be used together with "resets" property.)
> -
> -* clocks: from common clock binding: handle to biu and ciu clocks for the
> -  bus interface unit clock and the card interface unit clock.
> -
> -* clock-names: from common clock binding: Shall be "biu" and "ciu".
> -  If the biu clock is missing we'll simply skip enabling it.  If the
> -  ciu clock is missing we'll just assume that the clock is running at
> -  clock-frequency.  It is an error to omit both the ciu clock and the
> -  clock-frequency.
> -
> -* clock-frequency: should be the frequency (in Hz) of the ciu clock.  If this
> -  is specified and the ciu clock is specified then we'll try to set the ciu
> -  clock to this at probe time.
> -
> -* fifo-depth: The maximum size of the tx/rx fifo's. If this property is not
> -  specified, the default value of the fifo size is determined from the
> -  controller registers.
> -
> -* card-detect-delay: Delay in milli-seconds before detecting card after card
> -  insert event. The default value is 0.
> -
> -* data-addr: Override fifo address with value provided by DT. The default FIFO reg
> -  offset is assumed as 0x100 (version < 0x240A) and 0x200(version >= 0x240A) by
> -  driver. If the controller does not follow this rule, please use this property
> -  to set fifo address in device tree.
> -
> -* fifo-watermark-aligned: Data done irq is expected if data length is less than
> -  watermark in PIO mode. But fifo watermark is requested to be aligned with data
> -  length in some SoC so that TX/RX irq can be generated with data done irq. Add this
> -  watermark quirk to mark this requirement and force fifo watermark setting
> -  accordingly.
> -
> -* vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
> -  specified we'll defer probe until we can find this regulator.
> -
> -* dmas: List of DMA specifiers with the controller specific format as described
> -  in the generic DMA client binding. Refer to dma.txt for details.
> -
> -* dma-names: request names for generic DMA client binding. Must be "rx-tx".
> -  Refer to dma.txt for details.
> -
> -Aliases:
> -
> -- All the MSHC controller nodes should be represented in the aliases node using
> -  the following format 'mshc{n}' where n is a unique number for the alias.
> -
> -Example:
> -
> -The MSHC controller node can be split into two portions, SoC specific and
> -board specific portions as listed below.
> -
> -       dwmmc0@12200000 {
> -               compatible = "snps,dw-mshc";
> -               clocks = <&clock 351>, <&clock 132>;
> -               clock-names = "biu", "ciu";
> -               reg = <0x12200000 0x1000>;
> -               interrupts = <0 75 0>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               data-addr = <0x200>;
> -               fifo-watermark-aligned;
> -               resets = <&rst 20>;
> -               reset-names = "reset";
> -       };
> -
> -[board specific internal DMA resources]
> -
> -       dwmmc0@12200000 {
> -               clock-frequency = <400000000>;
> -               clock-freq-min-max = <400000 200000000>;
> -               broken-cd;
> -               fifo-depth = <0x80>;
> -               card-detect-delay = <200>;
> -               vmmc-supply = <&buck8>;
> -               bus-width = <8>;
> -               cap-mmc-highspeed;
> -               cap-sd-highspeed;
> -       };
> -
> -[board specific generic DMA request binding]
> -
> -       dwmmc0@12200000 {
> -               clock-frequency = <400000000>;
> -               clock-freq-min-max = <400000 200000000>;
> -               broken-cd;
> -               fifo-depth = <0x80>;
> -               card-detect-delay = <200>;
> -               vmmc-supply = <&buck8>;
> -               bus-width = <8>;
> -               cap-mmc-highspeed;
> -               cap-sd-highspeed;
> -               dmas = <&pdma 12>;
> -               dma-names = "rx-tx";
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> new file mode 100644
> index 000000000..05f9f36dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/synopsys-dw-mshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys Designware Mobile Storage Host Controller Binding
> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +# Everything else is described in the common file
> +properties:
> +  compatible:
> +    const: snps,dw-mshc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +    description:
> +      Handle to "biu" and "ciu" clocks for the
> +      bus interface unit clock and the card interface unit clock.
> +
> +  clock-names:
> +    items:
> +      - const: biu
> +      - const: ciu
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
> +    mmc@12200000 {
> +      compatible = "snps,dw-mshc";
> +      reg = <0x12200000 0x1000>;
> +      interrupts = <0 75 0>;
> +      clocks = <&clock 351>, <&clock 132>;
> +      clock-names = "biu", "ciu";
> +      dmas = <&pdma 12>;
> +      dma-names = "rx-tx";
> +      resets = <&rst 20>;
> +      reset-names = "reset";
> +      vmmc-supply = <&buck8>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      broken-cd;
> +      bus-width = <8>;
> +      cap-mmc-highspeed;
> +      cap-sd-highspeed;
> +      card-detect-delay = <200>;
> +      clock-freq-min-max = <400000 200000000>;
> +      clock-frequency = <400000000>;
> +      data-addr = <0x200>;
> +      fifo-depth = <0x80>;
> +      fifo-watermark-aligned;
> +    };
> --
> 2.11.0
>
