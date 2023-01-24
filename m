Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A2C38142
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Jan 2023 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjAXM6C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 07:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjAXM5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 07:57:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2583A9D
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 04:57:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k13so14688193plg.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 04:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lbga1PekNQG7Wr08X5AD8bYyGj914Yhe8xMoadj6ep8=;
        b=Wkgvt7M/3VLY+FML2DA+LVjnEPI6mopPmwB+jdxBTvY1cW+hfiTbvwPmfPCRqxGI/5
         U3eRsnTqOG/OKrTOaCjpI+jKcytHrjhZx6z39hTcQlghqpfQlhf29szyk26EOPQ81aqv
         RvwwXVDt+PD6CF73FMYrpZEPqnV75wK6k25xYKamIq9l28L6Gp65toSLr+8cLL6q0TLO
         ccCO/h/ArwS/JoxxHnTzcPk2iEfgeIx30Ctb7nPpqPE37BtQA8X64Bv2FTfaU609ago/
         JAZdxoMS/9mYTNvfvzHD4f1RyngBXoDNWTOYRxudbM0n2u2AKtqYXULrUqbNAOiL/GbG
         s51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lbga1PekNQG7Wr08X5AD8bYyGj914Yhe8xMoadj6ep8=;
        b=bFvbC91rY7p9VA+xgKfQH67k3WflfrZvEb4YDj5LTjhHpTcgsUwOdWOb0B3SW81yQ9
         1i3Sr4JV4qQEbc9OYPgbKC2OSVgGOwrabs0JjYVQ1Pqxqb9+A5CE9LgjYgJhKRi+r4In
         dwZ1crWEkwgmMFfR4as+Y/g0vVjJfZ8b6eFqxuVpdl8NjXFltqLXpGrwlEEVjgJujHnZ
         8XUSRrKzwEMxRZ+feohZnYBPuOsFvL09uzF41xeKOT1fa/IUdGjFwZBC0Zn3U5G7voIM
         njtmvSkBSVSc4FP7vgvw1stiLt0jFZo6kfUW0mIXT3G+1dfzy+e2A3WuzcTQolAOBrFX
         02qw==
X-Gm-Message-State: AFqh2kqhiKFsRNhSoxZZiIlvyEP5nTy3YnbynXf0IJfBOzW4oOCEH6eF
        6OU3tflVF1MwX2f6oW9AQASflrqBbcvYFI5aS/02nA==
X-Google-Smtp-Source: AMrXdXtCakx+gDCZWxcq7+x+5SmE+6G1+2IncnakyeXGIZcRncfenaixWLy34xEgyDCGALWUs3tkMTZmGb6hw3x1WUo=
X-Received: by 2002:a17:90a:1d07:b0:228:f08f:a9b3 with SMTP id
 c7-20020a17090a1d0700b00228f08fa9b3mr3625899pjd.202.1674565070644; Tue, 24
 Jan 2023 04:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v3-6-e28dd31e3bed@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v3-6-e28dd31e3bed@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Jan 2023 13:57:14 +0100
Message-ID: <CAPDyKFrRN-+fhvWQNmQfD2u-0+2iqP-iONaKx61K685ZqcrZOg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: mmc: convert amlogic,meson-gx.txt to dt-schema
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 23 Jan 2023 at 11:10, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Convert the Amlogic SD / eMMC controller for S905/GXBB family SoCs
> to dt-schema.
>
> Take in account the used variant with amlogic,meson-gx-mmc.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/amlogic,meson-gx-mmc.yaml         | 73 ++++++++++++++++++++++
>  .../devicetree/bindings/mmc/amlogic,meson-gx.txt   | 39 ------------
>  2 files changed, 73 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> new file mode 100644
> index 000000000000..46e235bf228b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/amlogic,meson-gx-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic SD / eMMC controller for S905/GXBB family SoCs
> +
> +description:
> +  The MMC 5.1 compliant host controller on Amlogic provides the
> +  interface for SD, eMMC and SDIO devices
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: amlogic,meson-axg-mmc
> +      - items:
> +          - const: amlogic,meson-gx-mmc
> +          - const: amlogic,meson-gxbb-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: clkin0
> +      - const: clkin1
> +
> +  resets:
> +    maxItems: 1
> +
> +  amlogic,dram-access-quirk:
> +    type: boolean
> +    description:
> +      set when controller's internal DMA engine cannot access the DRAM memory,
> +      like on the G12A dedicated SDIO controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc@70000 {
> +        compatible = "amlogic,meson-gx-mmc", "amlogic,meson-gxbb-mmc";
> +        reg = <0x70000 0x2000>;
> +        interrupts = <GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
> +        clocks = <&clk_mmc>, <&xtal>, <&clk_div>;
> +        clock-names = "core", "clkin0", "clkin1";
> +        pinctrl-0 = <&emm_pins>;
> +        resets = <&reset_mmc>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> deleted file mode 100644
> index ccc5358db131..000000000000
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -Amlogic SD / eMMC controller for S905/GXBB family SoCs
> -
> -The MMC 5.1 compliant host controller on Amlogic provides the
> -interface for SD, eMMC and SDIO devices.
> -
> -This file documents the properties in addition to those available in
> -the MMC core bindings, documented by mmc.txt.
> -
> -Required properties:
> -- compatible : contains one of:
> -  - "amlogic,meson-gx-mmc"
> -  - "amlogic,meson-gxbb-mmc"
> -  - "amlogic,meson-gxl-mmc"
> -  - "amlogic,meson-gxm-mmc"
> -  - "amlogic,meson-axg-mmc"
> -- clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
> -- clock-names: Should contain the following:
> -       "core" - Main peripheral bus clock
> -       "clkin0" - Parent clock of internal mux
> -       "clkin1" - Other parent clock of internal mux
> -  The driver has an internal mux clock which switches between clkin0 and clkin1 depending on the
> -  clock rate requested by the MMC core.
> -- resets     : phandle of the internal reset line
> -
> -Optional properties:
> -- amlogic,dram-access-quirk: set when controller's internal DMA engine cannot access the
> -  DRAM memory, like on the G12A dedicated SDIO controller.
> -
> -Example:
> -
> -       sd_emmc_a: mmc@70000 {
> -               compatible = "amlogic,meson-gxbb-mmc";
> -               reg = <0x0 0x70000 0x0 0x2000>;
> -               interrupts = < GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
> -               clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
> -               clock-names = "core", "clkin0", "clkin1";
> -               pinctrl-0 = <&emmc_pins>;
> -               resets = <&reset RESET_SD_EMMC_A>;
> -       };
>
> --
> 2.34.1
>
