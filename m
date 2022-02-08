Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0788CC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Feb 2022 15:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351656AbiBHPNO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379651AbiBHPNG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2022 10:13:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544CEC0613CB
        for <linux-mmc@vger.kernel.org>; Tue,  8 Feb 2022 07:13:04 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i17so7844876lfg.11
        for <linux-mmc@vger.kernel.org>; Tue, 08 Feb 2022 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ul6586FcR2XNKw03Estem+L/2VYFh9q5OPSt2ipD/I=;
        b=lTtINBBOCY8o3GicRiibtef9ezSJryqKiDbXTVXhiO2U9dopVM6SL0E++3vEtiIRSj
         rS1GnQalBTA1I7lJodLcbsoS0D8ywNS8LVmOpinkajALmglHEsjWQLeK6m1aG+WnV66h
         jhXKV/qfDnWh0WQxPwSWLP+zzio3U73dP/HwllvT2QN2sInSJcvivIHrqiEEya9A9gdU
         yCuX+3BtSAbSAJIOSmXpFb+fGVM3+yZ8OWP7LwnT1gGlzChXv8v1qOxgMDNXjFIGgAiP
         HcUGwLco3iOmOwLrpa3SiOXc8rgDhaGZT6W10uP8KdICZoVXsFR4RecOTYA1dO1Tec2D
         0+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ul6586FcR2XNKw03Estem+L/2VYFh9q5OPSt2ipD/I=;
        b=mSLCbASMR+jz+Je9OqcQckZlrwSstxtE89vgKKDO5BqjfE9kub59kAhs3XpVte8k6f
         VeDgaRSAcHwhtZmsZNDd7r9O62j8li+vqZJ+Y7miXjLIHVNusZohUneEdcXxqXEhJNLJ
         G7hrIVjbXKkLpyNFeTr7DFCNE3Ku+RjqTrDOMOcLT5YR0/t2yF/+//dP6yc6PGIQHXPO
         AXSaRTWdf4AFM4pKBSY3ZPreaEsvN+PFW5BplbyX5IzydBeqk8aOkZtCKC4Qmv6V7T0K
         CNbnrPpvOcPTB0mK8LHD9CHbuKaSxro1H7bp8qBCrzh0T6T0IeLSNCnHf55p6BXRx1je
         lv+Q==
X-Gm-Message-State: AOAM532QAm/anJ/Djecnt8Mz4wiWV2ckqwX03KWiGm8148SZsBp1k0s6
        dKvbQmMs7VbcAE00n5JYViOe+tYTXnzwdmt72vlybw==
X-Google-Smtp-Source: ABdhPJwi6FPXFMyazeJ7i45pYAQSCW8A1BCRnS82xEFe9NN4cuh8Q4joFFexYDXE7e2Y5nmlF/FcS/EQkzm2rd08e2A=
X-Received: by 2002:a05:6512:3b9a:: with SMTP id g26mr3266780lfv.71.1644333182732;
 Tue, 08 Feb 2022 07:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20220203015112.12008-1-samuel@sholland.org>
In-Reply-To: <20220203015112.12008-1-samuel@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Feb 2022 16:12:25 +0100
Message-ID: <CAPDyKFoQzcD0gV0fXU=FyzTqQfLoTuDWhMrUaRPGYqsD7Spq8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sunxi: Add D1 MMC and eMMC compatibles
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Feb 2022 at 02:51, Samuel Holland <samuel@sholland.org> wrote:
>
> D1 contains variants of the usual sunxi MMC controller. The eMMC
> controller has the same parameters as the A100 eMMC controller. The
> other controllers have a DMA address shift like on A100, but they have
> a smaller 13-bit size field, making them a new incompatible variant.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 4f62ad6ce50c..94e2c6c4e4b7 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -24,6 +24,7 @@ properties:
>        - const: allwinner,sun7i-a20-mmc
>        - const: allwinner,sun8i-a83t-emmc
>        - const: allwinner,sun9i-a80-mmc
> +      - const: allwinner,sun20i-d1-mmc
>        - const: allwinner,sun50i-a64-emmc
>        - const: allwinner,sun50i-a64-mmc
>        - const: allwinner,sun50i-a100-emmc
> @@ -49,6 +50,9 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h6-mmc
>            - const: allwinner,sun50i-a64-mmc
> +      - items:
> +          - const: allwinner,sun20i-d1-emmc
> +          - const: allwinner,sun50i-a100-emmc
>        - items:
>            - const: allwinner,sun50i-h616-emmc
>            - const: allwinner,sun50i-a100-emmc
> --
> 2.33.1
>
