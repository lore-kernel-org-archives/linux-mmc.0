Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69531C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 11:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiK3LkV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 06:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiK3LkU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 06:40:20 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E12EF2B
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 03:40:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so1737930pjg.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 03:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LNjWyH35fVY/TMIzB5ImQEdzHY0s+B+xCvg9O56BsM=;
        b=z5CawRqPrYDA48WMicMvok00qsLCphUB2bR6AkZ/d9YBlR2s4zjnPdO9kK7hRXpzgg
         pyHgndfm3URHkyHq3sZChFZbNKLbevZK8BtyEBcjgUqj+e5OmI7jyrfQJaInYxqrDq3y
         IY7Y9lGxslKC7eKrUgyhNNnU02mrs3jLvcxT2M0iK3uzbfmKALbUSeqUVUXXvFtuTMaF
         U0SQGDcsBmeGnj13YRDFRKnMoxHB38c/HFaNVrE33jjs8BHRwO8wih2vHrnAbmmxApTH
         9nNpiXL/XwvauD76pxaD9e9UGVmx1JufEeW5+H4HZ8cp5wO+bK/VqjZOnRCRNg/n7bRP
         phPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LNjWyH35fVY/TMIzB5ImQEdzHY0s+B+xCvg9O56BsM=;
        b=ocxqesaV4dw1MpJEsRb+sr/IfP2XRMP3mi4ny0aMwaU3gI5BRLY4cWZ9v0KGLUOIo/
         qOpaLZayAkY/VY4hPglnNKrG8hqGxWi1u73h5ozfrP/3+yEW01/R4FYdya/q1OIr+bQP
         DsO7CBwti7DX7vzKlT/KMaUt7gJurl9sMzJUhrLqMV4/CXjSpKQbkgLzouqF05rSZakT
         DBJ2Flvcj6oNZkWzGptUYS4m9jirDEtPPOzvvkrqOFYqwpPVrMnMSG1wcdXT+Dr0D+Hg
         rq/XsAE0Nb+6UupCFbxCHzm6v6Sp79HnlyQzrKdOYlvAjeXQdtOMhP+zvR1xH1jZVyA5
         P8zQ==
X-Gm-Message-State: ANoB5pmsAU+0gS14YQpatR1fxlBQEh4wjEB4g4YrFpMmrEGY6RzFs9pp
        DByDcV+vddNG7vBXyPRuFrwJeCWOOE4MFY253E8CBg==
X-Google-Smtp-Source: AA0mqf6iaywNXQp7J6No+cTnfXmbnavNVNaL9Gtrh9Vdjr65ORYiD9n0kq1vcrM3ud2gzVPfwi75crAIe0SaKgFEjvI=
X-Received: by 2002:a17:902:a503:b0:188:6baf:2011 with SMTP id
 s3-20020a170902a50300b001886baf2011mr39978056plq.165.1669808419589; Wed, 30
 Nov 2022 03:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20221130101852.5408-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20221130101852.5408-1-cniedermaier@dh-electronics.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 12:39:43 +0100
Message-ID: <CAPDyKFpZnnx_4+NmsVewMs8duDqf=qY57a134QD+1NdcKRnK_A@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: mmc: Remove comment on wakeup-source property
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 11:20, Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> The current comment on wakeup-source is a little confusing because
> the word deprecated can be interpreted at first glance to mean that
> wakeup-source is deprecated. Also mentioning the obsolete property
> confuses more than it helps. Therefore, the comment should be removed
> completely because the enable-sdio-wakeup property is not used in
> any current DTs.
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
> V2: - Instead of changing the comment, remove it
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 802e3ca8be4d..e82c00368088 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -293,7 +293,6 @@ properties:
>      description:
>        SDIO only. Preserves card power during a suspend/resume cycle.
>
> -  # Deprecated: enable-sdio-wakeup
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:

This looks good to me!

However, let's also drop the reference to the property from
Documentation/devicetree/bindings/power/wakeup-source.txt.

Kind regards
Uffe
