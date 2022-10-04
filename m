Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDBC433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Oct 2022 07:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJDHgR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Oct 2022 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJDHgP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2022 03:36:15 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45CF49B5A
        for <linux-mmc@vger.kernel.org>; Tue,  4 Oct 2022 00:36:13 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 203so15811955ybc.10
        for <linux-mmc@vger.kernel.org>; Tue, 04 Oct 2022 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=epQv7F2qJ84iAW4L5349YGXrHzlAKAVIa/bBXFB0Ad4=;
        b=P8ChbWpT0YG30J3zUr9FXH2IBiHLJImXbnh3Bp6QCr7ycn4os8DwkN4zVxe9jwYCqh
         iIt4Vw+qQeooAwfOIFjtcyhWbY60qsSvde1i9B1qlQycypAtDrAE9i1GayX9ihwQ6Iup
         xtPOOj2tH08HkIZX0cWdUb1kAHdMa962GNiccPwqpfScp3TLt8e6enqb+fFbr3Z8yk/W
         JIDHS9gPyiytvYZmDh5rvQbfx8FmrC3lEQtaJwMFyLzpjXqGRkKUPbJCmKF3j7jR50zr
         hwX2sodAOGDV29UG4gtx/51/9Ak51BAhacwwBK+R++g6UDs+C4wIosMpsOF6AMTOkWHX
         3puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=epQv7F2qJ84iAW4L5349YGXrHzlAKAVIa/bBXFB0Ad4=;
        b=xxGIVYp2F/EHfT6Qw1Yrmi2nmeyfgDnIC5w64QpqI48ZrRrVQ/gm+rT2c6+mcyZkK4
         ajJOH+LG58BwrnnQMJX8Y4xJVzIDoEt9Rd0AHvJcc87O984U24na7XeTeMNSzt1Wm/4w
         Sv1Ccr3ZDPZ0KqCUhIyD5rMal7WLv7eorouu4RHmxlAhwdgxI9WqOSYmzTUwDxjsMPQK
         xIRkpC4z2pHyaVdDTGTuHSjyJ6c9xz5HeBkB1+Hl0Ekz2j7AURQbg2wkG88FufUJ5A17
         MO/m4xscDvVtJs/YVA5ZKTx0FkvTd+CFmAbyR6vRlHGzWYfmOYPP3rExLPwA5tgpNcFt
         AJWA==
X-Gm-Message-State: ACrzQf0jh/2X7Pg6q3xR4sRcqOINl3F2W1Xvo4ZXmi0zk9JloqS53XJj
        /kf5sTcUhp+QvBgXIsf2c58bsmAjhDESDeuYEXVNXQ==
X-Google-Smtp-Source: AMsMyM6+w9SWD7hb7k99VJI3GyDPbYFNuQ+U244465sm48x/yJocpc335gm0ixgO8BVhLnpDafAZBq+Iq06T0RuuEUE=
X-Received: by 2002:a05:6902:102e:b0:6bd:bdd2:ac32 with SMTP id
 x14-20020a056902102e00b006bdbdd2ac32mr8599365ybt.516.1664868972999; Tue, 04
 Oct 2022 00:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-2-quic_molvera@quicinc.com> <09f5d364-320e-9ecc-2c2b-68066c61f802@linaro.org>
 <e9c44e3b-b29f-0f47-b822-da0f4f2264cc@quicinc.com> <CAA8EJprE-mOOH8VF3m8TRb+0q=3_8NpvzdEAugabDaDbq6FMVQ@mail.gmail.com>
 <9664a623-3c58-49e8-1b9a-69335d844448@linaro.org>
In-Reply-To: <9664a623-3c58-49e8-1b9a-69335d844448@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Oct 2022 10:36:02 +0300
Message-ID: <CAA8EJprQoCQzr2x0JA9_b3MDE=oOTODyHD23debEL1MCE1mWBA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatibles
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
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

On Tue, 4 Oct 2022 at 09:53, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/10/2022 00:14, Dmitry Baryshkov wrote:
> > On Tue, 4 Oct 2022 at 01:02, Melody Olvera <quic_molvera@quicinc.com> wrote:
> >>
> >>
> >> On 10/1/2022 4:25 AM, Krzysztof Kozlowski wrote:
> >>> On 01/10/2022 05:06, Melody Olvera wrote:
> >>>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
> >>>>
> >>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>>> index c5b76c9f7ad0..b47a5dda3c3e 100644
> >>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>>> @@ -51,6 +51,8 @@ properties:
> >>>>            - qcom,scm-sm8250
> >>>>            - qcom,scm-sm8350
> >>>>            - qcom,scm-sm8450
> >>>> +          - qcom,scm-qdu1000
> >>>> +          - qcom,scm-qru1000
> >
> > I think after seeing all the patchsets it's time to ask the following
> > question. Do we really need a duplicate compatibility families:
> > qdu1000 vs qru1000? I'd suggest using a single set of compatibile
> > strings in most of the cases.
> > Settle down onto a single name (qdu,qru, qdru, whatever) and define
> > distinct compat strings only when there is an actual difference?
> >
> > E.g .we don't have separate compatible strings for all the sda660,
> > apq8096, etc. unless this is required by the corresponding hardware
> > block not being compatible with corresponding sdm or msm counterpart.
> >
>
> I am not that fluent in Qualcomm naming, so let me ask - what are the
> differences between QDU and QRU?
>
> For compatible (and/or similar) devices the general recommendation is to
> have specific compatibles followed by fallback. Even if devices are
> very, very, very similar, usually the recommendation still stays.

Well, true. But in some cases we handle this by using a single set of
compatibles. Consider e.g. sa8155 vs sm8150 (sa8155 overrides just few
compats that differ). Or qrb5165 vs sm8250 (there is no separate
qrb5165.dtsi). APQ8096 (#include "msm8996.dtsi"). Etc.

I'd say this really depends on the actual difference between qru and qdu.

-- 
With best wishes
Dmitry
