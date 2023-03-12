Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F61C74A4B
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCLU6Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjCLU6U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 16:58:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F2B125BF
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:58:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g10so12170685eda.1
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678654697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20W8M2TdEhNy7aTngidW3iiHvYf5XABL/NJb+wNETK0=;
        b=I02JLnAeOEVaZGRIcfS1UM3P7RFH2leQ9zMuXN0HLdN6J02MDaQ42e2WEap6Oag1/S
         rlVO9nY9zT/MfLkpF0/zzHMTskhAY5n0MEzIvuXptYExJZwIBcfo8uIGEjspnYq8L8W1
         1bNl1jJFWQGbH0/NbsXk+vJxYlaLdXjiaW+CskmXjzFyoXihJqmi8K0T9sMOfj4omYz9
         amkplJ5I8OPoIKAyD1IxHN4jlSh/FFSrvm2gNtQBi6NGRjZVOAaVHEb8b2qQXCjGzmKD
         xe2+NPZSr0NP/WmauDsYzCJGX2MXyEfJG/P+GZ8rq9QyyPuX1a4Dqs//a7XG1UbqZ6uD
         IyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20W8M2TdEhNy7aTngidW3iiHvYf5XABL/NJb+wNETK0=;
        b=4hONentDLxUo10htpggUfxn4qwocEV4QPPjX4YSbmsGrsQRnOEZEqg2y19DqzWKZhM
         RMjXHbQwYoVnJxo4wevBel0xOU3EjexnOo21F/k/8+b6gJSaxCtD7a+a7DAzy8nDSOQI
         pfzYMbCyEYam+YWP7SXDpjv+TpK1313OM60LainS+f10IAEBUemSRuDVKk8v53SDZ4oj
         S+QMvMi2d2DTL/yCJgL7j9fMSmff65/Q1NMX6c0n9K6MwsTRkOGcoWAz/cv4rjHmf9au
         mwv4rGvXfqIZq+ib+OWmwxKorDBOQoax08GuA1BaKULAs7hFrsxFfN0vnOdUP358Gv8M
         Z8gw==
X-Gm-Message-State: AO0yUKXg37Q5Ktic97jcfRzBnH91GWScggtnjDygnAuQDPU35f6jXVkH
        g4+78HwfbO5p1tqy78jZJ7Er5dOCRThoJoaqYFc=
X-Google-Smtp-Source: AK7set8XaKUkz6qbzkBRl5y1qtqalHLBAv3RLKmkgmCfyFwnymmDsiDYn1Y3sC5kXO3E2WOOjEkW4w==
X-Received: by 2002:a17:907:a04:b0:8af:370b:da59 with SMTP id bb4-20020a1709070a0400b008af370bda59mr45390936ejc.17.1678654697314;
        Sun, 12 Mar 2023 13:58:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b008d68d018153sm2597511ejb.23.2023.03.12.13.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:58:16 -0700 (PDT)
Message-ID: <92b4970a-f904-884b-f0fe-0ab8f024210c@linaro.org>
Date:   Sun, 12 Mar 2023 21:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 05/15] dt-bindings: soc: amd: amd,pensando-elba-ctrl:
 Add Pensando SoC Controller
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230312004445.15913-1-blarson@amd.com>
 <20230312004445.15913-6-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312004445.15913-6-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 01:44, Brad Larson wrote:
> Support the AMD Pensando Elba SoC Controller which is a SPI connected
> device providing a miscellaneous set of essential board control/status
> registers.  This device is present in all Pensando SoC based designs.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v11 changes:
> - Fixed the compatible which should have stayed as 'amd,pensando-elba-ctrl',
>   the commit message, and the filename
> - Reference spi-peripheral-props
> - Delete spi-max-frequency 
> - Remove num-cs from example


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

