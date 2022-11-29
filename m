Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B417BC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 15:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiK2PbV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 10:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiK2PbS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 10:31:18 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4758B63CCB
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 07:31:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so6776982pje.5
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3fVszqxgQ016BSb5qNf+hCvyWQbfpRSMkXlPPrp4GVI=;
        b=bSoOisz9I9mHhMJiRBlqA98mcW26hkx7Xp/+fcTXZMmZBqyh1NAeNuhydDzv6eniZC
         UnhSBrDa3rOJUZ0VLUoEvXiSqNsAhcw3I5PiP8hpBWT6Pt33fbt+MTOr3911YUILLMsx
         X7d39KEEaQg0aOqHk6fOE6sy6Y5atjhFiv53VzRKof/3dSjO4BVCCWNCgZLcku1xFegj
         eNnGq+i7vNumxfZVraDv0AlhybJTPThiFPFGXaHDCFRAv3Q96CyDdeGMCILaRv82dd6z
         y3jPFZvGNVxeggjlx8KnjL0sl1novb60iZwlh0keCyMvHVdG11rFb6lmUFPdi/NOyK8K
         sLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fVszqxgQ016BSb5qNf+hCvyWQbfpRSMkXlPPrp4GVI=;
        b=gH6G4gZeUi6NpuqTY/Z61ViEClmHyjmozITwTt2IV+sZlIMum1c41RZgU+5xT+3+iN
         9VmKAnp557NYsphcQ+80GcdzeJx9WUP9rNWcF4xq2gyyEC3mDaCodKDxfqG+M96fX4OI
         K43ohBbBcXFZvNSg3AfwBZVWRDyymXhz1PKvM2XVIVzuOwnYpjp6lFNe7NG932fJQ9iV
         hC1uD34Dx2RVZkmz5D2T3ZssZli3ON1xazBJToKY1SB/NZnh9kYlIqYFEgiQtyCilxyd
         MoCAETnxjiVifi1/AASo3zpATECKzpzfI4zI9gS75HTLuVU86cv/gjDADbFueAZYAaNU
         eo9w==
X-Gm-Message-State: ANoB5pmWtOpCCNHOoUFdWxgkRoQkA/vG64KF9LOAgaJ++LYcCi3tuQjz
        fLHkddw4zc7bsKYj6mc3vEArNNy5qSAbpovpVOSrzQ==
X-Google-Smtp-Source: AA0mqf5ik5i4ChFnRvy/bmtuc8PRZp06XQinOIdUlzKVikOtmWsKfjSysf196kcbBAdsx08nJT52ptjgdMON40RNQ9k=
X-Received: by 2002:a17:902:d68b:b0:188:cca8:df29 with SMTP id
 v11-20020a170902d68b00b00188cca8df29mr44499277ply.148.1669735873662; Tue, 29
 Nov 2022 07:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-3-cniedermaier@dh-electronics.com> <55c29f92-4c6b-266f-2004-ae633a658963@linaro.org>
In-Reply-To: <55c29f92-4c6b-266f-2004-ae633a658963@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 16:30:37 +0100
Message-ID: <CAPDyKFparoXMJ-sRxgqi8zDGn5AoNDLfsAF9YkdoaKpTU3EchQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less confusing
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 29 Nov 2022 at 13:36, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/11/2022 12:11, Christoph Niedermaier wrote:
> > The current comment on wakeup-source is a bit confusing, because it isn't
> > clear at first sight which property is actually deprecated.
> > Change the comment to one that is less confusing.
>
> It's still confusing - you mention some non-existing property. I don't
> think it's worth to touch it. If you insist, drop entire comment...

Hmm, it doesn't look that easy to me. The "enable-sdio-wakeup" is
indeed a deprecated wakeup property [1], but it seems like it's not
really described somewhere. I wouldn't mind removing it (as it seems
to add some confusions), but in that case it needs to be entirely
removed from the DT docs, right?

Another option, would be to add a proper description of the property
and mark it with "deprecated: true".

>
> >
> > Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> > ---
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: kernel@dh-electronics.com
> > Cc: linux-mmc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > index 802e3ca8be4d..a921442c6c1d 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > @@ -293,7 +293,7 @@ properties:
> >      description:
> >        SDIO only. Preserves card power during a suspend/resume cycle.
> >
> > -  # Deprecated: enable-sdio-wakeup
> > +  # Use wakeup-source instead of the deprecated enable-sdio-wakeup
> >    wakeup-source:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:

Kind regards
Uffe

[1]
Documentation/devicetree/bindings/power/wakeup-source.txt
