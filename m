Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB5C63797
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Jan 2023 10:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjAJKOT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Jan 2023 05:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjAJKOJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2023 05:14:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124204D731
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2023 02:14:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id co23so11181459wrb.4
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2023 02:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jojCCGfavVKv5imMe2sO0IZFTAm6Qt+UkX8aAOYmM8Q=;
        b=bbhb/M2Tbo7P6JQFLKz1c0s92pip1LUY/qoQtVnezlvmXlve3kgyeNba8+WtmX4t2D
         Dqs5HvWz9j8ad8G7zjQAKt2OUhJ5oPpmAugq792ubXvNuvlNgx12r2eNxoiWtfJtAgkc
         ln8dRvw1xf/0keWdYbSaNriNWp27rABFZucUCHjhkgOSv2oYBu+gDWHpRQmu7nuZYux/
         Ch1A4NbCcbmL1JAXJRKL58l8adrR3ecbI+lYW+4ObQNnSVJc2XVqhStvYLd1MguXeStw
         ks3SHXuek07nXLDarhxwAioHsl5xyI708nCoT8Z6Vdq/Uf2JhdoccDoTWgGesRpg8BQ0
         zb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jojCCGfavVKv5imMe2sO0IZFTAm6Qt+UkX8aAOYmM8Q=;
        b=kP6ATIiYqX+kuinQRbr09frZnf5UcisVVjDQtzOf5IxpBwJ40Uc0MftItb/ytULckd
         lPJq+MP77fq0ZjU1yNb6J3KbdUlzyUMB1HVz/0ikclqQLUoYrHwtVgaKsQ3Ct64LNRGG
         zPCznRe0ZHFeMlYe69kGtvjyGxsXq9bYyiVX0nMb3rIpBsnA+B3S8DbDcZB9zwJstw6s
         zUUXj49sRwOLdXwWgeFBmmylrdpCXLarpHBgsuVpaz83JeMtV4U/QY29lIAKWIvZ/kz4
         PPnJxGXcu/+kWh3VL5ZMaAKU/yxZA8G0OEiymCe3t/mNJLn85nf/UeOSeY6xRU1vHLvC
         qXAQ==
X-Gm-Message-State: AFqh2krmeB4vUgjJ0f0cG4NPtSQZFmn3ZHlc+5d7ik911FtpY8Lx4Ih1
        Oaolp4QgVoxPXx3n4bjUWECyhQ==
X-Google-Smtp-Source: AMrXdXsns+wODkeVA+eyVg6DWDP7h4ZsUK2KoND8WPXo2OLQMg/ZUcoSsqQ0z3Y2wBq+9Yj/x0NG4A==
X-Received: by 2002:a05:6000:16cb:b0:242:1b0d:9c58 with SMTP id h11-20020a05600016cb00b002421b0d9c58mr50376842wrf.69.1673345645653;
        Tue, 10 Jan 2023 02:14:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a10-20020adfdd0a000000b002bb6b45ab57sm8867372wrm.85.2023.01.10.02.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:14:04 -0800 (PST)
Message-ID: <6044f85b-93f2-fe2e-68b5-9912836f4a38@linaro.org>
Date:   Tue, 10 Jan 2023 11:14:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 01/11] dt-bindings: firmware: convert meson_sm.txt to
 dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v2-0-36ad050bb625@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v2-1-36ad050bb625@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v2-1-36ad050bb625@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 09/01/2023 13:53, Neil Armstrong wrote:
> Convert the Amlogic Secure Monitor bindings to dt-schema.
> 
> Take in account usage the used variant with amlogic,meson-gx-sm.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

