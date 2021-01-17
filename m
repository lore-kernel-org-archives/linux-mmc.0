Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA76C433E0
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Jan 2021 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3188A2250F
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Jan 2021 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbhAQP5i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 Jan 2021 10:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbhAQP5h (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 17 Jan 2021 10:57:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FCB32250F;
        Sun, 17 Jan 2021 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610899016;
        bh=z4ezSvuG+zMRRv3rtbFmH/EaI9E6X3LilyHWG7ZkIzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uyV2Z7RXPIM6PBhovsUYTarzWtRFBnmCI9g6sFHRPy7p4l25UCmHr21dyD+tzKL+o
         Wj5RVBQRJHTeURrAcG60AGcdVDbppTf/lqvK6zqwnqUDBFj1inZZNzEfDsZ2X9xFbP
         L+4rQKnEREoDieSUT3FerVS3JtAhQsK5+8znCdSry7bmI9S3kDqRspQgH5FtqfjhZV
         e4xBNROKCJLhgUU9Y038YZPkGEM/nb8fqYskVWEKnY+xhJ/RSLr1KeS5OnzDVT3WAp
         3K6Pk9rQ3v+tVsdwMNzA6KGZNm+mxF0GkxNOneBFNBOZf1/htleOa2SrUTpfkoCs8g
         Vi6Y+2UVApgiw==
Received: by mail-ed1-f50.google.com with SMTP id h16so14851368edt.7;
        Sun, 17 Jan 2021 07:56:55 -0800 (PST)
X-Gm-Message-State: AOAM532U6KoksMYlOxkl7rpYumZ1t5Yi95FqV53Dgw8tbG5Ifd7QkZ3k
        y81cOsPPoAQobrUmUJISUoLUIjhG3MFPPi77hA==
X-Google-Smtp-Source: ABdhPJzlbsRfqxEbK7GJlvnTStkW7P4tUhsopAsTnS8thOLIjmC4417wWasUSnVYUQ6iMe4+7310NMduUFazFIwjPKk=
X-Received: by 2002:a50:fc04:: with SMTP id i4mr1927605edr.137.1610899014597;
 Sun, 17 Jan 2021 07:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20210115225313.2616477-1-linus.walleij@linaro.org>
In-Reply-To: <20210115225313.2616477-1-linus.walleij@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 17 Jan 2021 09:56:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+B9-Qfi7s4mfknSXegqKoH+ZjxyEyrjzQM7zb=BpPZA@mail.gmail.com>
Message-ID: <CAL_JsqJ+B9-Qfi7s4mfknSXegqKoH+ZjxyEyrjzQM7zb=BpPZA@mail.gmail.com>
Subject: Re: [PATCH] RFC: mmc: mmci: Convert bindings to DT schema
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jan 15, 2021 at 4:54 PM Linus Walleij <linus.walleij@linaro.org> wr=
ote:
>
> This converts the MMCI bindings from simple text to a proper
> schema.
>
> I can't get this to work when testing the schema and I don't
> know why, possibly my fault. That is why it is RFC.
>
> /var/linus/linux-nomadik/build-ux500/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@5000: 'clock-names', 'clocks' do not match=
 any of the regexes: 'pinctrl-[0-9]+'
>         From schema: /var/linus/linux-nomadik/Documentation/devicetree/bi=
ndings/mmc/arm,pl18x.yaml
> /var/linus/linux-nomadik/build-ux500/Documentation/devicetree/bindings/mm=
c/arm,pl18x.example.dt.yaml: mmc@80126000: 'bus-width', 'cap-mmc-highspeed'=
, 'cap-sd-highspeed', 'cd-gpios', 'clock-names', 'clocks', 'max-frequency',=
 'vmmc-supply', 'vqmmc-supply' do not match any of the regexes: 'pinctrl-[0=
-9]+'
>
> This appear on my machine despite:
>
> allOf:
>   - $ref: /schemas/arm/primecell.yaml#
>   - $ref: /schemas/mmc/mmc-controller.yaml#
>
> No idea why these refs are not reffed. Help.

They are, but additionalProperties cannot 'see' into a $ref. You need
to use 'unevaluatedProperties: false' instead. Note that
'unevaluatedProperties' is not supported by the underlying jsonschema
package, so it doesn't yet have any effect.

The other way to solve this is listing all the properties from the
above schemas that can be used. I don't think that makes sense in this
case.

You should however, have 'clocks' here because otherwise 1-32 clock
entries is valid.

> Cc: devicetree@vger.kernel.org
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/mmc/arm,pl18x.yaml    | 208 ++++++++++++++++++
>  .../devicetree/bindings/mmc/mmci.txt          |  74 -------
>  2 files changed, 208 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Docum=
entation/devicetree/bindings/mmc/arm,pl18x.yaml
> new file mode 100644
> index 000000000000..2e1157560d7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -0,0 +1,208 @@
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
> +  vendors have use the VHDL code from ARM to create derivative MMC/SD/SD=
IO
> +  host controllers with very similar characteristics.
> +
> +allOf:
> +  - $ref: /schemas/arm/primecell.yaml#
> +  - $ref: /schemas/mmc/mmc-controller.yaml#
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
> +          exist but get detected at runtime by reading some magic number=
s
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
> +  dmas:
> +    description: Two or zero DMA channels for RX and TX DMA.

That's what the schema says...

> +    items:
> +      - description: RX DMA channel
> +      - description: TX DMA channel
> +
> +  dma-names:
> +    description: One "tx" channel for transmit and one "rx" channel
> +      for receive.

That's what the schema says. Drop.

> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  power-domains: true
> +
> +  resets:
> +    maxItems: 1
> +
> +  reg:
> +    description: the MMIO memory window must be exactly 4KB (0x1000) and=
 the
> +      layout should provide the PrimeCell ID registers so that the devic=
e can
> +      be discovered. On ST Micro variants, a second register window may =
be
> +      defined if a delay block is present and used for tuning.
> +
> +  interrupts:
> +    description: The first interrupt is the command interrupt and corres=
ponds
> +      to the event at the end of a command. The second interrupt is the
> +      PIO (polled I/O) interrupt and occurs when the FIFO needs to be
> +      emptied as part of a bulk read from the card. Some variants have t=
hese
> +      two interrupts wired into the same line (logic OR) and in that cas=
e
> +      only one interrupt may be provided.

How many interrupts?

> +
> +  st,sig-dir-dat0:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, bus signal direction pins u=
sed for
> +      DAT[0].
> +
> +  st,sig-dir-dat2:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, bus signal direction pins u=
sed for
> +      DAT[2].
> +
> +  st,sig-dir-dat31:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, bus signal direction pins u=
sed for
> +      DAT[3] and DAT[1].
> +
> +  st,sig-dir-dat74:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, bus signal direction pins u=
sed for
> +      DAT[7] and DAT[4].
> +
> +  st,sig-dir-cmd:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, CMD signal direction used f=
or
> +      pin CMD.
> +
> +  st,sig-pin-fbclk:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, feedback clock FBCLK signal=
 pin
> +      in use.
> +
> +  st,sig-dir:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, signal direction polarity u=
sed for
> +      pins CMD, DAT[0], DAT[1], DAT[2] and DAT[3].
> +
> +  st,neg-edge:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, data and command phase rela=
tion,
> +      generated on the sd clock falling edge.
> +
> +  st,use-ckin:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, use CKIN pin from an extern=
al
> +      driver to sample the receive data (for example with a voltage swit=
ch
> +      transceiver).
> +
> +additionalProperties: false
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
> +      compatible =3D "arm,pl180", "arm,primecell";
> +      reg =3D <0x5000 0x1000>;
> +      interrupts-extended =3D <&vic 22 &sic 1>;
> +      clocks =3D <&xtal24mhz>, <&pclk>;
> +      clock-names =3D "mclk", "apb_pclk";
> +    };
> +
> +    mmc@80126000 {
> +      compatible =3D "arm,pl18x", "arm,primecell";
> +      reg =3D <0x80126000 0x1000>;
> +      interrupts =3D <0 60 IRQ_TYPE_LEVEL_HIGH>;
> +      dmas =3D <&dma 29 0 0x2>, <&dma 29 0 0x0>;
> +      dma-names =3D "rx", "tx";
> +      clocks =3D <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
> +      clock-names =3D "sdi", "apb_pclk";
> +      max-frequency =3D <100000000>;
> +      bus-width =3D <4>;
> +      cap-sd-highspeed;
> +      cap-mmc-highspeed;
> +      cd-gpios  =3D <&gpio2 31 0x4>;
> +      st,sig-dir-dat0;
> +      st,sig-dir-dat2;
> +      st,sig-dir-cmd;
> +      st,sig-pin-fbclk;
> +      vmmc-supply =3D <&ab8500_ldo_aux3_reg>;
> +      vqmmc-supply =3D <&vmmci>;
> +    };
> +
> +    mmc@101f6000 {
> +      compatible =3D "arm,pl18x", "arm,primecell";
> +      reg =3D <0x101f6000 0x1000>;
> +      clocks =3D <&sdiclk>, <&pclksdi>;
> +      clock-names =3D "mclk", "apb_pclk";
> +      interrupt-parent =3D <&vica>;
> +      interrupts =3D <22>;
> +      max-frequency =3D <400000>;
> +      bus-width =3D <4>;
> +      cap-mmc-highspeed;
> +      cap-sd-highspeed;
> +      full-pwr-cycle;
> +      st,sig-dir-dat0;
> +      st,sig-dir-dat2;
> +      st,sig-dir-dat31;
> +      st,sig-dir-cmd;
> +      st,sig-pin-fbclk;
> +      vmmc-supply =3D <&vmmc_regulator>;
> +    };
> +
> +    mmc@52007000 {
> +      compatible =3D "arm,pl18x", "arm,primecell";
> +      arm,primecell-periphid =3D <0x10153180>;
> +      reg =3D <0x52007000 0x1000>;
> +      interrupts =3D <49>;
> +      interrupt-names =3D "cmd_irq";
> +      clocks =3D <&rcc 0>;
> +      clock-names =3D "apb_pclk";
> +      resets =3D <&rcc 1>;
> +      cap-sd-highspeed;
> +      cap-mmc-highspeed;
> +      max-frequency =3D <120000000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentati=
on/devicetree/bindings/mmc/mmci.txt
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
> -- vmmc-supply            : phandle to the regulator device tree node, me=
ntioned
> -                           as the VCC/VDD supply in the eMMC/SD specs.
> -
> -Optional properties:
> -- arm,primecell-periphid : contains the PrimeCell Peripheral ID, it over=
rides
> -                           the ID provided by the HW
> -- resets                 : phandle to internal reset line.
> -                          Should be defined for sdmmc variant.
> -- vqmmc-supply           : phandle to the regulator device tree node, me=
ntioned
> -                           as the VCCQ/VDD_IO supply in the eMMC/SD spec=
s.
> -specific for ux500 variant:
> -- st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
> -- st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
> -- st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and =
DAT[1].
> -- st,sig-dir-dat74       : bus signal direction pin used for DAT[4] to D=
AT[7].
> -- st,sig-dir-cmd         : cmd signal direction pin used for CMD.
> -- st,sig-pin-fbclk       : feedback clock signal pin used.
> -
> -specific for sdmmc variant:
> -- reg                   : a second base register may be defined if a del=
ay
> -                           block is present and used for tuning.
> -- st,sig-dir             : signal direction polarity used for cmd, dat0 =
dat123.
> -- st,neg-edge            : data & command phase relation, generated on
> -                           sd clock falling edge.
> -- st,use-ckin            : use ckin pin from an external driver to sampl=
e
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
> -       compatible =3D "arm,pl18x", "arm,primecell";
> -       reg =3D <0x80126000 0x1000>;
> -       interrupts =3D <0 60 IRQ_TYPE_LEVEL_HIGH>;
> -
> -       dmas =3D <&dma 29 0 0x2>, /* Logical - DevToMem */
> -              <&dma 29 0 0x0>; /* Logical - MemToDev */
> -       dma-names =3D "rx", "tx";
> -
> -       clocks =3D <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
> -       clock-names =3D "sdi", "apb_pclk";
> -
> -       max-frequency =3D <100000000>;
> -       bus-width =3D <4>;
> -       cap-sd-highspeed;
> -       cap-mmc-highspeed;
> -       cd-gpios  =3D <&gpio2 31 0x4>; // 95
> -       st,sig-dir-dat0;
> -       st,sig-dir-dat2;
> -       st,sig-dir-cmd;
> -       st,sig-pin-fbclk;
> -
> -       vmmc-supply =3D <&ab8500_ldo_aux3_reg>;
> -       vqmmc-supply =3D <&vmmci>;
> -
> -       pinctrl-names =3D "default", "sleep";
> -       pinctrl-0 =3D <&sdi0_default_mode>;
> -       pinctrl-1 =3D <&sdi0_sleep_mode>;
> -};
> --
> 2.29.2
>
