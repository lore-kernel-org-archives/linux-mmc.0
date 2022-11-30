Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FD4C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 11:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiK3L54 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 06:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiK3L5y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 06:57:54 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD63510079
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 03:57:51 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w129so16605620pfb.5
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 03:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPDD92aY5IkTDUm0AI88V6KsAntfL3f78DeuvRzGvOM=;
        b=gJFEf7gFsMnlSQpBr5KEIt5Psur+Fhv7TOvTVRy6K5MMkpva5lKkiMdT4uItObth6J
         0FzYQRO2YbzMuerlOFLXHzWM5M3tYOs5MxdXnu7iSdCftJ54HCCC+WKbhVO82CFrZNIc
         C5Gc7fvKH1INTTDCOGPdLBhDWkIohTBWgmvKdL6lPS4sRllC13VA6dr1/TXw1v61wcH9
         6EjcYpwB/GUsYm5ccQw2AcNJIyC77bzbGS1uk/6NsOsb4DSYY+QufHq8AR4YOwHcFEnn
         w6oPTQfPwZVoPC0dJvmm9vuolcShlc8eETnFqZqiZcitya5SsXYqt29AtB1N+RGPNYH9
         Yg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPDD92aY5IkTDUm0AI88V6KsAntfL3f78DeuvRzGvOM=;
        b=lU2FZ/atfIfyw5cPaqxLA+nmrQ3wkolFiWglgEkJq4pdN1Xw9K6By+dsXaEUnlVWGG
         5wa+DdkZKi6nhsSBU6yfvcFacLcndWQJOD3jwuRCEZtaJYSodsYrSaITL0DfwcruP/Os
         SHUjTnzd+oXrXw6UGIhnLRRESTPC65ZIg574UrlgEIZjfGiVX5UaSH6yU11iInedmwS6
         mWe/2jCS0hbBElhXp8SsjW7vbc6Ur3oPcPZeH9jQvzojoenQj0QlZgEjtJlbeUaDpoQu
         yF2bUm0+KTy7qEbq0D8FNI5u9HfMHTnpg8uqitx2h3jIABqAW4bL9uwh/NEInqwAXySm
         LjWA==
X-Gm-Message-State: ANoB5pkRMET6jwkDsbv+yT9LchMMycyy6c5307e96nA1GngMt4O35F+I
        HWpkZ4DXmxXd+jIAjp4+FYyYuIwQahFLurXQvVWc9Q==
X-Google-Smtp-Source: AA0mqf7EAo/yINVgmXn1/T70ufIfXqN2h6gc2Kx2rj1rmrErgBCihDYj3FxMaOL9Pg+2q1QlIo7A7fy4gsavegxAHNA=
X-Received: by 2002:a65:4688:0:b0:477:7aee:a464 with SMTP id
 h8-20020a654688000000b004777aeea464mr40156253pgr.595.1669809471316; Wed, 30
 Nov 2022 03:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20221130101852.5408-1-cniedermaier@dh-electronics.com>
 <CAPDyKFpZnnx_4+NmsVewMs8duDqf=qY57a134QD+1NdcKRnK_A@mail.gmail.com> <adc58f49cb0c4de6b95d203f4b5440ba@dh-electronics.com>
In-Reply-To: <adc58f49cb0c4de6b95d203f4b5440ba@dh-electronics.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 12:57:15 +0100
Message-ID: <CAPDyKFoMQH=XnF=v9nCg0=xws985nXCDNygCLKkuY82Nt4VLyg@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: mmc: Remove comment on wakeup-source property
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 12:55, Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Wednesday, November 30, 2022 12:40 PM
> > On Wed, 30 Nov 2022 at 11:20, Christoph Niedermaier<cniedermaier@dh-electronics.com> wrote:
> >>
> >> The current comment on wakeup-source is a little confusing because
> >> the word deprecated can be interpreted at first glance to mean that
> >> wakeup-source is deprecated. Also mentioning the obsolete property
> >> confuses more than it helps. Therefore, the comment should be removed
> >> completely because the enable-sdio-wakeup property is not used in
> >> any current DTs.
> >>
> >> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> >> ---
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> >> Cc: Marek Vasut <marex@denx.de>
> >> Cc: kernel@dh-electronics.com
> >> Cc: linux-mmc@vger.kernel.org
> >> Cc: devicetree@vger.kernel.org
> >> To: linux-kernel@vger.kernel.org
> >> ---
> >> V2: - Instead of changing the comment, remove it
> >> ---
> >>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> >> index 802e3ca8be4d..e82c00368088 100644
> >> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> >> @@ -293,7 +293,6 @@ properties:
> >>      description:
> >>        SDIO only. Preserves card power during a suspend/resume cycle.
> >>
> >> -  # Deprecated: enable-sdio-wakeup
> >>    wakeup-source:
> >>      $ref: /schemas/types.yaml#/definitions/flag
> >>      description:
> >
> > This looks good to me!
> >
> > However, let's also drop the reference to the property from
> > Documentation/devicetree/bindings/power/wakeup-source.txt.
>
> Should I include this in a version 3 or should I send a separate patch?

Please add it in v3, so we can remove the confusing things altogether.

Kind regards
Uffe
