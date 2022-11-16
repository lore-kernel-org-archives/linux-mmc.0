Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F448C43217
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiKPQS2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiKPQSQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 11:18:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A2C57B4A
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c2so16839784plz.11
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lor3rulwbXv5cvKmMp9W8Gkpke6RAbR94pio1OJ5+w=;
        b=Ztv59t+sdJ8FDfj0AqsB1lXlLXAtn8P7awrZ7yCvTLOkTg0lsq+Ek2oma5rc554bNg
         x4GrCoZdi3HhPQW5u0gbcggxJlB65GP2LPJZHAA7oFXHE5BIkss6BlVwRC/ryCuAeITY
         FIxSccjwIKCeOW139gY1Yc4PKCVA5mHIYwlDDxDnVcvxnnQcPR5kjt4JyvXQ2MXhOlAV
         ZOsI6d/v8BOukvO/Hgoy6ZyoCTjzjW9ATKpea4JcPTxtX+rFYWpliefucNAzuuALx5yM
         a4czvMF88oyT5jpfc7hjmjNAlYhYnPFMUOf+JrdVsfgfzInYGG40QKA5iFrEq/MmzBD+
         ftiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lor3rulwbXv5cvKmMp9W8Gkpke6RAbR94pio1OJ5+w=;
        b=Tiu2HJFMlUcnFh/VyDgzBPxGCWh4SUit+8arkovfQITWoMiI/wAje+sZCbhFkhWYlU
         5yZdtcPYVVNcW9EcDAbxwscJaHbDDlkjsrfj/Mj/7LmVQ5xeS1p94GEcpJjnSUAd+Q+3
         mYBsDWe0vVZimX3TzgFVTnJnnjWCE6AThLaMWKC/Z3Wn4EsZacvp+Gk3+AwY+cTghomi
         IzN/dPdTnrDwSF1mjGiDNmHiAKnTniLFi//QFj4kf1F4bn8K6bJ6g3EDwDlB8b6HS9bL
         YU1Ut2mzyl5F/X192EAwx8S93vpDGGy3UekbOhv5EgiZ1Qi1KBFii8TP5ab1CNWeV4hq
         Vhvg==
X-Gm-Message-State: ANoB5pl7NMb+zZcglqj35Ltylm3wwFW4OhJESj+kCGpiNlr969xTDD1I
        69OlxTp7FpNT2EK1ZneJQDW94yZdlo80FaXDMpFNBQ==
X-Google-Smtp-Source: AA0mqf6BBuCK/2Uwy7g0M6z08aNUdokEWMht3+/108Ulon6FcDnZllT4TN9FRoe6hk47Scp5HBb3W1Myuqkmr4XZKnM=
X-Received: by 2002:a17:902:d386:b0:188:cca8:df29 with SMTP id
 e6-20020a170902d38600b00188cca8df29mr9787748pld.148.1668615495048; Wed, 16
 Nov 2022 08:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20221114-narmstrong-sm8550-upstream-sdhci-v1-0-797864a30e71@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-sdhci-v1-0-797864a30e71@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:37 +0100
Message-ID: <CAPDyKFqKvpMYBqySP=jo_5ZFmcqh6mNQbXTXxjz9fDkfC966cw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Document the SM8550 compatible
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Nov 2022 at 11:15, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> From: Abel Vesa <abel.vesa@linaro.org>
>
> Document the compatible for SDHCI on SM8550.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index fc8a6b345d97..f0b7e6d0ecbf 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -49,6 +49,7 @@ properties:
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
>                - qcom,sm8450-sdhci
> +              - qcom,sm8550-sdhci
>            - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
>    reg:
>
> ---
> base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
> change-id: 20221114-narmstrong-sm8550-upstream-sdhci-1ae5ac4924e5
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
