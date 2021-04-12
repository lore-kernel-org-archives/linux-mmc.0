Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DB6C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8FA61221
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhDLHjg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbhDLHjf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:39:35 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F6C06138D
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:39:17 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id l8so6152051vsj.13
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ExoxKCgaqdCsDepfvxx4zot0Xxz7DmLhOne1aZN2lc=;
        b=uQWrxcfVq6tfFk45Dsu1M+8DO7/Y3gkFEqjkH08QcNmmKLD8MMRYdhz1uYrJfFXUR8
         Ag7+QypWcgC7ioD1+aBvgrup18mKd563yDSy5jIK7AZEwztzNDB7RlHt+virdnOASLe4
         zVXEBJxMmOwQfyhEhHuJQOmWK98iYJmSOV0kKNATYMEili8QMEamRMMEYXKTF5quQc2f
         kZOpdTyUEmV0sOAI+Ff7bKlti9lucQgPmGGVnBJi6bNubf0CnO7FF4ruawkLQIIXp6AZ
         MDjy24sd1F4eS+GzFpPuYxUCJqYNaC975P/rB38ekIY7Qy1WVBo/z8lVjIuvlywVPLgV
         Pu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ExoxKCgaqdCsDepfvxx4zot0Xxz7DmLhOne1aZN2lc=;
        b=Rc5DqhlRTE12QMSZYbB5MZ91ERE/C443jmBzDTr556jBOShiRuz4hUsmDUA9rV6GaK
         pqU1Rw+xmLwyfXXg7K/QjqyAsUJhvBVWrbmXVTMsmigQ9rCZTcT6MagQJVopS3lGibDf
         epj9vYUzzH54GtXclBxB2SHIYq8r8/MSudh/GJCp7Mj8YTMpWckAdNsAQLAvddXjJocO
         3cq+ZHpF/qTKISLpktChbw/BhUhdMpLbM7j8KkRtxbZ5mTRl1bokF2XPObP3J4DPMrlD
         bbb5zQWiqzbYGGkTgzbJGnDbsQB2J9stpk7KfOJtZpo/zReAQV3KnIwA8PRRrsKjvYDy
         S1mg==
X-Gm-Message-State: AOAM530DY9RvT1kcx7Fu0kOttp1krXMzLMSgE/mRrdpK/8YS8oarPBzP
        Q/5qH+kmnEQuE/uFOGK8P6WBawn/cpDtIa7OWu91UIx9MJ8xGA==
X-Google-Smtp-Source: ABdhPJy3atKJOCw7R/9czTlSfDsNIyt3sFse/HJpxmIRKKl4EAag4GD6AjYNfHVS688ENiFwU5SbPJxcoVpMTnEjNso=
X-Received: by 2002:a67:fe05:: with SMTP id l5mr18228581vsr.34.1618213156719;
 Mon, 12 Apr 2021 00:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210408015218.20560-1-steven_lee@aspeedtech.com> <20210408015218.20560-2-steven_lee@aspeedtech.com>
In-Reply-To: <20210408015218.20560-2-steven_lee@aspeedtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:38:40 +0200
Message-ID: <CAPDyKFr=Gtwu4v22FBaax5EjRbXTNez1N2ZQxP=v0LKGFTCovw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: sdhci-of-aspeed: Add power-gpio
 and power-switch-gpio
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        ryan_chen@aspeedtech.com, chin-ting_kuo@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 8 Apr 2021 at 03:52, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> AST2600-A2 EVB provides the reference design for enabling SD bus power
> and toggling SD bus signal voltage by GPIO pins.
> Add the definition and example for power-gpio and power-switch-gpio
> properties.
>
> In the reference design, GPIOV0 of AST2600-A2 EVB is connected to power
> load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is connected to
> a 1.8v and a 3.3v power load switch that providing signal voltage to
> SD1 bus.
> If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> disabled.
> If GPIOV1 is active high, 3.3v power load switch is enabled, SD1 signal
> voltage is 3.3v. Otherwise, 1.8v power load switch will be enabled, SD1
> signal voltage becomes 1.8v.
>
> AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and GPIOV3
> as power-switch-gpio.

Thanks for sharing the details, it certainly helps while reviewing.

>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 987b287f3bff..515a74614f3c 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -37,6 +37,14 @@ properties:
>    clocks:
>      maxItems: 1
>      description: The SD/SDIO controller clock gate
> +  power-gpio:
> +    description:
> +      The GPIO for enabling/disabling SD bus power.
> +    maxItems: 1
> +  power-switch-gpio:
> +    description:
> +      The GPIO for toggling the signal voltage between 3.3v and 1.8v.
> +    maxItems: 1


>
>  patternProperties:
>    "^sdhci@[0-9a-f]+$":
> @@ -61,6 +69,14 @@ patternProperties:
>        sdhci,auto-cmd12:
>          type: boolean
>          description: Specifies that controller should use auto CMD12
> +      power-gpio:
> +        description:
> +          The GPIO for enabling/disabling SD bus power.
> +        maxItems: 1
> +      power-switch-gpio:
> +        description:
> +          The GPIO for toggling the signal voltage between 3.3v and 1.8v.
> +        maxItems: 1
>      required:

Please do not model these as GPIO pins like this. Instead, it's better
to model them as gpio regulators, since the mmc core manages them as
regulators.

We have a vmmc regulator (corresponding to vdd) and a vqmmc regulator
(corresponding the signal-voltage level). These are also described in
the common mmc DT bindings, see
Documentation/devicetree/bindings/mmc/mmc-controller.yaml.

>        - compatible
>        - reg
> @@ -80,6 +96,7 @@ required:
>  examples:
>    - |
>      #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/gpio/aspeed-gpio.h>
>      sdc@1e740000 {
>              compatible = "aspeed,ast2500-sd-controller";
>              reg = <0x1e740000 0x100>;
> @@ -94,6 +111,10 @@ examples:
>                      interrupts = <26>;
>                      sdhci,auto-cmd12;
>                      clocks = <&syscon ASPEED_CLK_SDIO>;
> +                    power-gpio = <&gpio0 ASPEED_GPIO(V, 0)
> +                                     GPIO_ACTIVE_HIGH>;
> +                    power-switch-gpio = <&gpio0 ASPEED_GPIO(V, 1)
> +                                     GPIO_ACTIVE_HIGH>;
>              };
>
>              sdhci1: sdhci@200 {
> @@ -102,5 +123,9 @@ examples:
>                      interrupts = <26>;
>                      sdhci,auto-cmd12;
>                      clocks = <&syscon ASPEED_CLK_SDIO>;
> +                    power-gpio = <&gpio0 ASPEED_GPIO(V, 2)
> +                                     GPIO_ACTIVE_HIGH>;
> +                    power-switch-gpio = <&gpio0 ASPEED_GPIO(V, 3)
> +                                     GPIO_ACTIVE_HIGH>;
>              };
>      };

Kind regards
Uffe
