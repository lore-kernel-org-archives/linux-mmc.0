Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A31CC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiGKOxd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiGKOxc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 10:53:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB90C4
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:53:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so6580644edc.4
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+DfESfcXMEMmXuDDJXvPYmOkPUKFW71mpdMtJevL6Y=;
        b=k7PwvkOX9vMswnngnpFJUR2Yim1tQzngfTgvN+kCBYpI1huL1ZQcx9t9kq1P/LJt/R
         PF2+6hYpLabGkw3gMvvi/HqDFOnXjayJCtaIrlo9A4HZqGWfd5eA7Ox4gFkYsY5QY6+N
         wIuDOcK8xlSMPM8Qu5fedhAMOfkNGz4Ew5pik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+DfESfcXMEMmXuDDJXvPYmOkPUKFW71mpdMtJevL6Y=;
        b=bU+COckWEqP+V6cTUjywU4EJkwaIdnkeC/JpbvxVGUflqRaLKZ3WSFIcrxeCRRZwyr
         O4A8dbRMLW8a7B0QUavWJT4RYOPlfKgm6Cq0t4E91D3eTxVEQK2aqRw2MtryZXuUiSyO
         RlrdOHJH0VL76Yh1yNuG80t8ANjXp7E6iadCXSKYfdZ2cIAUX49dil/cf6f/+64NnPuw
         G2PIieCpDdMXh4V55022YuohR0ZlDvztbMZ88dnmnBStJZmZG3uputsUioHTyMymISH2
         HYBNJ6nUo6X7YKPZn8Kmk8X8UOzxSfX6jMmCqEMBUqRAzxRuSc+w4ieWpIA3tqE7ZctB
         6tSw==
X-Gm-Message-State: AJIora/aYLzRhEusgg8mZ3UugGbft85BIw5XbJMlzfPE+n49qp7wWhr/
        c1RRKdBsBHH/DPc6xiWxfllTzN98If53DyRr
X-Google-Smtp-Source: AGRyM1v0x37zd10UEIlvzh73CTnw1MbJbI3XGIgraz0z9eBCUVJ3Qu2w1Wm9Xd/HszX3iPnTUeqjOw==
X-Received: by 2002:a05:6402:40c9:b0:43a:a20d:3fe5 with SMTP id z9-20020a05640240c900b0043aa20d3fe5mr25282902edb.154.1657551208593;
        Mon, 11 Jul 2022 07:53:28 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906190f00b006f3ef214ddesm2730683eje.68.2022.07.11.07.53.26
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:53:27 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id f2so7349007wrr.6
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 07:53:26 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr16792836wrr.583.1657551206156; Mon, 11
 Jul 2022 07:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 07:53:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ue+LUHKmG_ceMO-qGqJXkmqMcvyjLFCGNK8s2VBDDd2A@mail.gmail.com>
Message-ID: <CAD=FV=Ue+LUHKmG_ceMO-qGqJXkmqMcvyjLFCGNK8s2VBDDd2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-msm: add MSM8998
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
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
