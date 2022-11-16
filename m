Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B77BC43217
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 16:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiKPQSY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiKPQSL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 11:18:11 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F9657B6C
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:09 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f3so10698486pgc.2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+6kofWK+lAk9nYMdFCTFYyZyxlN1y4m9eqx3Qu6bH8=;
        b=J6QmENGbkz8JaelIwNWSJ8l299ttLiHNHQJbCutNLWXPp7HMamJ0nxlXFphKb5OFaC
         cNygK5/QTbSUGOeFzpo0kXYYztKZpAwspryVy6TEKqFcPFI9jDBBSb8CZ5ucaBTQzqom
         w1ckAJmV0OkD0oeTRLj3s8GjRwb7D7gq95HJwGYtjybJzDRUnVPNwr+JSFEBlchYhAvK
         LGJK8+IKVMPEkojNgT7uG9WNA2Iq//VYKMFaCjp/+FFRlT4oge1JJCGlm6t/+2Vq4mvA
         TmEBOpYcrquiRPrwE0C57a3LkkFXOKaDSsxk25BkjvxyXaUlmJXwp8x6Ul39kX8wkHQG
         RMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+6kofWK+lAk9nYMdFCTFYyZyxlN1y4m9eqx3Qu6bH8=;
        b=nev+yzCB9XGlCcBj913WzNCuJU3jYqJKW1ckbvpwdaNqywPg5pxLUEeD/FHTdUCNux
         vobuJx194SEP0D4dxx3eyYYg8xYKo68m4UWhwYTK4SJjtx49w0eDEqGIKZFgEkDj5fZM
         2lzmv30RkWgGodpdSFjETd/t1jGX0gdyyIy6JSVf6v0Y1srAW5DadLS/+YTC9jf1UysD
         5+L8ak2E5O1xJiFxsLZMhfbi50wu93H5jOjq4dSTQTPW/6T5a+jNmQJT5kXdil1jiEUK
         4di096js5v9+sgWGWsfSCGZM3bxao1EAJSFPGKwhlw7zRFpHJRIz2R6d8YdKmfgwpBPC
         +QsQ==
X-Gm-Message-State: ANoB5pnKtGoa08IyS4rKv8EviJAp7tDUeGwrt/qNVZD1xyEwo1lAdDp0
        rYaK2p/K0YKV9R5xl+U7FTy1goaXW+vDBCJ1dENlBw==
X-Google-Smtp-Source: AA0mqf7Yk01flNfOp6SxymOc+XEuglm7jqex2dsSPKvWtWPa80gI4EKbAlDuk8r2R4WzOyG+XpbjS2afb54fviVWB8w=
X-Received: by 2002:a63:db03:0:b0:470:4f30:f743 with SMTP id
 e3-20020a63db03000000b004704f30f743mr21500123pgg.434.1668615489044; Wed, 16
 Nov 2022 08:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20221114105043.36698-1-konrad.dybcio@linaro.org> <20221114105043.36698-2-konrad.dybcio@linaro.org>
In-Reply-To: <20221114105043.36698-2-konrad.dybcio@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:30 +0100
Message-ID: <CAPDyKFq391+dvG-R=5S7RkW03hWvP2c+WEAvYLPhaoVUasm1VQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: sdhci-msm: Document the SM6375 compatible
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patch@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Nov 2022 at 11:50, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Document the compatible for SDHCI on SM6375.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> No changes in v3.
>
> Changes in v2:
> - pick up rb
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index fc8a6b345d97..12def0f57e3e 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -46,6 +46,7 @@ properties:
>                - qcom,sm6115-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
> +              - qcom,sm6375-sdhci
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
>                - qcom,sm8450-sdhci
> --
> 2.38.1
>
