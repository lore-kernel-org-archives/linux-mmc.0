Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F0C433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 14:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbiGGOb7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiGGOb6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2022 10:31:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED5F2F3B3
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jul 2022 07:31:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so10024593edc.4
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lY857WNunFqeqIFvxE1vZpLl3WuWGarLzBkhv9eJbA=;
        b=NSB+HwZAGzym7P8P5YzXKsR+yE+p76mZE/kK8486IflBF3t23m7j3+LsvPtzSC2/Wf
         dp7N0rTamqmMKX2sd/ZgWDY7mV3EI7hFiKuc7AgeUHmhbGsvaUEaDApZUyMmZe3m7Hjj
         ySgJA6vxLeoh0FkRpBmq8K4gXxlXxsA+KjtKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lY857WNunFqeqIFvxE1vZpLl3WuWGarLzBkhv9eJbA=;
        b=g0z5MEw0QQ2X2fXM2VB0o2+jydvq2pndxwEdiLqnHsffqV3oi7u4JbR2b9bPTHXtCT
         irx/FQtv7Id7DBZCt4Tok2LL75Pnw2sDBDbC77CqMcZWTcgE5UcS7YGNUQKWdGeN4OZF
         nlIrkd/oCXU9mZyOdIQRI7NPJzTDIE/hEglaGTyGjzsa6C6HnRAKclqqMQSXsQU/v9LD
         iDb+rJjRMpgPC+t/8m/Y+O4RiQUCEGgvt5fYB20pkGSNMBvyLbXtN8jadC5x1Hb0L2dW
         kjgygRsfsRamCQVAm4aQ9JcFrb4cxCAhAT7jTTtFyr+uyd6z9y9zjMCMLYxHF/GICpBY
         TSmA==
X-Gm-Message-State: AJIora/m2ZLjxVsZIH1ie1eVraU+NdRnplBngD9ywTW/sGuGyaIWkG65
        wK/GSwPciL0IqrMhHpSHDjHg1I1KyVju9y/nN20=
X-Google-Smtp-Source: AGRyM1t6oH/OsMETLDM5V4U9ScJhEcPiSapMTl/cG01tFmxbAEP2VgW+3BQrZkNn/O2AYbpnWg8JEQ==
X-Received: by 2002:a05:6402:3590:b0:43a:8156:e842 with SMTP id y16-20020a056402359000b0043a8156e842mr15839067edc.219.1657204315089;
        Thu, 07 Jul 2022 07:31:55 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id q25-20020a17090676d900b0072ab06bf296sm7438145ejn.23.2022.07.07.07.31.54
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:31:54 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id l42so1073878wms.5
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2022 07:31:54 -0700 (PDT)
X-Received: by 2002:a1c:4c0b:0:b0:3a1:92da:bddf with SMTP id
 z11-20020a1c4c0b000000b003a192dabddfmr4827050wmf.188.1657204313641; Thu, 07
 Jul 2022 07:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org> <20220707075151.67335-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707075151.67335-3-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 07:31:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFdtx_v3iPaNYDkhBw+fkSRriG0-w1R5vXRCugZPW6Vg@mail.gmail.com>
Message-ID: <CAD=FV=WFdtx_v3iPaNYDkhBw+fkSRriG0-w1R5vXRCugZPW6Vg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names at
 least for one variant
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
> The entries in arrays must have fixed order, so the bindings and Linux
> driver expecting various combinations of 'reg' addresses was never
> actually conforming to guidelines.
>
> Specifically Linux driver always expects 'core' reg entry as second
> item, but some DTSes are having there 'cqhci'.

This is a bit misleading and makes it sound like we've got a bug. In
truth the Linux driver looks at the compatible string. If it sees any
compatible listed as "v5" (or a slight variant of v5 to handle a
workaround for sc7180 / sdm845) then it _doesn't_ expect 'core' reg as
the second entry. See the variable `mci_removed`. The old bindings
".txt" file also had this to say:

                For SDCC version 5.0.0, MCI registers are removed from SDCC
                interface and some registers are moved to HC. New compatible
                string is added to support this change - "qcom,sdhci-msm-v5".

So I guess that means this is the documentation for all of the
combinations you have listed:

* hc only - v5 controller w/out CQE / ICE

* hc + core - v4 controller w/out CQE / ICE

* hc + cqhci - v5 controller w/ CQE and w/out ICE

* hc + cqhci + ice - v5 controller w/ CQE / ICE

* hc + core + cqhci + ice - v4 controller w/ CQE / ICE

Said another way, before v5 the "core" range existed. After v5 it
apparently doesn't so there's no way we could have specified it.

You'll notice that one of the options above implies that a v4
controller (with "core" specified) can have CQE and ICE. Is this
actually true, or was it a misunderstanding in the .txt to .yaml
conversion?

If it's true that a v4 controller can have CQE and ICE then your patch
is wrong in asserting that v4 controllers have only "hc" and "core".

If a v4 controller _can't_ have CQE and ICE then your patch is right
but incomplete. It should also be removing the option:
          - const: hc
          - const: core
          - const: cqhci
          - const: ice

I am not intimately familiar with Qualcomm MMC controller history.
That being said, the old .txt file said:

        - CQE register map (Optional, CQE support is present on SDHC
instance meant
                            for eMMC and version v4.2 and above)

To me this implies that a v4 controller could _at least_ have "cqhci".
I dunno about "ice". I seem to recall that this was the argument for
why the driver had to use reg-names to begin with and why the driver
looks for "cqhci" by name.

-Doug
