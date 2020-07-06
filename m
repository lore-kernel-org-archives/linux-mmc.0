Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3A3C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2363A20724
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ok4GIZkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgGFOtc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgGFOtc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:49:32 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB867C061794
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:49:31 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id d64so8644574vke.4
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrAHRiw2LCnTsQAYhalue995neGmTKcUjyd6ccjloho=;
        b=ok4GIZkgdD9CbteQoY2hR+fRGvG9a7f97+2rVl+iuRPqZnLlQzcI5uk/qRI7SZGuef
         Dx9CZdkdmX12Sf2bCd1+7Z4gsxctH/xudpH4X0q9IGAK0x0xWiPdt/alT7r3wxRLLoax
         26iGOkWMxNF7Cb/ZI4u0YeZJys1jDhezH+FjGx+JH3yocrqMi4UuUbHGkpyw/c7667pV
         3KG0XSOso877PdVEDAlCqV41CnLyGe/d1nIBHaiVgTSg2PQBVbEXtoc/mFkwJC1V4a/9
         9ZAQYcsutT/tBqqfFJRlizFFCZM9+d9X5KppwjgAjWorDs7ma31QaJ2wmTEta4h+zBiW
         wSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrAHRiw2LCnTsQAYhalue995neGmTKcUjyd6ccjloho=;
        b=Jayrmr8scVE4OpvrV0xLHBXg9sWnKuoSG1d65L0vgK2KuIRR09o51SSoVxYNf6xHOa
         566hdoEE8RqgwawHL5TMkGFUF0+1G3ER1Iq3EKX0EWrCLpJXFrClosbtSzBpfcdBC5qV
         dHF4fJvU9F01WBPtuM0WiGsZ0hcsQDZwjuQjZZfr/yyoQidaCN7vnWCwYHDnsVnxvm2t
         XdybKGWQBbvhWKW731zfv7tIZK1anR5cqDCe6zLRza5PQNYwHSABAQdFHzO7KTrn7WGJ
         PxluHANdQmxhRMo4PRboq0wfWOqhOs4fSLIVVoeCd5WmopUy5jmujrUAOU1yapylVxZf
         PWHg==
X-Gm-Message-State: AOAM532r/JwsdzoK70VJh/ySkBnmvnM4MJd345hgw9OIM3OViLiRpZwd
        Op75sHUx8vK6OYUkRuJB0b4LYWqCMc+TvZ9TqIwhGg==
X-Google-Smtp-Source: ABdhPJwyjiLUirdHYnW3t1dYh+t3XMHDyGzOQhwgqf4aL8QF/aKTgK4/1roqYJkorFhDvCXrSdtvXmlIYtwiW0dbK70=
X-Received: by 2002:a05:6122:12a8:: with SMTP id j8mr10487376vkp.43.1594046970888;
 Mon, 06 Jul 2020 07:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200622164431.3dbc8c5a@xhacker.debian>
In-Reply-To: <20200622164431.3dbc8c5a@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:48:52 +0200
Message-ID: <CAPDyKFpWAu0uH_1-XL8O5Jj2WS6zPhLV2ZvoXBFQT_dpqnD0FQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: Convert pwrseq to json-schema
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Jun 2020 at 10:51, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Convert the pwrseq binding to DT schema format using json-schema.
>
> At the same time, fix a couple of issues with the examples discovered by
> the validation tool -- missing ";"
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> since v1:
>  - conver pwrseq to yaml format rather than fixing old docs
>
>  .../bindings/mmc/mmc-pwrseq-emmc.txt          | 25 --------
>  .../bindings/mmc/mmc-pwrseq-emmc.yaml         | 46 ++++++++++++++
>  .../bindings/mmc/mmc-pwrseq-sd8787.txt        | 16 -----
>  .../bindings/mmc/mmc-pwrseq-sd8787.yaml       | 39 ++++++++++++
>  .../bindings/mmc/mmc-pwrseq-simple.txt        | 31 ----------
>  .../bindings/mmc/mmc-pwrseq-simple.yaml       | 62 +++++++++++++++++++
>  6 files changed, 147 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
> deleted file mode 100644
> index 3d965d57e00b..000000000000
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -* The simple eMMC hardware reset provider
> -
> -The purpose of this driver is to perform standard eMMC hw reset
> -procedure, as described by Jedec 4.4 specification. This procedure is
> -performed just after MMC core enabled power to the given mmc host (to
> -fix possible issues if bootloader has left eMMC card in initialized or
> -unknown state), and before performing complete system reboot (also in
> -case of emergency reboot call). The latter is needed on boards, which
> -doesn't have hardware reset logic connected to emmc card and (limited or
> -broken) ROM bootloaders are unable to read second stage from the emmc
> -card if the card is left in unknown or already initialized state.
> -
> -Required properties:
> -- compatible : contains "mmc-pwrseq-emmc".
> -- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted
> -       and then deasserted to perform eMMC card reset. To perform
> -       reset procedure as described in Jedec 4.4 specification, the
> -       gpio line should be defined as GPIO_ACTIVE_LOW.
> -
> -Example:
> -
> -       sdhci0_pwrseq {
> -               compatible = "mmc-pwrseq-emmc";
> -               reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> -       }
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
> new file mode 100644
> index 000000000000..77f746f57284
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-pwrseq-emmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple eMMC hardware reset provider binding
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description:
> +  The purpose of this driver is to perform standard eMMC hw reset
> +  procedure, as described by Jedec 4.4 specification. This procedure is
> +  performed just after MMC core enabled power to the given mmc host (to
> +  fix possible issues if bootloader has left eMMC card in initialized or
> +  unknown state), and before performing complete system reboot (also in
> +  case of emergency reboot call). The latter is needed on boards, which
> +  doesn't have hardware reset logic connected to emmc card and (limited or
> +  broken) ROM bootloaders are unable to read second stage from the emmc
> +  card if the card is left in unknown or already initialized state.
> +
> +properties:
> +  compatible:
> +    const: mmc-pwrseq-emmc
> +
> +  reset-gpios:
> +    minItems: 1
> +    description:
> +      contains a GPIO specifier. The reset GPIO is asserted
> +      and then deasserted to perform eMMC card reset. To perform
> +      reset procedure as described in Jedec 4.4 specification, the
> +      gpio line should be defined as GPIO_ACTIVE_LOW.
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    sdhci0_pwrseq {
> +      compatible = "mmc-pwrseq-emmc";
> +      reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
> deleted file mode 100644
> index 22e9340e4ba2..000000000000
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -* Marvell SD8787 power sequence provider
> -
> -Required properties:
> -- compatible: must be "mmc-pwrseq-sd8787".
> -- powerdown-gpios: contains a power down GPIO specifier with the
> -                  default active state
> -- reset-gpios: contains a reset GPIO specifier with the default
> -                  active state
> -
> -Example:
> -
> -       wifi_pwrseq: wifi_pwrseq {
> -               compatible = "mmc-pwrseq-sd8787";
> -               powerdown-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
> -               reset-gpios = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
> -       }
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
> new file mode 100644
> index 000000000000..a68820d31d50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-pwrseq-sd8787.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell SD8787 power sequence provider binding
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: mmc-pwrseq-sd8787
> +
> +  powerdown-gpios:
> +    minItems: 1
> +    description:
> +      contains a power down GPIO specifier with the default active state
> +
> +  reset-gpios:
> +    minItems: 1
> +    description:
> +      contains a reset GPIO specifier with the default active state
> +
> +required:
> +  - compatible
> +  - powerdown-gpios
> +  - reset-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    wifi_pwrseq: wifi_pwrseq {
> +      compatible = "mmc-pwrseq-sd8787";
> +      powerdown-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
> +      reset-gpios = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> deleted file mode 100644
> index 9029b45b8a22..000000000000
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -* The simple MMC power sequence provider
> -
> -The purpose of the simple MMC power sequence provider is to supports a set of
> -common properties between various SOC designs. It thus enables us to use the
> -same provider for several SOC designs.
> -
> -Required properties:
> -- compatible : contains "mmc-pwrseq-simple".
> -
> -Optional properties:
> -- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
> -       at initialization and prior we start the power up procedure of the card.
> -       They will be de-asserted right after the power has been provided to the
> -       card.
> -- clocks : Must contain an entry for the entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names : Must include the following entry:
> -  "ext_clock" (External clock provided to the card).
> -- post-power-on-delay-ms : Delay in ms after powering the card and
> -       de-asserting the reset-gpios (if any)
> -- power-off-delay-us : Delay in us after asserting the reset-gpios (if any)
> -       during power off of the card.
> -
> -Example:
> -
> -       sdhci0_pwrseq {
> -               compatible = "mmc-pwrseq-simple";
> -               reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> -               clocks = <&clk_32768_ck>;
> -               clock-names = "ext_clock";
> -       }
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
> new file mode 100644
> index 000000000000..449215444723
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-pwrseq-simple.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple MMC power sequence provider binding
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description:
> +  The purpose of the simple MMC power sequence provider is to supports a set
> +  of common properties between various SOC designs. It thus enables us to use
> +  the same provider for several SOC designs.
> +
> +properties:
> +  compatible:
> +    const: mmc-pwrseq-simple
> +
> +  reset-gpios:
> +    minItems: 1
> +    description:
> +      contains a list of GPIO specifiers. The reset GPIOs are asserted
> +      at initialization and prior we start the power up procedure of the card.
> +      They will be de-asserted right after the power has been provided to the
> +      card.
> +
> +  clocks:
> +    minItems: 1
> +    description: Handle for the entry in clock-names.
> +
> +  clock-names:
> +    items:
> +      - const: ext_clock
> +    description: External clock provided to the card.
> +
> +  post-power-on-delay-ms:
> +    description:
> +      Delay in ms after powering the card and de-asserting the
> +      reset-gpios (if any).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  power-off-delay-us:
> +    description:
> +      Delay in us after asserting the reset-gpios (if any)
> +      during power off of the card.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    sdhci0_pwrseq {
> +      compatible = "mmc-pwrseq-simple";
> +      reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +      clocks = <&clk_32768_ck>;
> +      clock-names = "ext_clock";
> +    };
> +...
> --
> 2.27.0
>
