Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61FFCCA47C
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 10:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiFGKnX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbiFGKnV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 06:43:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E11D0F9
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 03:43:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id be31so27660112lfb.10
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XdRg5mTQzw6nhVkPbcttepeHu1kmSLwBbs3fva93xc=;
        b=N1DSIYQ2tUBiiR928h/wpbuAkWoyNemmJ20vBlcsKVQyNN84AnPudb55G8X5EEHZc5
         VrfLCbnWDAtsrhHYhabH4L0BcK6Yj8HILDRD4QS8o9jivIkV09uQ9k8+flwSL9YhpfOf
         EKIY6RpNWcq9H5P5HOecjEdKbfbUTACnthsEE+FVdO9ZPFQkU20CO5hbDY+TsXwi7Gyk
         XR89OVy0Qnt+8Lqc8HgO4+mf7B2XbeP3Iw4IkdQhRpmxypzV+y4NmZjw14ztQ0cTRyjV
         Vc9XiSpbooXYnaIEGWYbXJ0j+c6+AycmpTWR911QhQRT0pklscDEgFFUW/dz8ZLGdIVr
         VVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XdRg5mTQzw6nhVkPbcttepeHu1kmSLwBbs3fva93xc=;
        b=QGgK0LEa3QP1atdO9flLMg4l9kYgeJLGYRlpARE25S39ZlXKaNTb6sdw8WW/f1Zu3A
         2uHn36TSj110kajM3ENYZyyPBe2vEJ2uodP6MIHTc9/OEr8G1GkeOktX6Hacggy6K5oa
         xT8SZZ0agH5A1y3KvxzGtENjspemj22Um30JSawUAz2epuM9xjZogN1OO58BGpZBCZsU
         0e+F71vMdOuf6IFE0RN6y8juD23sdYoHfPyhg0P745hJ1smT0KMdrvo+6EgHUkChoxjF
         +Ci9emt+pnHBUxbrkQuFnAkQ3hjRvluosOIAg+I0hPZnWhFHsKezNfH8TM6zasbl4JkW
         ZAoA==
X-Gm-Message-State: AOAM530m2ajMUsl8N+iH7JBt6htsU55ZktFal0AH6WIo6iVwq47IYdnW
        uiOalI86boTvpb9ZTmDRtoS6b1YGaHhj/C67pDoAHw==
X-Google-Smtp-Source: ABdhPJzxvjAZjQF6R+Mrr94IoW1X7wi8uwFKBgPf5GLnc+Gvu4doMpfp0SK0kukM6bfhDVOV0zyEW3g+vrtCParwkeY=
X-Received: by 2002:a05:6512:403:b0:479:1627:a9b7 with SMTP id
 u3-20020a056512040300b004791627a9b7mr15634227lfk.233.1654598595349; Tue, 07
 Jun 2022 03:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220606225137.1536010-1-robh@kernel.org>
In-Reply-To: <20220606225137.1536010-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:42:38 +0200
Message-ID: <CAPDyKFqNiJB_2aEaQpBo4=Vzc60-986=aKKw4JZtXvO=X9WTqQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop more redundant 'maxItems/minItems' in
 if/then schemas
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hu Ziji <huziji@marvell.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Jun 2022 at 00:51, Rob Herring <robh@kernel.org> wrote:
>
> Another round from new cases in 5.19-rc of removing redundant
> minItems/maxItems when 'items' list is specified. This time it is in
> if/then schemas as the meta-schema was failing to check this case.
>
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  .../bindings/memory-controllers/nvidia,tegra186-mc.yaml        | 3 ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 1 -
>  .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml  | 1 -
>  3 files changed, 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> index c7cfa6c2cd81..935d63d181d9 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> @@ -150,7 +150,6 @@ allOf:
>            description: 5 memory controller channels and 1 for stream-id registers
>
>          reg-names:
> -          maxItems: 6
>            items:
>              - const: sid
>              - const: broadcast
> @@ -170,7 +169,6 @@ allOf:
>            description: 17 memory controller channels and 1 for stream-id registers
>
>          reg-names:
> -          minItems: 18
>            items:
>              - const: sid
>              - const: broadcast
> @@ -202,7 +200,6 @@ allOf:
>            description: 17 memory controller channels and 1 for stream-id registers
>
>          reg-names:
> -          minItems: 18
>            items:
>              - const: sid
>              - const: broadcast
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index c79639e9027e..7a2b22dd6d05 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -145,7 +145,6 @@ allOf:
>            items:
>              - description: Xenon IP registers
>              - description: Armada 3700 SoC PHY PAD Voltage Control register
> -          minItems: 2
>
>          marvell,pad-type:
>            $ref: /schemas/types.yaml#/definitions/string
> diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> index cbcf19f51411..ed6c1ca80dcc 100644
> --- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> @@ -64,7 +64,6 @@ if:
>  then:
>    properties:
>      clocks:
> -      minItems: 2
>        items:
>          - description: High-frequency oscillator input, divided internally
>          - description: Low-frequency oscillator input
> --
> 2.34.1
>
