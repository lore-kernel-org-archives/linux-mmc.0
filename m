Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A950C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Oct 2022 22:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJCWOO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Oct 2022 18:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJCWON (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2022 18:14:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7732EC9
        for <linux-mmc@vger.kernel.org>; Mon,  3 Oct 2022 15:14:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n74so616900yba.11
        for <linux-mmc@vger.kernel.org>; Mon, 03 Oct 2022 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5FZVe4qgx0VvS22BuyLf2t6tSB6jCkuSkQ/O1CHtM3Q=;
        b=VcY4r82G7gHdeYUFFoYACviWj/qy2778vE5P5cUgPX5rJ4Am9rDQT1DSnJOt7jIgQD
         iILfYNH7faJ/NBW6BiX+bUp0RKKWXwFp6NXsQFLc2I0Z/adzj3zl0d3cjVa5xufWon4T
         syr8jsukj9it8KBoEafQMUdtTHl9hPVELSUMMhP+clMoi19xYwuozv+T+0qopdx+l0Wl
         dh9CWdHg7U6v3o6GjaNP5FGSMwBOT2qdP5HEsreksKBEy0wtZ62tslUg8nhx9lDqGRCZ
         D07cmU/uJ7auZo0aCHRIHpj6Wgm7DPVCUJKJ4NwRHkiXbaH9JPpNGai6SeMcNaJxH6n8
         EMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5FZVe4qgx0VvS22BuyLf2t6tSB6jCkuSkQ/O1CHtM3Q=;
        b=Cx9cVL4QNdUrmPw8lP/gelZudGwcLo/xAKJvxP5gs3U6Wet0RuzOoe1ugs6IObQhvE
         895vlIC8scIhZ3sARDJOnJyVk79pPK6YEa/JlMrKP0VNZUbCXfNGqrCAPj1AjqUSTqwN
         /pYfmHpdtuUot6j8YKvZuHVyatBTj/VYaCXGQfCMmVI/NKAAezijfdQACP+P3mWbziW4
         /rGfwQuFRwdfaRs8gLWf4MkzOBJwr+NkdVnW/p6wgr0bTm19obkYrQ36WwLLH0i6tQL/
         t27xXrXu2xn9KJB/WR2aPvuCeAtSt3/M/l+rmwCEB+JjpYf9Q6aYTqxsGLl2fkoqxy6u
         +2ew==
X-Gm-Message-State: ACrzQf3ZRDJ1Xkk81FDtINNXkYl5XnO9edkqQnBE/RJKW6yrKDFFTVGU
        adPgJ/DYBROnFCTtbgo/xCwMIxU7vikA42sWCn0nsw==
X-Google-Smtp-Source: AMsMyM50iuzbg50mfv02VLKAqIUzPFceoAfv9Ta62zYqvc7Msa9SH+aEBaFaPaaRG9C/g9GCEVWNCEr29yIgQu/mqrA=
X-Received: by 2002:a5b:c:0:b0:6bd:f84c:b63e with SMTP id a12-20020a5b000c000000b006bdf84cb63emr3690764ybp.275.1664835251547;
 Mon, 03 Oct 2022 15:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-2-quic_molvera@quicinc.com> <09f5d364-320e-9ecc-2c2b-68066c61f802@linaro.org>
 <e9c44e3b-b29f-0f47-b822-da0f4f2264cc@quicinc.com>
In-Reply-To: <e9c44e3b-b29f-0f47-b822-da0f4f2264cc@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Oct 2022 01:14:00 +0300
Message-ID: <CAA8EJprE-mOOH8VF3m8TRb+0q=3_8NpvzdEAugabDaDbq6FMVQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatibles
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Oct 2022 at 01:02, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
>
> On 10/1/2022 4:25 AM, Krzysztof Kozlowski wrote:
> > On 01/10/2022 05:06, Melody Olvera wrote:
> >> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
> >>
> >> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> >> ---
> >>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >> index c5b76c9f7ad0..b47a5dda3c3e 100644
> >> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >> @@ -51,6 +51,8 @@ properties:
> >>            - qcom,scm-sm8250
> >>            - qcom,scm-sm8350
> >>            - qcom,scm-sm8450
> >> +          - qcom,scm-qdu1000
> >> +          - qcom,scm-qru1000

I think after seeing all the patchsets it's time to ask the following
question. Do we really need a duplicate compatibility families:
qdu1000 vs qru1000? I'd suggest using a single set of compatibile
strings in most of the cases.
Settle down onto a single name (qdu,qru, qdru, whatever) and define
distinct compat strings only when there is an actual difference?

E.g .we don't have separate compatible strings for all the sda660,
apq8096, etc. unless this is required by the corresponding hardware
block not being compatible with corresponding sdm or msm counterpart.

> > Items should be ordered alphabetically.
> Will fix.
> >
> >>            - qcom,scm-qcs404
> >>        - const: qcom,scm
> > Patch is incomplete. Missing changes for allOf.
> Will add.
> >
> >>
> > Best regards,
> > Krzysztof
>
> Thanks,
>
> Melody
>


-- 
With best wishes
Dmitry
