Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22A6C636D7
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 10:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBQK1a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQK1a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 05:27:30 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2700627F9
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:27:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b6so801267plg.11
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676629647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dYUz8oisVi2MXZNU739kVbVZfuIh484HESHjTvaz9UM=;
        b=meORSfrOitZ4zlTOzjjoOw+lVQAZ9cPa9GCbsF5D7r2vSISSZGzNJGvYAoYrHiKEKv
         D6pebsua3r4XJBH5BiGIQkY8vipuODqMajcUK7EWXtgMLAScFJtklAIJJ0Z4hFgSIXNr
         y/qUyoGREIkKZKzoA+5sVCkhERCmguZJd6+/PewB/3Eg+irdm5wISjIz0QibvzahWSHI
         cda4g/Pef9SXm8+7XBMbYEZwkWd4TA06wYEwGRpWqC9QiNY4lpav8XLnqv8PM1qR3BpS
         9alx2cRI00R44N9Owo8bWeX9A7bKgN0720YIXMWx1jSE3xgHdcARDIxYrKlD999FjCpT
         YBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676629647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYUz8oisVi2MXZNU739kVbVZfuIh484HESHjTvaz9UM=;
        b=zdPEXX/4lRzPaueJa3Pmt+PaVbo6KWmNdAKhLcWTg0Y7uNKgQDzdUWN7ZDF6eN9Lt9
         /39w5X0s6phn3+ZL3iRNfZ7GkVQc68thN5W7SemFr1XgXlwvAswTDY35B607jONVemni
         Ugy0sF9UzPk2EJJOM8DK2UYJCL5MbnGshsKGnu6pvKt68UO+DcZ8jhyeVasKpRMgsvV5
         hoAjt8P9NRN83RbLpFi1pWTlkeCJmWaF9lvnxKwHO7eFDwNV74QGIpEDj7haQMAMDDiR
         9uAFz7WXJyZ0Ak9KEFQu2vzvuXX3r1diHEzHIPruGceSYNKBwqyA42WAc1HHzaPG9yrj
         OIMA==
X-Gm-Message-State: AO0yUKXQo0+xqRiLuKWUBPAE0C1SAO0OQ5P66af+ZFGfHFDe7NMVlBfb
        eWu7s3PGUBVLFM47orNjRODsLhB7f3ujWj6lL7vKLw==
X-Google-Smtp-Source: AK7set8Zqc99tI1n8m5kImc/yYJuO2ErLq/s41RuQOt/YA+reJHb6HINNqc7ZSfnEhsxkCMLALMX2fO1gyvLLpvOClo=
X-Received: by 2002:a17:902:8d89:b0:199:15c2:99ae with SMTP id
 v9-20020a1709028d8900b0019915c299aemr77197plo.20.1676629647338; Fri, 17 Feb
 2023 02:27:27 -0800 (PST)
MIME-Version: 1.0
References: <c1437eb6-0c01-809f-422b-cb1109489355@gmail.com>
In-Reply-To: <c1437eb6-0c01-809f-422b-cb1109489355@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Feb 2023 11:26:50 +0100
Message-ID: <CAPDyKFp-ASckmet2hA7XuycijRSe64HEkVRzPSBKP4G4NG6v-g@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: meson-gx: fix interrupt binding
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Feb 2023 at 20:50, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Reflect in the binding that the cd interrupt is optional,
> and add a description of the interrupts.
>
> Fixes: 09b31a610328 ("dt-bindings: mmc: meson-gx: support specifying cd interrupt")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> v2:
> - omit maxItems and use items
> ---
>  .../devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml        | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index c8c30300d..bc403ae9e 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -28,7 +28,10 @@ properties:
>      maxItems: 1
>
>    interrupts:
> -    maxItems: 2
> +    minItems: 1
> +    items:
> +      - description: mmc controller instance
> +      - description: card detect
>
>    clocks:
>      maxItems: 3
> --
> 2.39.1
>
