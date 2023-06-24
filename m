Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2456CC001DF
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Jun 2023 07:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFXHxU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Jun 2023 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjFXHxR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Jun 2023 03:53:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7E226B0
        for <linux-mmc@vger.kernel.org>; Sat, 24 Jun 2023 00:53:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso194047a12.1
        for <linux-mmc@vger.kernel.org>; Sat, 24 Jun 2023 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593192; x=1690185192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr9nrGlYrxN00jEwRxs6PYBUQxgnGyvMLv6d+S+IyFk=;
        b=LQEc0yoJm0GslpUZYCjcHtwoTCvu+59CHRYP/sGpmh7IIEWYyKbcmwOTWkHIAk5amo
         GW/7Gpe870PqzwscCvwhvS2tRdD4lIO92N5a+9t0YvyTUExmCh3G/ey+cNZCCGzcBTPJ
         6yPMwkjqsKsodsXDqWTZBNezjTKe+7X8fdEpM8mYCN9NPvWn/peXOWQ5kyvKsBiKcO44
         1nn5gapVl7Ro8gQLfw1L+9piaUTX+p6FPVZZ1/ijnscvD92eH3mJCbstLfuZt0gY2UUX
         +QldvphwJQ8glfg3JyKVOgSk3y2EQry5UIdVnMeV03t88wxPGoe0khhNc6S3VhqB4zja
         Bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593192; x=1690185192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr9nrGlYrxN00jEwRxs6PYBUQxgnGyvMLv6d+S+IyFk=;
        b=R6ajPZEhNK3HRVq9CRZks1Rdo6NJ+HvzGBgxhyb7lU0DeBYwhJ5npWbvgBm8nb6Z+v
         uq8SchgdqsMXomKKy7FeL8bojv3JytAKcEEuG+H2/uwhn4+vXBOhwXrFubuQZmcZ9CWA
         kCjs6o7HPKmLZiHauaE1eLtrGIsn0WXV0sZBAVYUkEaZdBbyDbE1auhNuFSrO6v7s7wq
         8MSs/bQDfi1I/i89+e2ITy5QQasVv9mHMO4XBJYCXQ84IsgZZGdWvOR86JK3Axnv6v2C
         /5Gxeq4q4DTO3JLqlqX2G9anZ5pWYcyH2PYB8xgIARxhOIAZKEUCGSDLJCnW/Jn1suT6
         jPlw==
X-Gm-Message-State: AC+VfDzX0xxrf75pNy9zE+TuX8qVcm2k4a8KKlsPqNYpckHtoGTxL7R1
        yiKpWrDWB1sQKj0dTtCYaIt5hg==
X-Google-Smtp-Source: ACHHUZ522CJYVOfO8kVotsUuEt+wtHkNFHrIi0PS6ACNcKvYFOPHzOCYWLySAcxpXgHfsNodLNJqrA==
X-Received: by 2002:a50:ef12:0:b0:51a:f6de:bb81 with SMTP id m18-20020a50ef12000000b0051af6debb81mr10804337eds.28.1687593192613;
        Sat, 24 Jun 2023 00:53:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7d345000000b0051495ce23absm404938edr.10.2023.06.24.00.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:53:12 -0700 (PDT)
Message-ID: <074048a2-5153-e013-3562-b5cad2ba0954@linaro.org>
Date:   Sat, 24 Jun 2023 09:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/45] dt-bindings: microchip: atmel,at91rm9200-tcb:
 add sam9x60, sam9x7 compatible
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
 <20230623203056.689705-2-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-2-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add sam9x60, sam9x7 compatible string support in the schema file.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml | 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

