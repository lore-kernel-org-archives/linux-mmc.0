Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF7C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 11:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E4361994
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 11:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350429AbhI3L1N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350439AbhI3L1K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 07:27:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1AAC061773
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 04:25:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so23715607lfa.9
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2021 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQ6FUBIM9thJqbhUS63FKjztr/wXj8cgKR4tXqEtQ7s=;
        b=M8ozWpEVoGJuI2AqrfnJ8grrWDDy3hICF7yDn5elT2VNODPrJYZq/1dUel6ac/46xP
         zEa4ct8ihuroQLVWvo/qmmiMqiX2DggNre9oKvXc0vf24Ebz0M/HbGz3afSH4J1u6rq1
         LyhocEM49mPnbbAhmz7moVfZIjEkUNcoD8waWv58fPfoTi9DLf8ARV+yVPP84jkM673V
         a7SKJ6LbWZg+qLSc4LiPoVIEpr2ItJFRHI+diEDfYRfSylO8ZIfFfFZI7yW55YzYx7qB
         ubm3BkG7OWuXVr/J/RAsf20oczo8MMbv3w6DZSbx+LpER/VdzfgPMcX47k/RzsPVfrhY
         X/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQ6FUBIM9thJqbhUS63FKjztr/wXj8cgKR4tXqEtQ7s=;
        b=lQDxCQyNP/QFBcYrUcF++rT8Nw+M8/INPfOC3epTacQZM+jXCO8jKo6lIglzEhftes
         fgs1x/t+tVNy/hl3aAJ9eMbo+JxyqedvkrGs6MHReFtG9oT9ci/yRoOsqGMTiiwJwbEr
         DkFDBBXLTChCLE0wHPYY0uXMje7dFMD9ewzEzWHQsqXJHyg1n4t907CzrdOu4qLedm9a
         aL+xHKK7O7Jyvifxz96mTxar+ipU8PFV2xUGzem23Pgk0fAY1l3S68Z97Pf0hgfSHI67
         kSUHLLjcBkUuf9evN2LmXcsjMf6cMZICM16w1hhGdsr1Lpcu205aHiZwa3qaNFRxo5EG
         ZxBQ==
X-Gm-Message-State: AOAM532GKynZtT8RIk0kWmnoqQzky1eQuUSjei18S6S1LwqQYoM5ZkxA
        h5YVwUyga4cWeg4nWCSlinYcC32IFVc8szsYZwpQhw==
X-Google-Smtp-Source: ABdhPJyMnk07HkEmQ5T4dxMeflUqucQ/Q/tgaQvW78ey2NbZe+7L8S68QtEOQeKSrxWS+FGbmyyMpqTTZw1YJPCMLqM=
X-Received: by 2002:a05:6512:3fa5:: with SMTP id x37mr5618301lfa.233.1633001124808;
 Thu, 30 Sep 2021 04:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 13:24:48 +0200
Message-ID: <CAPDyKFrWTDe83Thbf_JGLGmfKbJvFyCLEXgoOgg-=ROvV8yJrw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdci: drop unneeded clock-cells dependency
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 Sept 2021 at 10:23, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The meta-schema already defines dependency between clock-cells and
> clock-output-names.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 23abb7e8b9d8..dd70431df0b7 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -158,10 +158,6 @@ properties:
>      description:
>        The MIO bank number in which the command and data lines are configured.
>
> -dependencies:
> -  clock-output-names: [ '#clock-cells' ]
> -  '#clock-cells': [ clock-output-names ]
> -
>  required:
>    - compatible
>    - reg
> --
> 2.30.2
>
