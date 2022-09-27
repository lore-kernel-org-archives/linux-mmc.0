Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E5FC54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiI0MU5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiI0MU0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 08:20:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E5112E40C
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:19:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lh5so20253189ejb.10
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0ZK1eijlfuB75W2R5VMV3jU4dLlENKu7GQ8sbTsnldo=;
        b=AssFJQ50nKYv9yXu5A0ATQRovpLXsd174gZnDiKQQK3Uxr82lwlViEkQ8hhOLcnedu
         QJSy8EE8GBOibVWRJ7PDOY6sOLhOG0FSB2/xbsGTRbs7BezNc2QNmksjXwSqvcRZJPwm
         srl+gGbXWj+qHX2h+3wUAClvyzrHWs51LC3VDL8kFPFHH7p65GOcWaHQTycA/VVxj5K7
         ZkIRtgZJ9yy6160sQVOFeAYxdhZnKdRINmchwd5KlKmz+M48+ZZdYaW1q7JrHRmC41/0
         wMCjuyvifCkYikZFk/uFiJL3CXCZEt8tbf5OMhxyh/r+WPRgtXIHGAOB6UnlUoSfjj1q
         fnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0ZK1eijlfuB75W2R5VMV3jU4dLlENKu7GQ8sbTsnldo=;
        b=IINx5397XmE4rV3u5KiBqs3n3+TKdIc4wOkFiNNnvBGWqxFVcWC7RE88eJN97sZm3Q
         KjXNsqYKbOaf/NM074TSjnkLDY7Q7IwPDu/UulfJtAIgpQAF95eymkwAios6GhlpZ13v
         0V54/4258/jpgmnD1oJHcUa57cP3R/fRKBm0QAoKGM9rzuQvL3TmQRhwnFHAxngSMVnX
         0YL52RZt4Hc/bDDlaDWSL18yEHpASbEXCt1ne8cpSqj76a103Yldz59kvLG36RLB8zOd
         w51IoSjRrYjE496t7A7EnRTwykMn4aCbgrHJGoguDSRDuqJZiRnJ4QtoYUYDIFx6Vliw
         yAMw==
X-Gm-Message-State: ACrzQf27buPdz6k8BItxbBg+av8cZ3JAd9qcvby153yxoU+kxI6tsi/V
        9g8xvBBrx3DHo2xKb96MUEVN71sXmlJA1E2cYiAVew==
X-Google-Smtp-Source: AMsMyM4DBYJmlp+aMpC8DVQo7RHtEZBA4GNatpgLZtI9iqTDVOWQDaV5gCeqqOh4C6ZJbQPRD5NTCS6UK/7FcGYWGVo=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr23079321ejs.190.1664281149918; Tue, 27
 Sep 2022 05:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220927104138.5924-1-marex@denx.de>
In-Reply-To: <20220927104138.5924-1-marex@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 27 Sep 2022 14:18:58 +0200
Message-ID: <CACRpkdaA=3QU+_HQkK6RSe4qQJ28O4BbtT6jHuKeVjKqaqLJaQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: arm,pl18x: Document interrupt-names property
To:     Marek Vasut <marex@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Yann Gautier <yann.gautier@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 27, 2022 at 12:41 PM Marek Vasut <marex@denx.de> wrote:

> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -99,6 +99,9 @@ properties:
>      minItems: 1
>      maxItems: 2
>
> +  interrupt-names:
> +    const: cmd_irq

This hardware come in variants with one or two IRQs.

Either two: "cmd_irq", "data_irq"

Or one combined IRQ (logic OR between those two!)
I don't know what that should be called, perhaps
"cmd_data_irq".

Since all DTS:es then have to be patched an alternative
is as Arnd says to just delete the names. We should however
at the very least patch the bindings description: for the IRQs
to make the above situation clear.

Yours,
Linus Walleij
