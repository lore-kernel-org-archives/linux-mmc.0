Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBF7C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 15:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586FF2339E
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 15:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbhATOvy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390187AbhATOLo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 09:11:44 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36CEC061793
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:35 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a16so1581773uad.9
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzSnUO1IBl2rCi/hM/gu3eKVLQrhYdesLwIEYip4Q2I=;
        b=DG13tf28yD94kYNz9VoREhx9rMSRnoe/xBmBI7gKMWmeZhRWUZqp7TBNxRUPEetUYt
         y3RcRtDQB17rOL5DuTEfjFgiwblGTOJI8qbRWIE4G2aTbMGQH+MNtfKCSbS9k5Cqg8Ex
         nNQVjjOfpO4H2siO3+7/+U+b26K0o3xbXeSr85r3Ay7LDY4P287G7MnkClC/Si5WSXzh
         PG7/NOhvVPiJRyPCw3h3Qb5/7ngq4JcCqrFRpnCL8ZI0Su0ycBJpX87ZkRqirLFX1MZI
         q0MAglAcNRFte4HmrTYQ2KcNll/oEyvgT7oc1n74URBk0YDhXuFsYZLrDGrHziT3FRLy
         R86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzSnUO1IBl2rCi/hM/gu3eKVLQrhYdesLwIEYip4Q2I=;
        b=e5ckg8c0HdcdN91QYu1eAfK87pUVtozxwdQ4KQsH21maSbso5BquUdqm7Wcm+YNL9W
         VsgkfWVjl14q4sELIHMBWl67hk0uLcH+964CpIcjyRi94bMU8C2v5nhGJWNOFi17IlkC
         1+95Sh0gME3E9AtjjbrU1OlE9rYqdZPKULgI2rHEWyYJMDhQoXVeBQuAJUqrTBpN32xg
         XJ/UNdzyUKnAQ/CiNWhpBiFySfDLIqi8O7GLKm/uMrjlvWGvPQtx88kq7JhMxOXEx+mz
         5rX3wwWj1xxNRRs1s2HDc2ebIVVTriTgIwQakPJHGl43A+WSkRzS1gtxhAg8U8Y4NFu2
         FBNg==
X-Gm-Message-State: AOAM5300IAGFiwAxsfujyHMFlvwhFNfqWrOf8FuC3jAeEHEGKJU9dgSW
        Z0GZMlvtXbxcywYR6zx9rK3KCupX/oBXCgLRpk+xig==
X-Google-Smtp-Source: ABdhPJxNL2Cl3QqNd4tRQPOBhB2bUNVqth/eTCTLFskttjrvOfM+XiT1lIYJaN1GWqxrRSrpFqOC0Lbf09XVC8GKtSo=
X-Received: by 2002:ab0:1c10:: with SMTP id a16mr6509705uaj.100.1611151714625;
 Wed, 20 Jan 2021 06:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20210119100655.2755164-1-linus.walleij@linaro.org>
In-Reply-To: <20210119100655.2755164-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 15:07:56 +0100
Message-ID: <CAPDyKFr-9B27bAdLH9hQnUxzc3XRPVZZ9ZAneC9qPKa8NhaH-Q@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mmci: Convert bindings to DT schema
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Jan 2021 at 11:06, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This converts the MMCI bindings from simple text to a proper
> schema.
>
> Cc: devicetree@vger.kernel.org
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> ChangeLog v2->v3:
> - Drop "dmas" and "dma-names" that are already part of the
>   generic schema. Sorry for missing this in v2.
> ChangeLog v1->v2:
> - Use unevaluatedProperties: false instead of
>   additionalProperties: false and refs start working.
> - Define clocks to 1 or 2 items.
> - Define interrupts to 1 or 2 items.
> ---
>  .../devicetree/bindings/mmc/arm,pl18x.yaml    | 203 ++++++++++++++++++
>  .../devicetree/bindings/mmc/mmci.txt          |  74 -------
>  2 files changed, 203 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> new file mode 100644
> index 000000000000..eddc1f6bdbe5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -0,0 +1,203 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/arm,pl18x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM PrimeCell MultiMedia Card Interface (MMCI) PL180 and PL181
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description:
> +  The ARM PrimeCells MMCI PL180 and PL181 provides an interface for
> +  reading and writing to MultiMedia and SD cards alike. Over the years
> +  vendors have use the VHDL code from ARM to create derivative MMC/SD/SDIO
> +  host controllers with very similar characteristics.
> +
> +allOf:
> +  - $ref: /schemas/arm/primecell.yaml#
> +  - $ref: mmc-controller.yaml#
> +
> +# We need a select here so we don't match all nodes with 'arm,primecell'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - arm,pl180
> +          - arm,pl181
> +          - arm,pl18x
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: The first version of the block, simply called
> +          PL180 and found in the ARM Integrator IM/PD1 logic module.
> +        items:
> +          - const: arm,pl180
> +          - const: arm,primecell
> +      - description: The improved version of the block, found in the
> +          ARM Versatile and later reference designs. Further revisions
> +          exist but get detected at runtime by reading some magic numbers
> +          in the PrimeCell ID registers.
> +        items:
> +          - const: arm,pl181
> +          - const: arm,primecell
> +      - description: Wildcard entry that will let the operating system
> +          inspect the PrimeCell ID registers to determine which hardware
> +          variant of PL180 or PL181 this is.
> +        items:
> +          - const: arm,pl18x
> +          - const: arm,primecell
> +
> +  clocks:
> +    description: One or two clocks, the "apb_pclk" and the "MCLK"
> +      which is the core block clock. The names are not compulsory.
> +    minItems: 1
> +    maxItems: 2
> +
> +  power-domains: true
> +
> +  resets:
> +    maxItems: 1
> +
> +  reg:
> +    description: the MMIO memory window must be exactly 4KB (0x1000) and the
> +      layout should provide the PrimeCell ID registers so that the device can
> +      be discovered. On ST Micro variants, a second register window may be
> +      defined if a delay block is present and used for tuning.
> +
> +  interrupts:
> +    description: The first interrupt is the command interrupt and corresponds
> +      to the event at the end of a command. The second interrupt is the
> +      PIO (polled I/O) interrupt and occurs when the FIFO needs to be
> +      emptied as part of a bulk read from the card. Some variants have these
> +      two interrupts wired into the same line (logic OR) and in that case
> +      only one interrupt may be provided.
> +    minItems: 1
> +    maxItems: 2
> +
> +  st,sig-dir-dat0:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, bus signal direction pins used for
> +      DAT[0].
> +
> +  st,sig-dir-dat2:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, bus signal direction pins used for
> +      DAT[2].
> +
> +  st,sig-dir-dat31:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, bus signal direction pins used for
> +      DAT[3] and DAT[1].
> +
> +  st,sig-dir-dat74:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, bus signal direction pins used for
> +      DAT[7] and DAT[4].
> +
> +  st,sig-dir-cmd:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, CMD signal direction used for
> +      pin CMD.
> +
> +  st,sig-pin-fbclk:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, feedback clock FBCLK signal pin
> +      in use.
> +
> +  st,sig-dir:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, signal direction polarity used for
> +      pins CMD, DAT[0], DAT[1], DAT[2] and DAT[3].
> +
> +  st,neg-edge:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, data and command phase relation,
> +      generated on the sd clock falling edge.
> +
> +  st,use-ckin:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, use CKIN pin from an external
> +      driver to sample the receive data (for example with a voltage switch
> +      transceiver).
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mmc@5000 {
> +      compatible = "arm,pl180", "arm,primecell";
> +      reg = <0x5000 0x1000>;
> +      interrupts-extended = <&vic 22 &sic 1>;
> +      clocks = <&xtal24mhz>, <&pclk>;
> +      clock-names = "mclk", "apb_pclk";
> +    };
> +
> +    mmc@80126000 {
> +      compatible = "arm,pl18x", "arm,primecell";
> +      reg = <0x80126000 0x1000>;
> +      interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
> +      dmas = <&dma 29 0 0x2>, <&dma 29 0 0x0>;
> +      dma-names = "rx", "tx";
> +      clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
> +      clock-names = "sdi", "apb_pclk";
> +      max-frequency = <100000000>;
> +      bus-width = <4>;
> +      cap-sd-highspeed;
> +      cap-mmc-highspeed;
> +      cd-gpios  = <&gpio2 31 0x4>;
> +      st,sig-dir-dat0;
> +      st,sig-dir-dat2;
> +      st,sig-dir-cmd;
> +      st,sig-pin-fbclk;
> +      vmmc-supply = <&ab8500_ldo_aux3_reg>;
> +      vqmmc-supply = <&vmmci>;
> +    };
> +
> +    mmc@101f6000 {
> +      compatible = "arm,pl18x", "arm,primecell";
> +      reg = <0x101f6000 0x1000>;
> +      clocks = <&sdiclk>, <&pclksdi>;
> +      clock-names = "mclk", "apb_pclk";
> +      interrupt-parent = <&vica>;
> +      interrupts = <22>;
> +      max-frequency = <400000>;
> +      bus-width = <4>;
> +      cap-mmc-highspeed;
> +      cap-sd-highspeed;
> +      full-pwr-cycle;
> +      st,sig-dir-dat0;
> +      st,sig-dir-dat2;
> +      st,sig-dir-dat31;
> +      st,sig-dir-cmd;
> +      st,sig-pin-fbclk;
> +      vmmc-supply = <&vmmc_regulator>;
> +    };
> +
> +    mmc@52007000 {
> +      compatible = "arm,pl18x", "arm,primecell";
> +      arm,primecell-periphid = <0x10153180>;
> +      reg = <0x52007000 0x1000>;
> +      interrupts = <49>;
> +      interrupt-names = "cmd_irq";
> +      clocks = <&rcc 0>;
> +      clock-names = "apb_pclk";
> +      resets = <&rcc 1>;
> +      cap-sd-highspeed;
> +      cap-mmc-highspeed;
> +      max-frequency = <120000000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> deleted file mode 100644
> index 4ec921e4bf34..000000000000
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -* ARM PrimeCell MultiMedia Card Interface (MMCI) PL180/1
> -
> -The ARM PrimeCell MMCI PL180 and PL181 provides an interface for
> -reading and writing to MultiMedia and SD cards alike.
> -
> -This file documents differences between the core properties described
> -by mmc.txt and the properties used by the mmci driver. Using "st" as
> -the prefix for a property, indicates support by the ST Micro variant.
> -
> -Required properties:
> -- compatible             : contains "arm,pl18x", "arm,primecell".
> -- vmmc-supply            : phandle to the regulator device tree node, mentioned
> -                           as the VCC/VDD supply in the eMMC/SD specs.
> -
> -Optional properties:
> -- arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
> -                           the ID provided by the HW
> -- resets                 : phandle to internal reset line.
> -                          Should be defined for sdmmc variant.
> -- vqmmc-supply           : phandle to the regulator device tree node, mentioned
> -                           as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> -specific for ux500 variant:
> -- st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
> -- st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
> -- st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
> -- st,sig-dir-dat74       : bus signal direction pin used for DAT[4] to DAT[7].
> -- st,sig-dir-cmd         : cmd signal direction pin used for CMD.
> -- st,sig-pin-fbclk       : feedback clock signal pin used.
> -
> -specific for sdmmc variant:
> -- reg                   : a second base register may be defined if a delay
> -                           block is present and used for tuning.
> -- st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
> -- st,neg-edge            : data & command phase relation, generated on
> -                           sd clock falling edge.
> -- st,use-ckin            : use ckin pin from an external driver to sample
> -                           the receive data (example: with voltage
> -                          switch transceiver).
> -
> -Deprecated properties:
> -- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
> -- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
> -
> -Example:
> -
> -sdi0_per1@80126000 {
> -       compatible = "arm,pl18x", "arm,primecell";
> -       reg = <0x80126000 0x1000>;
> -       interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
> -
> -       dmas = <&dma 29 0 0x2>, /* Logical - DevToMem */
> -              <&dma 29 0 0x0>; /* Logical - MemToDev */
> -       dma-names = "rx", "tx";
> -
> -       clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
> -       clock-names = "sdi", "apb_pclk";
> -
> -       max-frequency = <100000000>;
> -       bus-width = <4>;
> -       cap-sd-highspeed;
> -       cap-mmc-highspeed;
> -       cd-gpios  = <&gpio2 31 0x4>; // 95
> -       st,sig-dir-dat0;
> -       st,sig-dir-dat2;
> -       st,sig-dir-cmd;
> -       st,sig-pin-fbclk;
> -
> -       vmmc-supply = <&ab8500_ldo_aux3_reg>;
> -       vqmmc-supply = <&vmmci>;
> -
> -       pinctrl-names = "default", "sleep";
> -       pinctrl-0 = <&sdi0_default_mode>;
> -       pinctrl-1 = <&sdi0_sleep_mode>;
> -};
> --
> 2.29.2
>
