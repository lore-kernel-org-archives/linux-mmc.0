Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D6EC7EE23
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 23:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjFHXKy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbjFHXKu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 19:10:50 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE030C3
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 16:10:49 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba86ea269e0so1209749276.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2023 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686265848; x=1688857848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSEQet0GKrnr4pMn8FjH5AOgQ3B0lsZ20KBmXO0sWPo=;
        b=pnntPWqoyFjiGEPsSDDJOsjSPKnhtAxqJr8hxCAp1oOStZsydaau/YdYtp2YxnXEin
         57IbGlgMrR8BCsBFwlbsOj8UiQdZ5WVAJmACsn25rKAdFNjJ3M4bhztM5jRZRLT1XAfu
         KRTbCPky2JTZamkrOJ3D2WqGwSK/KRWCMXW34pFLYPE9fUdCaX4gQy7Mx1IuusYwvv2p
         W2+ZgfB5K4aaLt4DHAnIDEkx8zFIl2iB99zEqAq9t5AeQ4ErDwdAp2hvTstLNkXQXTiF
         XWZi1ZF6VC4ezSwoOUZ+ptMGUeRGo0GrcqU+CHeMyceq096STKNZOKeAVdeMLEARWvNf
         Yj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265848; x=1688857848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSEQet0GKrnr4pMn8FjH5AOgQ3B0lsZ20KBmXO0sWPo=;
        b=TpJ94oYzS7GZ/l9SCoLe5NnQ+P8iNlUybVpbV928sH+Vdr66K+4vDbn+X0doCrwWFq
         J3AFYfPYnfYfbgmhmsYgV4/KI+51nog69OaKDoxr//QK+PsPvhqpQ/7myJAe3rdmWVaM
         5hHVWt8RALc7UYDzt4MkZ6V0TsGkexgSsYig+QApGyVL3j1eoTVayLHzbq46oAcxWaMD
         1JBB/kPVcyKiGAPRM3yz6OIdB5E4IBsNZv3pe21Ah4+rbzpB56jwC2iEheeeuUx3L5VZ
         EzSKXhMLPF17rQi4Q5AEMazYeO/bPoOg9+9p7AhHb7g40+ErDjhCZqUwpqtjKdRlqO/m
         5Ydg==
X-Gm-Message-State: AC+VfDxg+Os0BTKXiO/XRmaNXvub7LoxS2gJdjDP8iuUR+quZN76NrSc
        /UjipcnEqDkTHeb5FBlyRd97vDfICbHtLdRj4WBLVg==
X-Google-Smtp-Source: ACHHUZ5ieHiWUe0+jCkKqPgwkmhjEiQMZfXdZn7EsyrfeetzBu0F5vssZk1uzJeDBX3CkFb7uI2m4RiqK+KMbMEwKbs=
X-Received: by 2002:a25:b44:0:b0:bac:5d73:7f04 with SMTP id
 65-20020a250b44000000b00bac5d737f04mr1078129ybl.10.1686265848459; Thu, 08 Jun
 2023 16:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230601111128.19562-1-quic_kbajaj@quicinc.com> <20230601111128.19562-2-quic_kbajaj@quicinc.com>
In-Reply-To: <20230601111128.19562-2-quic_kbajaj@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 01:10:12 +0200
Message-ID: <CAPDyKFpDKgdZtxtsuRSR7rfQwpXZO9LAL_AtcQ6BuRaA_-S2HQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: sdhci-msm: Document the
 QDU1000/QRU1000 compatible
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 1 Jun 2023 at 13:11, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Document the compatible for SDHCI on QDU1000 and QRU1000 SoCs.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 4f2d9e8127dd..af29d60ff0d6 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -39,6 +39,7 @@ properties:
>                - qcom,ipq9574-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
> +              - qcom,qdu1000-sdhci
>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
>                - qcom,sdm630-sdhci
> --
> 2.17.1
>
