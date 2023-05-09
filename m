Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B69BC77B7C
	for <linux-mmc@archiver.kernel.org>; Tue,  9 May 2023 08:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjEIIhy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 May 2023 04:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjEIIhy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2023 04:37:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DA5B9B
        for <linux-mmc@vger.kernel.org>; Tue,  9 May 2023 01:37:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f423521b10so15980865e9.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2023 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683621471; x=1686213471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oaH5bMyyF/pRBIEeFPGeW8T3yMB7Pu8EJCEKG63OvYQ=;
        b=OivsJeqlYDQKXvjGnGzWbFoyvy4TxHfVcnOhnrQ4+WfFGt0Rolo4waPg8tkZnR9B1L
         SHzR++dleWUsyYZi9aqrvdv89xfLYQOY1I+fS0NCwqJvnOM929eh1hrEwiAvSJJuzFYO
         Yo/GTqy7E3VMjEqrQQ0gGaSn2q+lZRtjS2D+yV1IUFbjjc22mJp5WclnIQrZB0+ltSU5
         SFXRqSYrC4KUSRYpeOSpmAVUhElcoLTDAZ/A9et9sFGCzUnpSesJV8qV5ADYoTbxVYZ4
         ZWaynBbhmu3AH5ClKb0QcSEobnSfZXesTBL/lyXqg+0dtuEV1RGy+CF/XBN+A5M9K8P2
         xpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683621471; x=1686213471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaH5bMyyF/pRBIEeFPGeW8T3yMB7Pu8EJCEKG63OvYQ=;
        b=GlstjMcn0S9YO6acaiqCjOETEcuXGQRQUKmVABjR27WHGD9Lq/FO/eTdUaxWW/+/lw
         TbmjW8nRnH7JZTsZWx38P7lTOxkU86u2XiaCn7krxQQRUjEWuvRk6TVCgAqmO5wfFLwv
         kJOgpfRNbcE97KKldtU6NAq8FV62nI7jCyfHtxKhF/aRNcWV9hk7draPk5e4acvS5pVF
         2SeQOEWjghKbXfjFfkySH37zM7tBxDqrgJy+FvUlRKslQVhWMekcQ0NWcMVfoUHLnFe1
         dpun0S3tQr6Z/h+n5AlNDLEBCAtXviqcD8NBtNoy9X1Bj51GXMwUkaTEvd7U/eRvnLch
         pvrw==
X-Gm-Message-State: AC+VfDzlFILdrSVFWFCSO/sewxDp+ET5/0wDi/68veLAtFsPy0J3bOTr
        ec5z8AUwRUwY/fCI621xpBG9iRSCfBhzWyowA0iNnw==
X-Google-Smtp-Source: ACHHUZ6t1Dtc91VFmGEDmqG1U5Gv9JfMO9EgpE482ZrIfsgizHH8p9LdXOKrvqucABNkj0B5Ae0xikR2XNzeSiSGUFM=
X-Received: by 2002:a1c:f209:0:b0:3f1:92aa:4eb8 with SMTP id
 s9-20020a1cf209000000b003f192aa4eb8mr8835278wmc.16.1683621470712; Tue, 09 May
 2023 01:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
In-Reply-To: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 9 May 2023 14:07:39 +0530
Message-ID: <CAH=2NtzV8JYAGvHgpimjFuGvB2TTXMvhjoAvR5hJ7ma_ZG35CA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document SC8280XP SDHCI
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
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

On Tue, 9 May 2023 at 08:31, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> Add compatible for the SDHCI block found in SC8280XP.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 4f2d9e8127dd..9a87c03937c7 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -41,6 +41,7 @@ properties:
>                - qcom,qcs404-sdhci
>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
> +              - qcom,sc8280xp-sdhci
>                - qcom,sdm630-sdhci
>                - qcom,sdm670-sdhci
>                - qcom,sdm845-sdhci
> --
> 2.25.1

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
