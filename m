Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4853EC4332F
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Apr 2022 10:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiDWKOa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 23 Apr 2022 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiDWKMb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Apr 2022 06:12:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA51CF703
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2022 03:09:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks6so20768222ejb.1
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2022 03:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DCeonWjVpVvFaDIUwzVDrsiqJjzTalP0OPLls+NZnWc=;
        b=Ti6mIMHpl+KN1/VH2J/2Cm2mTkZux/aaoLWdUgSJvMYK24cdjcpn/xrC3BuGDo4kU5
         zVPpBVbSqxfJsJOqUtG0AvsE5eno6MEaDIdYS5A5JMJ6H7ahribCTyyba0KYpA2nqLPJ
         BI8saKICCz7P89BZceexn4b0+G5zn3YM2hhIsdizMzQ0GYAcp2NhaS7unERZLNvZRkhV
         jyPbeGU5IJWhC21moe7MTkHHFwGGiJ9PXB0TzaGiZCsw3s83TzXTJOobl7nE8d5lHyzz
         nYMOCOeD9ctRMRRf9Rw8MYeHrcD2stIQr6yYnMX9fqRJQO1Oh7KtVK5a4d3dwe0wQOB1
         BhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DCeonWjVpVvFaDIUwzVDrsiqJjzTalP0OPLls+NZnWc=;
        b=CWPP2nXWZnuOL1M5ppbtv+RL9zAXgjOZH4MpWKxwajbgOIM+nGcSsu8edEywS0mlJU
         Nz1lCyqbaZil+lGfdH/kWV5+TkZbmsTEJh70Q35naH83wnfDp5E77oBgMmcPUh3Q8j0u
         HWEXtjyqqENEcqjXJifoJDTqHFxEgP7I0fSOdxBveoZudeCF3YSsoDKwzFtS2i2zVL+o
         ZiEBI16VWvHvlN6tDiix/yHoGbA3L5jseGQH+2libQkj/SQ4Qlvx9lJmGfskpGsr2/wj
         8DZ6s6Y4neYSRyMgh+wwBe5F/8QeWOzopUWl35tuaxpegc0Pp0YKKrW/ThqO6c0EnIXZ
         oWOA==
X-Gm-Message-State: AOAM532WvQJTcA/GWxhYIH6Xq7S7+2CYEKSqNW1Pc+zchaRq5wdKdOu4
        5cqdsLAhTjBm3hP3eI69iCdGWg==
X-Google-Smtp-Source: ABdhPJxH7lyOrG5mIRwnK45I7YIT1NaYQjc31HVx1K3KqPyODzSMcETNAdiuJaWQhGMZt5D/Z2kNzQ==
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id j1-20020a170906830100b006e4896d59b1mr7624358ejx.396.1650708563296;
        Sat, 23 Apr 2022 03:09:23 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p12-20020a50c94c000000b00425c48132bfsm1362892edh.55.2022.04.23.03.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:09:22 -0700 (PDT)
Message-ID: <46e72600-b96a-03a9-134d-28a0cb4bc078@linaro.org>
Date:   Sat, 23 Apr 2022 12:09:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1 19/19] arm64: dts: rockchip: Add rk3588-evb1 board
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-20-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422170920.401914-20-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/04/2022 19:09, Sebastian Reichel wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> Add board file for the RK3588 evaluation board. While the hardware
> offers plenty of peripherals and connectivity this basic implementation
> just handles things required to successfully boot Linux from eMMC
> and connect via UART.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, update commit message, use EVB1 for SoC bringup]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |  5 +++
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 34 +++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index eece92f83a2d..b14d0c84c69b 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -664,6 +664,11 @@ properties:
>            - const: rockchip,rk3568-bpi-r2pro
>            - const: rockchip,rk3568
>  
> +      - description: Rockchip RK3588 Evaluation board
> +        items:
> +          - const: rockchip,rk3588-evb1-v10
> +          - const: rockchip,rk3588
> +
>  additionalProperties: true
>  
>  ...
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 4ae9f35434b8..8a53ab6d37a1 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -61,3 +61,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> new file mode 100644
> index 000000000000..68b19acb1550
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model = "Rockchip RK3588 EVB1 V10 Board";
> +	compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	max-frequency = <200000000>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	status = "ok";
> +};
> +
> +&uart2 {
> +	status = "ok";

Usually status goes at the end of properties and rockchip sources use
"okay" instead of "ok".

It's a nit, so in any case:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
