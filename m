Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA6C2D0DB
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2519C206D4
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6o5NV0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403777AbgAXL0F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:26:05 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39234 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391312AbgAXL0E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2020 06:26:04 -0500
Received: by mail-vk1-f195.google.com with SMTP id t129so428937vkg.6
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2020 03:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yA+q0/tdz9pHwwQsFpujNL3r5hUZDki5Wt7XV+ptBKg=;
        b=b6o5NV0ph6Q5glGwWKgOfj96/rl7OpNF7ROax+CxomyD2+2mjB8eOKk92zzzlJ6YeN
         m6WZ1HBJjJtrPgxLvTAK0EHIQHE4gg/fAH3C6jVOCwyK2lHpsGzvwjrNw/RIzmOCxh2v
         +xqEFOtn3154mXloQvuBC/YS6t8zWwfAGDcQRSVi398wv0mvGB9vdEaRPldzpUeAmbjB
         9nLVp0UFICNnuTz/4JGrZUC85F58N9OYvxNwC0jY1gf71+W+JyTlwEfm+cpItbglH0IC
         SbAVfwF5wlW5zfQM7k47puAe/fp9WqLf65EgRQuecEzLJHYQhQrj6qiORWAu5cM+mo3W
         viyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yA+q0/tdz9pHwwQsFpujNL3r5hUZDki5Wt7XV+ptBKg=;
        b=FY2V3vaglyjlI9VNGDGJu7FatnUxDvHjHJNn4PJp9hhGmuGHqSmzHeNfeniiAS8plU
         YOy4s5DNDVGbxCD4g2l3D9tERJkzZg+oXutt4ZA2vGc1pw9ssA63IZnG0BQe1MiVOIgi
         bTmItjrCLSO1nkIJ3lUyavIJJ7PfJIRQa+0pWR2uVhS0EMDUwaeUKWHrRQqzu9mKHrFj
         DH/+m37kkRIPMf8EMhoUXaYC08C/Y2rKIpEmxXDVuXQr4NCa6/l+LkoeCCKOma7Lv3Tb
         wxYKMyI3AnYewxajU5xRT+1ZTWHqCGwINYQJr+wvtu3lEQpsH8LmCK5jSDFzXazBrK8l
         qV/w==
X-Gm-Message-State: APjAAAUHq4+ZBzJV3sCTxXnJemNx2Ls3Nq24zapDWYSzNn9pubr6JE3p
        fpT9yVrwccl4/YImr6k21+qKeQMnY06ujv+xrmg8BA==
X-Google-Smtp-Source: APXvYqyJdUDT6GFcqq2yfAaUP/QP9wvF8DIKUg6lcbvTtc2pgywF0VGwYxowttRK1UdAtwMIFixCI2grpuBptG0UGQQ=
X-Received: by 2002:a1f:94c1:: with SMTP id w184mr1709760vkd.43.1579865162655;
 Fri, 24 Jan 2020 03:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20200116152230.29831-1-jbx6244@gmail.com> <20200116152230.29831-2-jbx6244@gmail.com>
In-Reply-To: <20200116152230.29831-2-jbx6244@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 12:25:26 +0100
Message-ID: <CAPDyKFrgGTDK_4bv3ofs2ky6d5optfTh2H-99uBMjZzNpcOhUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: convert rockchip dw-mshc
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
> In order to automate this process rockchip-dw-mshc.txt
> has to be converted to yaml. In the new setup
> rockchip-dw-mshc.yaml will inherit properties from
> mmc-controller.yaml and synopsys-dw-mshc-common.yaml.
> 'dwmmc' will no longer be a valid name for a node and
> should be changed to 'mmc'.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  49 --------
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  | 123 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 124 insertions(+), 49 deletions(-)
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
> index 000000000..2f70f5ef0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -0,0 +1,123 @@
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
> +  This file documents the combined properties for the core Synopsys dw mshc
> +  controller that are not already included in the synopsys-dw-mshc-common.yaml
> +  file and the Rockchip specific extensions.
> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +# Everything else is described in the common file
> +properties:
> +  compatible:
> +    oneOf:
> +      # for Rockchip RK2928 and before RK3288
> +      - const: rockchip,rk2928-dw-mshc
> +      # for Rockchip RK3288
> +      - const: rockchip,rk3288-dw-mshc
> +      - items:
> +          - enum:
> +            # for Rockchip PX30
> +            - rockchip,px30-dw-mshc
> +            # for Rockchip RK3036
> +            - rockchip,rk3036-dw-mshc
> +            # for Rockchip RK322x
> +            - rockchip,rk3228-dw-mshc
> +            # for Rockchip RK3328
> +            - rockchip,rk3328-dw-mshc
> +            # for Rockchip RK3368
> +            - rockchip,rk3368-dw-mshc
> +            # for Rockchip RK3399
> +            - rockchip,rk3399-dw-mshc
> +            # for Rockchip RV1108
> +            - rockchip,rv1108-dw-mshc
> +          - const: rockchip,rk3288-dw-mshc
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
> +    minItems: 2
> +    items:
> +      - const: biu
> +      - const: ciu
> +      - const: ciu-drive
> +      - const: ciu-sample
> +    description:
> +      Apart from the clock-names "biu" and "ciu" two more clocks
> +      "ciu-drive" and "ciu-sample" are supported. They are used
> +      to control the clock phases, "ciu-sample" is required for tuning
> +      high speed modes.
> +
> +  rockchip,default-sample-phase:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 360
> +    default: 0
> +    description:
> +      The default phase to set "ciu-sample" at probing,
> +      low speeds or in case where all phases work at tuning time.
> +      If not specified 0 deg will be used.
> +
> +  rockchip,desired-num-phases:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 360
> +    default: 360
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
> +    sdmmc: mmc@ff0c0000 {
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
