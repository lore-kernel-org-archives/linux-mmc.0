Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D270C43217
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 14:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiKROt7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 09:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241567AbiKROt6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 09:49:58 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F747193C3
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:49:56 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id c25so7030788ljr.8
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz1fgFvu/EO4HMlO5FNKw0t0f66TQQFrAxbDNME5ooY=;
        b=mCXlT2aWEXGE5G4/8SDvVW5SPhpQwM/LAmoA1FXKxNWbMaxFQJ6lHchC1gmxGvjB1J
         qMGDIa/MyDLZ30UfBbe0oP1mkqBrn2eaC3kS9zBv48nUVlW6PMcU6EBTnuDULS6GTCi9
         e+ez4YhUacjysshZ2bdNrW47yRIj+wJeDXscMFG1mHOGFOWJ1R0r4D1qLEhBBa3s/tVf
         R2kLqtooeIfLpdqw/eBNUO3n+iKXn8zoetYxIGFw8jm9tUo5j2ff60TbmOi3rJhUrYpr
         9igjmxpTDX44ZKxpJxrgAGeCRaebTQnTP66S8cOg2pPG57WDFJrGzM4/6L4R/dmm7J3D
         UkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz1fgFvu/EO4HMlO5FNKw0t0f66TQQFrAxbDNME5ooY=;
        b=SwOXV/fOOF1DdCnK1C6J509nMss5W+R2gJCiyEnYBFYBj7+bGm4yMSuFx2YdoTtSb8
         EORqcszE+pVEBxkhRAVZHP5vA7h92mrEpRfxvY2UClfluXFB79yzYz3xW0SLT8RkvUZI
         nvmtd854+/Rvh47ytaltxJNTeRYMcMPYoZLoe5dBCSpyjp27mfDJCs02GfD0a+11Yuyx
         XslQJmkTp/ZZQ/OlpRxvNV35RMYR72yWtc0nCFHehw7eVLSlt5KDtXlVmubqK8yAMGA/
         kq+JebW8K8fBFJT7b2zgkVIgGowO0fQyUnzVNMPq9xf2GAwqEeraIJis71o51YWS3lZG
         9Wzw==
X-Gm-Message-State: ANoB5plx/MNiNaBXQfhXGY94/ous0pNQJZKrao/yKvIJUAacxagvwjs9
        fXAlsQletfltV5yEiNNz5KHAWQ==
X-Google-Smtp-Source: AA0mqf6L9W5MCkqEZsf64R6Fo8bZ58XpODRGgBZIIWvJLUKFWkuvQd/iPa+mcXNvtk+PBNvZ12YO+Q==
X-Received: by 2002:a2e:a4c8:0:b0:26c:4c27:a478 with SMTP id p8-20020a2ea4c8000000b0026c4c27a478mr2420022ljm.92.1668782994596;
        Fri, 18 Nov 2022 06:49:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h3-20020ac250c3000000b00492c463526dsm686190lfm.186.2022.11.18.06.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:49:53 -0800 (PST)
Message-ID: <2e10ec36-46a4-020f-34f0-30359001ff43@linaro.org>
Date:   Fri, 18 Nov 2022 15:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/12] dt-bindings: media: convert meson-ir.txt to
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
 <20221117-b4-amlogic-bindings-convert-v1-5-3f025599b968@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-5-3f025599b968@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/11/2022 15:33, Neil Armstrong wrote:
> Convert the Amlogic Meson IR remote control receiver bindings to
> dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/media/amlogic,meson6-ir.yaml          | 43 ++++++++++++++++++++++
>  .../devicetree/bindings/media/meson-ir.txt         | 20 --------


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

