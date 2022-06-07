Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E54C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 10:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbiFGKoa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbiFGKoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 06:44:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5B6898D
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 03:44:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a2so27669344lfc.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oldIK4x+0l/Bv7OoKE6IDpTyHYosL/5Va89KOtvyPN0=;
        b=sdSbJGbW1OUJvXPvD8Q9Hy5IA42Qek4A5YuRNjE8ookhoq+Z2IAwImXwP49rWgD9SU
         Hqsj+WzN80ZUlUVCvYiTLy84llXtk+/Aho3Re7A88Vzpw96Wv2fMCFp+iCC0JMTd5snp
         9cmBizKTETYF+QSAQ97VqAE1Rjr3r8bT4R2AZvAcQdSfZl0WzvxI9JtzNqX5ePIc8gxj
         ShaCHsx22gOPo67BpDkIiKCD4nmLzFTsAtc9q5D6+5hwZJ/fW8hz8CvquGsZamyANBfG
         Kn6QAf7oI9jlGmRubPGC9ThRM0EGIzsoQsLgPeO1TTJatbrqihzY50UTKV5djIboTX/t
         UFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oldIK4x+0l/Bv7OoKE6IDpTyHYosL/5Va89KOtvyPN0=;
        b=b0ugojf8GfhLzInyh4V3nTI51v7FmFiy0JL+SB5CaNLU4gWfBeYO/VOLjzsoO4R7zS
         tRmMlL0C5LbkmJmoksBNv/UViJi+IFafbAPtdSWYjIGv4l2aiyvJYkL9RZsdlPR5K9GR
         /mEusGX0hvi68GWVCbVuE6OkADQWH1Pk6+UkcjmybEt8CIi8Ngu5BstLb/gNrPEd1cae
         dEu3QtEwA+gkzJmOr1LFboGPcvDZcOpyHadrX0CIJJLl3gQpJ6DwMGDaYPw8m0aAc+zH
         dUU8JQnY3afSkXSzI5pHHW18CMsimXe/+C0+Bv3eIE2EK5qpd6hIhNF9yXuP8hSbRi74
         RTqw==
X-Gm-Message-State: AOAM533AVH2kJh5ZOVcNtjuQIQ0a6XvInS3JezhKKDIPJidbMGCySOqw
        gnVVhiGLPrVh1hIP4L3f1O3Uc0jnpmNjyQr1wXUIpiVl1k0=
X-Google-Smtp-Source: ABdhPJw8xKe/6musFxtIt/kptw9pdvrPuaN8AtcTfG6jYGUVqCbiWhCGQ5tX61Q3upwDXaY7xQ+Bq9LVDyiHzOqOGeE=
X-Received: by 2002:a19:ac42:0:b0:478:593c:e6fe with SMTP id
 r2-20020a19ac42000000b00478593ce6femr17809585lfc.254.1654598653115; Tue, 07
 Jun 2022 03:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220603233810.21972-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220603233810.21972-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:43:36 +0200
Message-ID: <CAPDyKFpr_XYj7R=ofgh00jyKi__3k_m8zmFMJYfcfnM5Z_nLGw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document R-Car S4-8 and
 generic Gen4 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 4 Jun 2022 at 01:38, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 9ac4986988c5..b46a90eb2063 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -61,6 +61,10 @@ properties:
>                - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
>                - renesas,sdhi-r9a07g054 # RZ/V2L
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
> +      - items:
> +          - enum:
> +              - renesas,sdhi-r8a779f0  # R-Car S4-8
> +          - const: renesas,rcar-gen4-sdhi # R-Car Gen4
>
>    reg:
>      maxItems: 1
> --
> 2.35.1
>
