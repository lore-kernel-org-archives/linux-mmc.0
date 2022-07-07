Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D331C43334
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 14:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiGGOd6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiGGOd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 10:33:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF02B286C6
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 07:33:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so32716825ejj.12
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Qaml/77EQfjVhTCPwJZGqOZHtYBkRsro8IPW1LDth0=;
        b=nGfPTVAksZnzIOYm3NKGz8gMMXNR8VQHECNNmE3N0p4ZtbshAnhr3JQ4+Fisy6PmVw
         DRHRkgubLyYcUlKfxZq/e8nSnXjAtIKNR3YM3AT3ODuVedDkx5EZ0mPt9QtVzWFQFaSO
         y1eXzyiTvypdbAAfNwawa+5t2TnhAqO0Z6WLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Qaml/77EQfjVhTCPwJZGqOZHtYBkRsro8IPW1LDth0=;
        b=H3844ccCLTpzF4jc6XYh95DyPU+93AJLtcO/2U5fU/ZzSoH7cDqE4w4sSd+s7PyNZr
         tvDZtqYCB3MLA/z+l1r8Tmj/DEllhzFLT6lBs17vCdVyxF2zNoGp6CAF+/jqVUY6bU0t
         ys+Lri2tZ4adwnO4R5N0gk2YUyiM/tuNBZ5Z0HCjNm8v0XQ3FT0PpDacTjRSu2pLzJlT
         mkzYPZu2d6Gk3PxWlDsjBkr+bKm8ErMD+zHEp5fIfGCO6hbieWzS1tXLTJuZLZRwNkYh
         zJADjvwjn+jgEYMGw8YkgMgQhx+vjS5ULsR8OQn1UU9KxHMhykRjv7liF027t2539rm+
         9y2A==
X-Gm-Message-State: AJIora+CNonXimqnfApXY7vM1yGQxs3sJ6BbPt0cpRGXL7jZSt/1F0xz
        Hl4/x6DMuy9Mn32DdiojUhmZ5LpfLpnEvKpoE3c=
X-Google-Smtp-Source: AGRyM1vU4mmd30Vqh8RxUxJM7jNQMQisklK52MMzNq0m5RAXhye7HBke0WR+M9lHnuAvxTtEUlYzUg==
X-Received: by 2002:a17:906:284c:b0:727:3773:1a53 with SMTP id s12-20020a170906284c00b0072737731a53mr44256658ejc.765.1657204433111;
        Thu, 07 Jul 2022 07:33:53 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id o19-20020aa7c7d3000000b0043a75f62155sm6825137eds.86.2022.07.07.07.33.52
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:33:52 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so10850132wmi.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:33:52 -0700 (PDT)
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id
 p9-20020a05600c204900b003a0536bc01bmr4978327wmg.151.1657204431600; Thu, 07
 Jul 2022 07:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org> <20220707075151.67335-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707075151.67335-5-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 07:33:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2d_TCqr+YHV0ep=4o9eqLY7YvF8Khxm2Vsi3uG11nPg@mail.gmail.com>
Message-ID: <CAD=FV=W2d_TCqr+YHV0ep=4o9eqLY7YvF8Khxm2Vsi3uG11nPg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: align SDHCI reg-names with DT schema
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
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
