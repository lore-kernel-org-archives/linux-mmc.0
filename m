Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F4BC43217
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 14:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbiKRO4U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbiKROzy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 09:55:54 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C146E554
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:55:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g12so8603254lfh.3
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=goUFPMKX4auhNOytpCS76F6+oFJbm5nDF3rRTkPSoxs=;
        b=ev8zzitMeZQuPjRj0P/TC0v7bJQVBjsNTIlj/vYfhMxFuR+OvntUDzBIMZEH11nujL
         HnCteaXp5n3QMFnDnDel1pkcwRnmcKF/HHapoacLlJxE+OJVvIFOmygYxO+zHqfZA/5Y
         Wtq0j+q+fqeudod2CPBAmCSaV2IWitzEjn2oAnGw4iK/nVg1L1ZkFB3vCZne8IJqHO1B
         xYgV+wALymQwd8zrJiMeLmbYxbaFgOZboRUK6CdTv2a0n2WI1fI2v8wz+a0V7uDToqEH
         EjY4B3YVUTJklIUQFYAZFlDp39fr/BGv/HZRpH481+iTcad97kjoL+sSZHZ2e2YUb8gK
         c+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goUFPMKX4auhNOytpCS76F6+oFJbm5nDF3rRTkPSoxs=;
        b=45UjKFU+wmyY3CqM+F3dZ9e4B94qUXbcGEijTVJyBuK6K/uXTsDKnyHN+jV1xqdOyy
         rdtP6iVmyxpALRKpB76aa7tAHTCiyBZbeHrenW6t5FgsVbUxIY0qerpIHnh1nO9LTQAJ
         jYgifhC+Ci6/JQ8mg3K+oAZWO5tse9fkcyRgu8uTEeYcO29muvEnlG1N5WBHF8mwXnSV
         hWTWtVymfbPwC//jUCygR51ePCIlQCXoIFBhM4pNC67YkgqNx9O5C2c1gHQ8SYaeQ6A8
         218/B799fUI6W1VkmlbwBk5kCeDD5lvHle4DBha5hooJj1UESZe1tTr3dcAc9ps2PBcN
         Vq3w==
X-Gm-Message-State: ANoB5plxSW4hCW7BA2c1fo8tjqVAZ3SWedmhdqxEFWB7eaLyJU9rstSK
        IiMn6LV0L2lzWyvSsz1SC78TBQ==
X-Google-Smtp-Source: AA0mqf4rUU5GFN13rGIm8oVXpzqHjxQvPRkD/HFkVTV6c9Dwb96c2a3B93ODDu0Sm7WxWsDPEwgNmQ==
X-Received: by 2002:a05:6512:3282:b0:4a2:4b1b:6ad9 with SMTP id p2-20020a056512328200b004a24b1b6ad9mr2863014lfe.296.1668783327899;
        Fri, 18 Nov 2022 06:55:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e19-20020a05651236d300b004afc1607130sm693758lfs.8.2022.11.18.06.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:55:27 -0800 (PST)
Message-ID: <86d3cb18-4e31-7389-f982-7985cf976791@linaro.org>
Date:   Fri, 18 Nov 2022 15:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 09/12] dt-bindings: phy: convert meson-gxl-usb2-phy.txt to
 dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v1-9-3f025599b968@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-9-3f025599b968@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/11/2022 15:33, Neil Armstrong wrote:
> Convert the Amlogic Meson GXL USB2 PHY bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/phy/amlogic,meson-gxl-usb2-phy.yaml   | 56 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/meson-gxl-usb2-phy.txt | 21 --------
>  2 files changed, 56 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-gxl-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-gxl-usb2-phy.yaml
> new file mode 100644
> index 000000000000..4dd287f1f400
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-gxl-usb2-phy.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/amlogic,meson-gxl-usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson GXL USB2 PHY
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: amlogic,meson-gxl-usb2-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: phy
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  phy-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@78000 {
> +          compatible = "amlogic,meson-gxl-usb2-phy";
> +          reg = <0x78000 0x20>;
> +          clocks = <&xtal>;
> +          clock-names = "phy";
> +          resets = <&phy_reset>;
> +          reset-names = "phy";
> +          #phy-cells = <0>;
> +          phy-supply = <&usb2_supply>;

Use 4 spaces for example indentation.

With indentation fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

