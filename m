Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C90CCA473
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 17:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbiFORd7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356203AbiFORdM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 13:33:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C40AE034
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a29so20031547lfk.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUgb1Pe+Veiyc1nTiM+3RHjRjGi5/SPESrYXTvlvRXM=;
        b=lpR1a6RXGTDYt15+E4r+yT/00L0A4FILcJrq9e4gJPPiJGz8QAfETf2g5D6di8fvHn
         J7GYA5sGsmbXV1u5SNJL5nWEPhzVX9ZXAjWr5VcvJQ0QBm3w638+rgeLfqMyuZUP5CRT
         r9SPqKoElpgdab66HMhgghETs7CMYZtopX0XmpOttnoAR0blC+IH5taRCOCMo4iB/KoE
         qUUzUvsG3ufiyzwVJK6NnhM84AON/2kpAlzWNHC3BSqlk7afGRPSo17RXmbHzkXIoRYt
         7XYKtBjLhYjNOkRgR2MCdY7hGcXJabBbejZpsZgZMup2oxjIiJOlOwjYl5DnMbmO/jBX
         kHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUgb1Pe+Veiyc1nTiM+3RHjRjGi5/SPESrYXTvlvRXM=;
        b=T6io7wRXrOkcYRDtidoq94F3CacX9k9iFXnoggv/LkdLJgPcIqENsE2Fa4K1XDKbmi
         92rCw91CPMpxD37WLRYYpNWQVfuZHQaNO28NLrBcBxolN/622SD0WmfjnE1Akoldm+wQ
         LQ0mlTVfp05gOpp+rMUs865iyn6G3tFdTjTmTxSrwMoXJHYOfKtuFHOI7zVxlftxLkBC
         eMLwGfz8icQUQFtohPxhdFWMgPAt1+d0fWOFuy3Bd+zK+b1v9mSzieksi3/jtrDpQmkf
         D1OALBSNEAW+hGKaYlGXz47Yjtloaim7ZO6aTJVZUfsOr1JoRHORca4qh/6mrxoe/TOp
         5GIw==
X-Gm-Message-State: AJIora9bQYjeu4PdmqMTiVUwIpQ4Bghf31REndjS3OmoH7mqTJclV3il
        27lOom5Iv7ZaiE0gCqXlIYz9H4+LinOmyLZN7tVjCw==
X-Google-Smtp-Source: AGRyM1uzZT5qbrIVqoqKo8NrzQAAiEbammbNVYH24ado8DrBIjHZ7ZONn86vPSD9rtjZsUL6eGAog6NNERQEcawmriM=
X-Received: by 2002:a05:6512:303:b0:479:1baf:7e5b with SMTP id
 t3-20020a056512030300b004791baf7e5bmr348682lfp.184.1655314386647; Wed, 15 Jun
 2022 10:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220608094831.8242-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220608094831.8242-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:29 -0700
Message-ID: <CAPDyKFqFuZxeGcrBQFL3KM4o4rTSqEQkmW_9YuQ6Fm5pUZtvHQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: R-Car V3U is R-Car Gen4
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jun 2022 at 10:22, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Depends on "[PATCH] dt-bindings: mmc: renesas,sdhi: Document R-Car S4-8
> and generic Gen4 support" which is already in mmc/next.
>
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index b46a90eb2063..d5b29728704b 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -56,13 +56,13 @@ properties:
>                - renesas,sdhi-r8a77980  # R-Car V3H
>                - renesas,sdhi-r8a77990  # R-Car E3
>                - renesas,sdhi-r8a77995  # R-Car D3
> -              - renesas,sdhi-r8a779a0  # R-Car V3U
>                - renesas,sdhi-r9a07g043 # RZ/G2UL
>                - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
>                - renesas,sdhi-r9a07g054 # RZ/V2L
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
>        - items:
>            - enum:
> +              - renesas,sdhi-r8a779a0  # R-Car V3U
>                - renesas,sdhi-r8a779f0  # R-Car S4-8
>            - const: renesas,rcar-gen4-sdhi # R-Car Gen4
>
> --
> 2.35.1
>
