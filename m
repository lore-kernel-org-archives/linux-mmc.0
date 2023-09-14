Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B96CA553F
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 13:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbjINND2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbjINND1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 09:03:27 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E531FD9
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d8164e661abso1043416276.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696602; x=1695301402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VY9skImPihszx8GxXcwgYcsBPmwUbBo5w6++v0wJVXI=;
        b=ubCzLP/HTVma8Q1MlDogMtuy7DSzCJuHT7eo99Kzce6UzePg50AduD6K+UcljX9IBz
         auA0+PT/A+pTEYL6RUdaLTly9pi1BYmN1XU6DuXfJCzi0368waHuo5/3yHga4tPJY5lq
         Gx+fHJJg5qi+DaIr5qxQ9gMS/I4YdnfAHUI6SaKARcUv/CjxvYb0q60w3QjbLYtGcJpx
         P5rtWBi1b+CHk9usZPTsT59UV//UUioB8H5ipZzqlC8LmVbXLBsPrtMDF0tlcY3Ob5eO
         PibqeP3QLp0UU5OxoJdDNJhdN+DH7JgWaPXJfH7+UI/xusQJdeLYkWCC/bkOG+QGOjM2
         RnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696602; x=1695301402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY9skImPihszx8GxXcwgYcsBPmwUbBo5w6++v0wJVXI=;
        b=q60NyqeRGTHww1Gplo//hynqXDsJ6jgBBactG8rbrhz0jekURcLeK+LimqFH9kd7+a
         DBsbka7BOfOWhHXJaeVy4sm9RsdioWKG9r/PWHdbxcJhDnG21tvL1Mf4LdF85ZmbU4md
         HEbvTHPRkAAuItgNbjAsqWnKpwVIgPsTP/1B1ro6V/M1/gWw7pDWAZRGSIh9e15z7TmZ
         YLpXroRjQY4C8O8eXyKszjdHZfr2ehCayAhAFc2w2yltG/PWJmIA5o+aoAGlQHZqzJ7z
         x+Y+F6TCOAI3Q4B7rvBIkRgJfCB2WdILF77UtGSNXBBP/TcydzRJtWdw2q30YtZRDMys
         DwQA==
X-Gm-Message-State: AOJu0YzckmTCKOcYOgqB6iRzOMNM1F2RfpcVtuCpyzZzK8qAkLw/QY24
        PtFUUOrYOF19QaoTwHPWvqR19XhgVOxbsBou1V+NNQlttYzmk2fioUQ=
X-Google-Smtp-Source: AGHT+IGhL7zhq2NyFUv0GFZ1EHoIEM9qG3P/8d1I7taSbdB08lO26SnjWqkAjxlGUrXzLFlXprXfMv+HSjcY8jbLv+Y=
X-Received: by 2002:a5b:685:0:b0:d53:f98f:8018 with SMTP id
 j5-20020a5b0685000000b00d53f98f8018mr4870666ybq.65.1694696599947; Thu, 14 Sep
 2023 06:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org> <20230825135503.282135-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825135503.282135-2-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 15:02:44 +0200
Message-ID: <CAPDyKFou65jecQVAfe3yKjWqJ7S_maoReK0XA6vhHNsSRKf-Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: sdhci-msm: allow flexible order of
 optional clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Aug 2023 at 15:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The Qualcomm SDHCI controller lists optional clocks, but still expects
> fixed order of them and does not allow to skip such clocks if further
> one in the list is needed.  These optional clocks are truly optional,
> so we need to allow the list to have different orders.  The clocks are:
>  - ice: used for Inline Crypto Engine, which is actually separate block
>    and merging it with SDHCI is not a requirement,
>  - bus: clock for SDCC bus frequency voting,
>  - cal and sleep: used for RCLK delay calibration and required for
>    certain platforms for such calibration (as expressed in original
>    commit 4946b3af5e8e ("mmc: sdhci-msm: Enable delay circuit
>    calibration clocks")).  Only MSM8974pro has these clocks.
>
> Relaxing the order fixes dtbs_check warnings:
>
>   qcom-msm8974pro-fairphone-fp2.dtb: mmc@f9824900: clock-names:3: 'ice' was expected
>   qcom-msm8974pro-fairphone-fp2.dtb: mmc@f9824900: clock-names:4: 'bus' was expected
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 10f34aa8ba8a..69a213965089 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -85,10 +85,10 @@ properties:
>        - const: iface
>        - const: core
>        - const: xo
> -      - const: ice
> -      - const: bus
> -      - const: cal
> -      - const: sleep
> +      - enum: [ice, bus, cal, sleep]
> +      - enum: [ice, bus, cal, sleep]
> +      - enum: [ice, bus, cal, sleep]
> +      - enum: [ice, bus, cal, sleep]
>
>    dma-coherent: true
>
> --
> 2.34.1
>
