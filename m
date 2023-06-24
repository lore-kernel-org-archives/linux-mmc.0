Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B7C04A6A
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Jun 2023 07:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjFXHzM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Jun 2023 03:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjFXHzF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Jun 2023 03:55:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920942954
        for <linux-mmc@vger.kernel.org>; Sat, 24 Jun 2023 00:54:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51be881b425so1505138a12.1
        for <linux-mmc@vger.kernel.org>; Sat, 24 Jun 2023 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593297; x=1690185297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soj7fUfKLSUMfNJRhcGNetkgOh1MYDCQh05RlBdkeN4=;
        b=eD/q9ISsMCL47wOXs6De7fuRpet/07x40xn71+pyopNmpfC/leMOmohtiJNK9d+/0e
         ILxksxb1fX6rwaa0PNl4dIKNWKQ0JE0p+6mC8Npy2RJ92zmvNc++lXF1Evombv7lLOhq
         j0dEkeCidthf58IY6B/xewKh7UeXN34mH4Tn/G+1iZuhgJY19SkmNAEXnRUl+6Hr2Pkf
         cSz2zRZiOrOsv0eavcQnSNRSp9hvrs6WsSE1JlocSaWw+8h6/lYnvjc7aqnaDQHYXfi2
         MGVSEIum3iSzoq+S0mokQ5a3djEQN7ISokIkliin4UzR1LuGSZT4+Gyjp384W6jbO4Hx
         53EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593297; x=1690185297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soj7fUfKLSUMfNJRhcGNetkgOh1MYDCQh05RlBdkeN4=;
        b=BZsVfiDNbgs8OrVUW8Lbz95jXmsmmcEPMyX+QZNR4c6z94TJ5+xskECtgg9yRM1nl0
         Qe2xpP35cCT7dwS6pQJ4dA0zQVEb33b2RerHGWQ9NThSOj0BjsydqusAkoSNZOIUrlxd
         h6EUEgyTh5nbFItvqssLUjyB6eRvD1SpvEuRxUkwZgp7ZhBDa6MS6SN3XNbrY3B+JzAW
         6M3lmTHdN/Mp0IHppJBsxGL3t/HUem8BQDY6ubO2R+sH2hL70K3CKEUVnn8cz+9sHh0J
         fceAv+u+RMxLXcWUMKzCyQulIPtRLmuwLSdC15vwZ22KgS4hewAmzEOTQzOr5vrWBzFl
         LJew==
X-Gm-Message-State: AC+VfDyufM6pLw6A0J+tCVVZ2R7HiMSKkRqj/6B6WwyNi4RtwOsZyje1
        Cujpm/oEJM19KLYrssPvsmBOVw==
X-Google-Smtp-Source: ACHHUZ5vmH/wKISmL4HMBTOHg32GmJjKiHm7OZvesTfDEOfAm6Koe4Xv//vNxQvMZ5IiPxQ9Ro3PoQ==
X-Received: by 2002:a17:907:320e:b0:96f:912e:5ec4 with SMTP id xg14-20020a170907320e00b0096f912e5ec4mr19710575ejb.16.1687593296802;
        Sat, 24 Jun 2023 00:54:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o6-20020aa7d3c6000000b0051a5177adeasm400813edr.21.2023.06.24.00.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:54:56 -0700 (PDT)
Message-ID: <428a655e-8664-0e68-7eda-8edd47a4eee7@linaro.org>
Date:   Sat, 24 Jun 2023 09:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/45] dt-bindings: net: cdns,macb: add documentation
 for sam9x7 ethernet interface
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, sre@kernel.org, jerry.ray@microchip.com,
        horatiu.vultur@microchip.com, durai.manickamkr@microchip.com,
        andrew@lunn.ch, alain.volmat@foss.st.com,
        neil.armstrong@linaro.org, mihai.sain@microchip.com,
        eugen.hristev@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-5-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-5-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add documentation for sam9x7 ethernet interface.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +

So you ignored the comments and tags everywhere?

Best regards,
Krzysztof

