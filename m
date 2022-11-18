Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EE9C4321E
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 14:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiKROtI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 09:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiKROtG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 09:49:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E31006E
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:49:05 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g12so8574727lfh.3
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xECLjM+1wJ3tyU5u/WQawVGRXnB8gHjb6MLiqzOmuE=;
        b=Zs12YmMMSavyYzmNqKcCRYMCcx5tO7qpQ0VvE7hyvFNBku6wyFMWhXNVMlF+Sqg0KT
         WoIA+w4A8iuBJ/Z1AAHH4aIRydfpKhe7bF24gwy0bRzlEk0jYncnokHI+00AlKhVfGXV
         JIIp3E5uA+gM7soG5wopEU+Lv1q63Zy9Cg91suTl/dBPE5V24XVYczE01kWsKEHVfQGb
         dBT162Z4F1TG+7XSK0OcZOSsHy+CA846o55K/WA07GJriE9bcEJQUbPZyZbcV94cF4R/
         VfK+gBKT/TkzM9E9oq25330xsTCuei+8omVXqqLIW5R7KPXHwfeYtmnlKBMLd61OMOgq
         UpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xECLjM+1wJ3tyU5u/WQawVGRXnB8gHjb6MLiqzOmuE=;
        b=ZBxHGNwn0ON83Ehs+FI0VMS990oktBPtKN4mGQPMKIf7nt3+KaZ0as6zROk0FwxYsO
         ND5EeZvD4Q62PcAESrEoVkXzNePn7LlmE4XGYxTBEilo1QME9dInSJvDRkGAWvLx7jyk
         XbTKWVFaOE5DXT++NyO4EHfAV7guWRl7YRz+qxbtJN4l+VtZyVm5h+AwUxrjIcYE/fNA
         5dd00E6xkiN5k2SkMPLsl3Q4vH66chy/j1Ge8MtKCF4qyiOT3UoBiXMDN1dnnYPpRzV2
         SHG1exqyn9/D5hJRK0mVKKGoQt19DTrf6BxhEl9nf1mpQCR5Lwl9wnVGFR84JiBnHsHT
         Tj3g==
X-Gm-Message-State: ANoB5pkbyMs0N1NgVYDFfDK2q+m0nIQzzNTY1ElkNdXREM4uwCUUXg1B
        JiJZ7AX3FDMpEjXTsJp60TnH9g==
X-Google-Smtp-Source: AA0mqf7ZXIKPBh9Rz/8NI/J74R1K82UMSY4YzepugR6KIDjTrCZkpyZFe0babnYb4sjivNlfYP6QJQ==
X-Received: by 2002:a19:5019:0:b0:4b4:8d47:7057 with SMTP id e25-20020a195019000000b004b48d477057mr2868955lfb.376.1668782943480;
        Fri, 18 Nov 2022 06:49:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h3-20020ac250c3000000b00492c463526dsm685909lfm.186.2022.11.18.06.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:49:03 -0800 (PST)
Message-ID: <24296f7d-416d-e5f5-ef6a-c960b59513cb@linaro.org>
Date:   Fri, 18 Nov 2022 15:49:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/12] dt-bindings: watchdog: convert meson-wdt.txt to
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
 <20221117-b4-amlogic-bindings-convert-v1-4-3f025599b968@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-4-3f025599b968@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/11/2022 15:33, Neil Armstrong wrote:
> Convert the Amlogic Meson6 SoCs Watchdog timer bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

