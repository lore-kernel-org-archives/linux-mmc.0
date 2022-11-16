Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A3DC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 16:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiKPQS0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiKPQSM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 11:18:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BC95800F
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v17so16878704plo.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BnBRD6c/pX6ypoX/gi2HqNrM2T85pThvuR/lc4jGdSg=;
        b=TrRAuR3v3tTbZUGEzzZ/YO6UxjEY81sW+W+VOJq+UMPXHSLD+DGLqizA7d2+a8/aNL
         TXZapSk/36WNFP0oueYZERI8SWx6b3ab/XH5+Mj00Kz6L1WZEwKOYxaN/2IDmm6jzX6G
         2Mek7dgBIaiaxIW84Svq7E/NfKo1hL9c0VF5suVsynd1QCyFcS0ooYep+4+2Medt+NBj
         kGGqoYpqBuD32u/4ET/MGD1gxW3J6ZWIe+WFjaPptTwfRReni5R8Q5Q+f0AyJASye9MJ
         nX4Ugs6UDHQh5lmu2+2f1lLvLTsnopbkMf3OiNBfotKupC2IOwCIf4QZZ+P0GuHO+M0w
         l6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnBRD6c/pX6ypoX/gi2HqNrM2T85pThvuR/lc4jGdSg=;
        b=F52xppU1nXBJZHpenHpMyw3qluWU32zrm2hz1bMyjqiU98Xe33/rB0ntda8AAepcZ0
         YHXmXCKhre/1VmaF5vmEwbGDLUIV4IRf9Gyqw4z4k/uQQBpncoonVeOXTJ/R40RneisB
         dv0TVdaVQNBDRNmzv00h/7rvzEZMK/yHsAJcqnxAfwFodJ0NZgu3c7OehrrLYAPiIiw/
         IAFcbCYSP32lKQoQlUkuAKtnmfwuZ6G53Mg3Yi7C2hGe9S7gak140dgQjYTxsFN7yYka
         TkfYhvQ0nUkMzIHR8j602n4XvvG47ARb9iOdu3tCFml1WBJK4YLRu7SqWK76M/CKrmno
         g7tg==
X-Gm-Message-State: ANoB5pn/lr7fiMUAZkzquFHYt4w3lTYLF33aipZPtUTxUROYGHJFak8I
        5x3j8nh64Q00ybpzuR/WYSBw+IUyYvE4WAzzw2F3/anLSE4=
X-Google-Smtp-Source: AA0mqf7PJW5No74LXA6sbNp+iJwm+715AipBaRsV47cbYNcn8gQrbUMiuhJEQMrbnYx0p8yIg1zCYwgJWn4swwZUvds=
X-Received: by 2002:a17:902:a584:b0:186:be05:798e with SMTP id
 az4-20020a170902a58400b00186be05798emr9543290plb.37.1668615491711; Wed, 16
 Nov 2022 08:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20221116123612.34302-1-konrad.dybcio@linaro.org>
In-Reply-To: <20221116123612.34302-1-konrad.dybcio@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:33 +0100
Message-ID: <CAPDyKFryt+oF=Yymv+8sP1j0se6eAz7rMYiRpxA1oPwSN_XoRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: sdhci-msm: Document SM8350 SDHCI
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

On Wed, 16 Nov 2022 at 13:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Document the SDHCI on SM8350.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - pick up a-b
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 12def0f57e3e..31dfaff0048d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -49,6 +49,7 @@ properties:
>                - qcom,sm6375-sdhci
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
> +              - qcom,sm8350-sdhci
>                - qcom,sm8450-sdhci
>            - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
> --
> 2.38.1
>
