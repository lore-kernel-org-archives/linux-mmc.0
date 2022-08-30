Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177CAECAAD8
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Aug 2022 07:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiH3HHs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiH3HHP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2022 03:07:15 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01CA0253;
        Tue, 30 Aug 2022 00:06:53 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id q8so8061342qvr.9;
        Tue, 30 Aug 2022 00:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ITwwszw/aKvRC4QUlra1KMwI37gw38jd+sitfZHgE+0=;
        b=qnCIzUYIfPBcwmYBoEQgNtoazmccGugV4n9J6VOOEuQHHPuUc0OXhXwEqq1UskRkR0
         Z01Z8pjSVK2rCYKzO8Hka8pjJDsQsOUm/S8+y/3AO82+b8DOnv/g7ANu7p46b7Q02J8E
         KqcnxYqzecE65vl0VK+yjunqOaSmUzmK79y8OwuFWwgiIKn2RXBrUE4pHOJHzhNkv7Cy
         oZZvfivHkAzVYTogkNwBx2ogPjZuDImmB5JS9Y+9VJi+6sDIyX+QBJI12aBX9gu4L6AC
         dzMw5wR3dBzOHUk0OIQh6dP3eqpJjj/UlUZiiHS4J3TE16OgR6FcD/C9A6lyQ+kalIjU
         h04w==
X-Gm-Message-State: ACgBeo2GcyiabdDcy0z+y8Y3JsgFjXk/tZUvu+EIxe5HNRfkoleM//jh
        L+oVizCRa5Qr+rlwr+F9ki6O/0InzWhZkw==
X-Google-Smtp-Source: AA6agR7Hxf62pV7aiVBiyCfJImUtcWAaMVHFae55Uk/hL5Sevvc40RNHiZHZv7vsE7v5GzwPnoPthQ==
X-Received: by 2002:a05:6214:23ca:b0:474:8c8:4fdf with SMTP id hr10-20020a05621423ca00b0047408c84fdfmr13951516qvb.89.1661843212344;
        Tue, 30 Aug 2022 00:06:52 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id l5-20020a37f905000000b006af3f3b385csm7463761qkj.98.2022.08.30.00.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:06:52 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-324ec5a9e97so250949397b3.7;
        Tue, 30 Aug 2022 00:06:51 -0700 (PDT)
X-Received: by 2002:a25:415:0:b0:696:814:7c77 with SMTP id 21-20020a250415000000b0069608147c77mr10903068ybe.36.1661843211665;
 Tue, 30 Aug 2022 00:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220829214256.5583-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220829214256.5583-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Aug 2022 09:06:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVV6eEtWBaeG4VESe_cyPKYcTo-xSfwJDPLYOYCG=ZHug@mail.gmail.com>
Message-ID: <CAMuHMdVV6eEtWBaeG4VESe_cyPKYcTo-xSfwJDPLYOYCG=ZHug@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Add iommus property
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Mon, Aug 29, 2022 at 11:43 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The SDHI block on Renesas R-Car and RZ/G2 SoC's make use of IOMMU.

blocks ... SoCs

> This patch fixes the below dtbs_check warnings:
> arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb: mmc@ee100000: Unevaluated properties are not allowed ('iommus' was unexpected)
>         From schema: Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -77,6 +77,9 @@ properties:
>
>    clock-names: true
>
> +  iommus:
> +    maxItems: 1

I would insert iommus below dma-names, as iommus belongs to dmas,
logically (yes I know dmas is not used on R-Car Gen3 and RZ/G2, as
SDHI has its own DMA controller).

> +
>    dmas:
>      minItems: 4
>      maxItems: 4

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
