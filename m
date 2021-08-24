Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C3C4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC09610C7
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhHXO5x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbhHXO5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:57:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F642C061757
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j4so11277083lfg.9
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66Nr9cfWRLjl+l/VaDJPhMnvKpMeK9HDiQZYQNyEOxQ=;
        b=WyWjr7on/dLv0JuqVzpGqlpiGngQhRG6oXHi6kqQiJRVT57Folkq3XbCjPRnzr0RMq
         3+1YCcao/7RDdsY3jRzPPVfv9BqGeCA7gca0YxRV+1rusPhovzjDOMKlTQQCjGEy6I+B
         k1eHxh+Nc2Sh6oDKoNQxq0M/Lzd2hQQcqc1M7s1nOElhMKZ8rnEgeOR0jj+E+rVgicnf
         k/KepYkenxL1EocPZjjaDm6Os9TktopF9mIFxCC/x9YfuaL7HQ/ExAncFTwDo0TU9eTI
         1hkBKjkxHgL/du4i5djxtJnqAQHX90kVjCJ9wGSBAhVtKCnZ+HFxtb3mFUItFqXQouMY
         r4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66Nr9cfWRLjl+l/VaDJPhMnvKpMeK9HDiQZYQNyEOxQ=;
        b=JnVBuICVg24BOgTIvlXFgTTE+RSqVncpC5zODxlAmqvepPB+caApoVCuH4FEktsoo5
         K27rEq4qtCo4PuZttNXHFH6Grn4biv4QZVpTDvodZjhRqsnEzn2nv5ExW7pDGDvJdmbZ
         c9xhx8E1wrM+7qddumW9M81Q8UF9gvB8cUUbCnORWHkb5bVGFggcQv9LjKpfkXnL0ScE
         GpIQoKF1Lf7SgkWTno6kUjQCI8YHYLANcp8czlUtavEQK8+HZzNbxjjtymtYaTDLKWYJ
         EulpJAybMYWhuo8aqULjEaTO0/946PLb4bGW4+mdA8YkmRPvJUqL4LJDUSbx5T1+xlab
         sm+w==
X-Gm-Message-State: AOAM533caXPgc4Wdo5u4KB8yQ5mx0SlfI4MfhsyFEmTydoSw29DqFrfi
        lmFdzfUzsGam/wlmkowZsVFcJpxDdS0DnHiBtBPaWSkgphK2gA==
X-Google-Smtp-Source: ABdhPJztWj6Zah9h6x7ZemArdgM8oqu2mVNIyCXtmL1d0aTqWhgNIaI/271g56lSQZnptFJOyg7XxN5tijzA1YTBab4=
X-Received: by 2002:a05:6512:ad6:: with SMTP id n22mr30706458lfu.532.1629817027412;
 Tue, 24 Aug 2021 07:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210817090313.31858-1-biju.das.jz@bp.renesas.com> <20210817090313.31858-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210817090313.31858-3-biju.das.jz@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:31 +0200
Message-ID: <CAPDyKFop5B1eZyrg3Q=h_RYRJPuFk7XCSm-sfn+wC1Q=LYz9cQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: mmc: renesas,sdhi: Document RZ/G2L bindings
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Aug 2021 at 11:03, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Document RZ/G2L SDHI controller bindings.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v3->v4:
>  * Defined clock-names for RZ/G2L SoC and make it as a required property
> v2->v3:
>  * split the patch into 2, first one for fixing dtbs-check issue and
>    later one for documenting RZ/G2L SDHI bindings.
> v1->v2:
>  * Fixed dtbs-check issue for RZ/A{1,2} platforms.
> ---
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml | 73 +++++++++++++------
>  1 file changed, 52 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 43584f4f4c7e..9f1e7092cf44 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -44,19 +44,20 @@ properties:
>            - const: renesas,sdhi-mmc-r8a77470 # RZ/G1C (SDHI/MMC IP)
>        - items:
>            - enum:
> -              - renesas,sdhi-r8a774a1 # RZ/G2M
> -              - renesas,sdhi-r8a774b1 # RZ/G2N
> -              - renesas,sdhi-r8a774c0 # RZ/G2E
> -              - renesas,sdhi-r8a774e1 # RZ/G2H
> -              - renesas,sdhi-r8a7795  # R-Car H3
> -              - renesas,sdhi-r8a7796  # R-Car M3-W
> -              - renesas,sdhi-r8a77961 # R-Car M3-W+
> -              - renesas,sdhi-r8a77965 # R-Car M3-N
> -              - renesas,sdhi-r8a77970 # R-Car V3M
> -              - renesas,sdhi-r8a77980 # R-Car V3H
> -              - renesas,sdhi-r8a77990 # R-Car E3
> -              - renesas,sdhi-r8a77995 # R-Car D3
> -              - renesas,sdhi-r8a779a0 # R-Car V3U
> +              - renesas,sdhi-r8a774a1  # RZ/G2M
> +              - renesas,sdhi-r8a774b1  # RZ/G2N
> +              - renesas,sdhi-r8a774c0  # RZ/G2E
> +              - renesas,sdhi-r8a774e1  # RZ/G2H
> +              - renesas,sdhi-r8a7795   # R-Car H3
> +              - renesas,sdhi-r8a7796   # R-Car M3-W
> +              - renesas,sdhi-r8a77961  # R-Car M3-W+
> +              - renesas,sdhi-r8a77965  # R-Car M3-N
> +              - renesas,sdhi-r8a77970  # R-Car V3M
> +              - renesas,sdhi-r8a77980  # R-Car V3H
> +              - renesas,sdhi-r8a77990  # R-Car E3
> +              - renesas,sdhi-r8a77995  # R-Car D3
> +              - renesas,sdhi-r8a779a0  # R-Car V3U
> +              - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
>
>    reg:
> @@ -66,15 +67,9 @@ properties:
>      minItems: 1
>      maxItems: 3
>
> -  clocks:
> -    minItems: 1
> -    maxItems: 2
> +  clocks: true
>
> -  clock-names:
> -    minItems: 1
> -    items:
> -      - const: core
> -      - const: cd
> +  clock-names: true
>
>    dmas:
>      minItems: 4
> @@ -108,6 +103,42 @@ properties:
>  allOf:
>    - $ref: "mmc-controller.yaml"
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,sdhi-r9a07g044
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: IMCLK, SDHI channel main clock1.
> +            - description: IMCLK2, SDHI channel main clock2. When this clock is
> +                           turned off, external SD card detection cannot be
> +                           detected.
> +            - description: CLK_HS, SDHI channel High speed clock which operates
> +                           4 times that of SDHI channel main clock1.
> +            - description: ACLK, SDHI channel bus clock.
> +        clock-names:
> +          items:
> +            - const: imclk
> +            - const: imclk2
> +            - const: clk_hs
> +            - const: aclk
> +      required:
> +        - clock-names
> +        - resets
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 2
> +        clock-names:
> +          minItems: 1
> +          items:
> +            - const: core
> +            - const: cd
> +
>    - if:
>        properties:
>          compatible:
> --
> 2.17.1
>
