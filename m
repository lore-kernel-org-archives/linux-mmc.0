Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108A1C43334
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 11:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiGRLjX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiGRLjT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 07:39:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A7726E1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:39:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n18so18824944lfq.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM/hn+OVqs3HFe+jDApgRgLmW0vQU4FyOltjDqB3/Sg=;
        b=BftAwgS+k5g/3vxqxG+3WrnB4nHH4Dq7BZDuswhBR4sT2Kue8FqghkpFrlfIHVC+P+
         U2TkIHTyeijTBJoh8cZ4S/DCr1fy7rmpG+VJUssgK5gyMAase1O+Uo4w6dmvwwCjboIA
         VUNWqFxJ7A/X3byP+PIS9xbH6/2tItBg2gcRaIRT5N9ypur1+ZjNu/5ovG4yXOSoIWvA
         0lHaFbfLSK2ZDmVITerKzNh+45X6xUEOcALAD00xsKHJ3mNpT8/AYEbwd46G2soZgZfQ
         shXWpyXa9H0x+NRGXBhiPUIZ/0XgToFO8l6GQ0pbHOoc90jR+19JHbJrQALbRnaBwBHo
         /nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM/hn+OVqs3HFe+jDApgRgLmW0vQU4FyOltjDqB3/Sg=;
        b=OnRNwwjNTCZQODKZ5oiecWIq3Ca4hgLCQMObU1mMZtkek+aVjhfuZpq8Qh2LzI15m+
         016qVVNmUqVxvmJG1Qb9neNMWVeUvFP9ml27zkIQ/n6XEW8Vjdv3c79hROMNdIqVtW3z
         qU1C9RfyQc15qeBPmYN9/+bx89Oj8g8ceyFolKnT3eW2QYSkHbhE5Rnjsc6gSnLzy9vw
         aXkStH9mtecBa7uBFZ+TiczzE49XIW+mEYFZ6Dlk5y/8pm5YhofI8xkpCfJR/GJ/0NSc
         M7ErF7adDSvluGQB43nWCmM3q5oTVh7a59Ypu1L3173Bo+r7t0BWWq37RM5o+NFkGwNf
         OAbw==
X-Gm-Message-State: AJIora/GvftYPKEaEl+xpfdUI4RsD51+8KIAwLFqruA7NipnWZ8D6BXm
        5gg4hk+7aFyxJPF/rhXbjfeo7auPKAtUQYi7b8mXTA==
X-Google-Smtp-Source: AGRyM1u7qX5AB/G++2uS/gtRhpTUCNvvrYExbLhAE2KGmAyp23WGYAhcJCO6LARGRm4eTJyZZYuNlPywKHZKt6zR2lk=
X-Received: by 2002:a05:6512:3e28:b0:48a:a4b:c474 with SMTP id
 i40-20020a0565123e2800b0048a0a4bc474mr13415274lfv.254.1658144355761; Mon, 18
 Jul 2022 04:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 13:38:39 +0200
Message-ID: <CAPDyKFoFGxjcAA7vDUzfBDzNyMfrn=g9ZJ9cnY_aX8im3G-=DQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] dt-bindings: mmc: / ARM: qcom: add MSM8998 and
 cleanup driver of_device_id
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Jul 2022 at 11:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Hi,
>
> Rationale/background:
> https://lore.kernel.org/linux-devicetree/CAD=FV=WGxQF4vPuRi7kWKoqTpe0RFsgH+J82C=sQbmncK_AFpw@mail.gmail.com/
>
> Changes since v2
> ================
> 1. Add Rb tags.
> 2. Add a comment to SDHCI driver to hopefully prevent re-adding of compatibles
> (suggested by Doug).
>
> Changes since v1
> ================
> 1. Add Rb tags.
> 2. Rework driver patch (now last in the series), after talk with Doug.
>
> Best regards,
> Krzysztof
>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Krzysztof Kozlowski (3):
>   dt-bindings: mmc: sdhci-msm: add MSM8998
>   arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
>   mmc: sdhci-msm: drop redundant of_device_id entries
>
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
>  drivers/mmc/host/sdhci-msm.c                  | 29 +++----------------
>  3 files changed, 6 insertions(+), 26 deletions(-)
>

Patch 1 and patch3 applied for next, thanks!

Kind regards
Uffe
