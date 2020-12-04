Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1867CC4361B
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 13:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D597222AAC
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 13:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgLDNTi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgLDNTh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 08:19:37 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C24C0613D1
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 05:18:57 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id p7so3201863vsf.8
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 05:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBNEUh/XtKi2eD8HVG/5DioPhKz6ioH7lNEIt4K6i5M=;
        b=aKkZitLkekd1Pooc4uxJqdRoZrdBSSK03Ev4OkjKehsx5KXNePG+CHpBTUhyd+IYzc
         DWtP/RMlpDFFlztdBtCHZ/70g+C2K3+CF4DyLh5rubI74X0jrlg1SDJkmNh19LbqDLHL
         3wRYZgKsmMPjezrWjyMarchMH4EzGKO+2dYfBJpiGqWIsjOFh56F6VdFU5c2kN4uMvzd
         xZqiPfvtqPL+hrhK2gzKHtJvrYsfGGpwcYeOyMKUnz8K3gF8PTL3AqYKwkBlsuVfdyva
         kTZa/7w7yJIpQk5+M19rKJ0jsiwkMhqk+8XuLVx5rtPAfJE1H8LI7sndoB8jEZzwZolk
         Omaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBNEUh/XtKi2eD8HVG/5DioPhKz6ioH7lNEIt4K6i5M=;
        b=t6DltEI0dA5Vt9hmPTrzT3HwP1CsK84SitmDT+3WszVanszonwYiE1rSv+Cq5gGGxH
         WKRjGtHidLIC8Af1L3f23A0kTDFw3w8dTud+kNT+rBcyCBnLT/fvLZAPFAkEOEde8zhc
         BNOpf9O6buRQUbHAlPisNks7/END4ekFqA7NcXmIxjOa8GmPNcaFVA5DhiZG7JGtIVlW
         UCbOGAjsZIcirk+A0/PyzINssP340yQEZFGSlD2tZjvlI73g5tSlvlDwji2y7bzIP2F/
         NntJUhOs8TI8df/G0+t24a6wdk/3mG1LfbDJYkLG5oHmIRaVRlBXM61J4t9hO5MGPyI2
         QTcg==
X-Gm-Message-State: AOAM531Yb313jeqwUSskM5r0C1VfWNSTCJolUwmZiweJsp/AmIMqMb9t
        X3puLyMuVQOZy5bl2y5eXKuzq6UzxV0r0Mp4Ohc30w==
X-Google-Smtp-Source: ABdhPJwflJcYgzBlpRuR7y9qVoINWYG/pPFk/3b4tu5anT1AGwT4XzvkQsH3wpuoouw6UhvB+0k2/CNbdiy+8PMuEqE=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr3446383vsg.48.1607087936378;
 Fri, 04 Dec 2020 05:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20201129203116.11987-1-adrien.grassein@gmail.com>
In-Reply-To: <20201129203116.11987-1-adrien.grassein@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 14:18:18 +0100
Message-ID: <CAPDyKFp0U5=s_AJh4-QAn=WCodkYUaFE9BuLjpJB80z23J7JkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add an option to disable HS400 for fsl
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 29 Nov 2020 at 21:31, Adrien Grassein <adrien.grassein@gmail.com> wrote:
>
> Add an option to disable the hs400 support in the fsl esdhc
> driver.
>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index e71d13c2d109..070b40ae8c44 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -101,6 +101,10 @@ properties:
>        If not use this property, driver default set the delay target to value 7.
>        Only eMMC HS400 mode need to take care of this property.
>      default: 0
> +  fsl,no-mmc-hs400:
> +    description: |
> +      boolean, if present, indicate to disable mmc-hs400 support.
> +    type: boolean

You need to disable hs400, because the sdhci capability register
wrongly claims it to be supported, right?

May I suggest using the DT property "sdhci-caps-mask" instead?

Kind regards
Uffe
