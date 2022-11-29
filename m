Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA1AC4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 12:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiK2MIP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiK2MHi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 07:07:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAAEB7A
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:07:14 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id v3so12820787pgh.4
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CLaMkaBp7KGIWxfb8Zd8ve3dRx2iCekJtCJrymRzWKA=;
        b=p8G9b0N31HwrkryXMsELri1esfPlWmkUvApiYvOqCI6V+RvhBMmAo3rfemrquf7d9x
         gv6PUWa46Tm5Ymh/rfgG0f9Pp+xgBQte9WTjYOLFk7rLpeHHZLelf2BE/f3fbN3B3j97
         1z7eNFVOPOogiLxxVsVYKwjsKyR61EviRxjEftCz47B9SvHBRKAoy3IGTJsuPjsJweTm
         FcLztLnQuMo4GzUVt7cgtfppT2l1OSI4V27NEtpmc7FN5oAfth76W5jAPShueqB6Nx8F
         9NqhCFXobifdhnyEs4L/BtbxAV7qZEoCVAwmxg/tTqr6JZJdOXvd+sgegWqE9R9DcFh2
         /UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLaMkaBp7KGIWxfb8Zd8ve3dRx2iCekJtCJrymRzWKA=;
        b=3LbrntLBHkMU+uijxfNbctDhjEFFdq0+cfeYxk7VlqKzVUaM1W4gcd9OtcNWS57jXl
         DJwg+Ra3sVS5V4lPiZAzn2AA5YO+lfLXZWoBRM22Wqo/8bmIvFBVvcqSuFV1qfVvPNd6
         XZH9ZM0VKG96V7DjM/P3l8Gh7PQA01pDuHtLcX4jkmlWcAPurPh4rJNg9Yzb0DSOpZMI
         fzPhY/9vTbQc+2w3ZC1jh0J6vnPK3b71p58SngjXzb1EwekCac01LmZLj3i9PPP0mEif
         grhGRfH+OzihkTlsF993lWM6SDjfsIwlYYJHB7czhFffkVuOZWywpFMmwKffbQ6e3DUw
         rAHQ==
X-Gm-Message-State: ANoB5plHOkHQL2EmXuM8YxB3F3l1DKkTICek12eJcvTTKY2ej3u3dV2e
        /dtxpRH9HSRg8+knuUjlzLBUMBuU+BC8jQwgP8hd3g==
X-Google-Smtp-Source: AA0mqf4Tf4VM1UWDXcxIfjvce1xmaAtKT915CDXPR9PGaf16YMIEdhpOXoB1vr0ly1KOA06qR727mEV0IgcbPs905yE=
X-Received: by 2002:a05:6a00:1409:b0:56b:e1d8:e7a1 with SMTP id
 l9-20020a056a00140900b0056be1d8e7a1mr36905889pfu.28.1669723634307; Tue, 29
 Nov 2022 04:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com> <20221122111124.6828-3-cniedermaier@dh-electronics.com>
In-Reply-To: <20221122111124.6828-3-cniedermaier@dh-electronics.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:06:38 +0100
Message-ID: <CAPDyKFqc2kc4O55BAVikZFeZpAeRYo3AAfnHyxKPcsUujeGauA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less confusing
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        kernel@dh-electronics.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 22 Nov 2022 at 12:43, Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> The current comment on wakeup-source is a bit confusing, because it isn't
> clear at first sight which property is actually deprecated.
> Change the comment to one that is less confusing.
>
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 802e3ca8be4d..a921442c6c1d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -293,7 +293,7 @@ properties:
>      description:
>        SDIO only. Preserves card power during a suspend/resume cycle.
>
> -  # Deprecated: enable-sdio-wakeup
> +  # Use wakeup-source instead of the deprecated enable-sdio-wakeup
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:

Rob, Krzysztof - do we have a preferred pattern for how to express
deprecated bindings - or is the above okay to you?

Kind regards
Uffe
