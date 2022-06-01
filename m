Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C179C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 12:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353040AbiFAMrD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353086AbiFAMrA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 08:47:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103456441
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 05:46:59 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s13so1873110ljd.4
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyyhorHqYhRzxEyqIbi/Zswxz0+oi9F21Ok1yg1RhLA=;
        b=ZH9WrW/SwuFpI0VP8M8Zc+awMiZ94uKV8XXHRXo02sxphluQkud6/bWPTPeHxT6DYH
         +KlddEaCrGu4aFj3bipnxYbruluqtcgSmkck5dIl/2tbrvcMOp+vJS5CcD6a+yVITzb+
         nJr3OLE8xMQ6hncurf80YJ3Dx49D28uu1nkToksJG86y1qVvCeDrzqER9okktApqd0zI
         tW8Kqmzw4lp4BQnL8S2vFpE9wTC3adLGT+SB0eccRmww4tz3FSSk2sbg6kbRPTKPHE2A
         gSNctdP9b5staF+2bTWH4s8IZh1KdT2zZsSDh1LFzgNSBc1KcT203rI9fNR1HqsEOlc5
         LpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyyhorHqYhRzxEyqIbi/Zswxz0+oi9F21Ok1yg1RhLA=;
        b=2UOibYZWKZTVgDojHQFzbR/WcYhUjpdDl8s7Iv2PwKzq9kjHtOUk2GtrMBIbfIp/fv
         I2qqgR0sczOX1TpNiVwHVADj7k4P07JPYEXsJQZ4L+RKOxk+p3FQH0+CA6R9Hgbg06J2
         UXUT82ZVfa6qBQkvOPX9e9C3yWmUQcBTDat+9Fk17L3AmpHohQwoOsyv4ArXssrW4r78
         M22HDTmFupvuMv3u7bCeJdE8yxzYLvZ6uUUMf/gEcObMhMd/L0+gwasZ2ee2vq4k6jOe
         PQFRaO3rlbIoXN4qxK01SBvuv5v2LT3/9Zcow7DpvyKfiGzjAMPe3XPo6YANDBMrxel+
         3g0w==
X-Gm-Message-State: AOAM531JpT4BIscGgHXDMXLripBQvbKJRPjG23YFxxMIdXRh2XaGHQdn
        GX1jpvx3bENh7OE0DTFivLjPOxd3xuh19LOABYfFkw==
X-Google-Smtp-Source: ABdhPJwt9gvrgwBFEfOMg53Brjr6mPeHznMhGr3I+MHKcTP0xi6t5Xs94b+k8tX0FX5KWt8rkYMl56bGgfyVkbUqQnI=
X-Received: by 2002:a2e:9e54:0:b0:250:d6c8:c2a6 with SMTP id
 g20-20020a2e9e54000000b00250d6c8c2a6mr40059816ljk.16.1654087617409; Wed, 01
 Jun 2022 05:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220526014204.2873107-1-robh@kernel.org>
In-Reply-To: <20220526014204.2873107-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:21 +0200
Message-ID: <CAPDyKFoh5FyRDxr22XnkOd76MG4YjkvqL039=+qHGZKwfdFquw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Fix unevaluatedProperties warnings in examples
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hu Ziji <huziji@marvell.com>, Al Cooper <alcooperx@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 May 2022 at 03:42, Rob Herring <robh@kernel.org> wrote:
>
> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples. Fix the warnings by removing
> spurious properties or adding a missing property to the schema.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml  | 2 --
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index b672202fff4e..5ecdac9de484 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -75,7 +75,6 @@ examples:
>        sd-uhs-sdr104;
>        sdhci,auto-cmd12;
>        interrupts = <0x0 0x26 0x4>;
> -      interrupt-names = "sdio0_0";
>        clocks = <&scmi_clk 245>;
>        clock-names = "sw_sdio";
>      };
> @@ -94,7 +93,6 @@ examples:
>        non-removable;
>        bus-width = <0x8>;
>        interrupts = <0x0 0x27 0x4>;
> -      interrupt-names = "sdio1_0";
>        clocks = <&scmi_clk 245>;
>        clock-names = "sw_sdio";
>      };
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index c79639e9027e..aca1a4a8daea 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -56,6 +56,9 @@ properties:
>        - const: core
>        - const: axi
>
> +  interrupts:
> +    maxItems: 1
> +
>    marvell,xenon-sdhc-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
> --
> 2.34.1
>
