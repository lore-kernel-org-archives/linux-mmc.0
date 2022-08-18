Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995EAC32789
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Aug 2022 21:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345969AbiHRVei (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiHRVeg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2022 17:34:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0F2BB69D
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 14:34:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v10so2868019ljh.9
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=57R1i97Exb7jiv3R+C+sLGgx2BChX5wJqOqueGuOy8o=;
        b=BpRf1j8XsCn/7ww8tOLJtJpEEyVf9B0Nkp8dZSfI90CLV5ieBJ3CDZMbPVxru2yVXz
         1l55Td1/RKqMyoMByybvH6bmTKczz2GHoaAtHV3VWUl3Y00PEJ8XFZO2YaqWKSmIgtUO
         q0beRrI68dYUftzgYBU/HmlW5n9hFBxIYlEfcaydSVpzwzwllso/sppoPR7KJBMe+EZu
         sd1gzVfaHnCD4gk5nvR/JfMkFXwk0yspHGUUoH7MJf/iiQzWqV+kFVBxVoPioup37F4u
         +uk0PDEXhbotpzeLvczvh3m7KQm6I+UvCmXb5OPqZ20iZ6mmdKFkbICd257afSvtVG5c
         3vyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=57R1i97Exb7jiv3R+C+sLGgx2BChX5wJqOqueGuOy8o=;
        b=u3ATiV8OWvHr9Cvm6upO/vKSHMzeKFUa0erZ2dPwD8Ytx7ZAaz5cVNeyZyVCdvf52l
         vLhdytrXluQmoxeUjU7gWgqGmteZtOkltzu4HAEtaElWSygxH+a6Tlu4g62N/zo1TilB
         2Ren5cV4pSL7bhWHnD87HWgQOcZZEuVBZR0o/FukkDf/lXP+AjPtXVmIT2kLEKbG0wzF
         aNcjX4jd8ItQZ873Ogw+t6m2noa1saRpeZY576+PlBOJiHc+Kg0YYDFeuFT/Xe842yEE
         LFTHHCf3ygR2B0tPIg53+azd1wUJ3mM3YfTO20nKmpQuEGE6Y17SW0YR0Hw9tRBnPYpB
         sofQ==
X-Gm-Message-State: ACgBeo2Vru/zcXAUuzMriCwqzP1AGUAaDAM8r5zoDl1sip9asLdW3eVn
        aTqZTwuP2lbIc2qK7W8DNx2+UcGxqf+kmo+SWvFgpA==
X-Google-Smtp-Source: AA6agR6GJXPp5/z0JTiP0q9mPDVCKJiO4ywyVq/9cFPr4MM0zelM0e/lZlpgvN0Odpiov3nkO1VEAYbE8La/yBkG2AA=
X-Received: by 2002:a05:651c:1718:b0:261:8700:25f4 with SMTP id
 be24-20020a05651c171800b00261870025f4mr1333316ljb.229.1660858472545; Thu, 18
 Aug 2022 14:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220815100952.23795-1-a39.skl@gmail.com> <20220815100952.23795-4-a39.skl@gmail.com>
In-Reply-To: <20220815100952.23795-4-a39.skl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Aug 2022 23:33:56 +0200
Message-ID: <CAPDyKFrc5aneqqC=uGKeQ0ROx69eMJhQ1pFA3GN8d5NpXHGEEQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: mmc: sdhci-msm: Document the SM6115 compatible
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Aug 2022 at 12:12, Adam Skladowski <a39.skl@gmail.com> wrote:
>
> Document the compatible for SDHCI on SM6115.
>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index fc0e81c2066c..a792fa5574a0 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -41,6 +41,7 @@ properties:
>                - qcom,sdm845-sdhci
>                - qcom,sdx55-sdhci
>                - qcom,sdx65-sdhci
> +              - qcom,sm6115-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
>                - qcom,sm8150-sdhci
> --
> 2.25.1
>
