Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FF4C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Mar 2022 10:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiCQKQ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiCQKQ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2022 06:16:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913C8DFF83
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 03:15:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u3so6639064ljd.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBJNQVwMyLBs8lLLZ+phXdIS1BZRlnyigKaYZzIPGus=;
        b=ZrFqjnS8CKuQDGyyWGOZxHY0dGaUnHUw9IrhHx+mGdrVp9Z/v5mQOg4A/OmMPxsD9+
         gQbMkSOAZTYsrKOxBBcT1OFivH9Qu8cr/eScxhBZB6FsY0Nugc+3Fy0sPIZTWUHg9zGy
         T2eFPO8ju7YBrDfOwhUZqPDQluCD5HcNRftCCYIBLKibbgSPObkpQtx61uZYb31vceUd
         Tr8Ah6tvAhRcrzhAmYmqPbMlC3McRihY8SgCMMf97Sy0skRr9ZDLQIW6ycO7InxovhaY
         yeFqHg2wY4brCSvwZPUbAEeKOF4bDZsmVInJVGhZzsp1lvINlMPckA0vyNxer+0N879q
         vWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBJNQVwMyLBs8lLLZ+phXdIS1BZRlnyigKaYZzIPGus=;
        b=TVJ4PmGLCBZAJrvO7a5fdE3GROpjNOyHVu9otNer0Jm5/hVekZ8cA4eD9q45K+kKzP
         iQtpxZGgk0RZg5l2mWd/9hH2SFM7LdPs/wCWm2fn2vA5NpbEpM9UTLmwXIYMF7i/UKUb
         m7HC2LG5uctB9Wx3Zv4bTt2fKoOA380H9EN0Sle34B3VzrffK/8F62ZQq2hqbJwW2mG5
         9n/a2tWtLggu9896LwyI4fHMKcJg9Rkhe/wA2xtgLG9mGGv+1y4Jfqdn+Nq1Q+qfpdTF
         nbnep+pdWjeZOPJ+GgqGnLkYbQkj24iT3FRcIJEy4UU5xKD8oFFGbsQM21DQWgRKJlHF
         RbkQ==
X-Gm-Message-State: AOAM531BIM4P+4L9pR563tc/tLsEO9W11Y5NTu99Cv9qf6l1AHeXuUBM
        PJnMAXjB5TU0KDrFCqpakooZFfjGGdpLCHfzAIDvDQ==
X-Google-Smtp-Source: ABdhPJzMAlFb6clniGiYBXS5RvYGVXflZX6StQiwUqd7rEWmCRagcg/bgKr+R6rvw17Siwuf39WjLbMxfMx2e9HTTg0=
X-Received: by 2002:a2e:890e:0:b0:249:295a:eb40 with SMTP id
 d14-20020a2e890e000000b00249295aeb40mr2376622lji.463.1647512139862; Thu, 17
 Mar 2022 03:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220315153258.21097-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220315153258.21097-1-biju.das.jz@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Mar 2022 11:15:03 +0100
Message-ID: <CAPDyKFpLVsNjuWX-5sketEw-j4nbgVpUY8qvWKBjDSXPG4Sfwg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/G2UL SoC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Mar 2022 at 16:33, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Document RZ/G2UL SDHI bindings. RZ/G2UL SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 3b191fb89cf1..9ac4986988c5 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -57,6 +57,7 @@ properties:
>                - renesas,sdhi-r8a77990  # R-Car E3
>                - renesas,sdhi-r8a77995  # R-Car D3
>                - renesas,sdhi-r8a779a0  # R-Car V3U
> +              - renesas,sdhi-r9a07g043 # RZ/G2UL
>                - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
>                - renesas,sdhi-r9a07g054 # RZ/V2L
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
> @@ -109,6 +110,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - renesas,sdhi-r9a07g043
>                - renesas,sdhi-r9a07g044
>                - renesas,sdhi-r9a07g054
>      then:
> --
> 2.17.1
>
