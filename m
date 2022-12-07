Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0137DC4708E
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 12:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLGMjA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiLGMib (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 07:38:31 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753050D6D
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 04:38:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl24so16893270plb.8
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 04:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YBX0rthji88f2u2kpbjWW8XV26nJpBCfbkYDEQ0jGgs=;
        b=B5n1LzzMR+vFf49xTP/rI64mCZcTUPodYeyxpjAXXP1IkgXVgcJ+aNl3ojevp2r2Lk
         +vIcaW4NvHRmOk4n74Hr5s37NzFsIAGMEkM9JbufPIwA1EQ+G1bOsEk/iEjgMNgPs5Yv
         flnpOPpGd6JVneMa1MM5Yw/2brb3xJ8HnW6Zw/OhWH5afCcOxi+1DKCPC3nU6JXIXx2J
         7g3M6db5dnRclDMWCaW6GgjqGTCnpSCtK8lNjDwDR9KHlVBuk/COIHGwxmuyAKNypHQz
         IfGHnTnckAnkzSLJBFkD0xutbWx4DF46wJIumJqTHJ1kANqSq/HMjKUkUM7+1PBNZfiE
         QX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBX0rthji88f2u2kpbjWW8XV26nJpBCfbkYDEQ0jGgs=;
        b=rMmz19z1HYgVD58uQ+ojhmFZr7+MLE2D7pN9Iexh2fgDpv/+xv7vebC7iX3XSh9QCg
         rBmr3DtFE7Xbx1x4TNAAljj5cTyM1zz/GqWJKwL3zNKuqa7iVx68/PNmOiWnp1yq+OSS
         VFsguVZWsACeARulzSjDRhYvgLjsJ/5CVHdGgnlb6BDpbg5ANH4g6ZoRkOUqOOTKiwfy
         6hqUrB1Q//OCNjaxWXxxTXtRnnQlQrFsa2WCD6n/RVybSx1Hql0389YcR8FJkmRIO2bc
         v7BDh6Ko3nKwardng6ZOIEvf3WX2453BuULWU/89O2W7SXtwe0DdARfYIumQxGn+suQc
         YN0w==
X-Gm-Message-State: ANoB5pkyHOg4uagXKTZi/9KcVx6v5QTyqztTUbgCaA6hRw5TDcSUUWiI
        Hq1FQCbzRIthNNbE1Eb8eM6OKV9kUihZO86UgHpqEQ==
X-Google-Smtp-Source: AA0mqf6dlj8DZXyu/nXvQiw+t5H43fPAM5QS0D71Dgo3NXBcy+o/mtivw3pVjRcUk4p/o1swJO8iVOuQUMTKcoCyTqE=
X-Received: by 2002:a17:90a:7485:b0:219:ef02:a5eb with SMTP id
 p5-20020a17090a748500b00219ef02a5ebmr10667292pjk.84.1670416700348; Wed, 07
 Dec 2022 04:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org> <20221204094717.74016-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204094717.74016-5-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:44 +0100
Message-ID: <CAPDyKFpccW4cFvf4BSJtO+UZdZnAzAhaE0vrU9p92Hn22Hcx8g@mail.gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: mmc: sdhci-msm: allow dma-coherent
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, abel.vesa@linaro.org,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 4 Dec 2022 at 10:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> SM8350, SM8450 and SM8550 SDHCI controllers for SD card are marked with
> dma-coherent, so allow it.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

All five patches applied from the series and by removing the fixes tag
from patch4/5, thanks!

Kind regards
Uffe


>
> ---
>
> dma-coherent was first added to SM8450... then to SM8350 (not merged
> yet) and now it appeared in SM8550 patches, but I actually do not know
> if this is copy-paste or real need.
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 39e303468bc4..6b89238f0565 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -83,6 +83,8 @@ properties:
>        - const: cal
>        - const: sleep
>
> +  dma-coherent: true
> +
>    interrupts:
>      maxItems: 2
>
> --
> 2.34.1
>
