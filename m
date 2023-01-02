Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C47C63705
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 15:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjABPHa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 10:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbjABPHN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 10:07:13 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4A25D6
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 07:07:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b2so29758644pld.7
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTUmFVkUrVVxCdL9TmMtPvZBf8ZmBmUdQovn/cWoQSs=;
        b=J/y6pHrgolcr/idbq4kQIOcfdjv7wWo5IwW+rAF2hWtg6IUup6eb+dAOl5bprfzTbr
         4YCR/CoV4akoRP/v9fboVdUhWM1PZd8RCsUpSZxzkvLxUqEvL7Nxi4RElJMR6L+ViC0B
         ZkBFRlhQUYPeeTyaMalEBk1+/LsppkXpYNT5zOcYiC7wDQs5L7tb1rTNbESqCr6Fa/bG
         vCwjNkEbPpHFyWoCZ9VMA35E4OjiANdBV3XRgVMLUv0v98dYC50eQGUX93cILW5+2YNA
         KDrOfoea0dUcui8KrMoFzv8FXd8K/RF74tbj/ejb9k/dMDVHPxwUU2p6MX3nmqaVC3wv
         Bq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTUmFVkUrVVxCdL9TmMtPvZBf8ZmBmUdQovn/cWoQSs=;
        b=veQLMrR7uBh7bx00CqxTDqme1zcfI521iSWV9JfVjXi9d2qqe7H8exEc5P3HsQMGnI
         tctGglxKi7jJ+oRraTwE0VVSCZtIVmH+nWH+Fft8k1hF/c6Ht7QuqmGMvcBU/HkR7cMq
         nW7ztWja3+isRw6RPWUSH8yPWJX5tCjVcu+iL/I4zHEdMrJgJuXfMVBRcPEht7Ib3Gyz
         1P2KayS35PQpn9O9LJH4KcD24KKB09kJSVVNTYBkQzfQTRFiwyfOm3q937zaI/ZF53Ie
         tpN3c2rWXGceuDPxQI9ucyFIpDR1lVNGvM7RzIuHCJ0weGz//MWZUSAkowNsLbcyr0Aq
         90KQ==
X-Gm-Message-State: AFqh2krHolK6dUQ0OftlkI+UV1Kq9qTFXXkscEk0C42eY7ExbD/hE+Rq
        nbDe1Yt9X7ayLGEDeGPJ2tjbBSelHI7esKX/9ohSaw==
X-Google-Smtp-Source: AMrXdXv8OX9M5689SnQnaSGPrLdj9p5QLmx+kBVYmhnA495PZDaD/5bf4mxIVTxVmZLdRLzgkWlifrloH6WCSDERMeE=
X-Received: by 2002:a17:902:e053:b0:192:8d55:4599 with SMTP id
 x19-20020a170902e05300b001928d554599mr1260768plx.165.1672672032313; Mon, 02
 Jan 2023 07:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com> <20221213230129.549968-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221213230129.549968-3-fabrizio.castro.jz@renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:06:36 +0100
Message-ID: <CAPDyKFoO6pKqg2vN1fbaBE2y=1SJFJR6FByLV3Jm3r2cWR2p1g@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 14 Dec 2022 at 00:01, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Document support for the SD Card/MMC interface on the Renesas
> RZ/V2M (a.k.a. r9a09g011) SoC.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 7bfb10c62566..435773607489 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -59,6 +59,7 @@ properties:
>                - renesas,sdhi-r9a07g043 # RZ/G2UL
>                - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
>                - renesas,sdhi-r9a07g054 # RZ/V2L
> +              - renesas,sdhi-r9a09g011 # RZ/V2M
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
>        - items:
>            - enum:
> --
> 2.34.1
>
