Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC1C63797
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Jan 2023 10:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbjAJKQC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Jan 2023 05:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjAJKPk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2023 05:15:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037956886
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2023 02:15:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so9451208wms.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2023 02:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOaM9klxyd9oBpbyKATfQLn+xwTyF3728aG0uRNv66U=;
        b=yoUk4O+00nkGYkYXyiqjTxWK4c7uEc66lLsyapNN3lN4GWq40l5XLLk6lO9MKtmxLQ
         0mF0Rhs+YcdM7Am20PD9umvFqLKrgIs2WmrZqIoUhClE+yw2sEunnBBIg5tONlN8P8cg
         T/1xm7p/HoG0u7bVzXhlUjL5p8+Fvq6t2cK3PJCGiI7caXb7zzfRZcI4qprHbjxN3Gal
         hVatrgn4tWSnEMLt3nvou6IN6lw7QGsWFvZT88CEO87sTEeS8NAtT4PaEbRYqoFH/rKp
         gsFXYOEShYrosm9/rWZnYkZv6fcSTdHmPOYz9UXe0E+RXWhxZ3TWNIKjLHIFrlUHmJ/e
         RjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOaM9klxyd9oBpbyKATfQLn+xwTyF3728aG0uRNv66U=;
        b=6vvKG+j7Orh+x+Hd7Qqe/8YQtuLzQGMPwT31QKITWF6SMj+ubduAzE7zWm1Q05g2m1
         47qT1gc0DE+i1PBjU1UXmfS+6V9a4Vq/JOAH/tWtcDMQgdmGH0ETYTzCp9FlBdb7T4BR
         2GONeIEm1qayUvNOCHb5Y7hEjOgnoY3E6116f8hVnDHmuLBjJWpbXh3lXWGWQbq0J5K7
         emDGYbgk4F8tHu6OSMzTFoRPhy2CHJvKLMB/h7P851q1q5lDdtpK6ctnwewfjKqplnFS
         heT/pg2vJ1rqzTw03Hp95JQs64lg5EsPFGgyDXDd914JWBl/2jhpbOaCAYKhLqhfJIVC
         wMRw==
X-Gm-Message-State: AFqh2kqKKRRsXTWra6sTrWTGjxa/ZeP0i/UuztZV2LJn+HvKtRxc3f1u
        loT1fPGxD/+PlKyhT4bHnC6hkA==
X-Google-Smtp-Source: AMrXdXstKuMbnF6GLlV2QioeyL83rfUZ/PCM9H9gtVt4kpI2kfbu1FzMUYifSv02GGXMFgTeLR3h+Q==
X-Received: by 2002:a05:600c:3b02:b0:3c7:18:b339 with SMTP id m2-20020a05600c3b0200b003c70018b339mr58648300wms.37.1673345710203;
        Tue, 10 Jan 2023 02:15:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003d9fb04f658sm754592wmc.4.2023.01.10.02.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:15:09 -0800 (PST)
Message-ID: <2a0408ab-085b-c104-7e84-ce2fe1e6bea7@linaro.org>
Date:   Tue, 10 Jan 2023 11:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 02/11] dt-bindings: nvmem: convert amlogic-efuse.txt to
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
 <20221117-b4-amlogic-bindings-convert-v2-2-36ad050bb625@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v2-2-36ad050bb625@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 09/01/2023 13:53, Neil Armstrong wrote:
> Convert the  Amlogic Meson GX eFuse bindings to dt-schema.
> 
> Take in account the used variant with amlogic,meson-gx-efuse.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

