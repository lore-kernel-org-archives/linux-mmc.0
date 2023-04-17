Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC7FC77B77
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 14:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjDQOzt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDQOzh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 10:55:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D39008
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:55:18 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54c12009c30so527551047b3.9
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743315; x=1684335315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQHJ4q3CdmAKlAlClHQ4EAPzOxZr151/BPputI4xT6o=;
        b=U3qVHE/9hnPcjaycLBiiZS7lx1jl07foVfwFfIjdxI7c1drlSx4zvJHPWnZDs4obLl
         ExHFRQjEa+teZG7x1ZiwhMw9B2ex1ef/Zj7fM3rB/IqvG1gq/VApC/csR0naGXUk+mpD
         tX0kPWjRRZ/WWodYD4mPLM5ZoOuvuTGBTUO+X5B2ODvUYEbWic7+zX7C/0ZQj3Y9L4SR
         Gyc/CUBr1zgCznWM81aBgFkldNBtHfcDn2BxqxBeEjguy5wJ2EM5zncTYQp8Q/xacP/H
         yc7d1jUTmxQzGjWPeSvuWYhXoMsWgKVsa0Sqb6mXE79jyDVmUIayzuCMCEj9U3mj4EIJ
         yY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743315; x=1684335315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQHJ4q3CdmAKlAlClHQ4EAPzOxZr151/BPputI4xT6o=;
        b=fTYEArYlc5ZPDqz9vzvCFKbs7i6pl+9U6Bw1ttspca01+6yvgCzZHIn8VTqaoh6BEU
         ziG0etLlnhnUWU6IyGv6HXafJB0zB8J5H9gKJRw8XKLpRw7xhg1eXckooEtRwtIlCpWS
         5Ja/JybUBaH7qRw7IcT0joLoMsu6QFWDIV2IzzHeBAxssch7A1gUoW0Nj/95pfFnOnZA
         QFrHoaOEAm2cTxeaIbLdb78nKP5B8bKYotXTOWAMYi9q6iR5hadlVHuRVUZTS8kxX6iM
         CMjrCax1AYAKT2tXo4mvuXWpQTdAhrHobEJhvyBs+m6s6dU0waoDx27T/F/+jNjhyska
         jEeQ==
X-Gm-Message-State: AAQBX9dEFutz4wHaO20ykxYh1awRRnzEn9j7kgLvzhuXfFMgh+/3eVPq
        EFrBDf4mSlkYIi7x5DAw4I3T2RKvPb4H2RTyj4k2ZQ==
X-Google-Smtp-Source: AKy350aMpQBedsbEVhsZzWk+zqIzObSk80KvK1Jwyz9aUfhHiBvphF8ZVmhjn1eJPXi8h5bpF1rVNodI9soVoRMjRLc=
X-Received: by 2002:a81:af0c:0:b0:54c:2889:7105 with SMTP id
 n12-20020a81af0c000000b0054c28897105mr9727485ywh.0.1681743315611; Mon, 17 Apr
 2023 07:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com> <1681468167-11689-8-git-send-email-quic_srichara@quicinc.com>
In-Reply-To: <1681468167-11689-8-git-send-email-quic_srichara@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:39 +0200
Message-ID: <CAPDyKFr=EFT-QroB=FixcTVA4b3ghiAah8uadmJ07bui7myhUw@mail.gmail.com>
Subject: Re: [PATCH V3 7/9] dt-bindings: mmc: sdhci-msm: Document the IPQ5018 compatible
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Apr 2023 at 12:35, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
> Document the compatible for SDHCI on IPQ5018.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 7d4c5ca..4f2d9e8 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -34,6 +34,7 @@ properties:
>            - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
>        - items:
>            - enum:
> +              - qcom,ipq5018-sdhci
>                - qcom,ipq5332-sdhci
>                - qcom,ipq9574-sdhci
>                - qcom,qcm2290-sdhci
> --
> 2.7.4
>
