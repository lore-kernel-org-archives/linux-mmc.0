Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4EAC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160D26138B
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhHXTLc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:11:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58496
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232710AbhHXTLc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 15:11:32 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 15:11:31 EDT
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 498FA40770
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629831772;
        bh=tXo6FALvM7TQ/HZAw0MdLp6mungZZc7pCeMeJQgnDkk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=g3i5l2M92xF6rlKhhhjhEw20C2jPprR6TPI92Mavqcu1r6qpmsBWswxwDJVsCybM/
         67IuDWKL4ZOMHEQFB4fctTnWVwbvpHDoz9oudzfyEobjvhseHx9rVMWhLp5elMb29N
         naO+cqV92Mol7JLt58FHyEr4fuMXvWjf30GkEP3LFQz1Xo7zTvrM7KGjyK/wSR+8rO
         Mo7eATR6WHWJA51E7CbH+EivZlJmLdKSVmW7Xo+e+cn+K1xR61Ihz8D66xiREerVMY
         LPGDgGHPwUvXvqYhl4E3v7fYXSLWeedWjY6bpSgQivjBjNwjFIchXjUNngi/CEkbmd
         MaWg5SlmB8vAA==
Received: by mail-wm1-f72.google.com with SMTP id z186-20020a1c7ec30000b02902e6a27a9962so1641925wmc.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 12:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tXo6FALvM7TQ/HZAw0MdLp6mungZZc7pCeMeJQgnDkk=;
        b=U/uK3xx6z4dZy9MBx2AXZT3vClEqiZuiDhI6M2LEigkHH2dUkzTQaiTPmAvVKfpwIx
         03GbuzmMsFbiA1Wd8aYx9pYw+ST3kNX6kMs8jHHqlinzaVmgppoCG7eVsWVVHnnz1ROF
         e4pMD8nFVVB0v0XNtrSxh3CBg5L8EPFvr+6TAr6nfFAV2BD+AQp84ePqmYKTyyhiTQFd
         KAhNO94M9lV6tW5LZBUnnZg/EVEKmhCKtM4JeAD1J4SNwobJoPRRQ4FAE0Y3tJvq7jX5
         iLM9o9vthVWO5tc8RYa+BykA4ZkZseNYPX9oj3bvoToku7GUud94ZDuUz6TPA7h/gekP
         nDzw==
X-Gm-Message-State: AOAM532HKIA475yWbOiGRbCqeKV+Z6UEQGmk3PHmK2pz1QfazCwNECC2
        zQuXbAFgSHpaUn+cUdPgdXaZ7/tW5DsM2AoTSa/rOlrGiAkznLHQBGUPfS5Gge7rNzcQaX0LJT/
        OaM91KwV68lwlZi3Xxb9q84Hu5B0nn86DnOAz6Q==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr19755882wrw.415.1629831771809;
        Tue, 24 Aug 2021 12:02:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/Nq9ck+jffd623Tc7f2vLQxJV7O8vjvKSyxvbiu6imcb5omWNkifvBcdaBd6SM5xESLiGyg==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr19755866wrw.415.1629831771683;
        Tue, 24 Aug 2021 12:02:51 -0700 (PDT)
Received: from [192.168.0.103] ([79.98.113.31])
        by smtp.gmail.com with ESMTPSA id t14sm7449255wrw.59.2021.08.24.12.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:02:51 -0700 (PDT)
Subject: Re: [PATCH 2/6] dt-bindings: mmc: cdns: match MPFS MMC/SDHCI
 controller
To:     Rob Herring <robh@kernel.org>, Atish Patra <atish.patra@wdc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-2-krzysztof.kozlowski@canonical.com>
 <YSUDTSuNlsOmu/G+@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9423ddab-4635-ea15-7a9d-dbcf1bc215dc@canonical.com>
Date:   Tue, 24 Aug 2021 21:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSUDTSuNlsOmu/G+@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/08/2021 16:33, Rob Herring wrote:
> On Thu, Aug 19, 2021 at 05:44:32PM +0200, Krzysztof Kozlowski wrote:
>> The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller
>> without any additional vendor compatible:
> 
> I think the lack of vendor compatible is the error here. Experience has 
> shown that vendor specific compatibles are needed for licensed IP.
> 

In such case this could be:
1. a specific "microchip,mpfs250t-sd4hc", which
seems to be on MPFS Icicle Kit:
https://www.digikey.co.uk/en/product-highlight/m/microchip-technology/mpfs-icicle-kit-es--polarfire-soc-fpga-icicle-kit

2. or a generic "microchip,mpfs-sd4hc"

Any hints here?

Best regards,
Krzysztof
