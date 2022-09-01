Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F15ECAAD1
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Sep 2022 10:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiIAKct (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiIAKcs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2022 06:32:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0812484B
        for <linux-mmc@vger.kernel.org>; Thu,  1 Sep 2022 03:32:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b26so10493051ljk.12
        for <linux-mmc@vger.kernel.org>; Thu, 01 Sep 2022 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZXVAap/RQrEllx7GHmHFEmTUCY+2JbnwMtDeiKRHfQ8=;
        b=Dhp+UYVqpfFeh+jDqzEIVKnoKF7JxN/03AsLCTOUMgF8GcAn6Ch3lv7LeqCPXQKl+w
         mnc7afdTf2olu/Dsh7tqSXvjEofGX/mfpNqZlPHUtutvzz+oOQQEHqxXi8KaEHRdTios
         D2olRqF2FvB2dZtP2+ZAuWQIKpYYqv3RWn2ILqHvhQoJK+SiOLyVC8LpGt2zi+GN4cgD
         BuJRqt794voF/gu2V68Qq88X7FxsK+u0VUAnJfOfrI2JjbX2gSTzBpNBqQq5Q8d5nuaA
         5WKRSjE9z1bBCVukE+iSE/s5V+duh/l7eW03rRDCG1+dEZ2QlkM6WzSw85o48R4/8o+M
         Y5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZXVAap/RQrEllx7GHmHFEmTUCY+2JbnwMtDeiKRHfQ8=;
        b=m7Q6WHcZ4BECqMs2izwIVWXoEC0vFgGUDMNpdIqFhrx3WnV8lr3mC/n+r4HycqvHaP
         kfgQvJqcHFPFRK8sSnoRv4HYEQFO4m5PM1r357mbxdIZec5iT7dOJWtjdBxkgHG4C+S/
         /DiN83bBFCd1LbPBPi41hRJODRXiJ4bbLYlKoWfS+7cnfLvXixeQ4A7t2vZCiE17aklx
         anceu++HkBfjoTi5mTnOqVoP7K7KkBU/NH5aj4C7JucfhkIsUc0xZ5V/vDMuIVjwkjQq
         HpqxTAqyrwqjpmmGSmZzkT9YDbu8u/+gdEUJ8CEexU70N4OQBkj0lgfHxP4Nx8nnedI6
         ap7g==
X-Gm-Message-State: ACgBeo1rIxlEjHT0XzyzdSnxBOxikc+F/bBxECwg0xkdntG5kMhIygjE
        /00QODb4jirjgus6OvHIq9S6Ge8pty9dyyFL8lMpTg==
X-Google-Smtp-Source: AA6agR7mNmum3u12wn3ZgEHjcazZ/nYXQByxwmYoXxhjxe9BEdBb/1ct3OBV5/pl3brFfdAY/MsAgwYyy+RX0B+CEP8=
X-Received: by 2002:a2e:9799:0:b0:261:e51d:8576 with SMTP id
 y25-20020a2e9799000000b00261e51d8576mr10441111lji.367.1662028362375; Thu, 01
 Sep 2022 03:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220831214314.7794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220831214314.7794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Sep 2022 12:32:05 +0200
Message-ID: <CAPDyKFpsQwB97qqR6otk6VuyWF3fk+o9qh3tbxrme8B_oENnuQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: renesas,sdhi: Add iommus property
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 31 Aug 2022 at 23:43, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> The SDHI blocks on Renesas R-Car and RZ/G2 SoCs make use of IOMMU.
>
> This patch fixes the below dtbs_check warnings:
> arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb: mmc@ee100000: Unevaluated properties are not allowed ('iommus' was unexpected)
>         From schema: Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1->v2
> * Moved the iommus property after dma-names
> * Updated commit message
> * Included RB tag from Geert
>
> v1: https://lore.kernel.org/lkml/20220829214256.5583-1-prabhakar.mahadev-lad.rj@bp.renesas.com/T/
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 3ea94d842c33..79dcd5f16a42 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -89,6 +89,9 @@ properties:
>          - tx
>          - rx
>
> +  iommus:
> +    maxItems: 1
> +
>    power-domains:
>      maxItems: 1
>
> --
> 2.25.1
>
