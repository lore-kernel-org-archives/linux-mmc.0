Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E503CC43334
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 14:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiGGOfr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiGGOfq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 10:35:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFF2FFD2
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 07:35:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x10so16055845edd.13
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6R/ddtNSwfm7ty86Jg8Rk/94EllRS1alXZobv2bNWis=;
        b=nop4+PYaSie6cLDfOoz79jPZj+LmcL3qmT5jqfFfbawptaU2DSYNGb9uCsJ6ie6CBA
         044wbTmELbC6ll9dHCgX/qKoXRUW4Gt58A8QRV6+vaYK5VZxmSNh9JGnRQJEzvaXSXoZ
         p894kw4QPJoW/iXmBPjcZx7ieiwtgw4Ew+ydA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6R/ddtNSwfm7ty86Jg8Rk/94EllRS1alXZobv2bNWis=;
        b=huKt4ZPsTrE9252HwsLPCYEi/5yPQ2pnz8TZm1pS43l+9/R/tBWH1Q2ecPCOCwiQw3
         1pTSl3PbTowOaAENiNtjeYp6s10lAQNfJUzRsnMyic2gJbzhi1sycs8gsCSVQlxQiyLh
         BAtu/TAnC+IfsylLzLg5RYsvwupvZQSIubr6aKR28e3Vbe6nPKyavUXMaYbQRrLD6oyU
         bcdg4QYWrSSC8lDpuBaAY+e4EkouSwPPFcwKMGjIHHyaRtjkq7cbLJ0okvw1Cb+MFONb
         dn9H3/sacr5a2bBF0AcyHQu18RKtwOozleGOkgmr+c9CWdNvoaAtmDy2kXPHNNsWLf1v
         nucw==
X-Gm-Message-State: AJIora9Y+XqJWtWa8f3NRXwDw6xvWHfpqtPGmSAkWfgObUoHO2EHS0gC
        OIijnTgNUi7/+GT3jFn+0I0GMNbyhYxde8MGhOI=
X-Google-Smtp-Source: AGRyM1tziTdLvoJCoBJbkO7DRAXhFVyr+364fbR7gRRXEGKhwvPkk/aI7s36gIxv1o+ZIkHajvZNpw==
X-Received: by 2002:a05:6402:5216:b0:43a:7b47:834f with SMTP id s22-20020a056402521600b0043a7b47834fmr19484003edd.343.1657204542937;
        Thu, 07 Jul 2022 07:35:42 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906210900b0072af56103casm2784699ejt.220.2022.07.07.07.35.41
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:35:42 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id r14so20832742wrg.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:35:41 -0700 (PDT)
X-Received: by 2002:adf:d1c1:0:b0:21b:a5e9:b7b2 with SMTP id
 b1-20020adfd1c1000000b0021ba5e9b7b2mr45296183wrd.405.1657204541324; Thu, 07
 Jul 2022 07:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org> <20220707075151.67335-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707075151.67335-6-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 07:35:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XOGLH9UH4Bwd3E6RC_PT5A4bf20muhnZoW5Rb8O3b2LA@mail.gmail.com>
Message-ID: <CAD=FV=XOGLH9UH4Bwd3E6RC_PT5A4bf20muhnZoW5Rb8O3b2LA@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: qcom: align SDHCI clocks with DT schema
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
> The DT schema expects clocks iface-core order.  No functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8084.dtsi    | 12 ++++++------
>  arch/arm/boot/dts/qcom-ipq4019.dtsi    |  4 ++--
>  arch/arm/boot/dts/qcom-msm8226.dtsi    | 18 +++++++++---------
>  arch/arm/boot/dts/qcom-msm8974.dtsi    | 18 +++++++++---------
>  arch/arm/boot/dts/qcom-msm8974pro.dtsi |  6 +++---
>  5 files changed, 29 insertions(+), 29 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
