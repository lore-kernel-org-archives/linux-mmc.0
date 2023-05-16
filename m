Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6E6C77B7F
	for <linux-mmc@archiver.kernel.org>; Tue, 16 May 2023 07:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjEPHPe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 May 2023 03:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjEPHPS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2023 03:15:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85BB5591
        for <linux-mmc@vger.kernel.org>; Tue, 16 May 2023 00:14:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso24234768a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 16 May 2023 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684221293; x=1686813293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwyQq6Ma+IalniJ60xUX0fi/X5hB5M8pYnXUsp4Z7gY=;
        b=xXrGev8c7n+hEhvi9ED2WV5N4+H6krmlBs/RISfv6BVeznDNlnPx+fUtj04r8BJpOU
         9/O0pRE0RZAUfN83i5SVmxCwn4j19/IV6DW9xV3JFIF4MI1m3DGu57QrUZ5dDvcUCDf0
         RDZuilvUB85ahh5VxqluKV6SD79zCa2lxPNCpV4dEdmEKn/NtLHukEim+Yv7xbHnHm5k
         3pqiajegnkvEsXmT1hdUPibxWrEFArF2XrLgA4avtWeuMg+vHdvVijoZo0V+a/pOKbWM
         28Elk3kQSpvCZxJwW99w8vGQ+O6ytFiwIc6u1kkOTTpKK98X24X+RzJna203wTuxqhIL
         ntOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221293; x=1686813293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwyQq6Ma+IalniJ60xUX0fi/X5hB5M8pYnXUsp4Z7gY=;
        b=bzzqZO+mGzkfRb2uChDABW/FtX5ayZrE7METI8UfeiJXWQSOzSVpGbod9CBNxV8EcC
         0eyhQV4wltZfCwwNpeKIMietLKiQ66i6SAGu1W001dcgwiio75t0ID6o+VJWfby7LnYD
         MZNq3FeaQNZSm42e1MOn+4Zvo/r8p1fs4sfsl4nkTmUjAQARTyZR4iwfIoAK+RImI46D
         KjjvpGmbwUyTZXOEAp3hU0PAWwpJPb9+utk8FlqB14H4sqnJvnQhxCUCcBlrmUdMupRQ
         HsWDy0tGyZa6CBrpLoI/+R5sxRcFIwFFrz0fRnFmYHN2HmtpszXkchm7hCceht3zt2uY
         kDkw==
X-Gm-Message-State: AC+VfDzx1JIqB+BU4TLGs1AIkepSTfpKHNK6OnJAZR8Pcdq9HoVRwEt7
        ROiwYXH1yQJf271cMyCZ9azLSMLCLpa4BWj2qqc=
X-Google-Smtp-Source: ACHHUZ6YHyV1ku6mmH3P0IsC9v4GxmhMCFVjSTIigwYYsmI8YOpiBLJUxecGFyGtxb5NIAoLKTnO4A==
X-Received: by 2002:a17:907:26c6:b0:91f:b13f:a028 with SMTP id bp6-20020a17090726c600b0091fb13fa028mr28954750ejc.34.1684221293282;
        Tue, 16 May 2023 00:14:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067a0100b0096b0e93193asm3444377ejo.90.2023.05.16.00.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:14:52 -0700 (PDT)
Message-ID: <463b4f44-dbcc-1c3a-5b9d-93f68a5db0bd@linaro.org>
Date:   Tue, 16 May 2023 09:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 0/8] Support AMD Pensando Elba SoC
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
References: <20230515181606.65953-1-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/05/2023 20:15, Brad Larson wrote:
> This series enables support for AMD Pensando Elba SoC based platforms.
> 
> The Elba SoC has the following features:
> - Sixteen ARM64 A72 cores
> - Dual DDR 4/5 memory controllers
> - 32 lanes of PCIe Gen3/4 to the Host
> - Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
>   also a single 1GE management port.
> - Storage/crypto offloads and 144 programmable P4 cores.
> - QSPI and EMMC for SoC storage
> - Two SPI interfaces for peripheral management
> - I2C bus for platform management
> 
> == V14 changes ==
> Updated email list using get_maintainer.pl

If you split the patches per subsystem (e.g. SPI), you would get more of
them merged already.

Best regards,
Krzysztof

