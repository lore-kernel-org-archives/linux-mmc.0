Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C1C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC04761090
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 17:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbhIWRCf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:02:35 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45619 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhIWRC2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 13:02:28 -0400
Received: by mail-ot1-f45.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso9348839otv.12;
        Thu, 23 Sep 2021 10:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=teChl1p/4EMf/WJShh1OZqgp3XvJdJ2naYCzMZiC37o=;
        b=RLEacuAHRsp768RPx92WvEr2SEJBscQLtW0aPE6Z1plDoboGKaR8bRRYh96gMn8SEU
         /INbNrgGBzVxNgcL5Qd7ijNjWVV+GEkcNMM+Dd0vjiOimypl0BlxbitYWwPqGymhLhu9
         mz7odZ7XJVp4zUMMPjpm8uZCeTDXuB1iKmNmmMkAJqtPPjaS6jzx3QrNlJS6nspQZoSy
         ktAL7dpbUQDtOO+iCTixwm2DlomFXm2qd4yLJHNoRQEguZLA6W7WX0oUNhwyXQlbhk+T
         Z9tKWVgj4RACljvsIPdwHSWkOwEn6oEpivXvqYs/CK9CC/ECM5lEyXe7qkc3gZuTpkAY
         mixA==
X-Gm-Message-State: AOAM532PRG6Zy0u/JapusXm8AcsGoUZPCyCWgP1Xg0x00nSX0Y1JmCsv
        2sjEDDHtX+ILM7r4Q2/siQ==
X-Google-Smtp-Source: ABdhPJzXw4Li/gy1lQs5OZieCWa6v8RMXxRDhEjXwGNg0aY+aGwWH4bmhcug7/5x6TS/we6PGqeLBg==
X-Received: by 2002:a05:6830:70b:: with SMTP id y11mr5409347ots.281.1632416454512;
        Thu, 23 Sep 2021 10:00:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 65sm1444412otc.32.2021.09.23.10.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:00:53 -0700 (PDT)
Received: (nullmailer pid 3171462 invoked by uid 1000);
        Thu, 23 Sep 2021 17:00:51 -0000
Date:   Thu, 23 Sep 2021 12:00:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mmc: cdns: document Microchip MPFS
 MMC/SDHCI controller
Message-ID: <YUyyw2AheXxDCAN1@robh.at.kernel.org>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Sep 2021 17:08:02 +0200, Krzysztof Kozlowski wrote:
> The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller
> without any additional vendor compatible:
> 
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v2:
> 1. Document vendor compatible instead of dropping it.
> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
