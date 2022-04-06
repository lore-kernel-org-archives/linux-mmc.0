Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFBBC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiDFRDn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbiDFRCn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 13:02:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48248C270
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 07:50:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a30so3505517ljq.13
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGnLkTqCELTBFaSqMXTfWHZuWgTtkPCAkZqgsLO5Kg8=;
        b=QO1SBDU20mwhil2dNyoItjQRcPfzmAt1Lu/Jgd5Z6pMa0P5Y3vDnaSDvLwlLktAM0s
         PngBw2IZjX0lmzelI40JlKFI4VtvGY4l+7ggY7BPg48KXQdsaLyGSfUxceybx5g97tSV
         W39WKKIrxplFlPVKK9nNIUwmZuoP3tczjH8ua6A23IeZ7R+vKrBGV/CWgczAVJ4dTr15
         oHpH9QWHEaNV+hz8MBKoFT82bDVvC3ZvtzEerYamAkjTRs14q8RYlNqjAEY8eEHmfTQf
         72FNgOEcgqzgMYBeolpay33rQsS6awSE59sD7K7xb+tzkXOr4fth9cFTWiAb2QEekJiv
         265A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGnLkTqCELTBFaSqMXTfWHZuWgTtkPCAkZqgsLO5Kg8=;
        b=GW7F13SPow5DSYThSv40yhabUn1YEOFKepV3MAVQINz+VVaIH7+G93vIhpeFECI+lu
         lEBj/nzKyHqFtmZbf6zJ+N1BcCD5PPpKohdGrRP3wRsYaTiY0IXejlX7bb6zMbrvzjYc
         uYfpzPQ9OjHRFa/SRKocXKplGrHnVYzUQDCuNXzkgOwTshgweLQ2Oen2Io326VW7rhoZ
         ggpL8LNZ0ofQ+0rXhej373ySG8/7e68RSSIoWvL7TIEgflFi1sUZGBGmE6qEd44Q1IV1
         OWq9xYQrG18z/hJ/0ynZjkdNPARdh1TCZAAov/0+zSIVSdJKI5mlNFzSboKinRp3QIg/
         V/Eg==
X-Gm-Message-State: AOAM531LbOXCxxTaMa/7KVQtlXLVj6JvFo4GMIwy8s0Qhjuh/kzIxgFK
        Rd/ZLoz1LfsVzCLZ61GXnFrIwtAUuJjU4eflkXx/xw==
X-Google-Smtp-Source: ABdhPJxvvBQ5AibBUrHQG5pwBKe7uNSo6RJTvLK3rzdgI8ek8VR+r/hnNLoH6wHR1lBxQc7vPOZ7/KfkFj5WLVKnIt0=
X-Received: by 2002:a2e:9048:0:b0:249:78bb:375e with SMTP id
 n8-20020a2e9048000000b0024978bb375emr5584753ljg.229.1649256622309; Wed, 06
 Apr 2022 07:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220403145133.93583-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220403145133.93583-1-bhupesh.sharma@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 16:49:45 +0200
Message-ID: <CAPDyKFp2U0MgrJYeV9T=fJ+82+2OP-VT1rSqgbyrAQM2E9ssfw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Add compatible string
 for sm8150
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 3 Apr 2022 at 16:51, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Add sm8150 SoC specific compatible strings for qcom-sdhci controller.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 6216ed777343..35a7d78da213 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -25,6 +25,7 @@ Required properties:
>                 "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
>                 "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
> +               "qcom,sm8150-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>         NOTE that some old device tree files may be floating around that only
>         have the string "qcom,sdhci-msm-v4" without the SoC compatible string

Even if this is a trivial change to the existing DT bindings, I would
really like to see all mmc bindings getting converted to the new (not
so new any more) yaml format.

Would you mind having a look and doing this conversion?

Kind regards
Uffe
