Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AAFCA5506
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 13:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbjINNDW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjINNDV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 09:03:21 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC41FD5
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:17 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59b4ec8d9c1so10827407b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696597; x=1695301397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aCsgoVc5MdDS0OEMSd5NVyJPQJml3xjCRjHmB8pQyQU=;
        b=UmE2vFAwharNvYSJfAL72mxudS2a4wmMf/TkC49VsGZd89aOhrQvypUzbF7VHtx+5a
         YC0BViG1cIGoWdpq0Wk1WSpeJL+12Xh2uJyvSYm4SC027sk8+3R+pbPXDyFh0sgVh+zq
         +toHzyaCDhS2DVcf+VzvePK3BfVZmovOBVq2KdwMDfy5PAWy12EcC9/a0poZjYvQyi/L
         CNS44n8C13mCfK+ICsZayqr9N842nE3AoEGju5c4BBD/ulhQAdP6J0AO99JNrOrCt24I
         Ayvd+SP0ciP7DovwVIQLwsp++nn1D6dz0sQPsuh3QoBcK5aT0bUCOLTT6cWsXl9M78IH
         b8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696597; x=1695301397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCsgoVc5MdDS0OEMSd5NVyJPQJml3xjCRjHmB8pQyQU=;
        b=CN348XZZvFGvbnRfWINUp+gSNflRHShDKb2nVMWXCoYbOvCdTlg9+HzOypf+Ba/aEe
         3Y3JBoKO+Zs1H6v+86g/eupgGihcTu7+T14rc4ECCqkYIWwuQIoGYqDL4n0F69+/JF9m
         nQ4gbIQK+DAJxm98N2wPSBt/v8dlyFrqs6FTuuXPxko6zZjNrzcClYP2XKc92g44FuWt
         niyOc+6pNL15rjO/mfylZtVoiAJgTNFzn9amg+pnuRytR3jy4H6kSEf0uB1bnkuvjswK
         Q0koakX1MCw3z6tsnhh34H86bfXb2riNYxOl5+v5dh/hzSJNpLPTmFn+R56k7B4MCT04
         V0KQ==
X-Gm-Message-State: AOJu0YxkHSgAx/ks2zXZvfHzHlX2WsKXsGk3rkWd43Wf02Pu2Sxke58u
        orrxDf0x8CvTc1CmX7IlV2mncBIiBQb49W8ZOZTksw==
X-Google-Smtp-Source: AGHT+IHtq67DZntMzVUKa/tcZfvAY9V5Pu2y+pL8a0RH0Ax2Jq7NeiRTvdNMEGDNeImVEaPGukeWC05mKHKjfg4DqmE=
X-Received: by 2002:a5b:449:0:b0:d54:b34c:1c7b with SMTP id
 s9-20020a5b0449000000b00d54b34c1c7bmr4766279ybp.59.1694696596656; Thu, 14 Sep
 2023 06:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 15:02:40 +0200
Message-ID: <CAPDyKFpZnoVnZt-WN_5YdqesoT_Xcbs56tJunwS5oNZSJySxgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: correct minimum number
 of clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Aug 2023 at 15:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> In the TXT binding before conversion, the "xo" clock was listed as
> optional.  Conversion kept it optional in "clock-names", but not in
> "clocks".  This fixes dbts_check warnings like:
>
>   qcom-sdx65-mtp.dtb: mmc@8804000: clocks: [[13, 59], [13, 58]] is too short
>
> Cc: <stable@vger.kernel.org>
> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to yaml")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 80141eb7fc6b..10f34aa8ba8a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -69,7 +69,7 @@ properties:
>      maxItems: 4
>
>    clocks:
> -    minItems: 3
> +    minItems: 2
>      items:
>        - description: Main peripheral bus clock, PCLK/HCLK - AHB Bus clock
>        - description: SDC MMC clock, MCLK
> --
> 2.34.1
>
