Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48154C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266A9611CE
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhIULmY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:42:24 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:43969 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhIULmW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 07:42:22 -0400
Received: by mail-vs1-f54.google.com with SMTP id n17so19204386vsr.10;
        Tue, 21 Sep 2021 04:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOlfZTrSii7Nb14rl9dZd76xYIBrclWvgXtZcJh0XvM=;
        b=oXivQnx3c3N7ZaGmzhlOGE+RN4ji6nIuRM1zJaGRXlBpVWeGk2wjJkwAhUjezUhe0D
         n8M6mjXFZ2C64eWvnT63QZA1ccwZas7vyJ00DPDLFAHuPLtZLwTl4jT2irtxrgsqMgJP
         H0ncqJTeHlkFy0Z/D5OwYk2yfepdwGlNbAR2Rcr8YFAc0CT9Nb1f6qYO+VuBz4gUXXCu
         t31gnft4C6iMWwhnE5gq23FhOc4jbuANtJhHJvKyteh4OJ5bbouhqhVfuXGlhKZFE23N
         5xLeoTBThieRPc8m6/CSEngZVKYOtP5RWIqpm7p+k7JeMvu3M5a3A3AWJ9b8rjvwm0tB
         lG2Q==
X-Gm-Message-State: AOAM531yGCOYYjR0ZmJdls7sCKrBlGhG0ZwH8Z2dLvwo8iIKiw4MM3fn
        SKXIO/+qwRqdsRtMezxB2QhU1DdheibyGNIl3Yk=
X-Google-Smtp-Source: ABdhPJwiN7fv8zkCxGRdSiJIiixTxoRHMRXiLr8T19X9+fGqcKipwyfkQQaXHbvVsTR6Cg4anMFHRjlYU50G8LO/Lys=
X-Received: by 2002:a67:f147:: with SMTP id t7mr13834174vsm.41.1632224444687;
 Tue, 21 Sep 2021 04:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Sep 2021 13:40:33 +0200
Message-ID: <CAMuHMdU7HHEHAcn=vPqAPYPkgeywKqb-rL6YmDRH0+4XNw8CuA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mmc: cdns: document Microchip MPFS
 MMC/SDHCI controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Krzysztof,

Thanks for your patch!

On Mon, Sep 20, 2021 at 5:09 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller

Actually it's the SoC .dtsi

> without any additional vendor compatible:
>
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
