Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDBEC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Mar 2022 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiCANyW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiCANyW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2022 08:54:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1D457BE
        for <linux-mmc@vger.kernel.org>; Tue,  1 Mar 2022 05:53:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f37so26923359lfv.8
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2022 05:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpS3f8EZoX7R2KAuz/UX0/xqwonI23q4hXHZBWApjxE=;
        b=YFJelA+ENY4EZJiP/YLHJkzoR5u7rW4E0VfzaZ8Q0qZfr9TB0HgZJOE/d1MySMcgPx
         Jf+/ZYCNvUoklZvkkIO9N8lnHCWaTxSd8Q/pfuSrwkZ31qj3uG/pBlU9hdB+FzzO1Bqa
         lmSYkKdaVatqRi/v1os1vNgdcFtMMHkJrbetMD5nmxughc6Duj/ZLysburORm04pujaU
         KZ1c7AyHGaDdC2fiLVz2VW+6SuRKZ3aGBHWXCdBU4CixGrA1OgBDOh/0wyOh9VhPVWZH
         Alx8GWnHSK7hg1IbTKx8yzgr5et49ZSuE6bwTPoZU9wBDc7ko43DeEneBxLzc4NHCR6U
         DfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpS3f8EZoX7R2KAuz/UX0/xqwonI23q4hXHZBWApjxE=;
        b=H+NlJjvtyCLzbbV9WADFE2C4QblrDiMQOJpohYYRsWGjU0sw/oCR9pBdvNDq52saci
         TS4KB2Wpe3TANewDtu4ZqlH97Xcil8AnIMpwT9jB2KtEBZuqeob7w4ebTBNQLYAp9HnO
         8jTRHTtzlJ6tdiZRBG0iGBrY5Pltgt1YkGDo+NuREpN7gGfRPTmyGymgE+pSCFbCU7l1
         +tm8iKnDNIlOWKh0VDLOuxg/W39eVNjbCfdmnDyupRtYwBp3GWcXjFtPrCZremZo0kuz
         2QRzxFZUywKSM5ir21mbzVReMk8yGoxCT8ZURubqdJrzjb1tseQFB8ymvPJx/fU3wneM
         F9dA==
X-Gm-Message-State: AOAM532iHIAiD3UJRrmLmKcbNAhTXjzmqTbKGxGbCiqMRm/maH8hxRxX
        3k4UT74Oc1rCilp9OcnIAwJr5lOQh1YlGPdc6wndLA==
X-Google-Smtp-Source: ABdhPJx0SoaiuulrB+NSo+UFoD6svkfCdOGBHeUCADEpXekaO/ti4K9CDSati5FTR+FCN4cJpmdhK9sgH1YngXvfez4=
X-Received: by 2002:ac2:44c1:0:b0:444:18fc:8389 with SMTP id
 d1-20020ac244c1000000b0044418fc8389mr15500530lfm.167.1646142819499; Tue, 01
 Mar 2022 05:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Mar 2022 14:53:03 +0100
Message-ID: <CAPDyKFpgG-P8Gtb+ww3YeO8jyjuNhKtjk=bePz=3qcf-37fsvA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 27 Feb 2022 at 22:23, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Document RZ/V2L SDHI bindings. RZ/V2L SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> DTSi changes have been posted [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 9ce6e06c19db..3b191fb89cf1 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -58,6 +58,7 @@ properties:
>                - renesas,sdhi-r8a77995  # R-Car D3
>                - renesas,sdhi-r8a779a0  # R-Car V3U
>                - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
> +              - renesas,sdhi-r9a07g054 # RZ/V2L
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
>
>    reg:
> @@ -107,7 +108,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,sdhi-r9a07g044
> +            enum:
> +              - renesas,sdhi-r9a07g044
> +              - renesas,sdhi-r9a07g054
>      then:
>        properties:
>          clocks:
> --
> 2.17.1
>
