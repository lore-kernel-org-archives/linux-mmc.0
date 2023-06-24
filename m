Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B721EB64DA
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Jun 2023 08:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjFXI2P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Jun 2023 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjFXI1G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Jun 2023 04:27:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5179F2130
        for <linux-mmc@vger.kernel.org>; Sat, 24 Jun 2023 01:25:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d89664272so8301a12.1
        for <linux-mmc@vger.kernel.org>; Sat, 24 Jun 2023 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687595085; x=1690187085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/1MyAMnY+Za4p1Z3b6q8vQY3JjDEV6jQ0tLk7ro11c=;
        b=vEp3OTxw3d1bxXmcrGbjPTZvGdATt4kPb7wTR8P+STWcYy+IGxBjmsrwXHlsdl+475
         D3HkXaVWkfKkJd8Y1v8mJIJNd7MKu+DSOBpGH1R/wozFufpVZ4WggR5v+D40MBe1DSSC
         xIxqP9drpnReATR6sXOtXazHadpPvVE4WXYIX8p8txCkuf3z8X9pyH76wlzCm+qOtyk4
         gvPYv/GZefHyoz4e7fucZIFONAUje8+rTmDzHlmEROrBOi8nsQuF66lLuDZBLi0jIYoP
         HsEXJZtaKyd0E+mlUCbFPj9PypWzwjLssl0KqaqVaVTXlEmAzs4cO8YEpP6UmKpo1O/B
         OPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687595085; x=1690187085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/1MyAMnY+Za4p1Z3b6q8vQY3JjDEV6jQ0tLk7ro11c=;
        b=AQXS5GJtUTaC7OwVLP0KIXMQb9qSkzzWD9mlJwnbl5CErL8Qdz5b1t4bD/gi+I6KwS
         oZrK6QFLaLFiA0Vgk8pz9AGvaAN41Xy8URWjbbBMiRQYTU4mwqpzTuVHYxDDUYmEPIeV
         AQHOr74PyPV/f+8Br7WzjHgq0bBso8jDYTg3ChJ97NJJWDOE4LCv8tvMfZZg/TEm4QkQ
         j8OKwCAYEqeH0J0sccmdD+J0sIz33ZziGwUFtYM1q/GrmULxYB4RsuFTYea2AUTR40c6
         e2ULnV34Dj6mp1imPlUbhVn+iFdZDwfzR50qAk8Y4SoFnWV66ib1qhzPX9Fp/v7kiUhi
         Slkg==
X-Gm-Message-State: AC+VfDyMr8IvSROndEfE9PKk9/8vuvn4FS3+61bG7XfA/24jkUMtLOU+
        Yx1rH2xuMLrF7ExBzqb45HbN0A==
X-Google-Smtp-Source: ACHHUZ6cYsMw0LIHQWddUSwohWm7hR0wZwIOc//Ha6WVz0kylI9t5vWz4f/hmDOCHTFgPVqzAQ5yVQ==
X-Received: by 2002:a17:907:3f87:b0:965:6075:d100 with SMTP id hr7-20020a1709073f8700b009656075d100mr20942422ejc.39.1687595085678;
        Sat, 24 Jun 2023 01:24:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id re3-20020a170906d8c300b00977ca5de275sm639460ejb.13.2023.06.24.01.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:24:45 -0700 (PDT)
Message-ID: <c9cbac9c-40dd-bb40-0d92-e25e767f486c@linaro.org>
Date:   Sat, 24 Jun 2023 10:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 26/45] dt-bindings: pinctrl: at91: add bindings for
 SAM9X7
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
 <20230623203056.689705-27-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-27-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add device tree binding for SAM9X7 pin controller.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt         | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> index e8abbdad7b5d..5a3be10dcbfb 100644
> --- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> @@ -20,6 +20,7 @@ such as pull-up, multi drive, etc.
>  Required properties for iomux controller:
>  - compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl"
>  		or "atmel,sama5d3-pinctrl" or "microchip,sam9x60-pinctrl"
> +		or "microchip,sam9x7-pinctrl"

That's not what your DTS is saying. NAK.

Best regards,
Krzysztof

