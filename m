Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C8DC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 12:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFCD2311F
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 12:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391647AbhAZMqF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391805AbhAZJ7j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2021 04:59:39 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9A8C061351
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:48 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id w187so8710648vsw.5
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2QpuY8rM4toyVpou9vFx2TY09PAPQwcRntc7oTA0is=;
        b=REheRH86QOMZ/fp5spJI+HYISUR+or1vKvxmyLai8utojsCRMMqRZNCOUCtr9iDzzT
         XKCjgZykN3eQ+Yd4tWF8Nx84mDqCcPaAX51DnmV1EQb0s+BU7FQ4/dGwbq8Hjyx4lb8X
         1bz23M3gWrmtbp0qNqGFhbDKnqcf/r4Nv8yHm996ztOvPdgDCz+F3cpsXgpcSvwX9/BB
         5M1Ld2sSZPlcwZEZgnauow/fO1i+zZ2dRrWkLhVtJm6FyvYm7Mzu7FdKu0qA41KQHY+c
         5mtgGQP6aqes5Uoo/O6YvxTu2aLRM9Al9fxuL8529+GWQY26Y2Za0GGLeltGrnjt6kff
         l6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2QpuY8rM4toyVpou9vFx2TY09PAPQwcRntc7oTA0is=;
        b=CwPuuvcPwg37aONrb6OWCxbJ6MsTyhaGYGyGRnBEfVU3ZSVTogtG9U2ZmtR/zxxfG1
         2oSefLg62cyWVS4Hjsrb72oiP9adIExqnPIYrn9UCZifCDfSaDeIRZLRv5deg2Dj4rgJ
         ZSPTJ8ftRyBcXyOzfcVcHWx0lGRsybH4QvyrWKlOTDfMUi3lBMQeB9tdXG3KkNikenWT
         9SvhNeiRxzXOupgcCHv9xSh17gJBuRci0JKaB3/rlv8lSccEpaIrWBMvUl4oFJm6tzcq
         aeupUuNcLdwDhB6ay8fRGYBFrgDhHB1YRpV+UXEdjbU9RIUfFRtWZsSZ1EzdFSgaqP15
         erkQ==
X-Gm-Message-State: AOAM530ofprgOldUvM8hymsqOXU4UvBk03m65QYLDK2pzTTovnMmkp/L
        r0/bUON7APx9Wyaz00h458NoTZcx5OKWgyINHOvPmyU0aHcFVg==
X-Google-Smtp-Source: ABdhPJyTySMXS2eZMh5eS03L32cNf15ToE5AvKZz7eICs1uJdhhGYno+oad4aRW7fF20tSBBSv54Xp63sFrSLCAF2oM=
X-Received: by 2002:a67:f997:: with SMTP id b23mr3471696vsq.34.1611655127850;
 Tue, 26 Jan 2021 01:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20210124170258.32862-1-marex@denx.de>
In-Reply-To: <20210124170258.32862-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jan 2021 10:58:11 +0100
Message-ID: <CAPDyKFrUnx4XSyxx=H8reDV=_vRORe7fE=6HQivC9T7OkHfyRg@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] mmc: mmci: Add bindings to operate CMD, CK, CKIN
 pins as GPIO
To:     =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 24 Jan 2021 at 18:03, Marek Vasut <marex@denx.de> wrote:
>
> Add DT bindings to describe GPIO line associated with CMD, CK, CKIN pins.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: devicetree@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
> V2: Rebase on next-20210122
> ---
>  .../devicetree/bindings/mmc/arm,pl18x.yaml    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index eddc1f6bdbe5..47595cb483be 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -127,6 +127,26 @@ properties:
>        driver to sample the receive data (for example with a voltage switch
>        transceiver).
>
> +  st,cmd-gpios:
> +    maxItems: 1
> +    description:
> +      The GPIO matching the CMD pin.
> +
> +  st,ck-gpios:
> +    maxItems: 1
> +    description:
> +      The GPIO matching the CK pin.
> +
> +  st,ckin-gpios:
> +    maxItems: 1
> +    description:
> +      The GPIO matching the CKIN pin.
> +
> +dependencies:
> +  st,cmd-gpios: [ "st,use-ckin" ]
> +  st,ck-gpios: [ "st,use-ckin" ]
> +  st,ckin-gpios: [ "st,use-ckin" ]
> +
>  unevaluatedProperties: false
>
>  required:
> --
> 2.29.2
>
