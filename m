Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9ECC77B73
	for <linux-mmc@archiver.kernel.org>; Mon, 22 May 2023 09:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjEVJvK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 05:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjEVJvB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 05:51:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E9DC
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 02:50:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so21617655e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684749051; x=1687341051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iSXoKW4svoPOIZA9jwOfVXwEQMw1P1DLgfEryZQY9O4=;
        b=gqGvi3LrZgQHit/+h+4Ey5bU0o6PwdO3GmnHc1rGRfq4d0VB0PKS3ancXXcuf9Ov9g
         2ooq7qvY1a2CwLfZIMvqttTGEpYxR5dpPfCRqTOE39loJIKkqJjIFmzPZBpdK5+ZyxPm
         UNarICUOrBOZdX7SVzVrTTnX2YbgsYDOM02I9WNrl7/3pTNYOv6QApGIXvGQ/FlgeUwX
         yMGKCBN5mt6XtDxrCbFvu4uPJXHE4SVmHF1S4vv2AE4IxPpccZDII5dDD8hTiS7okyAC
         +Y4DvXXAsEMbocKlKD3LSYyh8q3DVO2vaUnfsFOWR3LqW0X4J1oXbI1Wq1TpV0qwmR2y
         u+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684749051; x=1687341051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSXoKW4svoPOIZA9jwOfVXwEQMw1P1DLgfEryZQY9O4=;
        b=HPc0a0kGq0N0LxRW6TFJPTiAhw1FJXm3tSlz/DBr70nL3PXeUk2DVfAU4a8185U20i
         4l5tGCFqginCYE0sNK6Pla9O1nmgi640wouKbSEcPc6v+kLzd98GXwAqkSKDCOzlOXdU
         r7Uvw2p5/jzPAUvBLHdpt8tFKGjIngdPEuUUsrZNwsmKRnjk7mM1wK9yT+7O7vX4LjJR
         atc4N56bNbkXdwOIMKTvCnneNQKrdBs9+DLTE5pWBmqbcD5sorNymeaQEnftau8m9FAg
         SwkwHuDw1R5zCEcr8nu4VClJNTovwHQKkLgDocVftqQ1CEp0eBOq6JCy2qv6OkeubXBh
         HxJQ==
X-Gm-Message-State: AC+VfDwMugd9hvYX3w0ydbIarzhvRFk8nR0trVnKHzvbWCvXdtANOUet
        jCFm2dwgzyqfjOlniRRVbifWRLmn0beAkyMY8eoEBA==
X-Google-Smtp-Source: ACHHUZ7KVWWZo1XmM4Mv/pWB35mbIcyC7xtFyONKlm9eEk7VRc/+pfTtPeVMp42gunjjlwaCJ/HJQWue46rXtz4eeoE=
X-Received: by 2002:adf:ea82:0:b0:30a:8f9e:8ee6 with SMTP id
 s2-20020adfea82000000b0030a8f9e8ee6mr1995815wrm.22.1684749050893; Mon, 22 May
 2023 02:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230522093620.3568-1-quic_kbajaj@quicinc.com> <20230522093620.3568-2-quic_kbajaj@quicinc.com>
In-Reply-To: <20230522093620.3568-2-quic_kbajaj@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 22 May 2023 15:20:39 +0530
Message-ID: <CAH=2NtzzoUuVDNBmeEk7r=7b+i8pnmuteMrYtZw9JTYegix9ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: sdhci-msm: Document the
 QDU1000/QRU1000 compatible
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 May 2023 at 15:06, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Document the compatible for SDHCI on QDU1000 and QRU1000 SoCs.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
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

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
