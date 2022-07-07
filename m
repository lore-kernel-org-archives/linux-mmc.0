Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0247CCCA47F
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 14:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiGGOdU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiGGOdT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 10:33:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3F42F66B
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 07:33:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n4so13489600ejz.10
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoyTQr6cMk+DYKdiMg3NC5XJCceUe1dyjyTAOmKK+S0=;
        b=lroVGXv6SSW4e0FiWRd/MeL568MO0S+YQA+5UXYvLt0cA7bV5CNRO2Vu4OlmIKq1DE
         StvwBV4/hBbWlM69Ll0CA5hEfffF8nojIZ1YTZDOCYGfu8poE/e9HCaQjPz9cb/b1OCA
         H0iQiOnI53icrgv0o5MjZQZTuGu8PZlghwbAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoyTQr6cMk+DYKdiMg3NC5XJCceUe1dyjyTAOmKK+S0=;
        b=3aOfdXxu7huLYK4ZtZkA4vuMxOfVfkwhoUhNUJK+umIGCvI4GNDA8eIcAFqTran+4e
         zHkI4aP96iYyu5k6hUB5dhnObZxxrq7uaJiOj7R37BjCPzJS0XD16F7uYYW7kdnUE+iD
         +me3FSbzcucTXwhGj8mtu3ivaXXpwb4ELFtgPkyOi7UA2+xFiUyIaSlyNCEyPxxg2FSg
         1zZyfHIVQUDl011c/s70DZ9aAAkbGUGrNKv7P6fFaVZ9U5ohhZH/+mF+5msRi3XTu3cp
         cYswiM0Pf8BgFlc/mPPxX156LrNDX4js3J1Y/mD+KPi0E35ctJv20wNXxCuNDH5sRbT9
         OfBw==
X-Gm-Message-State: AJIora/g4aEz7Rx5agefQ1pLIyZqeOiMYrO0xWZIFwuIPyNH27A+FskF
        3qDC483AABoZvZ9kRsrrk+eaACi5abscs4cYtRM=
X-Google-Smtp-Source: AGRyM1vBHoCRTGlMCfKPjiTTKsH6fkmhVlaTuUP4kU0om+T88llCqkEoPle85dvFH7BylO1/ysk6AQ==
X-Received: by 2002:a17:907:6e03:b0:726:a6a3:7515 with SMTP id sd3-20020a1709076e0300b00726a6a37515mr46206886ejc.676.1657204396968;
        Thu, 07 Jul 2022 07:33:16 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id es25-20020a056402381900b0043a6b86f024sm8807386edb.67.2022.07.07.07.33.14
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:33:15 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so13589626wmp.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:33:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id
 d14-20020a05600c3ace00b003a04ea45f77mr4905076wms.57.1657204394580; Thu, 07
 Jul 2022 07:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org> <20220707075151.67335-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707075151.67335-4-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 07:33:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W8mDtb0Bg4oAFdzn5m+XeXc_aiCrWVMPAz-ZhO1errPw@mail.gmail.com>
Message-ID: <CAD=FV=W8mDtb0Bg4oAFdzn5m+XeXc_aiCrWVMPAz-ZhO1errPw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: qcom: align SDHCI reg-names with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Jul 7, 2022 at 1:04 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DT schema requires SDHCI reg names to be hc/core without "_mem" suffix,
> just like TXT bindings were expecting before the conversion.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 +
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 6 +++---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
>  arch/arm/boot/dts/qcom-sdx65.dtsi   | 2 +-
>  5 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
