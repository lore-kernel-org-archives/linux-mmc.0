Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F2CC43334
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 14:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiGLO3Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiGLO3Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 10:29:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452621B4
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:29:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w12so9606763edd.13
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpQJKKbtg93cX86UuSBO9tVRJrPAdwmdctCEOdnSRnU=;
        b=ijq11B8dVKWd4WwXQdLWGL47Ff65ZWhCh8I3SE5MaxMAad6+ff+0LigbAoCe2JY4iV
         3LYhRmAzDWby1Q6v0gv1VaqErS7z7UeZOhoWW35oxwjCuJ3tvmQYNhvS3m9DSj3ZipSe
         75C5HfTf7UALfjjpZlu/UxdxlwILLB1WhqUf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpQJKKbtg93cX86UuSBO9tVRJrPAdwmdctCEOdnSRnU=;
        b=xjeXQUNw2FibBXWyb6DkfcYbi2g6zdbKtw3pte4VekkpQVCSIwLjzanUl57VUZdkIK
         B3E3wBbTi5UXIr8b6fcPON7Bz/7wdueNr7oDf64raauSazTfq2FaEO2m9+l4YYeQ4mvL
         jtPpMSODUxVEzyycYxLfuGbVz3rMV7GQYJeWc3IQlS0hG3M1Kkt6I7iIhv2348Xuhnm0
         NLk/sIrH8AT5zhKVk9y60D5Zr79aAuvMV/t71f0ft3VjZCLG8z1mSK35ZsjD70GnHNBt
         EczHEuMBvTa8FQW4M9MTLjXKcbsYXIW9bLPCMWYbQ6bg4PhZX5z6wPdb+O9O90X71SMi
         BnDA==
X-Gm-Message-State: AJIora8rgpybGyDUSu5pvewiZF5wugtUVjDzwer3kMtgILu4LkH1Cgs/
        SArbmRYgQhKI1BDftPLO0Y+j2ds6qKTHwMtJTf0=
X-Google-Smtp-Source: AGRyM1tWeqK/oVjxK0TyImrtiwKj+sUWBRMv2FScELt3o83/BRlvnjMbMS9/V1RuNqkz8ZXFvqSynQ==
X-Received: by 2002:a05:6402:1518:b0:43a:103f:eaab with SMTP id f24-20020a056402151800b0043a103feaabmr31478010edw.280.1657636160714;
        Tue, 12 Jul 2022 07:29:20 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id dm3-20020a05640222c300b0043acddee068sm4297942edb.83.2022.07.12.07.29.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 07:29:19 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id a5so11421303wrx.12
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:29:19 -0700 (PDT)
X-Received: by 2002:adf:d1c1:0:b0:21b:a5e9:b7b2 with SMTP id
 b1-20020adfd1c1000000b0021ba5e9b7b2mr22505619wrd.405.1657636159126; Tue, 12
 Jul 2022 07:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
 <20220711082940.39539-3-krzysztof.kozlowski@linaro.org> <CAD=FV=WUCPzzZHAPqoz-vhmcVxzYDxkKQs=+1tLZvsQjWe4q3Q@mail.gmail.com>
 <f8744ff8-15a0-bf31-c49f-b1bb35ba5cdd@linaro.org> <CAD=FV=X2ZfwwDO_hSSN35ObfvBbBbPjMoSB4GvS7m0yJieNg3Q@mail.gmail.com>
 <629ede41-326b-9c84-4bb8-2f7e695ca928@linaro.org>
In-Reply-To: <629ede41-326b-9c84-4bb8-2f7e695ca928@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Jul 2022 07:29:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7dypM9=uqaY650TGfiV4EaZR9EBH_3svQefyNv-oE7Q@mail.gmail.com>
Message-ID: <CAD=FV=W7dypM9=uqaY650TGfiV4EaZR9EBH_3svQefyNv-oE7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names
 perp variants
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

On Tue, Jul 12, 2022 at 12:02 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/07/2022 17:11, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 11, 2022 at 7:53 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 11/07/2022 16:52, Doug Anderson wrote:
> >>> Hi
> >>>
> >>> On Mon, Jul 11, 2022 at 1:29 AM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> The entries in arrays must have fixed order, so the bindings and Linux
> >>>> driver expecting various combinations of 'reg' addresses was never
> >>>> actually conforming to guidelines.
> >>>>
> >>>> The 'core' reg entry is valid only for SDCC v4 and lower, so disallow it
> >>>> in SDCC v5.  SDCC v4 supports CQE and ICE, so allow them, even though
> >>>> the qcom,sdhci-msm-v4 compatible is used also for earlier SoCs with SDCC
> >>>> v2 or v3, so it is not entirely accurate.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>
> >>>> ---
> >>>>
> >>>> Changes since v1:
> >>>> 1. Rework the patch based on Doug's feedback.
> >>>> ---
> >>>>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
> >>>>  1 file changed, 38 insertions(+), 23 deletions(-)
> >>>
> >>> In the ${SUBJECT} I'm not sure what a "perp variant" is. Is that a
> >>> typo or just a phrase I'm not aware of?
> >>
> >> Should be:
> >> "per variants"
> >>
> >>>
> >>>
> >>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >>>> index fc6e5221985a..2f0fdd65e908 100644
> >>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >>>> @@ -49,33 +49,11 @@ properties:
> >>>>
> >>>>    reg:
> >>>>      minItems: 1
> >>>> -    items:
> >>>> -      - description: Host controller register map
> >>>> -      - description: SD Core register map
> >>>> -      - description: CQE register map
> >>>> -      - description: Inline Crypto Engine register map
> >>>> +    maxItems: 4
> >>>>
> >>>>    reg-names:
> >>>>      minItems: 1
> >>>>      maxItems: 4
> >>>> -    oneOf:
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -          - const: core
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -          - const: cqhci
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -          - const: cqhci
> >>>> -          - const: ice
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -          - const: core
> >>>> -          - const: cqhci
> >>>> -          - const: ice
> >>>>
> >>>>    clocks:
> >>>>      minItems: 3
> >>>> @@ -177,6 +155,43 @@ required:
> >>>>  allOf:
> >>>>    - $ref: mmc-controller.yaml#
> >>>>
> >>>> +  - if:
> >>>> +      properties:
> >>>> +        compatible:
> >>>> +          contains:
> >>>> +            enum:
> >>>> +              - qcom,sdhci-msm-v4
> >>>> +    then:
> >>>> +      properties:
> >>>> +        reg:
> >>>> +          minItems: 2
> >>>> +          items:
> >>>> +            - description: Host controller register map
> >>>> +            - description: SD Core register map
> >>>> +            - description: CQE register map
> >>>> +            - description: Inline Crypto Engine register map
> >>>> +        reg-names:
> >>>> +          minItems: 2
> >>>> +          items:
> >>>> +            - const: hc
> >>>> +            - const: core
> >>>> +            - const: cqhci
> >>>> +            - const: ice
> >>>> +    else:
> >>>> +      properties:
> >>>> +        reg:
> >>>> +          minItems: 1
> >>>> +          items:
> >>>> +            - description: Host controller register map
> >>>> +            - description: CQE register map
> >>>> +            - description: Inline Crypto Engine register map
> >>>> +        reg-names:
> >>>> +          minItems: 1
> >>>> +          items:
> >>>> +            - const: hc
> >>>> +            - const: cqhci
> >>>> +            - const: ice
> >>>
> >>> Do you need to set "maxItems" here? If you don't then will it inherit
> >>> the maxItems of 4 from above?
> >>
> >> No, items determine the size instead.
> >
> > Can you just remove the "maxItems" from above then? Does it buy us anything?
>
> There is no maxItems directly here...

Sorry, I mean above in the schema. After your patch the schema is effectively:

reg:
  minItems: 1
  maxItems: 4
reg-names:
  minItems: 1
  maxItems: 4

...

allOf:
  - if:
      blah-blah-blah
    then:
      properties:
        reg:
          minItems: 2
          items:
            - description: ...
            - description: ...
            - description: ...
            - description: ...
        reg-names:
          blah-blah-blah
    else:
      blah-blah-blah

I'm asking about the maxItems _above_, AKA in the section:

reg:
  minItems: 1
  maxItems: 4
reg-names:
  minItems: 1
  maxItems: 4

Can we remove the "maxItems: 4" from the above and have it just be:

reg:
  minItems: 1
reg-names:
  minItems: 1

-Doug
