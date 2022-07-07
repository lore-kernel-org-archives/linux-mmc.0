Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6630CCA479
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 14:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiGGOcM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiGGOcL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 10:32:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336F2F669
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 07:32:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v12so10766884edc.10
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AFexh2zgEl0TUS1BpdjvCEcYJ2S40IdgLkQGQ1nAyg=;
        b=DdMEbA8mazmcWoOmd4X7+rwrMU50Nl2RouFMQWjq5AiJRuD9yqY6W1v6xCMAvP/QpS
         LmGz2dVeW88jXWmqFwOAHUuC17oH51eq2VPRdGjihxZAV2ny33uDXEMAUntg/XZPlJKJ
         BiZG8CUBuOCysVTKexYbDpLXlIvQxYszmSUn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AFexh2zgEl0TUS1BpdjvCEcYJ2S40IdgLkQGQ1nAyg=;
        b=CnajVJ8PFwXy2vaFN4+I3f4/WuWduyStm4iysHWju22/1QpEEF/jI4rgv09fFG6Grc
         9wtmiCrFJVD49hUG8fRvJ6bl36PFXalmYzCLiF0azWhsdDgp7/ltics/nhNHuPI0PLTt
         Lolf1QdUfE6W8kVXgOrFyvwUdF3auRvoaLXJr1UzRro/uHy5N3tELOGbCqZM6wvVP3bc
         BU3yMRQngRhZ/bSItwaMbi80jXK/au1rBhQ6vb+qFOAuLAB9/uPAEIITa7a0bd2OggVF
         /qzm/BbWhVXuJs0EstdDdyxN5dauxae+MehVzT0eGdVaCzQGmBM+Wg8EiQvxYkfhIIUo
         7Alw==
X-Gm-Message-State: AJIora9nDq75/BzAIQ+koQPsM9kCZ+sq3Er4bWUV88NTuwZ8RdCOhzwc
        ZTWxNv1hmQbrtM7f7I40JcVDBwdl6JVtCL1CCcc=
X-Google-Smtp-Source: AGRyM1uF/KEddW9Tzpos9P2AtJYewT3wKEPfv5HuIbiaEi7z3ufmVRj0Y9EtA5NuOKjGKYCCO1bRcg==
X-Received: by 2002:a05:6402:510e:b0:435:9052:3b16 with SMTP id m14-20020a056402510e00b0043590523b16mr65027777edd.20.1657204327448;
        Thu, 07 Jul 2022 07:32:07 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906094800b006feed200464sm13657893ejd.131.2022.07.07.07.32.05
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:32:06 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id bk26so11525164wrb.11
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:32:05 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr1190056wrn.138.1657204325372; Thu, 07
 Jul 2022 07:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org> <20220707075151.67335-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707075151.67335-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 07:31:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcUNLrVST5h0ED9ScpJDiaNoVc2hE-FcOCJGD7zxY-Ww@mail.gmail.com>
Message-ID: <CAD=FV=WcUNLrVST5h0ED9ScpJDiaNoVc2hE-FcOCJGD7zxY-Ww@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: mmc: sdhci-msm: fix reg-names entries
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
> Bindings before conversion to DT schema expected reg-names without
> "_mem" suffix.  This was used by older DTS files and by the MSM SDHCI
> driver.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Fixes: edfbf8c307ff ("dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
