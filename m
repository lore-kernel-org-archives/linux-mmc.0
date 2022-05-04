Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA1CC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbiEDKmQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348332AbiEDKmF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:42:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8729CBD
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:38:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 4so1104597ljw.11
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0/S6UE8kVYqDNad7z3pjtRuJgpmgvfwcT2yCsHCfEM=;
        b=d6aE1Ig3kJW12Aq8yvux6ub9aoclrmtZQHodl+2SCNC1TTVIXN2a1xcOKMo477nJZM
         SYZJZnn/rjIOvYvEOSZT2kWMjKEd/8O9GrUloItb29+AVGSwuBw0s/OUfTYXbcaMixgr
         YNdnKaRQiFPHQ7yd004TWRlTGlB0KKgMZmgrAK40rawynkvyzNHrt1WmQDTyww2hh6T1
         0b5cqCZJLb3MbtQZRn/PlJnEglVfDAvFBFIL0iCsix5AuCHH0lYC3TxNE4GqR6oPAIeM
         7uvfx97tO7AaevpDLUPVRb3LwkpkblXSYQxj3xyFGg6TspgCo8DqCwfyq7yJZe63eq64
         1jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0/S6UE8kVYqDNad7z3pjtRuJgpmgvfwcT2yCsHCfEM=;
        b=GWBqjEaGu6PNQrXh8N8fjYULlGZeubS7LK/hn0fXKfozd5hCTbwwALkQoYRQikcgMX
         yVpdBFWbg+JarRVSibOTh91tLyRnhxHjOcu+5iGWyuv95Tlwk66yQiet8JW52aUQ/e0e
         tR880WwZnELMms4nW3cumHMax5udAjKjz2jHwzIm648I259udzZ9uBZZsC0tPbLsckNx
         ItxcsJ7kMH/JmdWGVvj1tP9z4mfzXDrNdn5pgM3DAuQU8mV0zQSJ7XVYTN+qQwhpjAYK
         vgQX+huKrUNt7QEbnz4RVmRCn/8g1ebKjB38rGBbPK7gSJtVha871zathvtWEqDsk1PK
         HGTQ==
X-Gm-Message-State: AOAM5327npFDS7+pkni4BG6DAeFc58PimbtaBxgGybjI0KRKQnocbCcT
        RAV8KcDdiFY/aU3JJr9kxCLNJ/tGH/tdnkgR6fpg3w==
X-Google-Smtp-Source: ABdhPJxNdFWS/wru3JHuLyOEikz5IC7uPf4QUB9vcB6u578vrjN4goN8ah7xYQTsnbdk4O0TiH3kqranj+niTENGv8M=
X-Received: by 2002:a05:651c:988:b0:24a:c21f:7057 with SMTP id
 b8-20020a05651c098800b0024ac21f7057mr12487369ljq.16.1651660703238; Wed, 04
 May 2022 03:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com> <1651480665-14978-2-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1651480665-14978-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:46 +0200
Message-ID: <CAPDyKFqmPdzR-RrQUf2bkr6KnSNVUt4uS5Tj31ug+y95ZSXhxA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        adrian.hunter@intel.com, bhupesh.sharma@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2 May 2022 at 10:38, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> The SDHCI controller on SDX65 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index da42a88..e423633 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -33,6 +33,7 @@ properties:
>                - qcom,sdm630-sdhci
>                - qcom,sdm845-sdhci
>                - qcom,sdx55-sdhci
> +              - qcom,sdx65-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
>                - qcom,sm8150-sdhci
> --
> 2.7.4
>
