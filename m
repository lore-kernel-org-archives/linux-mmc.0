Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD61CC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 12:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiK3Mgb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 07:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiK3Mg1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 07:36:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046997B624
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 04:36:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so1803178pjc.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bhnxxzbyBgwXVydGu+B/mgXlMp0Dw1k8g2zoQkfcNo8=;
        b=UGvBUrFjhu1KjtfNjzoVBn01HzbaTvtlgXOW9oOqaXkePKbAcwu+MkDoRe50kZ4Lrk
         Jjbxunl94UjNrbpRpL7Vv4hcVezpmU0GVsWDrKxhESgzoNupU3Q5rJUh3qzsJUyWH9GS
         bfSpdaLUDPUtn7uE0btukBLIaJ4jqXG7fITLwjdxtUJnPKnirXwGPA2b7ob5KFzCOs0w
         t9931Z0EsgOza0JO+P20+RoNsFw8pGR3YszKGTSxYcQPKIiKbVvvvI+MPfG2jx/6KTKL
         rJ79Lv+2XOamQ4uFaCuvvHCkWB8tcgDL+5AjknLzwbV85b0Djcwa/2AnJhB4Mw+0lW5B
         mqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhnxxzbyBgwXVydGu+B/mgXlMp0Dw1k8g2zoQkfcNo8=;
        b=Gd0niyhHIIDnQuBeLnxBSUpWy0TXRr8sBwS2D75Tjogjzi/4O6qA4rOtiZrrQSj6Pu
         KlTsMaCsXejW0ZRktI5JICkcjK+8fpOw+Y5+5YneWvDGq8lA3wPZElKuMaJwRRRt2oHX
         7aQMAdTXsvi9Lxd4ZKOgZ2a02NKpRfv7p1EcRIIUIC7IStEAX1+wygD+XHCCdRQZmjlf
         FYTxbfHMKEmI3A1LLtEI2BkVrLUx2RQ6wgdRRPBP4bFDadbA4sHbZ3UeA6gVrSTYFruF
         v+KQZcmJZUGt18dSC7x6cQtcSBUqxSnVVU+r4LH2EICcM/TiRI23iqmIYYBAuPSi0JY6
         FEEw==
X-Gm-Message-State: ANoB5plRiv/zi8P7l4NsH82DMbJ6JBB0rrwCCV6k0JO/4wfmWC+cbYXN
        DiQ24nIaAi+oKaRJZWBpywEhOAyK+NLvA6LrX0Uv6uVAw0Y=
X-Google-Smtp-Source: AA0mqf72LaJuo+xldVLoMSH5G22UPFDHa+Am3dOjn7c81G8pnPOX5X+pJ9fUEf8ltsSZSFWEDl7tgIcAn+JXKHzqzFI=
X-Received: by 2002:a17:902:ee55:b0:189:69cf:9ea0 with SMTP id
 21-20020a170902ee5500b0018969cf9ea0mr24961183plo.37.1669811780504; Wed, 30
 Nov 2022 04:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20221130121033.7270-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20221130121033.7270-1-cniedermaier@dh-electronics.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 13:35:44 +0100
Message-ID: <CAPDyKFpTT1=d=2LnynBywyRTfC7uM8GVGHkPYA0xgFhROhoPyg@mail.gmail.com>
Subject: Re: [PATCH V3] dt-bindings: mmc: Remove comment on wakeup-source property
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 13:12, Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> The current comment on wakeup-source is a little confusing because
> the word deprecated can be interpreted at first glance to mean that
> wakeup-source is deprecated. Also mentioning the obsolete property
> confuses more than it helps. Therefore, the comment should be removed
> completely because the enable-sdio-wakeup property is not used in
> any current DTs. Also remove enable-sdio-wakeup reference in
> wakeup-source.txt
>
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Applied for next, thanks!

Kind regards
Uffe

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
> V3: - Remove also reference in power/wakeup-source.txt
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml |  1 -
>  Documentation/devicetree/bindings/power/wakeup-source.txt | 13 ++++++-------
>  2 files changed, 6 insertions(+), 8 deletions(-)
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
> diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/Documentation/devicetree/bindings/power/wakeup-source.txt
> index cfd74659fbed..697333a56d5e 100644
> --- a/Documentation/devicetree/bindings/power/wakeup-source.txt
> +++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
> @@ -17,15 +17,14 @@ interrupt.
>  List of legacy properties and respective binding document
>  ---------------------------------------------------------
>
> -1. "enable-sdio-wakeup"                Documentation/devicetree/bindings/mmc/mmc.txt
> -2. "gpio-key,wakeup"           Documentation/devicetree/bindings/input/gpio-keys{,-polled}.txt
> -3. "has-tpo"                   Documentation/devicetree/bindings/rtc/rtc-opal.txt
> -4. "linux,wakeup"              Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> +1. "gpio-key,wakeup"           Documentation/devicetree/bindings/input/gpio-keys{,-polled}.txt
> +2. "has-tpo"                   Documentation/devicetree/bindings/rtc/rtc-opal.txt
> +3. "linux,wakeup"              Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
>                                 Documentation/devicetree/bindings/mfd/tc3589x.txt
>                                 Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
> -5. "linux,keypad-wakeup"       Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
> -6. "linux,input-wakeup"                Documentation/devicetree/bindings/input/samsung-keypad.txt
> -7. "nvidia,wakeup-source"      Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> +4. "linux,keypad-wakeup"       Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
> +5. "linux,input-wakeup"                Documentation/devicetree/bindings/input/samsung-keypad.txt
> +6. "nvidia,wakeup-source"      Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
>
>  Examples
>  --------
> --
> 2.11.0
>
