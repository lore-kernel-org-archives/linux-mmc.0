Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA68AC43334
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 14:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGKO6Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiGKO6Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 10:58:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F9372ECB
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:58:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y8so6603644eda.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK/h8I3TwzYyU8YTkNwIUL4+D9uJ1XU+DQgA/bhS4DQ=;
        b=X4wjMIEABz8noT1eAHb/RNu6qhp+hTqzGdaPiYYKviKYRh30CyC85AQZdVus+ckBr3
         XislwfMrvQ7Q3cEq6Ovn79KBtWs/U5wn6/d1XIJUxXnq0G3p1rp4j+Y1/twzmIQWXY8m
         v4Q8KmF9dFlq0dtRRxacW0DfVcf/S0JAjxyn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK/h8I3TwzYyU8YTkNwIUL4+D9uJ1XU+DQgA/bhS4DQ=;
        b=421mBN59yvyPxF06ooWfJ8Vap1UAcNp3rpWd8XQIwYM9+DbkIxImcSGIN0jweMIqHe
         xEx3Wi1MuRm+lTZB6P0xg3LAqzA3a/aCy9Ett7lMFYc7pdxBgIP4TdNT2kR5jE9SpLag
         bmTXZYZ+y3l7cC+TaczhLBjtcn/HQL4OGW63JTuMo18DDKf5RHm3IP00xBOjjYDijPrJ
         351h05Smonmmc58OG10VPNJSeCJI3ImKQLd6c671pj25vuN2XmqmlR+tdGZ9PXnGJYzo
         MU2oFQfCP3dm8Kn7bmPS7aCFWOM95X9DWa0E7Xtd3Y0SbXGaLJqzeiW8x0xxtu+yGuky
         HeAQ==
X-Gm-Message-State: AJIora8FJ2mOTHmmMwKj1o1+66qetof6ya91YszaSLtg2SK7ZEjov1mw
        q/7VYSfhxBDHSPUML2zhWuouaSxhmTjoCnaG
X-Google-Smtp-Source: AGRyM1vni7pOwSsdVGh7lFbX3gyMDg3Ylf+PzObv9W74j0BAV/iafkDnnPSjo8hQfKFdq2mxNjUCEA==
X-Received: by 2002:a05:6402:51cb:b0:43a:aed1:810d with SMTP id r11-20020a05640251cb00b0043aaed1810dmr23111317edd.281.1657551502087;
        Mon, 11 Jul 2022 07:58:22 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7dd42000000b0043ad162b5e3sm2323435edw.18.2022.07.11.07.58.21
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:58:21 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id b26so7380786wrc.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:58:21 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr17662599wrr.617.1657551501186; Mon, 11
 Jul 2022 07:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org> <20220711082709.39102-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711082709.39102-3-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 07:58:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uvc+d8v4UCMLhcEydt-RVf+94NTUWrMgORv8bw0kDNUQ@mail.gmail.com>
Message-ID: <CAD=FV=Uvc+d8v4UCMLhcEydt-RVf+94NTUWrMgORv8bw0kDNUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

On Mon, Jul 11, 2022 at 1:27 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add a MSM8998-specific SDCC compatible, because using only a generic
> qcom,sdhci-msm-v4 fallback is deprecated.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
