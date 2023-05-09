Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26896C77B7C
	for <linux-mmc@archiver.kernel.org>; Tue,  9 May 2023 10:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjEIKKb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 May 2023 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjEIKK3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2023 06:10:29 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3805144AC
        for <linux-mmc@vger.kernel.org>; Tue,  9 May 2023 03:10:28 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a5a830238so51559757b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2023 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683627028; x=1686219028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xFX4OXORNCMFM1k+V44X+v1G8lRpre4V5obhbQUsfME=;
        b=lAbb7gaAtspJI33WC5SDYV15HP//2x1Vp0Jtn7t+fX8QLOnJ/9g3cz3ZrtDu7Pbuk8
         7Kz7JGExkrska4lXRhvEyIpVHszGOroZCeqiYPeiO0mpgM34u7cF6PC5AKgBoRJhtgZn
         akFrGRFQ3KNQZrEKcEh0co4etZyNcQX4iWkCBTEKK9a0BcHF9pcy89dEK3Sw7QtOahC7
         nTyTXDUi376JKVFGq1/iaqoVHkFO2M3xT8fRHsUoLj1pSwSeJLtZfbp3Jk1wOh5wn50k
         r/3/bhQKtn5KZlrQ09Q5RRB1OG0hn5y/HqTCqx5btQdO220HKutPQLGZD9r9xXV9WaAN
         G8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627028; x=1686219028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFX4OXORNCMFM1k+V44X+v1G8lRpre4V5obhbQUsfME=;
        b=dKULuvhDbtlB9ygr5x2C2yzxDPfY72QNkaogaJ7OkbgwMBwvzGyxYTeGjaScOt6ZdA
         EV2ub/FZTxS+084VF6KR7FQiFf62UElNXa0drUzk0KtwdXEHNws7XKTAIFb0FdhAV8sO
         SHx6fKgCXAW/1oIkj0/91JjVHQaCfc8+RRzKrLzVw2g2bL0FoZMDyKBrrV/K73wQbrRS
         UWxQATsFFJINopLQYwR4puYh0byySRId1DfMbpJgNwj8uKy49xS1qoy8Fx16+VG0JEYM
         +koQTVEv6yeBFOcRaP2tb1Mf+QpZEOByEFAbHLIbQs93/tb49fYWO04QAEEum13+CmDZ
         F9Kg==
X-Gm-Message-State: AC+VfDx4pAfN0qe/C0Uf90L8NTBTF9fi+hZTGwxaW8t24SVE2J0SZpw7
        +uouLYWIQgetB6OmrfpOVYk6MnmGIIa6nn+LSwYwlQ==
X-Google-Smtp-Source: ACHHUZ6+Gii22lckyzjd/xIzgrh6OAFuQzx5+2BclyAMT9ff3k1J+DyQFGBoZ1rB4vXHqtyKuXzjqw74KtHZXPT4Jxc=
X-Received: by 2002:a0d:ea55:0:b0:55a:1cd9:153d with SMTP id
 t82-20020a0dea55000000b0055a1cd9153dmr13586766ywe.29.1683627027827; Tue, 09
 May 2023 03:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <1682338412-15420-1-git-send-email-mantas@8devices.com> <1682338412-15420-2-git-send-email-mantas@8devices.com>
In-Reply-To: <1682338412-15420-2-git-send-email-mantas@8devices.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 12:09:52 +0200
Message-ID: <CAPDyKFqeahcutHoOMgiaV0eWFX8Aex1HHH-aGRzMbKoQpwC=hA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: mmc: sdhci-msm: add IPQ6018 compatible
To:     Mantas Pucka <mantas@8devices.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 Apr 2023 at 14:14, Mantas Pucka <mantas@8devices.com> wrote:
>
> IPQ6018 has a sdhci-msm compatible MMC controller. Add the appropriate
> compatible to the documentation.
>
> Signed-off-by: Mantas Pucka <mantas@8devices.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 4f2d9e8127dd..5ad846b724f3 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -36,6 +36,7 @@ properties:
>            - enum:
>                - qcom,ipq5018-sdhci
>                - qcom,ipq5332-sdhci
> +              - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
> --
> 2.7.4
>
