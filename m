Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28061C33CB3
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E531C24685
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579101006;
	bh=On973BrhoR475dnZRG2cRmV2OCexuQ6TyfNxjO5OTMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k9lJD9FIOjtcbj34tNsVyznSqAsKOGbuuyuuOWpWaXXAsKSA1yRQyY6QNX8Cpbs5B
	 Ayr2zdruvSW7u8zBXbhlkcc4t2BuOVUhSc3MU/H+kZTQr9ZZemZMt4XyVJNbzM6cU+
	 2ZFQgshF1fa3bgeXpGn2P4OOTqODWM9tu0j/V26Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAOPKF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgAOPKE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 10:10:04 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C6BF2467C;
        Wed, 15 Jan 2020 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579101003;
        bh=On973BrhoR475dnZRG2cRmV2OCexuQ6TyfNxjO5OTMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i7TASilUBsLzntR4gZSZHePscwjsdF68olcDcQcdM8scE6YROBtjYmsEljI9tHe2M
         iUOxZ/sCOIOCRgIwsB1WZ5dUPqbufeznera6GS1zXw+i32gBJaJMutR8k3EB7SFvRw
         S3x/HUye5vt7l+QY3t8fn2jHtVbATxmHG+Qn96x4=
Received: by mail-qk1-f171.google.com with SMTP id c17so15906273qkg.7;
        Wed, 15 Jan 2020 07:10:03 -0800 (PST)
X-Gm-Message-State: APjAAAWMLwlhCQaWk7ESs5HlVGf2YynP0EhTNVHPj+05ZiEidYSWhYoE
        qvf9Aqofln+XHBrvfcooZpljXhYgLQQrHessrQ==
X-Google-Smtp-Source: APXvYqztAMAd0OsajU/QPMm8GA80nrSr6KedsAz2pVVqZrrY6JN6tyfc5i2NXErAO/T/CmJxzbPlK1MdeXVIH7n8XoA=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr27937250qkg.152.1579101002403;
 Wed, 15 Jan 2020 07:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20200114213809.27166-1-jbx6244@gmail.com> <20200114213809.27166-3-jbx6244@gmail.com>
In-Reply-To: <20200114213809.27166-3-jbx6244@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Jan 2020 09:09:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhJNcrR-RjbS8eAzot5FdE=C23b272QcOj5-12EobE0w@mail.gmail.com>
Message-ID: <CAL_JsqKhJNcrR-RjbS8eAzot5FdE=C23b272QcOj5-12EobE0w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] dt-bindings: mmc: convert rockchip dw-mshc
 bindings to yaml
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 14, 2020 at 3:38 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Convert the Rockchip designware mobile storage host controller
> device tree bindings to yaml.
> Add maintainer.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  49 --------
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  | 137 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 138 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> deleted file mode 100644
> index 6f629b12b..000000000
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -* Rockchip specific extensions to the Synopsys Designware Mobile
> -  Storage Host Controller
> -
> -The Synopsys designware mobile storage host controller is used to interface
> -a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> -differences between the core Synopsys dw mshc controller properties described
> -by synopsys-dw-mshc.txt and the properties used by the Rockchip specific
> -extensions to the Synopsys Designware Mobile Storage Host Controller.
> -
> -Required Properties:
> -
> -* compatible: should be
> -       - "rockchip,rk2928-dw-mshc": for Rockchip RK2928 and following,
> -                                                       before RK3288
> -       - "rockchip,rk3288-dw-mshc": for Rockchip RK3288
> -       - "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
> -       - "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip PX30
> -       - "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
> -       - "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322x
> -       - "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
> -       - "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
> -       - "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
> -
> -Optional Properties:
> -* clocks: from common clock binding: if ciu-drive and ciu-sample are
> -  specified in clock-names, should contain handles to these clocks.
> -
> -* clock-names: Apart from the clock-names described in synopsys-dw-mshc.txt
> -  two more clocks "ciu-drive" and "ciu-sample" are supported. They are used
> -  to control the clock phases, "ciu-sample" is required for tuning high-
> -  speed modes.
> -
> -* rockchip,default-sample-phase: The default phase to set ciu-sample at
> -  probing, low speeds or in case where all phases work at tuning time.
> -  If not specified 0 deg will be used.
> -
> -* rockchip,desired-num-phases: The desired number of times that the host
> -  execute tuning when needed. If not specified, the host will do tuning
> -  for 360 times, namely tuning for each degree.
> -
> -Example:
> -
> -       rkdwmmc0@12200000 {
> -               compatible = "rockchip,rk3288-dw-mshc";
> -               reg = <0x12200000 0x1000>;
> -               interrupts = <0 75 0>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> new file mode 100644
> index 000000000..da16916b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/rockchip-dw-mshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip designware mobile storage host controller device tree bindings
> +
> +description:
> +  Rockchip uses the Synopsys designware mobile storage host controller
> +  to interface a SoC with storage medium such as eMMC or SD/MMC cards.
> +  This file documents the combined properties for

Strange place for a line break...

> +  the core Synopsys dw mshc controller that are not already included
> +  in the synopsys-dw-mshc-common.yaml file and the Rockchip specific
> +  extensions.
> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml"
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # for Rockchip PX30
> +      - items:
> +          - const: rockchip,px30-dw-mshc
> +          - const: rockchip,rk3288-dw-mshc
> +      # for Rockchip RK2928 and before RK3288
> +      - const: rockchip,rk2928-dw-mshc
> +      # for Rockchip RK3036
> +      - items:
> +          - const: rockchip,rk3036-dw-mshc
> +          - const: rockchip,rk3288-dw-mshc
> +      # for Rockchip RK322x
> +      - items:
> +          - const: rockchip,rk3228-dw-mshc
> +          - const: rockchip,rk3288-dw-mshc
> +      # for Rockchip RK3288
> +      - const: rockchip,rk3288-dw-mshc
> +      # for Rockchip RK3328
> +      - items:
> +          - const: rockchip,rk3328-dw-mshc
> +          - const: rockchip,rk3288-dw-mshc
> +      # for Rockchip RK3368
> +      - items:
> +          - const: rockchip,rk3368-dw-mshc
> +          - const: rockchip,rk3288-dw-mshc
> +      # for Rockchip RK3399
> +      - items:
> +          - const: rockchip,rk3399-dw-mshc
> +          - const: rockchip,rk3288-dw-mshc
> +      # for Rockchip RV1108
> +      - items:
> +          - const: rockchip,rv1108-dw-mshc
> +          - const: rockchip,rk3288-dw-mshc

All the ones with fallback rockchip,rk3288-dw-mshc can be grouped as
one items list with 'enum' for the first item.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 4
> +    description:
> +      Handle to "biu" and "ciu" clocks for the bus interface unit clock and
> +      the card interface unit clock. If "ciu-drive" and "ciu-sample" are
> +      specified in clock-names, it should also contain
> +      handles to these clocks.
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +        - const: biu
> +        - const: ciu
> +      - items:
> +        - const: biu
> +        - const: ciu
> +        - const: ciu-drive
> +        - const: ciu-sample

Add 'minItems: 2' and you only need 1 list.

> +    description:
> +      Apart from the clock-names "biu" and "ciu" two more clocks
> +      "ciu-drive" and "ciu-sample" are supported. They are used
> +      to control the clock phases, "ciu-sample" is required for tuning
> +      high speed modes.
> +
> +  rockchip,default-sample-phase:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 360
> +      - default: 0

Move these 3 to the same level as 'allOf' (dropping '-').

> +    description:
> +      The default phase to set "ciu-sample" at probing,
> +      low speeds or in case where all phases work at tuning time.
> +      If not specified 0 deg will be used.
> +
> +  rockchip,desired-num-phases:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 360
> +      - default: 360
> +    description:
> +      The desired number of times that the host execute tuning when needed.
> +      If not specified, the host will do tuning for 360 times,
> +      namely tuning for each degree.
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
> +    #include <dt-bindings/clock/rk3288-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    sdmmc: dwmmc@ff0c0000 {
> +      compatible = "rockchip,rk3288-dw-mshc";
> +      reg = <0x0 0xff0c0000 0x0 0x4000>;
> +      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
> +               <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
> +      clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +      resets = <&cru SRST_MMC0>;
> +      reset-names = "reset";
> +      fifo-depth = <0x100>;
> +      max-frequency = <150000000>;

Not documented.

> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6ad01d71..1b16c0fdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2240,6 +2240,7 @@ L:        linux-rockchip@lists.infradead.org
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +F:     Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>  F:     arch/arm/boot/dts/rk3*
>  F:     arch/arm/boot/dts/rv1108*
>  F:     arch/arm/mach-rockchip/
> --
> 2.11.0
>
